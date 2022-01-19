function handler($context, $inputs) {
    
    # Initialize global variables
    $vcUser = $inputs.customProperties.vCenterUser
    $vcPassword = $context.getSecret($inputs."vcPassword")
    $vCenter = $inputs.customProperties.vCenter
    
    # Create vmtools connection to the VM 
    $vmName = $inputs.resourceNames[0]
    Connect-ViServer -Server $vCenter -User $vcUser -Password $vcPassword -Force
    $vm = Get-VM -Name $vmName
    Write-Host "Waiting for VM Tools to start..."
    if (-not (Wait-Tools -VM $vm -TimeoutSeconds 180)) {
        Write-Error "Unable to establish connection with VM tools" -ErrorAction Stop
    }
    
    # Detect OS type
    $count = 0
    While (!$osType) {
        Try {
            $osType = ($vm | Get-View).Guest.GuestFamily.ToString()
            $toolsStatus = ($vm | Get-View).Guest.ToolsStatus.ToString()        
        } Catch {
            # 60s timeout
            if ($count -ge 12) {
                Write-Error "Timeout exceeded while waiting for tools." -ErrorAction Stop
                break
            }
            Write-Host "Waiting for tools..."
            $count++
            Sleep 5
        }
    }
    Write-Host "$vmName is a $osType and its tools status is $toolsStatus."
    
    
    # Update tools on VM if out of date
    if ($toolsStatus.Equals("toolsOld")) {
        Write-Host "Updating VM Tools..."
        Update-Tools $vm
        Write-Host "Waiting up to 5 min for VM Tools to start..."
        if (-not (Wait-Tools -VM $vm -TimeoutSeconds 300)) {
            Write-Error "Unable to establish connection with VM tools" -ErrorAction Stop
        }
    }
    
    
    # Run OS-specific tasks
    
    if ($osType.Equals("windowsGuest")) {
        
        $script = "Script Here!"
        
        
        Start-Sleep -s 60
        $runscript = Invoke-VMScript -VM $vm -ScriptText $script -GuestUser $tmpl_user -GuestPassword $tmpl_pass -ToolsWaitSecs 300
        Write-Host $runscript.ScriptOutput
        
       
        Write-Host "Script Completed"
    
    # Cleanup connection
    Disconnect-ViServer -Server $vCenter -Force -Confirm:$false

    } 
    
    else {
        
        $script = "Script Here!"
       
    
        Start-Sleep -s 60
        $runscript = Invoke-VMScript -VM $vm -ScriptText $script -GuestUser $tmpl_user -GuestPassword $tmpl_pass -ToolsWaitSecs 300
        Write-Host $runscript.ScriptOutput
        
        Write-Host = "Script Completed"
    }
    
    
}