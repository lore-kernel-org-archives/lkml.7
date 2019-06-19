Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025FAC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E382085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 02:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=teoenmingcorp.onmicrosoft.com header.i=@teoenmingcorp.onmicrosoft.com header.b="cbY9tu73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfFSCYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 22:24:03 -0400
Received: from mail-eopbgr1300085.outbound.protection.outlook.com ([40.107.130.85]:53408
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfFSCYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 22:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector1-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z575xVjAAFQuPw0GL55LDVeQhtfcfEh8bpiTjVje34=;
 b=cbY9tu733pC9VQ/rB9dAi5u2h+xh3klo9PxqsNVweY0NZb9HtCkKIEf3Lxqg5zerVYuWM9DBoKfxnN2pyeHygY8KDYtyRi+C63//fh3H976IYwpMc5mqmYIY34durMqVDEVsrKQk15nVNRuFBAQWTKBF36gwy83BGqPeb5DiZyE=
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com (10.170.143.19) by
 SG2PR01MB2823.apcprd01.prod.exchangelabs.com (20.177.171.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Wed, 19 Jun 2019 02:23:56 +0000
Received: from SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::f1e8:6bca:cba7:caeb]) by SG2PR01MB2141.apcprd01.prod.exchangelabs.com
 ([fe80::f1e8:6bca:cba7:caeb%7]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 02:23:56 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: =?Windows-1252?Q?Teo_En_Ming=92s_Infocomm_Technology_(ICT)_Skillset_(Nov_?=
 =?Windows-1252?Q?2017_to_Jun_2019)?=
Thread-Topic: =?Windows-1252?Q?Teo_En_Ming=92s_Infocomm_Technology_(ICT)_Skillset_(Nov_?=
 =?Windows-1252?Q?2017_to_Jun_2019)?=
Thread-Index: AdUmRelHr4295wVaRHKT2dRR2pCqQg==
Date:   Wed, 19 Jun 2019 02:23:56 +0000
Message-ID: <SG2PR01MB21412797B244265C488A945687E50@SG2PR01MB2141.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [118.189.211.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cee9610f-43cb-4165-89bb-08d6f45d2e21
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SG2PR01MB2823;
x-ms-traffictypediagnostic: SG2PR01MB2823:
x-ms-exchange-purlcount: 5
x-microsoft-antispam-prvs: <SG2PR01MB28234AE8276590C569CDB0CD87E50@SG2PR01MB2823.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(39830400003)(366004)(346002)(189003)(199004)(6506007)(81156014)(476003)(486006)(74316002)(86362001)(2906002)(316002)(2351001)(9686003)(25786009)(107886003)(6436002)(66066001)(66574012)(68736007)(6916009)(45080400002)(76116006)(186003)(6306002)(53936002)(73956011)(55016002)(5640700003)(52536014)(7696005)(26005)(4326008)(64756008)(99286004)(102836004)(81166006)(305945005)(66556008)(66476007)(5660300002)(66446008)(2501003)(71200400001)(66946007)(8936002)(966005)(33656002)(256004)(14454004)(3846002)(71190400001)(6116002)(508600001)(14444005)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR01MB2823;H:SG2PR01MB2141.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kM+SDadXpAmac28599xFMxig20u6WPoSJ/FQ1a7JE46QDG8JTtb/Zxif6j6AL5hSBVN9NOd/hNejZ55HR2lQhOCSg6mobj5ZWqcLY1gAONaw7YUoRlxID3KsB3DbMye7TTIYlo+FfOZkq4jbbWbt/TGspv3DuGj00ftyrUX3Ivrg1VPsWGY5iotid5vVHgMIrxkvfaGDocosY5Mjt5vseKtyNSfaUHxymlPeiljig0FPuxmYcOflpqjXx4SZNF/lINs6ZuWL4X+167fPdBME3/srIwCSlDh7BR8qWAYzJhLH/ZTXmo08KmBJkJFWGsbA6xlV8e097NxNo4aXnZbUS6jWlEE/LgYfKiPNGOVwtVAwMprWoUF4QQQzNEj5Bcfx0D9jiswbmmAXd71UmXrVgjfqvz3joo3VnajBXxnJTOA=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee9610f-43cb-4165-89bb-08d6f45d2e21
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 02:23:56.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ceo@teo-en-ming-corp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR01MB2823
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject/Topic: Turritopsis Dohrnii Teo En Ming=92s Infocomm Technology (ICT=
) Skillset (Nov 2017 to Jun 2019)

This list is prepared on 19th Jun 2019 Wednesday 10:14 AM Singapore Time.

This list is NOT exhaustive and could be incomplete. More ICT skills will b=
e added in the future.

Section A: Turritopsis Dohrnii Teo En Ming=92s Infocomm Technology (ICT) Sk=
illset (Feb 2019 to Jun 2019)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

1. Got SSL VPN to work on Watchguard Firebox T30 Firewall.

2. Installed 90-day free Let's Encrypt Certification Authority SSL certific=
ate on Ubuntu 16.04 LTS /testing/ server for customer successfully.

3. Successfully setup Azure Active Directory Synchronization with Office 36=
5 for Business.

4. Learnt setting up Ubiquiti Cloud Key Controller and UniFi Access Point i=
n a Local Area Network (LAN).

5. Got Internet Protocol Security (IPsec) VPN to work on Fortinet Fortigate=
 60E Next Generation Firewall (NGFW).

6. Learnt Ping Plotter 5, which is a GUI frontend for traceroute(Linux)/tra=
cert(Windows).

7. Learnt tcping command line utility.

8. Learnt Sophos Cloud and Sophos Endpoint Security (Sophos Intercept X Adv=
anced).

9. Successfully setup Active Directory Domain Controller (testing only) for=
 British-based company within a few hours. With Active directory users and =
security groups.

10. Installed Duplicati Backup 2.0.4.5 in Ubuntu 16.04 LTS Linux Server

11. Installed X Windowing server and GNOME desktop manager in Ubuntu 16.04 =
LTS Linux Server

sudo apt-get install xorg gnome

12. Installed 90-day free SSL cert on Internet Information Services 10 Web =
Server on Windows Server 2016 Standard.

13. Learnt a tiny wee bit (0.001%) about Group Policy in Windows Servers (a=
utomatically map network drives/shared folders in computers and laptops tha=
t join Windows domains).

14. Learning how to deploy Fortigate-VM64 firewall virtual appliance in VMw=
are Workstation Player from scratch (learning in progress).

15. Successfully deployed NextCloudPi VM Private Cloud Server in VMware ESX=
i 5.5.0 host (the user interface is a bit like Google Drive).

16. Successfully integrated NextCloud Private Cloud user authentication wit=
h LDAP/Active Directory.

17. Successfully implemented two-factor authentication (2FA) for NextCloud =
Private Cloud using TOTP.

18. Successfully deployed FORTIGATE-VM64 virtual firewall appliance latest =
version 6.0.4 with only one firewall policy and one default static route.

19. Successfully implemented site-to-site IPsec VPN tunnel between Watchgua=
rd Firebox T30 Firewall (Headquarters) and Sophos UTM (SG) Firewall in the =
Cloud. IPsec Phase 1 and Phase 2 settings are all correct.

20. Successfully connected to Java Virtual Console in Dell IDRAC6 for Dell =
Enterprise Servers with Windows command batch file, Java JAR files, Java Dy=
namic Link Libraries and Java Runtime Environment 6 Update 45.

21. Successfully deployed NextCloud SME/Enterprise Appliance (based on Univ=
ention Corporate Server). Successfully integrated with non-UCS Microsoft Wi=
ndows Active Directory.

22. Successfully deployed site-to-site IPsec VPN tunnel between two units o=
f Fortigate-VM64 version 5.6.8 virtual firewall appliances and VMware Works=
tation Pro 15.0.4.

23. Activities on 11th April 2019
a. Configured Fortigate 90D firewall (firmware version 6.0.4) from scratch
b. Re-configured Cisco 881 Router
c. Re-configured 2X Cisco Catalyst 2960X switches
d. Re-configured 3X Cisco Aironet 1600 Wireless Access Points

24. Looked into /var/log/ on Ubuntu 16.04 LTS Server for customer

25. Successfully installed and configured automysqlbackup v3.0-rc6 on Ubunt=
u 16.04 LTS production server. Created cron jobs.

26. Successfully deployed ModSecurity 2.9.0 Web Application Firewall (WAF) =
in blocking mode on Ubuntu 16.04 LTS testing server.

27. Successfully implemented Two-factor Authentication for IPsec Remote Acc=
ess VPN in Fortigate firewall.

28. Introduction to Deep Packet Inspection for firewalls, eg. ndpi-netfilte=
r Linux Kernel module.

29. Learnt how to upgrade firmware for Watchguard Firebox T10 firewall.

30. Learnt Cobian 11 Gravity backup software for Windows.

31. Successfully configured HPE FlexNetwork MSR954-W router with basic rout=
ing and SSH access.

32. Successfully upgraded firmware of HPE FlexNetwork MSR954-W router from =
version 7.1.059 to 7.1.064 and enabled Web UI (https only).

33. Successfully configured Ubiquity Edge Router Lite 3 router from scratch=
.

34. Learnt a bit about Juniper Netscreen firewall.

35. Successfully configured Cisco 881 Router with DYNDNS Dynamic DNS Update=
 from scratch.

36. Completed 2-hour Introduction to Fortinet and Fortigate Firewalls onlin=
e course at Udemy with Certificate of Completion.

37. Learnt that UniFi Cloud Key Controller is based on Debian Linux OS. Uni=
Fi Controller cannot start due to MONGODB database error. Solved by copying=
 out backup config files using WINSCP, upgrading the firmware from 0.6 to 0=
.13.10, reset to factory defaults, and finally restoring backup config file=
.

38. Successfully integrated Fortigate 60E firewall with LDAP Server/Active =
Directory Domain Controller using regular binding.

39. Used Linux grep command and regular expressions to process MDaemon Emai=
l Server SMTP logs in Cygwin64 environment.

40. Brief introduction to PostgreSQL database server on Ubuntu Linux Custom=
er Relationship Management (CRM) server.

41. Learnt how to launch Java Virtual Console on Dell IDRAC on Dell enterpr=
ise servers.

42. Successfully solved Ubiquiti Cloud Key Controller database error (Cloud=
 Key is a Wireless Controller).

43. Successfully configured Huawei B315S-607 4G router for customer.

44. Successfully configured Ubiquiti EdgeRouter Lite 3 router.

45. Learnt command to check Active Directory user account password expirati=
on date.

net user username /domain

46. Successfully installed macOS 10.14 Mojave virtual machine (using VMDK) =
on VMware Workstation Pro 15 on Windows 10 Pro laptop. Need to use macOS Un=
locker to patch VMware Workstation Pro.

47. Successfully installed Ubiquiti UniFi Controller 5.10.24 software on Ub=
untu 18.04 LTS server virtual machine on VMware ESXi 5.5 host. UniFi Contro=
ller is a Wireless Controller.

Section B: Turritopsis Dohrnii Teo En Ming=92s Infocomm Technology (ICT) Sk=
illset (Nov 2017 to Nov 2018)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Achievement No. 1
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setting up my own Microsoft Exchange 2016 Cumulative Update 10 Email Server=
 on-premise. It consists of one Domain Controller and a Domain Member Serve=
r.

Achievement No. 2
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setting up my own cPanel Web Hosting Control Panel in Amazon Web Services (=
AWS) Cloud. It consists of two DNS-ONLY servers and one Virtual server.

Achievement No. 3
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setting up my own Experimental e-Commerce Online Store using WooCommerce in=
 Amazon Web Services (AWS) Cloud.

Achievement No. 4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Creating my own custom minimal Linux distribution from source code, dubbed =
Teo En Ming Extremely Simple Linux 1810.11.

YouTube video: https://www.youtube.com/watch?v=3DL5da1xdQ7Kw

Achievement No. 5
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Deployed Dell SonicWall TZ400 network security appliance for one customer a=
t Ubi and Dell SonicWall TZ300 network security appliance for another custo=
mer at Tuas.

Achievement No. 6
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Deployed open source firewalls like pfSense Community Edition (comparable t=
o commercial grade firewalls) and ipfire for myself.

Achievement No. 7
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Deployed an operational open source Snort Intrusion Prevention System (IPS)=
 for myself.

Achievement No. 8
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setting up SonicWall Global VPN for one customer at Ubi.

Achievement No. 9
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setting up IPsec VPN, OpenVPN and PPTP VPN for a shipping company at Beach =
Road.

Achievement No. 10
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Installed Windows Server 2016 Standard on Lenovo System x 3250 M6 Server an=
d HP Proliant DL360 Gen10 Server with RAID 1 and RAID 5 configurations.

Achievement No. 11
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setting up Active Directory Domain Services, DNS Server and Windows File Sh=
aring.

Achievement No. 12
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Deployed Ruckus Unleashed Network Wireless Access Points for customers at T=
uas and a bungalow.

Achievement No. 13
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Upgraded Symantec Endpoint Protection Manager (Management Console) from ver=
sion 12.1 to 14.2.0 MP1 for a customer at Downtown Core.

Achievement No. 14
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Setting up Avast Business Antivirus Cloud Management Console and installing=
 managed Avast Business Antivirus clients for a customer at Suntec City.

Achievement No. 15
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Experience with numerous Cloud Service Providers, e.g., Amazon Web Services=
, Google Cloud Platform, Microsoft Azure and Alibaba Cloud.

Achievement No. 16
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Some limited experience with open source Elastix Public Branch Exchange (PB=
X) Server for a customer at Senoko.

-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link: https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwav=
e.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

