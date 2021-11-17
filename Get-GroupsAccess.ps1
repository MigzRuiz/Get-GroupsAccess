$OutFile = "C:\Permissions.csv"
$Header = "Folder Path = IdentityReference"
Del $OutFile
Add-Content -Value $Header -Path $OutFile 


$RootPath = "C:\test"
$GroupName = "GROUP NAME HERE"

$Folders = dir $RootPath -recurse | where {$_.psiscontainer -eq $true}

foreach ($Folder in $Folders){
	$ACLs = get-acl $Folder.fullname | ForEach-Object { $_.Access  }
	Foreach ($ACL in $ACLs){
		
		if($ACL.IdentityReference -like $GroupName) {
			$OutInfo = $Folder.Fullname + " = " + $ACL.IdentityReference
			echo $OutInfo
			Add-content -Value $OutInfo -Path $OutFile
		}
	}
}
