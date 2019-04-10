Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E79CC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AB621906
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 05:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="nvuFytwC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbfDJFq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 01:46:59 -0400
Received: from mail-eopbgr710074.outbound.protection.outlook.com ([40.107.71.74]:35392
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725938AbfDJFq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 01:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkP94rwtcKCAXa2PsFj8ThRov5WyWfgl9zNWiUqL4A8=;
 b=nvuFytwCK6PUM2p4qeM2M26nUHa6dn6kW3JPoi69pun/l30+9K30E+I9nDdd9tIyQFBoRvsjKdeCv7/kcfaeE9Nj6vf59mU+CJjF1EVjjhKIhbTG2h97IwCJlt+6ibyn7Gcsdf7ANSFCPK7FLc/O6VV4MxgYaJC8nrnvXSgXWuY=
Received: from MWHPR02MB2623.namprd02.prod.outlook.com (10.168.206.9) by
 MWHPR02MB3263.namprd02.prod.outlook.com (10.164.133.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Wed, 10 Apr 2019 05:46:55 +0000
Received: from MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e]) by MWHPR02MB2623.namprd02.prod.outlook.com
 ([fe80::905a:a5f3:8d41:431e%6]) with mapi id 15.20.1792.016; Wed, 10 Apr 2019
 05:46:55 +0000
From:   Naga Sureshkumar Relli <nagasure@xilinx.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <michals@xilinx.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: RE: linux-next: Tree for Apr 9 (spi/spi-zynq-qspi.c)
Thread-Topic: linux-next: Tree for Apr 9 (spi/spi-zynq-qspi.c)
Thread-Index: AQHU7uf6kcuPIsmNnUmQTaPczmbAKaY040wA
Date:   Wed, 10 Apr 2019 05:46:54 +0000
Message-ID: <MWHPR02MB2623DDF884FD2DAA9C4B7C40AF2E0@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <20190409180042.15bb90b6@canb.auug.org.au>
 <4c933ec6-0247-5820-dfc2-326a5bc6b227@infradead.org>
In-Reply-To: <4c933ec6-0247-5820-dfc2-326a5bc6b227@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nagasure@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c2e59f-be5d-422d-45d0-08d6bd77f068
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:MWHPR02MB3263;
x-ms-traffictypediagnostic: MWHPR02MB3263:
x-microsoft-antispam-prvs: <MWHPR02MB3263181E2A2D6930311B1E9DAF2E0@MWHPR02MB3263.namprd02.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(53754006)(13464003)(199004)(189003)(81166006)(486006)(4744005)(81156014)(25786009)(8676002)(66066001)(6506007)(446003)(102836004)(4326008)(11346002)(86362001)(68736007)(26005)(53546011)(71200400001)(71190400001)(7696005)(76176011)(33656002)(186003)(2906002)(229853002)(476003)(106356001)(53936002)(6246003)(305945005)(55016002)(110136005)(105586002)(14454004)(478600001)(8936002)(5660300002)(52536014)(9686003)(7736002)(74316002)(5024004)(3846002)(256004)(6116002)(316002)(6436002)(99286004)(54906003)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3263;H:MWHPR02MB2623.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tYfebPdpALn2dpHiD0zlRDS+hAUHMcef3P79fPVrcxGNrn3QwKtv77lUWHqMt2Y6ker4DrHNGOF/UwX/5Udaz5RvoUNTsUAQUH4F9H4vjZXmrRqnNBizJodHPpyDviIIof7Qu0iCyGt9HdhKVBIW7tHwuZE8ghelRnbLpRGjWL5nvwXqEsZ7O3OQ88v6x3R+ONVwK6cZWKrSQM020wDhsxiZjwiLepFi3ICTo9DU8t2N4g+TutKfZUIywTaNq5Nn5or/ikso3L7GaP7WzzMAtfVWGt3mQLZ/r2smETdyWEXEoDCq7NKo5/1oFeiFWbfafN447Bf/lEP/sh9vo+iqURdWIYkOzhM9tMLFeUmEafik0Cq8XqZbDWCnjOBDxw7wGYQrJmrS6GfxMIV1iMDiKg2xRvBPzvNRE2+rg3fj8I0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c2e59f-be5d-422d-45d0-08d6bd77f068
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 05:46:55.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3263
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

I have sent the patch on top of the patch sent by yuehaibing@huawei.com.

Thanks,
Naga Sureshkumar Relli

> -----Original Message-----
> From: Randy Dunlap <rdunlap@infradead.org>
> Sent: Tuesday, April 9, 2019 8:52 PM
> To: Stephen Rothwell <sfr@canb.auug.org.au>; Linux Next Mailing List <lin=
ux-
> next@vger.kernel.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Naga Suresh=
kumar Relli
> <nagasure@xilinx.com>; Michal Simek <michals@xilinx.com>; linux-spi <linu=
x-
> spi@vger.kernel.org>
> Subject: Re: linux-next: Tree for Apr 9 (spi/spi-zynq-qspi.c)
>=20
> On 4/9/19 1:00 AM, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20190408:
> >
>=20
> on x86_64:
>=20
> ld: drivers/spi/spi-zynq-qspi.o: in function `zynq_qspi_supports_op':
> spi-zynq-qspi.c:(.text+0x185): undefined reference to `spi_mem_default_su=
pports_op'
>=20
>=20
> Full randconfig file is attached.
>=20
> --
> ~Randy
