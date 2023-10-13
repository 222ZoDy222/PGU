unit GalaSignals;

{ ���������� ������������� ���������������� Gala.
  ��������� ����������� �� �����������.
}

interface

uses
  Windows, Classes, SysUtils, Gala;

type
  TGalaEvent = class(TGalaSignal)
  public
    constructor Create(aManualReset: Boolean; aInitialState: Boolean = False;
                aName: PChar = nil);
    destructor  Destroy; override;
    procedure   SetState(aState: Boolean); virtual;
    procedure   Pulse; virtual;
  end;

  TGalaMutex = class(TGalaSignal)
  public
    constructor Create(aOwned: Boolean; aName: PChar = nil);
    destructor  Destroy; override;
    procedure   Release; virtual;
  end;

  TGalaSemaphore = class(TGalaSignal)
  public
    constructor Create(aMaxCount: Integer; aInitialCount: Integer = -1;
                aName: PChar = nil);
    destructor  Destroy; override;
    procedure   Release(aCount: Integer = 1); virtual;
  end;

  TGalaChangeNotification = class(TGalaSignal)
  protected
    FDirectory: String;
    FSubtree:   Boolean;
    FFilter:    Cardinal;

    function  NormDirectory(const aDirectory: String): String;
    procedure AfterWaiting(p: TGalaProcess); override;

  public
    constructor Create(const aDirectory: String; aSubtree: Boolean;
                aFilter: Cardinal);
    destructor  Destroy; override;
    procedure   NewDir(const aDirectory: String); virtual;

    property    Directory: String read FDirectory;
  end;

  TGalaDeque = class(TGalaSignal)
  protected
    FList:      TThreadList;
    FDequeSize: Integer;

    procedure AdditionQuery(aCount: Integer);
    procedure UpdateEvent(aCount: Integer);

  public
    constructor Create(aDequeSize: Integer = 0);
    destructor  Destroy; override;
    function    Count: Integer; virtual;
    procedure   PutLast(aObject: TObject); virtual;
    function    GetLast: TObject; virtual;
    procedure   PutFirst(aObject: TObject); virtual;
    function    GetFirst: TObject; virtual;
    function    PeekLast: TObject; virtual;
    function    PeekFirst: TObject; virtual;
  end;

  TGalaMessage = class(TGalaSignal)
  private
    FRefCount: Integer;

  protected
    procedure AddRef;

  public
    constructor Create;
    destructor  Destroy; override;
    procedure   Release; virtual;
    procedure   Send(aWnd: THandle; aMessage: Integer); virtual;
    procedure   Reply; virtual;
  end;

  EGalaOverflow = class(Exception)
  public
    constructor Create;
  end;

implementation

resourcestring
{$IFDEF RUSSIAN_VERSION}
  SGalaOverflow = '������������ ����';
{$ELSE}
  SGalaOverflow = 'Deque overflow';
{$ENDIF}

{ TGalaEvent }

constructor TGalaEvent.Create(aManualReset, aInitialState: Boolean;
  aName: PChar);
begin
  inherited Create(CreateEvent(nil, aManualReset, aInitialState, aName));
  if FHandle = 0 then
    raise EGalaObjectCreationFail.Create;
end;

destructor TGalaEvent.Destroy;
begin
  if FHandle <> 0 then
    CloseHandle(FHandle);
  inherited Destroy;
end;

procedure TGalaEvent.SetState(aState: Boolean);
begin
  if aState then
    SetEvent(FHandle)
  else
    ResetEvent(FHandle);
end;

procedure TGalaEvent.Pulse;
begin
  PulseEvent(FHandle);
end;

{ TGalaMutex }

constructor TGalaMutex.Create(aOwned: Boolean; aName: PChar);
begin
  inherited Create(CreateMutex(nil, aOwned, aName));
  if FHandle = 0 then
    raise EGalaObjectCreationFail.Create;
end;

destructor TGalaMutex.Destroy;
begin
  if FHandle <> 0 then
    CloseHandle(FHandle);
  inherited Destroy;
end;

procedure TGalaMutex.Release;
begin
  ReleaseMutex(FHandle);
end;


{ TGalaSemaphore }

constructor TGalaSemaphore.Create(aMaxCount: Integer; aInitialCount: Integer;
  aName: PChar);
begin
  if aInitialCount = -1 then
    aInitialCount := aMaxCount;
  inherited Create(CreateSemaphore(nil, aMaxCount, aInitialCount, aName));
  if FHandle = 0 then
    raise EGalaObjectCreationFail.Create;
end;

destructor TGalaSemaphore.Destroy;
begin
  if FHandle <> 0 then
    CloseHandle(FHandle);
  inherited Destroy;
end;

procedure TGalaSemaphore.Release(aCount: Integer);
begin
  ReleaseSemaphore(FHandle, aCount, nil);
end;


{ TGalaChangeNotification }

function TGalaChangeNotification.NormDirectory(
  const aDirectory: String): String;
var
  len: Integer;
