# Set-ExecutionPolicy RemoteSigned

param (
    [string]   $Source,
    [string]   $Placeholder,
    [switch]   $Debug,
    [switch]   $AsciiHexRandom,
    [string]   $Destination,
    [string]   $Destination2
)



$CSharp = @"
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Security.Cryptography;


public class HexLines {

    public HexLines() { }

    private readonly List<HexLine> Lines = new List<HexLine>();
    public readonly List<ByteLine> Bytes = new List<ByteLine>();


    public void Add(string line) {
        var hexLine = new HexLine(line);
        this.Lines.Add(hexLine);

        var bytes = hexLine.GetDataBytes();
        for (int i = 0; i < bytes.Length; i++) {
            this.Bytes.Add(new ByteLine(hexLine, i, bytes[i]));
        }
    }

    public int LineCount { get { return this.Lines.Count; } }
    public int ByteCount { get { return this.Bytes.Count; } }


    public int Find(int startAt, byte[] bytesToFind) {
        for (int i = startAt; i < this.Bytes.Count - bytesToFind.Length; i++) {
            bool isMatch = true;
            for (int j = 0; j < bytesToFind.Length; j++) {
                if (this.Bytes[i + j].Value != bytesToFind[j]) {
                    isMatch = false;
                    break;
                }
            }
            if (isMatch) { return i; }
        }
        return -1;
    }


    public void Fill(int startAt, byte[] bytes) {
        for (int i = 0; i < bytes.Length; i++) {
            var byteLine = this.Bytes[startAt + i];
            byteLine.Line.SetDataByte(byteLine.Index, bytes[i]);
        }
    }

    public IEnumerable<HexLine> AllLines {
        get {
            foreach (var line in this.Lines) {
                yield return line;
            }
        }
    }
}


public class HexLine {
    public HexLine(string line) {
        if (line.StartsWith(":")) {
            var dataLength = byte.Parse(line.Substring(1, 2), NumberStyles.HexNumber, CultureInfo.InvariantCulture);
            if (dataLength * 2 < line.Length - 3) {
                var dataOffset = line.Length - dataLength * 2 - 2;
                this.Start = ":";
                this.Prefix = line.Substring(1, dataOffset - 1);
                this.Data = line.Substring(dataOffset, dataLength * 2);
                this.Checksum = line.Substring(dataOffset + dataLength * 2);
            } else {
                this.Start = line;
            }
        } else {
            this.Start = line;
        }
    }

    private readonly string Start;
    private readonly string Prefix;
    private string Data;
    private string Checksum;

    public string Content { get { return this.Start + this.LinePrefixAndData + (this.Checksum ?? ""); } }
    private string LinePrefixAndData { get { return (this.Prefix ?? "") + (this.Data ?? ""); } }

    public byte[] GetDataBytes() {
        if (this.Data != null) {
            var list = new List<byte>();
            for (int i = 0; i < this.Data.Length; i += 2) {
                list.Add(byte.Parse(this.Data.Substring(i, 2), NumberStyles.HexNumber, CultureInfo.InvariantCulture));
            }
            return list.ToArray();
        } else {
            return new byte[] { };
        }
    }

    public void SetDataByte(int index, byte value) {
        var dataBytes = this.GetDataBytes();
        dataBytes[index] = value;
        this.Data = BitConverter.ToString(dataBytes).Replace("-", "");
        byte checksum = 0;
        for (int i = 0; i < this.LinePrefixAndData.Length; i += 2) {
            var b = byte.Parse(this.LinePrefixAndData.Substring(i, 2), NumberStyles.HexNumber, CultureInfo.InvariantCulture);
            checksum = (byte)((checksum + b) % 256);
        }
        checksum = (byte)((~checksum + 1) % 256);
        this.Checksum = checksum.ToString("X2");
    }
}


public class ByteLine {

    public ByteLine(HexLine line, int index, byte value) {
        this.Line = line;
        this.Index = index;
        this.Value = value;
    }

    public HexLine Line { get; private set; }
    public int Index { get; private set; }
    public byte Value { get; private set; }

}


public static class Helper {

    public static byte[] GetPlaceholderBytes(string placeholder) {
        var list = new List<byte>();
        foreach (var ch in placeholder) {
            int chNum = ch;
            if (chNum < 0) { chNum = 0; }
            if (chNum > 255) { chNum = 255; }
            list.Add((byte)chNum);
        }
        return list.ToArray();
    }

