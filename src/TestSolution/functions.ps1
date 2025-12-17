

function Update-AppConfigXmlAppSettings() {
	<#
		.SYNOPSIS
			Updates an app.config file with a new appSettings section

		.DESCRIPTION
			This function takes a new appSetting section (as a Base64 string) and replaces the current appSetting section.
			If no appSetting section exists a new one will be inserted
			
			The following command can be used:
			
			$xml = @"
				<appSettings>
					<add key="Test" value="NewValue" />
				</appSettings>
			"@
			$xmlBase64 = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($xml))
			$xmlBase64
			

		.EXAMPLE
			Update-AppConfigXmlAppSettings $(Join-Path $(Get-Location) "bin/Debug/EdgeDriverTest1.dll.config") "PGFwcFNldHRpbmdzPgo8YWRkIGtleT0iVGVzdCIgdmFsdWU9Ik5ld1ZhbHVlIiAvPgo8L2FwcFNldHRpbmdzPg=="
			
			# If the current file contained:
			#
			# <?xml version="1.0" encoding="utf-8"?>
			# <configuration>
			# 	<appSettings>
			#	<add key="Test" value="RepoValue" />
			# </appSettings>
			# </configuration>
			#
			# It would be replaced with:
			#
			# <?xml version="1.0" encoding="utf-8"?>
			# <configuration>
			# 	<appSettings>
			# 	<add key="Test" value="NewValue" />
			# </appSettings>
			# </configuration>
	#>
	param(
        [Parameter(Position = 0, Mandatory)]
        [string] $appConfigXmlPath,

        [Parameter(Position = 1, Mandatory)]
        [string] $newAppSettingsXmlAsBase64
    )

	Write-Host "appConfigPath: $appConfigXmlPath"
	Write-Host "newAppSettingsXmlAsBase64: $newAppSettingsXmlAsBase64"
	  
	if (-not (Test-Path -Path $appConfigXmlPath -PathType Leaf)) {
	throw "Required file not found: $appConfigXmlPath"
	}
	  
	[xml]$configXmlFile = Get-Content $appConfigXmlPath
	Write-Host "Existing Xml:"
	$configXmlFile.Save([Console]::Out)

	$bytes = [System.Convert]::FromBase64String($newAppSettingsXmlAsBase64)
	$newXml = [System.Text.Encoding]::UTF8.GetString($bytes)
	Write-Host ""
	Write-Host ""
	Write-Host "New appSettings section:"
	Write-Host "$newXml"
	$newAppSettings = [xml]$newXml
	  
	# Find the old <appSettings> node
	$oldAppSettingsNode = $configXmlFile.configuration.appSettings

	if ($oldAppSettingsNode -ne $null) {
		# Replace old <appSettings> with the new one
		$parent = $oldAppSettingsNode.ParentNode
		$importedNode = $configXmlFile.ImportNode($newAppSettings.appSettings, $true)
		$parent.ReplaceChild($importedNode, $oldAppSettingsNode)
	} else {
		# If no <appSettings> exists, append it
		$importedNode = $configXmlFile.ImportNode($newAppSettings.appSettings, $true)
		$configXmlFile.configuration.AppendChild($importedNode) | Out-Null
	}
}

function Update-AppConfigXmlAppSettings2() {
	<#
		.SYNOPSIS
			Updates an app.config file with a new appSettings section

		.DESCRIPTION
			This function takes a new appSetting section (as a Base64 string) and replaces the current appSetting section.
			If no appSetting section exists a new one will be inserted
			
			The following command can be used:
			
			$xml = @"
				<appSettings>
					<add key="Test" value="NewValue" />
				</appSettings>
			"@
			$xmlBase64 = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($xml))
			$xmlBase64
			

		.EXAMPLE
			Update-AppConfigXmlAppSettings $(Join-Path $(Get-Location) "bin/Debug/EdgeDriverTest1.dll.config") "PGFwcFNldHRpbmdzPgo8YWRkIGtleT0iVGVzdCIgdmFsdWU9Ik5ld1ZhbHVlIiAvPgo8L2FwcFNldHRpbmdzPg=="
			
			# If the current file contained:
			#
			# <?xml version="1.0" encoding="utf-8"?>
			# <configuration>
			# 	<appSettings>
			#	<add key="Test" value="RepoValue" />
			# </appSettings>
			# </configuration>
			#
			# It would be replaced with:
			#
			# <?xml version="1.0" encoding="utf-8"?>
			# <configuration>
			# 	<appSettings>
			# 	<add key="Test" value="NewValue" />
			# </appSettings>
			# </configuration>
	#>
	
    param(
        [Parameter(Position = 0, Mandatory)]
        [string] $appConfigXmlPath,

        [Parameter(Position = 1, Mandatory)]
        [string] $newAppSettingsXmlAsBase64
    )
      	  
	  Write-Host "appConfigPath: $appConfigXmlPath"
	  Write-Host "newAppSettingsXmlAsBase64: $newAppSettingsXmlAsBase64"
	  
	  if (-not (Test-Path -Path $appConfigXmlPath -PathType Leaf)) {
		throw "Required file not found: $appConfigXmlPath"
	  }
	  
	  [xml]$configXmlFile = Get-Content $appConfigXmlPath
	  Write-Host "Existing Xml:"
	  $configXmlFile.Save([Console]::Out)
	  
	  $bytes = [System.Convert]::FromBase64String($newAppSettingsXmlAsBase64)
	  $newXml = [System.Text.Encoding]::UTF8.GetString($bytes)
	  Write-Host ""
	  Write-Host ""
	  Write-Host "New appSettings section:"
	  Write-Host "$newXml"
	  $newAppSettings = [xml]$newXml
	  
	  # Find the old <appSettings> node
	  $oldAppSettingsNode = $configXmlFile.configuration.appSettings

	  if ($oldAppSettingsNode -ne $null) {
	    # Replace old <appSettings> with the new one
		$parent = $oldAppSettingsNode.ParentNode
		$importedNode = $configXmlFile.ImportNode($newAppSettings.appSettings, $true)
		$parent.ReplaceChild($importedNode, $oldAppSettingsNode)
	  } else {
		# If no <appSettings> exists, append it
		$importedNode = $configXmlFile.ImportNode($newAppSettings.appSettings, $true)
		$configXmlFile.configuration.AppendChild($importedNode) | Out-Null
	  }
	  Write-Host ""
	  Write-Host "Saving file..."
	  
	  # Save the updated XML back to the file
	  $configXmlFile.Save($appConfigXmlPath)
	  Write-Host "File saved"
}