begin
  result := aDirectory;
  len    := Length(result);
  if len <> 0 then
    if result[len] in ['\', '/'] then
      SetLength(result, len - 1);
end;

procedure TGalaChangeNotification.AfterWaiting;
begin
  if FHandle <> 0 then
    FindNextChangeNotification(FHandle);
end;

constructor TGalaChangeNotification.Create(const aDirectory: String;
  aSubtree: Boolean; aFilter: Cardinal);
var
  s:  LongBool;
  ps: PDWORD;
begin
  FDirectory := NormDirectory(aDirectory);
  FSubtree   := aSubtree;
  FFilter    := aFilter;
  ps         := @s;
  if aSubtree then
    ps^ := 1
  else
    ps^ := 0;
  inherited Create(FindFirstChangeNotification(PChar(FDirectory), s, FFilter));
  if FHandle = INVALID_HANDLE_VALUE then
    FHandle := 0;
end;

destructor TGalaChangeNotification.Destroy;
begin
  if FHandle <> 0 then
    FindCloseChangeNotification(FHandle);
  inherited Destroy;
end;

procedure TGalaChangeNotification.NewDir(const aDirectory: String);
var
  d:  String;
  s:  LongBool;
  ps: PDWORD;
begin
  d := NormDirectory(aDirectory);
  if AnsiCompareText(PChar(d), PChar(FDirectory)) <> 0 then begin
    if FHandle <> 0 then
      FindCloseChangeNotification(FHandle);
    FDirectory := d;
    ps         := @s;
    if FSubtree then
      ps^ := 1
    else
      ps^ := 0;
    FHandle := FindFirstChangeNotification(PChar(FDirectory), s, FFilter);
    if FHandle = INVALID_HANDLE_VALUE then
      FHandle := 0;
  end;
end;

{ TGalaDeque }

constructor TGalaDeque.Create(aDequeSize: Integer);
var
  List: TList;
begin
  inherited Create(CreateEvent(nil, True, False, nil));
  if FHandle = 0 then
    raise EGalaObjectCreationFail.Create;
  FList      := TThreadList.Create;
  FDequeSize := aDequeSize;
  if FDequeSize <> 0 then begin
    List := FList.LockList;
    try
      List.Capacity := aDequeSize;
    finally
      FList.UnlockList;
    end;
  end;
end;

destructor TGalaDeque.Destroy;
var
  i:    Integer;
  obj:  TObject;
  List: TList;
begin
  List := FList.LockList;
  try
    if List.Count <> 0 then begin
      for i := 0 to Pred(List.Count) do begin
        obj := TObject(List.Items[i]);
        if Assigned(obj) then
          obj.Free;
        List.Items[i] := nil;
      end;
    end;
  except
  end;
  FList.UnlockList;
  FList.Free;
  if FHandle <> 0 then
    CloseHandle(FHandle);
  inherited Destroy;
end;

procedure TGalaDeque.AdditionQuery(aCount: Integer);
begin
  if (FDequeSize <> 0) and (aCount >= FDequeSize) then
    raise EGalaOverflow.Create;
end;

procedure TGalaDeque.UpdateEvent(aCount: Integer);
begin
  if aCount = 0 then
    ResetEvent(FHandle)
  else
    SetEvent(FHandle);
end;

function TGalaDeque.Count: Integer;
begin
  result := FList.LockList.Count;
  FList.UnlockList;
end;

procedure TGalaDeque.PutLast(aObject: TObject);
var
  List: TList;
begin
  List := FList.LockList;
  try
    AdditionQuery(List.Count);
    List.Add(aObject);
    UpdateEvent(List.Count);
  finally
    FList.UnlockList;
  end;
end;

function TGalaDeque.GetLast: TObject;
var
  List: TList;
begin
  result := nil;
  List := FList.LockList;
  try
    if List.Count <> 0 then begin
      result := TObject(List.Items[List.Count - 1]);
      List.Delete(List.Count - 1);
      UpdateEvent(List.Count);
    end;
  finally
    FList.UnlockList;
  end;
end;

procedure TGalaDeque.PutFirst(aObject: TObject);
var
  List: TList;
begin
  List := FList.LockList;
  try
    AdditionQuery(List.Count);
    List.Insert(0, aObject);
    UpdateEvent(List.Count);
  finally
    FList.UnlockList;
  end;
end;

function TGalaDeque.GetFirst: TObject;
var
  List: TList;
begin
  result := nil;
  List   := FList.LockList;
  try
    if List.Count <> 0 then begin
      result := TObject(List.Items[0]);
      List.Delete(0);
      UpdateEvent(List.Count);
    end;
  finally
    FList.UnlockList;
  end;
end;

function TGalaDeque.PeekFirst: TObject;
var
  List: TList;
begin
  result := nil;
  List   := FList.LockList;
  try
    if List.Count <> 0 then
      result := TObject(List.Items[0]);
  finally
    FList.UnlockList;
  end;
end;

function TGalaDeque.PeekLast: TObject;
var
  List: TList;
begin
  result := nil;
  List   := FList.LockList;
  try
    if List.Count <> 0 then
      result := TObject(List.Items[List.Count - 1]);
  finally
    FList.UnlockList;
  end;
end;

{ TGalaMessage }

constructor TGalaMessage.Create;
begin
  inherited Create(CreateEvent(nil, True, False, nil));
  if FHandle = 0 then
    raise EGalaObjectCreationFail.Create;
  FRefCount := 1;
end;

destructor TGalaMessage.Destroy;
begin
  if FHandle <> 0 then
    CloseHandle(FHandle);
  inherited Destroy;
end;

procedure TGalaMessage.AddRef;
begin
  FRefCount := InterlockedIncrement(FRefCount);
end;

procedure TGalaMessage.Release;
begin
  FRefCount := InterlockedDecrement(FRefCount);
  if FRefCount = 0 then
    Destroy;
end;

procedure TGalaMessage.Send(aWnd: THandle; aMessage: Integer);
begin
  AddRef;
  Windows.PostMessage(aWnd, aMessage, 0, Integer(Self));
end;

procedure TGalaMessage.Reply;
begin
  SetEvent(FHandle);
  Release;
end;

{ EGalaOverflow }

constructor EGalaOverflow.Create;
begin
  inherited Create(SGalaOverflow);
end;

end.
