# OU INFO POWERSHELL FILE
cls
$users=Get-ADUser -Filter * -SearchBase `
'OU=mydomain,DC=mydomain,DC=domain,DC=com'
FOREACH ( $user in $users) {
#Get-ADUser -Identity $user -Properties * | Select SamAccountName,EmployeeID,Name,EmailAddress,Created,extensionattribute6,Title,Department,PasswordLastSet,Office,Enabled
Get-ADUser -Identity $user -Properties * | Select SamAccountName,Name,
}
# Get-ADUser -Identity domain_account -Properties Memberof | Select -ExpandProperty Memberof --> use this command to
# get group details in which the user is a member of.
# Get-ADGroupMember -Identity security-group | Select -Property SamAccountName --> use this command to get members of a group
