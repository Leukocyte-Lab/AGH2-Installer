INSERT INTO public.mitre_groups (id,created_at,updated_at,deleted_at,techniques,exploit_id,name,description,steps,targets) VALUES
	 ('2189560d-6f6f-4c33-88a8-2b6d802cf06a','2022-01-06 13:50:41.27764+08',NULL,NULL,'{"T1071.001","T1217","T1110","T1115","T1059.001","T1059.003","T1059.005","T1543.003","T1485","T1486"}','f6e31497-2a13-4809-9856-9d0f5e86feef','APT38','[APT38](https://attack.mitre.org/groups/G0082) is a North Korean state-sponsored threat group that specializes in financial cyber operations; it has been attributed to the Reconnaissance General Bureau.[1] Active since at least 2014, APT38 has targeted banks, financial institutions, casinos, cryptocurrency exchanges, SWIFT system endpoints, and ATMs in at least 38 countries worldwide. Significant operations include the 2016 Bank of Bangladesh heist, during which APT38 stole $81 million, as well as attacks against Bancomext (2018) and Banco de Chile (2018); some of their attacks have been destructive.','@->Web Server: Port Scan
@->Web Server: Exploit with `CVE-2017-5638`
@->Web Server: Upload `jspspy` and run it
@->Web Server: Start Web Service as Waterhole (`CVE-2016-0189`)
John PC->Web Server: Connect the Waterhole
John PC->@: Spawn a reverse shell with encryption protocols
@->John PC: Exec `net user /domain` to get domain and user list
@->John PC: Find password in clipboard
@->@: Generate wordlist to start brute force
@->Peter PC: Start brute force login
@->Peter PC: Remote login with `HTTP` protocol
Peter PC->Peter PC: Disable firewall
@->Peter PC: Download files in `FTP` via `anonymous` account and try to find password
@->Lisa PC: Start `SMB` brute force login
@->Lisa PC: Remote login with `HTTP` protocol
Lisa PC->Lisa PC: Modify registry to disable defender
@->Lisa PC: Upload `mimikatz` and run it to find domain admin’s `NTLM` hash
@->@: Re-generate 20 wordlist to start brute force
@->Leon PC: Start `SMB` brute force login
@->Leon PC: Remote login with `HTTP` protocol
Leon PC->Leon PC: Set `%TEMP%` as defender''s exclude path
@->Leon PC: Upload `mimikatz` and run it to find domain admin’s `NTLM` hash (success)
@->AD Server: Remote login with encryption protocols
@->AD Server: Upload ransomware and run it to encryption files
@->AD Server: Clear Windows event log
','[{"ip": "", "os": "ArgusHack", "name": "@", "status": "STATUS_PENDING"}, {"ip": "", "os": "Ubuntu Server 16.04", "name": "Web Server", "status": "STATUS_PENDING"}, {"ip": "", "os": "Windows 7", "name": "John PC", "status": "STATUS_PENDING"}, {"ip": "", "os": "Windows 10", "name": "Peter PC", "status": "STATUS_PENDING"}, {"ip": "", "os": "Windows 10", "name": "Lisa PC", "status": "STATUS_PENDING"}, {"ip": "", "os": "Windows 10", "name": "Leon PC", "status": "STATUS_PENDING"}, {"ip": "", "os": "Windows Server 2012", "name": "AD Server", "status": "STATUS_PENDING"}]');
