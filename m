Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DABC4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8443020880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="qFlpY2Xb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbfDASAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:00:10 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:39966 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbfDASAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:00:06 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca251a30001>; Tue, 02 Apr 2019 02:00:03 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 01 Apr 2019 11:00:02 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 01 Apr 2019 11:00:02 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 1 Apr
 2019 18:00:02 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.54) by
 HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 1 Apr 2019 18:00:02 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com (20.178.196.24) by
 BYAPR12MB3414.namprd12.prod.outlook.com (20.178.196.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Mon, 1 Apr 2019 17:59:58 +0000
Received: from BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26]) by BYAPR12MB3398.namprd12.prod.outlook.com
 ([fe80::80de:b71d:ffd0:3d26%6]) with mapi id 15.20.1750.017; Mon, 1 Apr 2019
 17:59:58 +0000
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V1 19/26] DT bindings: spi: add spi client device
 properties
Thread-Topic: [PATCH V1 19/26] DT bindings: spi: add spi client device
 properties
Thread-Index: AQHU5GIKDOA1QCn5LEGhPbdcmaHIJKYm8rmAgACr1SA=
Date:   Mon, 1 Apr 2019 17:59:57 +0000
Message-ID: <BYAPR12MB3398F515727D46DE21C54FD6C2550@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
 <20190401073723.GH2059@sirena.org.uk>
In-Reply-To: <20190401073723.GH2059@sirena.org.uk>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=skomatineni@nvidia.com; 
x-originating-ip: [216.228.112.22]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d007f4e-0628-4a19-b757-08d6b6cbda98
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR12MB3414;
x-ms-traffictypediagnostic: BYAPR12MB3414:
x-microsoft-antispam-prvs: <BYAPR12MB34141D8E8DA6C7E610C93536C2550@BYAPR12MB3414.namprd12.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(376002)(346002)(136003)(189003)(199004)(446003)(8676002)(6246003)(6116002)(99286004)(25786009)(53936002)(11346002)(6916009)(256004)(476003)(7696005)(6506007)(2906002)(105586002)(478600001)(26005)(4326008)(33656002)(14454004)(186003)(97736004)(66066001)(106356001)(76176011)(486006)(3846002)(81156014)(68736007)(52536014)(102836004)(55016002)(81166006)(86362001)(9686003)(8936002)(74316002)(71190400001)(229853002)(7736002)(71200400001)(5660300002)(316002)(6436002)(305945005)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB3414;H:BYAPR12MB3398.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nvidia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: E5dzH4QkGIy4l2rLTqKLqtcOPkN0uaH3vBLQqSoHk3YjYbdwONQmGHbruKwzTNM/4V712pxhNLONp3KVOM5vumJ2q74v0MiBXQav2JlnbgwRgpVy15F3jsocAbL1EDi+TMdaQSlicqUHIjAHnWb17kqAy6lyGw8vN9/MKJTd/HWppz0SRKamFjKApK8PgTZKfsW6SeaNAdt/jNSPfO2Weg5z+HnVoinY9q/Z+X5Et9clQxwZFqv0OUZworT5pL6iG+5w1PD5PHjg+O1xpahMWLkawTfCgZwfCpgpUXIzRKQhv5L3oiAp7JSxfYIZOXoGlGtyJJ1Vl7pu47NFcG7tcU3OycSYmzgiciKmamsxZ0iA8kE8xwDNrtnaPNuNXmVCE5gP25Xmk1BrO2Xu5i2D0IetsPiu7Ct9WBeGR5YJF0o=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d007f4e-0628-4a19-b757-08d6b6cbda98
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 17:59:57.9630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
X-OriginatorOrg: Nvidia.com
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554141603; bh=VbNgjbR35ODRX1xdorA+F/l0qzjBuzNtBhnDNPlAveQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Thread-Topic:Thread-Index:Date:
         Message-ID:References:In-Reply-To:Accept-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-microsoft-antispam:x-ms-traffictypediagnostic:
         x-microsoft-antispam-prvs:x-forefront-prvs:
         x-forefront-antispam-report:received-spf:
         x-ms-exchange-senderadcheck:x-microsoft-antispam-message-info:
         MIME-Version:X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg:
         Content-Language:Content-Type:Content-Transfer-Encoding;
        b=qFlpY2XbWe49nabp3oSwaf0UIyp5Q9K7JTFco+5ns6Qv9tEWzbRi2pKgvCVX8wme3
         XCX+4EDRggEygsoq/LqURxOOv9UzCfUNXX/Js7ChJ3pGBiHqA+o9iBCtPkpYAjY7rZ
         rd/okMiTh4DMTyughKYa58CQRf2wVX8vw54HDhAR1o9U9yhM0thJgwYiM6bv4qbCq8
         nJMak45Bh4fkcr+jJCNf/PteLuNnVTrgpAvHFimuJNAElzmMilwiCXaAUjMV3c6/ET
         V1waP7lmkxYU7Z2e96F4z2ozi7e7+zyJKarMLk3fh6MTcamTNNATj2Z+rogEXiMLo5
         lVx1W7DwvfxUQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 26, 2019 at 10:56:40PM -0700, Sowjanya Komatineni wrote:
> > This patch adds below cs timing properties to allow SPI master=20
> > configuring setup, hold and time interval between two SPI transactions=
=20
> > to meet specific SPI client device requirements.
> >  CS setup time
> >  CS hold time
> >  CS inactive delay
> > DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dnvidia.=
com; s=3Dn1;
> > 	t=3D1553666253; bh=3DTbJVgRAIkjok3TkKNkfcvYc4WGyZhOpiH6sUZvadGrQ=3D;
> > 	h=3DX-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
> > 	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
> > 	 Content-Type;
> > 	b=3DTud9guY5XCzkjKA2k2n0+xO/vTfMTNhH1e0viAyYmlgoG/j+uSBAAmOeZucVUlmEa
> > 	 rwqxlSm+rkYMUfgSWqmJXqEjgRIAqMhA32FOJmhgpblGwYUR22hnbdhbk4TcqMNsIO
>
> Something got corrupted?

Possible. Will re-send anyway with your feedback fixes.

> > +spi-client device controller properties:
> > +- nvidia,cs-setup-clk-count: CS setup timing parameter.
> > +- nvidia,cs-hold-clk-count: CS hold timing parameter.
> > +- nvidia,cs-inactive-cycles: CS inactive delay in terms of clock=20
> > +between
> > +  transfers.
>
> Why are these being done as nVidia specific properties rather than generi=
c ones and why are these being configured in DT rather than by the client d=
river?  If the devices have particular timing requirements for chip select =
presumably that's going to apply no matter what controller or system they'r=
e used with so it seems best to configure this in the client driver and hav=
e an API that any controller can implement.

These are implemented thru DT as Tegra SPI is master and master controls th=
e timing.
Some SPI slaves have specific requirements of certain CS setup/hold time an=
d inactive cycles which SPI master should meet when driving during transfer=
 and Tegra SPI controller supports tuning these parameters.

