# Load the PDFCreator COM interface
$pdfCreator = New-Object -ComObject PDFCreator.JobQueue

try {
    $pdfCreator.Initialize()

    $printJob = $pdfCreator.PrintJob

    $applicationSettings = $pdfCreator.GetApplicationSettings()
    $profiles = $applicationSettings.GetProfiles()

    $customProfile = $profiles.CreateProfile("CustomProfile")
    $customProfile.Name = "My Custom Profile"

    $customProfile.PaperSize = New-Object -TypeName PDFCreator.ComImplementation.PaperSize
    $customProfile.PaperSize.Width = 8
    $customProfile.PaperSize.Height = 10
    $customProfile.PaperSize.Unit = [PDFCreator.ComImplementation.PaperSizeUnits]::Inches

    $profiles.SaveProfile($customProfile)

    $applicationSettings.Save()

    Write-Host "Custom profile created successfully."
}
catch {
    Write-Error "An error occurred: $_"
}
finally {
    $pdfCreator.ReleaseCom()
}