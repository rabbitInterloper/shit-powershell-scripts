Write-Host "Starting Script..."
Write-Host "Script successfully loaded without crashing! ⊂(◉‿◉)つ" -BackgroundColor Black -ForegroundColor Green
$NewlineSpam = "`n" * 20
Write-Host $NewlineSpam

#<-- These small two lines actually do read with spaces in the filename; very proud of getting that to work -->#
Write-Host "Please make sure the csv you want to read is in your Downloads Folder, and then give the filename." -BackgroundColor Black -ForegroundColor White
Write-Host "Syntax Examples: My Grid Report.csv / MyGridReport.csv" -BackgroundColor Black -ForegroundColor Gray
$File = Read-Host "Filename" 

#<-- Only way I could find to dynamically get the local Username Object and Trim the domain -->#
$GetLocalUser = Get-WMIObject -class Win32_ComputerSystem |Select-Object username 
$LocalUserTrim = $test.username
$Username = $LocalUserTrim.Trim().Replace("ABC\","")
$CSVData = Import-Csv C:\Users\$Username\Downloads\$File


$FriendlyName = "Friendly Name"
$FirstName = "First Name"
$ObjectData = $CSVData | Select-Object Email, $FriendlyName, $FirstName, OS, Username

Write-Host $NewlineSpam

#<-- User has to pull the trigger here -->#
Write-Host "File Path: C:\Users\$Username\Downloads\$File" -BackgroundColor Black -ForegroundColor Yellow
$Choice = Read-Host "This will email all people listed in $File. Are you sure? [y/n]"
while($Choice -ne "y")
{
    if ($choice -eq 'n') {exit} 

}

#This For Loop goes through each object entry, determines if it's a shared device, and if not send out #
#an email asking the User to update their device with information on it. #

foreach($User in $ObjectData){


if ($User.Username -eq "ZZZMobile" -or $User.Username -eq "XXXMobile" -or $User.Username -eq "CCCmobile" -or $User.Username -eq "WWWMobile" -or $User.Username -eq "AAAMobile" -or $User.Username -eq "BBBproject" -or $user.Username -eq "AAA_AAA_AAA") {
Write-Host "Skipping Shared Device Email inbox for:" $User.Username
}

else {
try{
$BodyEmail = "Hello " + $User.$FirstName + ",`n `nYour Device: " + "'"+ $User.$FriendlyName +"'" + " needs to be updated.`nIt is currently on: " + $User.OS + ", and needs to be updated to the latest version of iOS.`nIf you have any issues in relation to updating, feel free to email the XXX inbox (XXX@gmail.com); and we will assist you.`n `nRegards,`n `n<LARGE SIGNATURE OF TEXT GOES HERE>"
$SubjectEmail = "Your Device: " + $User.$FriendlyName + ", needs to be updated!"

Get-Date
Send-MailMessage -From XXX@gmail.com -To $User.Email -Body $BodyEmail -Subject $SubjectEmail -SmtpServer ZZZ.XXX.YYY.com
Write-Host "Sending Email to" $User.Email "..." -BackgroundColor Black -ForegroundColor Yellow

Start-Sleep -Seconds 5
Write-Host "Email Sent to" $User.Email "!" -BackgroundColor Black -ForegroundColor Green
}
catch{
Get-Date
Write-Host "An Error has occurred, posting object data on error and skipping (╥﹏╥):" $User -BackgroundColor Black -ForegroundColor Red}
}
}
Write-Host "All Emails sent out from" + $File "!" -BackgroundColor Black -ForegroundColor Yellow
Start-Sleep -Seconds 2


Write-Host "Successfully ran script without crashing (ﾉ◕ヮ◕)ﾉ" -BackgroundColor Black -ForegroundColor Green
Write-Host "Exiting Script..."