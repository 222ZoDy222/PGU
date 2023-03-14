function timer
{
	$time=6
	$secondsRunning = 0;
	write-host 'Enter pass:'
	while ( (-not $Host.UI.RawUI.KeyAvailable) -and ($secondsRunning -lt $time) )
	{
     		Start-Sleep -Seconds 1
     		$secondsRunning++
	}
	if($secondsRunning -eq $time)
	{
		return -1
	}
	
	$res = read-host -AsSecureString
	return $res
}

function subMenu1
{
	write-output "Notepad - n"
	write-output "Word - w"
	write-output "exit - e"
	
	$in = read-host
	if("n" -eq $in)
	{
		C:\windows\notepad.exe
	}
	elseif("w" -eq $in)
	{
		
		& 'C:\Program Files\Microsoft Office\root\Office16\WINWORD.EXE'
		
	}
	elseif("e" -eq $in)
	{
		return 
	}
	else
	{
		write-host not defined
	}
	
}

function SubMenu2
{
	write-output "Visual Studio - v"
	write-output "Calculator - c"
	write-output "exit - e"
	
	$in = read-host
	if("v" -eq $in)
	{
		& 'C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\Common7\IDE\devenv.exe'
	}
	elseif("c" -eq $in)
	{
		
		C:\Windows\System32\calc.exe
		
	}
	elseif("e" -eq $in)
	{
		return 
	}
	else
	{
		write-host not defined
	}
}

function mainMenu($mode)
{
	
	if("1" -eq $mode  )
	{
		$password1 = "qwerty"
	
		$input = timer
		if($input.GetType().Name -eq "Int32")
		{
			write-host Timeout
			return 
		}
		$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($input[0])
		$decrypt_pass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
		
		if($decrypt_pass -eq $password1)
		{
			subMenu1
		}
		else
		{
			write-host password failed
			return 
		}
	}
	elseif($mode -eq "2")
	{
		$password2 = "12345"
		$input = timer
		
		if($input.GetType().Name -eq "Int32")
		{
			write-host Timeout
			return 
		}
		
		$BSTR =[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($input[0])
		$decrypt_pass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
		
		if($decrypt_pass -eq $password2)
		{
			subMenu2
		}
		else
		{
			write-host password failed
			return 
		}
	}
	else
	{
		write-host param not defined
	}
}

"Name users: $(whoami)"

$mainMenu = "`nOperating mode`nEdit - 1`nProg - 2`nExit - e"

while(1)
{
	write-host $mainMenu
	$mode = read-host
	if($mode -eq 'e')
	{
		break
	}
	else
	{
		MainMenu $mode
	}
}
