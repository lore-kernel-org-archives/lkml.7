Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98A0C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675D4206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 13:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=daktronics.com header.i=@daktronics.com header.b="Hs/UROba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391581AbfFKN5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 09:57:35 -0400
Received: from mail-eopbgr720072.outbound.protection.outlook.com ([40.107.72.72]:3807
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2391557AbfFKN5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 09:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=daktronics.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXwYd5rDPqfq54U2WqMVU3a3Bl6dswf0jyYrsWiLDN8=;
 b=Hs/UROba4RVaY1VZnErJ53MCg2wW5/2yrCdbA9RWoK/1ISQyT3+xcqcCo7Sod5mx+MdMWcQZGpNlFPSDC/hbBH9QBztaroDvESd4Iw65XyYGTkavJhrP04S3djI3SPSXxTwdo07DBmfHmZ1ZLBFFiRCYonQUkWKpC6d0F7UVdlQ=
Received: from SN6PR02MB4016.namprd02.prod.outlook.com (52.135.69.145) by
 SN6PR02MB4814.namprd02.prod.outlook.com (52.135.114.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Tue, 11 Jun 2019 13:57:30 +0000
Received: from SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::f551:3180:ba2d:7c1f]) by SN6PR02MB4016.namprd02.prod.outlook.com
 ([fe80::f551:3180:ba2d:7c1f%6]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 13:57:30 +0000
From:   Matt Sickler <Matt.Sickler@daktronics.com>
To:     Geordan Neukum <gneukum1@gmail.com>,
        Hao Xu <haoxu.linuxkernel@gmail.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] staging: kpc2000: kpc_i2c: remove the macros inb_p and
 outb_p
Thread-Topic: [PATCH v2] staging: kpc2000: kpc_i2c: remove the macros inb_p
 and outb_p
Thread-Index: AQHVH2Dso4KgADC9a0e1F3CVK4xfcaaVuXWAgADA57A=
Date:   Tue, 11 Jun 2019 13:57:30 +0000
Message-ID: <SN6PR02MB40169CA0F341B5727B806607EEED0@SN6PR02MB4016.namprd02.prod.outlook.com>
References: <1560152904-31894-1-git-send-email-haoxu.linuxkernel@gmail.com>
 <20190611021933.GA915@arch-01.home>
In-Reply-To: <20190611021933.GA915@arch-01.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Matt.Sickler@daktronics.com; 
x-originating-ip: [2620:9b:8000:6046:1c1e:e54f:8af5:e89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6cb339b-bc5c-4039-6427-08d6ee74bec4
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:SN6PR02MB4814;
x-ms-traffictypediagnostic: SN6PR02MB4814:
x-microsoft-antispam-prvs: <SN6PR02MB4814529B2FE4471FA863F17EEEED0@SN6PR02MB4814.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(189003)(199004)(13464003)(81156014)(53936002)(7696005)(8676002)(76176011)(72206003)(8936002)(25786009)(55016002)(102836004)(478600001)(86362001)(229853002)(9686003)(52536014)(99286004)(305945005)(14454004)(54906003)(6436002)(5660300002)(68736007)(2906002)(110136005)(6116002)(7736002)(6506007)(316002)(74316002)(4744005)(46003)(66556008)(64756008)(66446008)(33656002)(71190400001)(186003)(71200400001)(4326008)(486006)(66476007)(73956011)(81166006)(66946007)(6246003)(446003)(256004)(476003)(14444005)(11346002)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4814;H:SN6PR02MB4016.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: daktronics.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DdVAs975oqDT1Lfyr3il8WbBNn+2mS/6dv3H00sOeu3jKhXLDfAlB/T02A1P936Kw4njGn2OrsKcYFrNflXckEWIoSTzkG03C7W5JRM8TJiCh2BNvX7R7JYlXC8G27bO5hyG4wdfvIyagCnOmpDCf+MqX9xbdkXfnEjV/32UYYDxIwbsLBvLLPaMLZxrHPxKgbtxKLwmwwh2VjOmPMdhVzQOGRBkdwDdxEO2nsQnSi9T74hoERPcDvadIavxGS9jTLk7yNcEf3UrEVORAPfe824Il46+k6PalX1f/sHcH80Cx+dnqPdnW53mku2o+qsrdcSxeLZgl650X8f2llxACAdtritJQI5dEsMRbsb8SqvPoadH/zmv7q/FJ0mEI/UNbCDX5OqJqLBpJoFagdOuvIreoRXKaWZBo6KkNx9tesM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: daktronics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cb339b-bc5c-4039-6427-08d6ee74bec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 13:57:30.2243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: be88af81-0945-42aa-a3d2-b122777351a2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: matt.sickler@daktronics.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4814
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: devel <driverdev-devel-bounces@linuxdriverproject.org> On Behalf Of
>Geordan Neukum
>
>This inb() call looks like a bug. We perform a 64-bit operation when
>talking to this hardware register everywhere else in this driver. Anyone
>have more insight into the hardware with which this driver interacts
>such that they could shed some light on the subject?

That would be me.  I looked at the VHDL for the hardware.  The registers se=
em to
be aligned to 8 bytes but only use the LS byte of each.  So it probably doe=
sn't
matter whether the memory transactions are 64-bit or 8-bit.
I know the hardware doesn't support byte-enables either, which is probably =
why
the registers were padded this way.   Probably also why the inb_p and outb_=
p
macros were redefined.

>Probably a separate issue, but I did notice it as a result of this patch.
>
>Thanks,
>Geordan

