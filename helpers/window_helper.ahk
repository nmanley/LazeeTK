/**
  * Fetches PIDs from WMI and queries against the given name.
  *
  */
FindNTKPids(name) 
{
    foundPIDS := []
    for proc in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process WHERE Name = '" name "'")
    {
        pid := proc.ProcessId
        foundPIDS.Push(pid)
    }
    return foundPIDS
}