using System.Diagnostics;

public class SandboxManager{

    public bool CreateNewEnvironment(string nsName){
        return ExecuteBashFile("create-env.sh", new string[]{nsName});
    }

    private bool ExecuteBashFile(string fileName, string[] args){
        var cmd = "sh";
        var argss = $"{fileName} {String.Join(" ", args)}"; //this would become "/home/ubuntu/psa/PdfGeneration/ApacheFolder/ApacheFOP/transform.sh /home/ubuntu/psa/PdfGeneration/ApacheFolder/XMLFolder/test.xml /home/ubuntu/psa/PdfGeneration/ApacheFolder/XSLTFolder/Certificate.xsl /home/ubuntu/psa/PdfGeneration/ApacheFolder/PDFFolder/test.pdf"
        
        var processInfo = new ProcessStartInfo();
        processInfo.UseShellExecute = false;
        processInfo.FileName = cmd;   // 'sh' for bash 
        processInfo.Arguments = argss;    // The Script name 

        var process = Process.Start(processInfo);   // Start that process.
        // var outPut = process.StandardOutput.ReadToEnd();
        process.WaitForExit();

        return true;
    }
}