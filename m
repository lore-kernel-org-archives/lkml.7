Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CACFC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553E721479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 14:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="iziCrLrw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbfDROLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 10:11:17 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:61048 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbfDROLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 10:11:16 -0400
X-IronPort-AV: E=Sophos;i="5.60,366,1549954800"; 
   d="scan'208";a="30585053"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 18 Apr 2019 07:11:12 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.108) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 18 Apr 2019 07:11:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULA6uS9lZOs0fkNikHNemWvqx4GlEJUO/b1qAjZw+Ts=;
 b=iziCrLrwcyRsy+X5RpWgciTOzR6UmA0RJ/GX8elfeX/Yjdx3IBajm1bCmbK+kLFwuOjqQnI/ptoC2CRKInDWFCUe95Y0eLs+twdXRFNoNqNbevUvgJ+0Q4YVHNo/3drjKyl8s0qy31dnHa/2csZMbk0ZZBm3IDcqcxqxHnVGGL4=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.98.146) by
 BN6PR11MB1587.namprd11.prod.outlook.com (10.172.24.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.17; Thu, 18 Apr 2019 14:11:10 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e4c0:24a5:9a32:46e3]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::e4c0:24a5:9a32:46e3%9]) with mapi id 15.20.1792.018; Thu, 18 Apr 2019
 14:11:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <nagasure@xilinx.com>, <liu.xiang6@zte.com.cn>, <vigneshr@ti.com>
CC:     <bbrezillon@kernel.org>, <broonie@kernel.org>, <richard@nod.at>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <marek.vasut@gmail.com>, <linux-mtd@lists.infradead.org>,
        <nagasuresh12@gmail.com>, <dwmw2@infradead.org>,
        <michals@xilinx.com>
