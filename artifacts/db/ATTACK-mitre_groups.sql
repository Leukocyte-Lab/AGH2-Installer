INSERT INTO public.mitre_groups (id,created_at,updated_at,deleted_at,techniques,exploit_id,name,description,steps,targets) VALUES
	 ('0efb0d84-59dd-4a07-9b76-973f67f9eab2','2022-01-06 13:50:41.283591+08','2022-01-06 13:50:41.283591+08',NULL,'{"T1213.002","T1059.004"}','dc1f6262-cd58-4659-9f7e-3a88fe4ad6a8','MitreGroup-2','Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit','@->@: Generate wordlist to start brute force @->target-3: Start brute force login @->target-3: Remote login with `HTTP` protocol target-3->target-3: Disable firewall @->target-3: Download files in `FTP` via `anonymous` account and try to find password @->target-4: Start `SMB` brute force login @->target-4: Remote login with `HTTP` protocol target-4->target-4: Modify registry to disable defender @->target-4: Upload `mimikatz` and run it to find domain admin’s `NTLM` hash @->@: Re-generate 20 wordlist to start brute force ','[{"ip": "", "os": "Linux", "name": "target-3"}, {"ip": "", "os": "WIN10", "name": "target-4"}]'),
	 ('1d71b41d-0e4b-450c-91cf-8893373701df','2022-01-06 13:50:41.27764+08','2022-01-06 13:50:41.27764+08',NULL,'{"T1548.001","T1499.001"}','d7bc05e7-c6a5-403a-b966-b85982b378ac','MitreGroup-1','Lorem Ipsum is simply dummy text of the printing and typesetting industry.','@->AGH-Group-Lisa: Port Scan
AGH-Group-John->AGH-Group-Lisa: Connect the Waterhole
AGH-Group-John->@: Spawn a reverse shell with encryption protocols','[{"ip": "", "os": "ArgusHack", "name": "@"}, {"os": "WINDOWS_9_64", "name": "AGH-Group-Lisa"}, {"os": "WINDOWS_7_64", "name": "AGH-Group-John"}]'),
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
