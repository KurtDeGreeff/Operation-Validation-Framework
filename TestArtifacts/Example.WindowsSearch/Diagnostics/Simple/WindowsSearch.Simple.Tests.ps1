Describe "Windows Search finds the proper application" {
    It "Finds notepad" {
        $con = new-object -com ADODB.Connection
        $rs = new-object -com ADODB.RecordSet
        $con.Open("Provider=Search.CollatorDSO;Extended properties='Application=Windows';")
        $rs.Open("Select System.ItemPathDisplay FROM SYSTEMINDEX Where System.FileName = 'notepad.exe'",$con)
        $rs.MoveFirst()
        $notepads = @()
        While(! $rs.EOF ){
            $notepads += $rs.Fields['System.ItemPathDisplay'].Value
            $rs.MoveNext()
        }
        $rs.Close()
        $con.Close()
        $notepadPath = "C:\Windows\System32\notepad.exe"
        $notepads -eq $notepadpath | Should be $notepadpath
        
    }
}