    public static byte[] GetPlaceholderBytes(string placeholder, int additionalNullCount) {
        var list = new List<byte>();
        foreach (var b in GetPlaceholderBytes(placeholder)) {
            list.Add(b);
            for (int i = 0; i < additionalNullCount; i++) { list.Add(0); }
        }
        return list.ToArray();
    }

    public static byte[] GetRandomBytes(int length, bool asciiHexRandom = false) {
        var buffer = new byte[length];
        RandomNumberGenerator.Create().GetBytes(buffer);
        if (asciiHexRandom) {
            for (int i = 0; i < buffer.Length; i++) {
                buffer[i] = (byte)(buffer[i] % 16);
                buffer[i] = (byte)(((buffer[i] < 10) ? 0x30 : 0x37) + buffer[i]);
            }
        }
        return buffer;
    }

    public static byte[] GetRandomBytes(int length, int additionalNullCount, bool asciiHexRandom = false) {
        var list = new List<byte>();
        foreach (var b in GetRandomBytes(length, asciiHexRandom)) {
            list.Add(b);
            for (int i = 0; i < additionalNullCount; i++) { list.Add(0); }
        }
        return list.ToArray();
    }

}
"@
if (-not ("HexLines" -as [type])) {
    Add-Type -TypeDefinition $CSharp
}



if ($Debug -eq $true) {
   $DebugPreference = "Continue" #powershell will show the debug message.
}


$SourceFileName = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Source)

if (($Destination -eq $Null) -or ($Destination.length -eq 0)) {
    $DestinationFileName = $SourceFileName
} else {
    $DestinationFileName = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination)
}

if (($Destination2 -eq $Null) -or ($Destination2.length -eq 0)) {
    $Destination2FileName = $Null
} else {
    $Destination2FileName = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Destination2)
}


Write-Debug "Source file name ........: $SourceFileName"
Write-Debug "Destination file name ...: $DestinationFileName"
if ($Destination2FileName -ne $Null) {
    Write-Debug "Destination (2) file name: $Destination2FileName"
}
Write-Debug "Placeholder .............: $Placeholder"
if ($AsciiHexRandom -eq $true) {
    Write-Debug "Random numbers ..........: ASCII Hex"
} else {
    Write-Debug "Random numbers ..........: Binary"
}


$Reader = New-Object System.IO.StreamReader("$SourceFileName") 
$Lines = New-Object HexLines
while (($line = $Reader.ReadLine()) -ne $null)  {
    $Lines.Add("$line")
}
$Reader.Dispose()
Write-Debug("Hex line count ..........: " + $Lines.Count)


foreach ($i in 0, 1) {
    Write-Debug " "
    $placeholderBytes = [Helper]::GetPlaceholderBytes("$Placeholder", $i)
    Write-Debug("Searching for " + [System.BitConverter]::ToString($placeholderBytes))

    $location = $Lines.Find(0, $placeholderBytes);
    $location2 = $Lines.Find($location + 1, $placeholderBytes);
    if ($location -eq $location2) {
        if ($location -eq -1) {
            Write-Debug "  Cannot find placeholder!"
        } else {
            Write-Debug "  Cannot determine unique replace location for placeholder!"
        }
        continue
    } else {
        $newBytes = [Helper]::GetRandomBytes("$Placeholder".Length, $i, ($AsciiHexRandom -eq $true))
        Write-Debug("  Replacing with " + [System.BitConverter]::ToString($newBytes))
        $Lines.Fill($location, $newBytes);
        
        $Writer = New-Object System.IO.StreamWriter("$DestinationFileName") 
        foreach ($line in $Lines.AllLines)  {
            $Writer.WriteLine($line.Content)
        }
        $Writer.Dispose()
        
        Write([System.BitConverter]::ToString($placeholderBytes) + " -> " + [System.BitConverter]::ToString($newBytes))
        Write("$DestinationFileName")

        if ($Destination2FileName -ne $Null) {
            Copy-Item $DestinationFileName $Destination2FileName
            Write("$Destination2FileName")
        }

        return;
    }
}
Write-Error "Cannot find placeholder!"