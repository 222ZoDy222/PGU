unit GalaContainer;

{ ���������� ������������� ���������������� Gala.
  ������ GalaContainer & GalaContainerChannel.
}

interface

uses
  Windows, Gala;

type
  TGalaContainer = class;

  TGalaContainerChannel = class
  private
    FOwner: TGalaContainer;
    FEntry: TGalaEntry;
    FGuard: TGalaGuard;
    FPrev:  TGalaContainerChannel;

    function Enabled: Boolean;

  public
    procedure Send(aSender: TGalaProcess; aData: Pointer = nil;
              aTimeout: Cardinal = INFINITE);
    property  Entry: TGalaEntry read FEntry write FEntry;
    property  Guard: TGalaGuard read FGuard write FGuard;
  end;

  TGalaContainer = class
  protected
    FMutex:            THandle;
    FLatch:            TGalaLatch;
    FPossibleToOccupy: THandle;
    FChannelsList:     TGalaContainerChannel;

    function  CreateChannel(aEntry: TGalaEntry; aGuard: TGalaGuard = nil):
              TGalaContainerChannel;
    procedure Log(const S: String);

  public
    constructor Create(AsMutex: Boolean = True);
    destructor  Destroy; override;
  end;

implementation

{ TGalaContainerChannel }

procedure TGalaContainerChannel.Send(aSender: TGalaProcess;
  aData: Pointer; aTimeout: Cardinal);
var
  Objs:      array[0..1] of THandle;
  ResWait:   DWORD;
  Ok:        Boolean;
  StartTime: Cardinal;

  function Timeout: Cardinal;
  var
    dt: Cardinal;
  begin
    dt := GetTickCount - StartTime;
    if aTimeOut > dt then
      result := aTimeout - dt
    else
      result := 1;
  end;

  procedure Action;
  begin
    { ��������� ��������. ��������� ��������, ��� ��� �� ����� �������� �����
      ��������� ���������, �������� �� ��������� ���������� ������� }
    if Enabled then begin
      // ���������� �������� � ���������� � ������ ��������� ����������
      Entry(aData);
      // �������� ������ ���� ���������, ������ � ������� ����������
      SetEvent(FOwner.FPossibleToOccupy);
      Ok := True;
    end;
  end;

begin
  if not Assigned(aSender) then
    raise EGalaInvalidArgument.Create('aSender', ClassName, 'Send');
  if not Assigned(aData) then
    aData := aSender;
  StartTime := GetTickCount;
  Objs[1]   := aSender.TerminationEvent;
  Ok        := False;
  while not Ok do begin
    if Enabled then begin
      if FOwner.FMutex <> 0 then begin
        Objs[0] := FOwner.FMutex;
        { �������� ��������:
          a) ���������� (�����������) ����������
          �) ��� �������� ���������� ��������
          �) ��� ��������
        }
        ResWait := WaitForMultipleObjects(2, @Objs, False, Timeout);
        if ResWait = WAIT_FAILED then
          raise EGalaWaitFailed.Create;
        if ResWait = WAIT_TIMEOUT then
          raise EGalaTimeout.Create;
        if ResWait = (WAIT_OBJECT_0 + 1) then
          raise EGalaPrematureTermination.Create;
        try
          Action;
        finally
          ReleaseMutex(FOwner.FMutex);
        end;
      end
      else begin // ����������� ������
        // �������� ���������� (�����������) ����������
        FOwner.FLatch.Lock;
        try
          Action;
        finally
          FOwner.FLatch.Unlock;
        end;
      end;
    end;
    if not Ok then begin
      { ��������:
        a) ����������� ������� ����������
        �) ��� �������� ���������� ��������
        �) ��� ��������
      }
      Objs[0] := FOwner.FPossibleToOccupy;
      ResWait := WaitForMultipleObjects(2, @Objs, False, Timeout);
      if ResWait = WAIT_FAILED then
        raise EGalaWaitFailed.Create;
      if ResWait = WAIT_TIMEOUT then
        raise EGalaTimeout.Create;
      if ResWait = (WAIT_OBJECT_0 + 1) then
        raise EGalaPrematureTermination.Create;
      // ������ ����� �������
      ResetEvent(FOwner.FPossibleToOccupy);
    end;
  end;
end;

// ����� ��������, ���� ���������� ������� ���� � ��� ���������� True
function TGalaContainerChannel.Enabled: Boolean;
begin
  if Assigned(Guard) then
    result := Guard
  else
    result := True;
end;


{ TGalaContainer }

constructor TGalaContainer.Create(AsMutex: Boolean);
begin
  inherited Create;
  if AsMutex then begin
    FMutex := CreateMutex(
      nil,
      False, // ���������� ��������
      nil
    );
    if FMutex = 0 then
      raise EGalaObjectCreationFail.Create;
  end
  else
    FLatch := TGalaLatch.Create;
  FPossibleToOccupy := CreateEvent(
    nil,
    True, { ������ �������������. ������������ ����� ��������������
            ������������ ��� ��������� �������� (� �� ����)
          }
    True, // ��������� ��������� - ���������������
    nil
  );
  if FPossibleToOccupy = 0 then
    raise EGalaObjectCreationFail.Create;
end;

destructor TGalaContainer.Destroy;
var
  chan, prev: TGalaContainerChannel;
begin
  // ����������� ����������� �������
  chan := FChannelsList;
  while Assigned(chan) do begin
    prev := chan.FPrev;
    chan.Free;
    chan := prev;
  end;
  if FPossibleToOccupy <> 0 then
    CloseHandle(FPossibleToOccupy);
  if FMutex <> 0 then
    CloseHandle(FMutex);
  FLatch.Free;
  inherited Destroy;
end;

function TGalaContainer.CreateChannel(aEntry: TGalaEntry; aGuard: TGalaGuard):
  TGalaContainerChannel;
begin
  if not Assigned(aEntry) then
    raise EGalaInvalidArgument.Create('aEntry', ClassName, 'CreateChannel');
  result        := TGalaContainerChannel.Create;
  result.FOwner := self;
  result.FEntry := aEntry;
  result.FGuard := aGuard;
  // ���������� ������ � ������ ����������� �������
  result.FPrev  := FChannelsList;
  FChannelsList := result;
end;

procedure TGalaContainer.Log(const S: String);
begin
  GalaTheater.Log(S);
end;

end.
