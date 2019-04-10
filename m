Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D28C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046AC2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 06:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="B84SeBoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfDJGHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 02:07:23 -0400
Received: from mail-eopbgr1300072.outbound.protection.outlook.com ([40.107.130.72]:30160
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725924AbfDJGHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 02:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynrFHRlZLrj5J+eHpTcvYxhKBma448ynGvYpIOwKqZk=;
 b=B84SeBoLbbtVkwbBVgf5tZWBOduQogOzy+ZJ8ATNuN5dg1VuAcHQ9zX9r0n3LuX2ic3CM/qaA/aTwEQWH7iGsF9Igp2DrRlTLAjz8Mun3BpCXTugbYGDfwcYpTwDu9uqV/oLZ+B15u7lmVH7mznHkN9Eugw26DgkcsTHHnLZtPU=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB1567.apcprd02.prod.outlook.com (10.167.77.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.19; Wed, 10 Apr 2019 06:06:36 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1771.019; Wed, 10 Apr 2019
 06:06:36 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     Christopher Lameter <cl@linux.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [External] Re: Basics : Memory Configuration
Thread-Topic: [External] Re: Basics : Memory Configuration
Thread-Index: AQHU7qEJC6EuUiGvjEiZ+OVh95dcd6Yz/amAgADo4Wc=
Date:   Wed, 10 Apr 2019 06:06:36 +0000
Message-ID: <SG2PR02MB30989B644196598CEDDD5337E82E0@SG2PR02MB3098.apcprd02.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: cc86bda2-c7a8-422d-8c58-08d6bd7ab055
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:SG2PR02MB1567;
x-ms-traffictypediagnostic: SG2PR02MB1567:
x-microsoft-antispam-prvs: <SG2PR02MB15676281446B4EBE6DB49FA7E82E0@SG2PR02MB1567.apcprd02.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39840400004)(376002)(136003)(366004)(396003)(189003)(199004)(66066001)(54906003)(25786009)(478600001)(33656002)(6116002)(3846002)(76176011)(2906002)(55016002)(78486014)(6436002)(86362001)(52536014)(7696005)(11346002)(229853002)(14454004)(71200400001)(6916009)(446003)(71190400001)(316002)(186003)(14444005)(4326008)(7736002)(53936002)(105586002)(256004)(81166006)(5660300002)(99286004)(6246003)(476003)(55236004)(6506007)(9686003)(8676002)(53546011)(106356001)(8936002)(66574012)(97736004)(81156014)(68736007)(44832011)(74316002)(305945005)(486006)(26005)(5024004)(102836004)(586874002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB1567;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bmlzdzWn2Pk1q+5mTtZD2YfVM4p8MYkS2goKRW2wAiGy3RGQ5ZA+V1EAlAr02T/h9h9tivL/4aZi4r8ZyEjCtBh19n8bwbymr9vwGmayKtsH2Ck1uG6De9jH5PFvDWs1nXlLAoJHGsiQqXVPwzEgR3sjzs46gKhGdkM0xwHnPayqhi/0BfUOOLgwo0PTPYaNU8PuyFx8gKlI9tOdR2dLCskYMBq9mPNcYb7xmpdC+f1hdDJO696BMrmebIWtGf2zzlhjSm50YGZpXtk6Yy/U2WUHP3b+mlH4XWzHRFs8aM3d4KOJx/+Tv/qr0rgl1NZtYLjNxBmZCkrbnYaHq9GzaC34fcrKhex5/Nf/keW2C5fzWYE8DnYoHn74JaVB1B+d33RV/i2YHlGKpyLijCKgPhU3R7NWufaLGyUlTROKy7M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc86bda2-c7a8-422d-8c58-08d6bd7ab055
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 06:06:36.0929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB1567
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

The size of the virtual memory space per process is configurable on x86 32
bit (2G, 3G, 4G). Thus the possible virtual process size may vary
depending on the hardware architecture and the configuration of the
kernel.

If i have configures VMSPLIT =3D 2G/2G what does it mean ?
Virtual memory uses disk space ? let say for 32-bit os i have 4GB ram than =
what is the use case of virtual memory ?

If i have 32-bit and 2gb/3gb ram than virtual memory is useful  because its=
 less than 4GB ?

> 2. In 32-bit os 12 bits are offset because page size=3D4k i.e 2^12 and
> 2^20 for page addresses
>    What about 64-bit os, What is offset size ? What is page size ? How it=
 calculated.

12 bits are passed through? Thats what you mean?

The remainder of the bits  are used to lookup the physical frame
number(PFN) in the page tables.

64 bit is the same. However, the number of bits used for lookups in the
page tables are much higher.

for 32-bit os page size is 4k, what is the page size for 64-bit os ? page s=
ize and offset is related to each other ?

if i increase the page size from 4k to 8k, does it change the offset size t=
hat it 2^12 to 2^13 ?

Why only 48 bits are used in 64-bit os ?


> 3. What is PAE? If enabled how to decide size of PAE, what is maximum
> and minimum size of extended memory.

PAE increases the physical memory size that can be addressed through a
page table lookup. The number of bits that can be specified in the PFN is
increased and thus more than 4GB of physical memory can be used by the
operating system. However, the virtual memory size stays the same and an
individual process still cannot use more memory.

Let say i have ,enabled PAE for 32-bit os with 6GB ram.Virtual size is same=
 4GB, 32-bit os cant address more thatn 4gb, Than what is the use of 6GB wi=
th PAE enabled.

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
