Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3292C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B690B2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="EwkahNqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbfDKFd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:33:28 -0400
Received: from mail-eopbgr1300040.outbound.protection.outlook.com ([40.107.130.40]:65080
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726646AbfDKFd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/01hvD1MohZ5VWaUYvOCFUU2hZKlsxB3EeWHB9PWUg=;
 b=EwkahNqo8zYPigRvCUX875SznmYF2P08fHmy8VPiFhLha33RcoSF3D+hbS36QH+UXmd5Q8rHY0OK0G1SEPfM4PtvpjufoQ+0ZiKyc9ZC5ni0JQRSg4B5aNeDZcM05RiGe6ry/TiwbLm0wrmiXSHBCT9sdVAWbKTZXIKYqw6/Kg4=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB2778.apcprd02.prod.outlook.com (20.177.86.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.21; Thu, 11 Apr 2019 05:33:22 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1771.019; Thu, 11 Apr 2019
 05:33:22 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Christopher Lameter <cl@linux.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [External] Re: Basics : Memory Configuration
Thread-Topic: [External] Re: Basics : Memory Configuration
Thread-Index: AQHU7qEJC6EuUiGvjEiZ+OVh95dcd6Yz/amAgAJxijU=
Date:   Thu, 11 Apr 2019 05:33:22 +0000
Message-ID: <SG2PR02MB309859B3EFFF331580DBA8C5E82F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098925678D8D40B683E10E2E82D0@SG2PR02MB3098.apcprd02.prod.outlook.com>,<0100016a02d5038e-2e436033-7726-4d2a-b29d-d3dbc4c66637-000000@email.amazonses.com>
In-Reply-To: <0100016a02d5038e-2e436033-7726-4d2a-b29d-d3dbc4c66637-000000@email.amazonses.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66e8d897-7af6-4d62-6876-08d6be3f3696
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:SG2PR02MB2778;
x-ms-traffictypediagnostic: SG2PR02MB2778:
x-microsoft-antispam-prvs: <SG2PR02MB2778265B3A8A4CADDFE205D6E82F0@SG2PR02MB2778.apcprd02.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39850400004)(366004)(346002)(136003)(396003)(199004)(189003)(55236004)(78486014)(52536014)(6506007)(14454004)(106356001)(66066001)(97736004)(478600001)(33656002)(86362001)(76176011)(53546011)(8936002)(7696005)(44832011)(256004)(305945005)(7736002)(99286004)(14444005)(5024004)(74316002)(105586002)(53936002)(9686003)(186003)(5660300002)(229853002)(6246003)(54906003)(4326008)(55016002)(66574012)(316002)(3846002)(25786009)(2906002)(6116002)(81166006)(71200400001)(26005)(6436002)(6916009)(102836004)(8676002)(476003)(446003)(11346002)(486006)(81156014)(71190400001)(68736007)(586874002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB2778;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Ddx/yFysrWC4fokHAeGtpK9FVOrEnUYEHokJj+7WepvmEORCTDI4/F3InqtXR4zIzxc6MuKg6Zyex30gw4ubBA92OYmjnHOewpHJkyEuDkiVTeUjVHHflrAjoJqYiEZvC617gftjylQ14SOtdwiBL6GHO02BzK+PARIwan43Om3suS2mRMaHgnEKpkJaY/FZYc2qjVJcYD36trf1gX6kOEqAng2pbWR5AxnWTU8ngeSi9nDm4aPURKwKRM0O4STotEevVm45IMdZnqnt0nOQjumLLwoR+MIE0SRNKS+xbrelplwEQ/oX8if5w+kwxOS9pJQs12gF/SkTOiQ+MXZwQI7rhcDvw6duqdtutlVkPgXxh0BAkAobyIbWcXwbsrgvQvmwyZsY0k4culmokolmZYQs+X1MbhJuTuDcF84UydY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e8d897-7af6-4d62-6876-08d6be3f3696
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 05:33:22.5626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2778
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
From: Christopher Lameter <cl@linux.com>
Sent: 09 April 2019 21:31
To: Pankaj Suryawanshi
Cc: linux-kernel@vger.kernel.org; linux-mm@kvack.org
Subject: [External] Re: Basics : Memory Configuration



On Tue, 9 Apr 2019, Pankaj Suryawanshi wrote:


> I am confuse about memory configuration and I have below questions

Hmmm... Yes some of the terminology that you use is a bit confusing.

> 1. if 32-bit os maximum virtual address is 4GB, When i have 4 gb of ram
> for 32-bit os, What about the virtual memory size ? is it required
> virtual memory(disk space) or we can directly use physical memory ?

The virtual memory size is the maximum virtual size of a single process.
Multiple processes can run and each can use different amounts of physical
memory. So both are actually independent.

Okay Got it.

The size of the virtual memory space per process is configurable on x86 32
bit (2G, 3G, 4G). Thus the possible virtual process size may vary
depending on the hardware architecture and the configuration of the
kernel.

Another Questions -
- Q. If i configures VMSPLIT =3D 2G/2G what does it mean ?
- Q. Disk Space is used by Virtual Memory ? If this is true, than without s=
econdary storage there is no virtual memory ?
        let say for 32-bit os i have 4GB ram than what is the use case of v=
irtual memory ?

> 2. In 32-bit os 12 bits are offset because page size=3D4k i.e 2^12 and
> 2^20 for page addresses
>    What about 64-bit os, What is offset size ? What is page size ? How it=
 calculated.

12 bits are passed through? Thats what you mean?

The remainder of the bits  are used to lookup the physical frame
number(PFN) in the page tables.

64 bit is the same. However, the number of bits used for lookups in the
page tables are much higher.

- Q. for 32-bit os page size is 4k, what is the page size for 64-bit os ? p=
age size and offset is related to each other ?
- Q. if i increase the page size from 4k to 8k, does it change the offset s=
ize that it 2^12 to 2^13 ?
- Q. Why only 48 bits are used in 64-bit os ?


> 3. What is PAE? If enabled how to decide size of PAE, what is maximum
> and minimum size of extended memory.

PAE increases the physical memory size that can be addressed through a
page table lookup. The number of bits that can be specified in the PFN is
increased and thus more than 4GB of physical memory can be used by the
operating system. However, the virtual memory size stays the same and an
individual process still cannot use more memory.

- Q. Let say i enabled PAE for 32-bit os with 6GB ram.Virtual size is same =
4GB, 32-bit os cant address more thatn 4gb, Than what is the use of 6GB wit=
h PAE enabled.
***************************************************************************=
***************************************************************************=
******* eInfochips Business Disclaimer: This e-mail message and all attachm=
ents transmitted with it are intended solely for the use of the addressee a=
nd may contain legally privileged and confidential information. If the read=
er of this message is not the intended recipient, or an employee or agent r=
esponsible for delivering this message to the intended recipient, you are h=
ereby notified that any dissemination, distribution, copying, or other use =
of this message or its attachments is strictly prohibited. If you have rece=
ived this message in error, please notify the sender immediately by replyin=
g to this message and please delete it from your computer. Any views expres=
sed in this message are those of the individual sender unless otherwise sta=
ted. Company has taken enough precautions to prevent the spread of viruses.=
 However the company accepts no liability for any damage caused by any viru=
s transmitted by this email. **********************************************=
***************************************************************************=
************************************
