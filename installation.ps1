<# Installing additional Components like
	IIS, Tomcat, Websphere, MySQL softwares and
	Google Chrome browser, Putty, 7Zip utilities
	in Azure windows based vm images
#>

<# Import environment variables #>
 param
	(
		[string]$InstallIIS='true',
		[string]$InstallTomcat='false',
		[string]$InstallWebSphere='false',
		[string]$InstallMySQL='false',
		[string]$InstallGooglechrome='true',
		[string]$InstallPutty='true',
		[string]$Install7Zip='true',
		[string]$WebServerPort='',
		[string]$WebServerPackage='',
		[string]$TimeZone=''
	)

	try {
	<# Altering the time zone of the machine #>
		If(!($TimeZone -eq ''))
		{
			cd $env:WINDIR\system32\
			tzutil /s $TimeZone
		}
	}
	catch
	{
		Write-Output "Unable to set the time zone"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

	try {
		<# Install Chocolatey  #>
		iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
		refreshenv
	}
	catch
	{
		Write-Output "Unable to install the Chocolatey"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

	#try {
	#	choco feature enable -n allowGlobalConfirmation
	#}
	#catch
	#{
	#	Write-Output "Unable to enable global confirmation in chololatey"
	#	$ErrorMessage = $_.Exception.Message
	#	$FailedItem = $_.Exception.ItemName
	#	Write-Output $ErrorMessage
	#}

	try {
		<# VC++ runtimes needed as dependencies for other installations #>
		#choco install vcredist-all -y
		choco install vcredist2010 -y
		choco install vcredist2012 -y
		choco install vcredist2013 -y
		choco install vcredist140 -y
	}
	catch
	{
		Write-Output "Unable to install VC++ redistributables"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}


		
	try {
		If($InstallIIS -eq 'true')
		{
			<# Install IIS Server #>
			Install-WindowsFeature -Name web-server -IncludeManagementTools
			Install-WindowsFeature -Name Web-Asp-Net45

			<# Configure the IIS server #>
			Set-WebBinding -Name 'Default Web Site' -BindingInformation "*:80:" -PropertyName Port -Value 8080
			netsh advfirewall firewall add rule name="HTTP Web Application" dir=in action=allow protocol=TCP localport=8080
		
			try 
			{
				<# SQL Server Management Studio #>
				choco install sql-server-management-studio -y
			}
			catch
			{
				Write-Output "Unable to install SQL Server management Studio"
				$ErrorMessage = $_.Exception.Message
				$FailedItem = $_.Exception.ItemName
				Write-Output $ErrorMessage
			}
		}
	}
	catch
	{
		Write-Output "Unable to install IIS Server"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

	try {
		#If($InstallIIS -eq 'true')
		#{
			<# Install the IIS server #>
			#Install-WindowsFeature -Name web-server -IncludeManagementTools
			#Install-WindowsFeature -Name Web-Asp-Net45

			<# Configure the Firewall #>
			#Set-WebBinding -Name 'Default Web Site' -BindingInformation "*:80:" -PropertyName Port -Value $WebServerPort
			#netsh advfirewall firewall add rule name="HTTP Web Application" dir=in action=allow protocol=TCP localport=$WebServerPort

			If($WebServerPackage -ne '')
			{
				# Folders
		#        New-Item -ItemType Directory c:\temp
		#        New-Item -ItemType Directory c:\sites

				# Download app package
		#        Invoke-WebRequest  $WebServerPackage -OutFile c:\temp\app.zip
		#        Expand-Archive C:\temp\app.zip c:\sites

				# Configure iis
		#       Remove-WebSite -Name "Default Web Site"
				#Set-ItemProperty IIS:\AppPools\DefaultAppPool\ managedRuntimeVersion ""
		#       New-Website -Name "Application" -Port 80 -PhysicalPath C:\sites\ -ApplicationPool DefaultAppPool & iisreset
			}
		#}
	}
	catch
	{
		Write-Output "Unable to deploy the packages to IIS Server"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

	#<# Import environment variables #>
	# $InstallIIS = $env:installiis
	# $InstallTomcat = $env:installtomcat
	# $InstallWebSphere = $env:installwebsphere
	# $InstallMySQL = $env:installmysql
	# $InstallGooglechrome = $env:installgooglechrome
	# $InstallPutty = $env:installputty
	# $Install7Zip = $env:install7zip
	# $WebServerPort = $env:webserverport
	# $WebServerPackage = $env:webserverpackage



	try {
		if($InstallGooglechrome -eq 'true')
		{
			<# Google Chrome Browser #>
			choco install googlechrome -y
		}
	}
	catch
	{
		Write-Output "Unable to install Google Chrome browser"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

	try {
		If($InstallPutty -eq 'true')
		{
			<# Putty application #>
			choco install putty -y
		}
	}
	catch
	{
		Write-Output "Unable to install Putty application"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}

	try {
		If($InstallMySQL -eq 'true')
		{
			<# 7zip application #>
			choco install 7zip -y

			<# MySQL #>
			choco install mysql -y
		}
	}
	catch
	{
		Write-Output "Unable to install MySQL server"
		$ErrorMessage = $_.Exception.Message
		$FailedItem = $_.Exception.ItemName
		Write-Output $ErrorMessage
	}