Subject: Re: 4-Byte addressing issue with IS25WP256D nor flash
Thread-Topic: 4-Byte addressing issue with IS25WP256D nor flash
Thread-Index: AdTZgzps1dokp2Q3SSmhxyFZkToq1ADyQRIAAEN81xAF5ZbtAA==
Date:   Thu, 18 Apr 2019 14:11:10 +0000
Message-ID: <dd6cc84d-7dc3-af55-9177-7930544f0dcf@microchip.com>
References: <MWHPR02MB2623388725B13BB7B133B98BAF4A0@MWHPR02MB2623.namprd02.prod.outlook.com>
 <e1e2f867-8a28-c74b-7f01-5f798e37c81d@microchip.com>
 <MWHPR02MB2623D039832785A980B3B8EFAF400@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB2623D039832785A980B3B8EFAF400@MWHPR02MB2623.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0089.eurprd04.prod.outlook.com
 (2603:10a6:803:64::24) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:101::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 540e8173-ff39-4c76-77c4-08d6c407b524
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN6PR11MB1587;
x-ms-traffictypediagnostic: BN6PR11MB1587:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <BN6PR11MB1587D3BA51D0A051B92909CCF0260@BN6PR11MB1587.namprd11.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(136003)(366004)(346002)(39860400002)(189003)(199004)(13464003)(316002)(8936002)(31696002)(186003)(14444005)(256004)(2201001)(99286004)(53546011)(386003)(26005)(81156014)(3846002)(486006)(2616005)(476003)(8676002)(6506007)(11346002)(102836004)(71200400001)(71190400001)(81166006)(86362001)(6116002)(2906002)(97736004)(76176011)(446003)(6486002)(4326008)(52116002)(5660300002)(6246003)(7416002)(229853002)(31686004)(36756003)(478600001)(25786009)(14454004)(6436002)(6512007)(72206003)(6306002)(54906003)(110136005)(53936002)(305945005)(66066001)(68736007)(966005)(2501003)(7736002)(505234006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1587;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: d2BdIhDEZa5ZcH+7YkCy9Ewo9SGokYRs6gHzSNr3+MKY78p6HKXUDmVtr6Xcj+SxiF2FKCvcwxtnx/irtwJVTClIx6DBg4NalcNRqeF7bdzJMUcWcFyen04rcSYOuePvxumMgHYlriqlmzZ+ByHU/oPpOrUHAuFK+Mk3W1rmWRAidk3UnJQO3lH+elBwgQn4fns9Y3DnECOwni8/GzRKniyTNe0ACXd7DfdMuQrMub3kVFvOA69OkxXOVB6opVsnBUw+AzLkRqXu6puMYCnWCrjPWxYofWmclp3x0/a9xqxgJMYDWt+vzCZPCZoqDZeHT0UMlTnQ2nN04AQBHT0lxVCbZ9pNPfuS5p6xg7trviQrfPPboSPy5JYawcqc5zs+hYbfzROboC3ljdrvVVHoftWk8mb6m/r7U6wL7hIKPa8=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <411DC5CF29459A49976FEDCFCF984DA6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 540e8173-ff39-4c76-77c4-08d6c407b524
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 14:11:10.5928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1587
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Naga,

On 03/19/2019 03:57 PM, Naga Sureshkumar Relli wrote:
> *External E-Mail*
>=20
> *
> *
>=20
> Hi Tudor,
>=20
> =A0
>=20
>> -----Original Message-----
>=20
>> From: Tudor.Ambarus@microchip.com <Tudor.Ambarus@microchip.com>
>=20
>> Sent: Monday, March 18, 2019 11:05 AM
>=20
>> To: Naga Sureshkumar Relli <nagasure@xilinx.com>; bbrezillon@kernel.org;
>=20
>> broonie@kernel.org
>=20
>> Cc: richard@nod.at; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.=
org;
>=20
>> marek.vasut@gmail.com; linux-mtd@lists.infradead.org; nagasuresh12@gmail=
.com;
>=20
>> dwmw2@infradead.org; Michal Simek <michals@xilinx.com>; liu.xiang6@zte.c=
om.cn
>=20
>> Subject: Re: 4-Byte addressing issue with IS25WP256D nor flash
>=20
>>
>=20
>> Hi, Naga,
>=20
>>
>=20
>> On 03/13/2019 12:30 PM, Naga Sureshkumar Relli wrote:
>=20
>> > Hi,
>=20
>> >
>=20
>> >
>=20
>> >
>=20
>> > Currently I am facing an issue with is25wp256d part.
>=20
>> >
>=20
>> >=A0 1. With u-boot the data integrity is working(erase, write, read and=
 verify)
>=20
>> >=A0=A0=A0=A0 with out any issues
>=20
>> >=A0 2. Don=92t probe the qspi at u-boot, and boot Linux and do data int=
egrity
>=20
>> >=A0=A0=A0=A0 (erase, write, read and verify) =A0and verification done s=
uccessfully.
>=20
>> >=A0 3. At u-boot, do sf probe and after booting Linux, check for data
>=20
>> > integrity
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0 (erase, write, read and verify) and verify is failing.
>=20
>> >
>=20
>> > And here are my observations.
>=20
>> >
>=20
>> > When we do sf probe at u-boot, as per the device size, u-boot is
>=20
>> > changing
>=20
>> >
>=20
>> > The flash device addressing mode from 3 byte to 4 byte
>=20
>> >
>=20
>> >
>=20
>> >
>=20
>> > But Linux spi-nor frame work is using 3 byte commands with 3 Byte
>=20
>> > addressing(because
>=20
>> >
>=20
>> > Of wrong sfdp information from the is25wp256d part). Hence data verifi=
cation is failing.
>=20
>> >
>=20
>> > i.e. sfdp information is saying that it supports only 3-Byte addressin=
g.
>=20
>> >
>=20
>> > that means, sfdp table for is25wp256d is wrong.
>=20
>> >
>=20
>>
>=20
>> I couldn't find the sfdp table described in the datasheet. I would like =
to check if bfpt is not
>=20
>> entirely wrong. Can you please hexdump the entire sfdp table?
>=20
> sfdp header:
>=20
> 0x53, 0x46, 0x44, 0x50,
SFDP Header: 1st DWORD

>0x6, 0x1,0x1, 0xff,
SFDP Header: 2nd DWORD
Number of Parameter Headers (NPH)=3D2

>0x0, 0x6, 0x1, 0x10,
JEDEC Flash Parameter Header: 1st DWORD
Parameter Table length: 0x10

>0x30, 0x0, 0x0, 0xff
JEDEC Flash Parameter Header: 2nd DWORD
Parameter Table Pointer

> =A0
>=20
> Parameter table header
>=20
> 0x9d, 0x5, 0x1, 0x3, 0x80, 0x0, 0x0, 0x2

is this a vendor table?

> Parameter Table data:
>=20
dword[1]:
> 0xe5, 0x20, *0xf9*, 0xff,

indeed, A18:A17 is 00b, 3-byte only addressing. A18:A17 should have been of
value 01b.

dword[2]:
> 0xff, 0xff, 0xff, 0xf,
dword[3]:
> 0x44, 0xeb, 0x8, 0x6b,
dword[4]:
>  0x8, 0x3b, 0x80, 0xbb,
dword[5]:
> 0xfe, 0xff, 0xff, 0xff,
dword[6]:
> 0xff, 0xff,  0x0, 0xff,
dword[7]:
> 0xff, 0xff, 0x44, 0xeb,dword[8]:
>  0xc, 0x20,  0xf, 0x52,
   ^4KB erase  ^32KB erase
dword[9]:
> 0x10, 0xd8,  0x0, 0xff,
   ^64KB erase
dword[10]:
> 0x23, 0x4a, 0xc9, 0x0,
dword[11]:
> 0x82, 0xd8, 0x11, 0xce,
dword[12]:
> 0xcc, 0xcd, 0x68, 0x46,
dword[13]:
> 0x7a, 0x75, 0x7a, 0x75,
dword[14]:
> 0xf7, 0xae, 0xd5, 0x5c,
dword[15]:
> 0x4a, 0x42, 0x2c, 0xff,
dword[16]:
> 0xf0, 0x30, 0xf2, 0xa9
                     ^ xx1x_xxxxb is set, and confirms that the flash suppo=
rts
dedicated 4-Byte address instruction set.

BFPT looks sane, with the exception of the 3-byte only addressing.

You have the same problem as Liu. Check Liu's patch at
https://patchwork.ozlabs.org/patch/1071453/. Ideally would be to know if th=
ese 2
parts are the only ones that have this bug or if there are more. Can you co=
ntact
ISSI and ask them which parts are affected? If ISSI will not respond in a
reasonable amount of time, we can update Liu's patch to have a single post_=
bfpt
function that checks if the flash id corresponds to IS25(WP/LP)256D before
setting addr_width to 4.

Cheers,
ta

>> > Here are the steps that I am running.
>=20
>> >
>=20
>> > Write data using u-boot =A0like below
>=20
>> >
>=20
>> > 1. sf probe 0 0 0
>=20
>> >
>=20
>> > 2. mw.b 0x100000 11 0x100
>=20
>> >
>=20
>> > 3. sf write 0x100000 0x0 0x100
>=20
>> >
>=20
>> > 4. sf read 0x200000 0x0 0x100
>=20
>> >
>=20
>> > 5. md.b 0x200000 0x100
>=20
>> >
>=20
>> > 00200000: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200010: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200020: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200030: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200040: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200050: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200060: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200070: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200080: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 00200090: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000a0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000b0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000c0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000d0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000e0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > 002000f0: 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11 11=A0=A0=A0 ...=
.............
>=20
>> >
>=20
>> > And in Linux just try reading the data,
>=20
>> >
>=20
>> > root# mtd_debug read /dev/mtd0 0x0 0x100 test.bin
>=20
>> >
>=20
>> > root#hexdump -C -n 50 test.bin
>=20
>> >
>=20
>> > 0000000 ffff ffff =A01111 1111 1111 1111 1111 1111
>=20
>> >
>=20
>> > 0000010 1111 1111 1111 1111 1111 1111 1111
>=20
>> >
>=20
>> > *
>=20
>> >
>=20
>> > 0000100
>=20
>> >
>=20
>> >
>=20
>> >
>=20
>> > I did the below change in spi-nor.c
>=20
>> >
>=20
>> > iff --git a/drivers/mtd/spi-nor/spi-nor.c
>=20
>> > b/drivers/mtd/spi-nor/spi-nor.c
>=20
>> >
>=20
>> > index 4216ce0..f8603ff 100644
>=20
>> >
>=20
>> > --- a/drivers/mtd/spi-nor/spi-nor.c
>=20
>> >
>=20
>> > +++ b/drivers/mtd/spi-nor/spi-nor.c
>=20
>> >
>=20
>> > @@ -2890,6 +2890,11 @@ static int spi_nor_init_params(struct spi_nor
>=20
>> > *nor,
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
nor->addr_width =3D 0;
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
nor->mtd.erasesize =3D 0;
>=20
>> >
>=20
>> > =A0 =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if=
 ((JEDEC_MFR(info) =3D=3D SNOR_MFR_ISSI) &&
>=20
>> Does all issi flashes have this problem?
>=20
> No.
>=20
>>
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 params->size >=A0 OFFSET_16_MB) {
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 nor->addr_width =3D 4;
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 set_4byte(nor, info, 1);
>=20
>> >
>=20
>> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =
memcpy(params, &sfdp_params, sizeof(*params));
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
>> >
>=20
>> > =A0=A0=A0=A0=A0=A0=A0 }
>=20
>> >
>=20
>> > Any further suggestions?
>=20
>>
>=20
>> We should implement this as a post_bfpt fixup hook.
>=20
> Ok
>=20
>>
>=20
>> >
>=20
>> > I have gone through https://lkml.org/lkml/2018/11/14/599.
>=20
>> >
>=20
>> > But I didn=92t see any further mails after that.
>=20
>>
>=20
>> Sorry, I forgot about it :(
>=20
> No problem and thanks for asking more information.
>=20
> =A0
>=20
> Thanks,
>=20
> Naga Sureshkumar Relli
>=20
>>
>=20
>> Cheers,
>=20
>> ta
>=20
