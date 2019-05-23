Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF03C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581AB2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nTPbEMK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbfEWHvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:51:45 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:20195
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727319AbfEWHvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:51:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJ3o9VR06uXbtWd0Km5MxNrhLgxNR2egPQDH31h5Y6Y=;
 b=nTPbEMK9JfKKwl93Moo/gZ7+gVCovtTPxAEDokBHsHn1xl4Ao9zm+VFEjgj5FwtAxQFav+FveFFkCQBmnJwx1DaS8jjeXVi3vFfPh3pKqR0IINUEeCt1SzOBUf10jhtVoJlk2eAIKvOTNa30SAu3cTUwv0wOla7s3c9czPj2d34=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2802.eurprd04.prod.outlook.com (10.175.44.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.18; Thu, 23 May 2019 07:51:42 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::a1bf:17d:a52:3824%4]) with mapi id 15.20.1922.016; Thu, 23 May 2019
 07:51:41 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RESEND][PATCH] arm64: dts: lx2160a: Enable usb3-lpm-capable for
 usb3 node
Thread-Topic: [RESEND][PATCH] arm64: dts: lx2160a: Enable usb3-lpm-capable for
 usb3 node
Thread-Index: AQHVCuPVqNHVZQ8GjEWf3MbcUA38AaZ4YIOAgAAAyGA=
Date:   Thu, 23 May 2019 07:51:41 +0000
Message-ID: <AM5PR0402MB2865A81EB93DBAC90DB22E87F1010@AM5PR0402MB2865.eurprd04.prod.outlook.com>
References: <20190515060434.33581-1-ran.wang_1@nxp.com>
 <20190523074300.GH9261@dragon>
In-Reply-To: <20190523074300.GH9261@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b23dcff-5563-4ecf-826b-08d6df537e60
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2802;
x-ms-traffictypediagnostic: AM5PR0402MB2802:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM5PR0402MB2802DBCCE7E2FF63B769DCD4F1010@AM5PR0402MB2802.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 00462943DE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(11346002)(53936002)(305945005)(76176011)(186003)(446003)(76116006)(6116002)(3846002)(316002)(8936002)(54906003)(99286004)(7736002)(26005)(66446008)(64756008)(66556008)(66476007)(66946007)(73956011)(476003)(6436002)(52536014)(45080400002)(74316002)(55016002)(81156014)(256004)(81166006)(229853002)(68736007)(71200400001)(71190400001)(25786009)(14444005)(486006)(478600001)(6246003)(6306002)(2906002)(5660300002)(6916009)(4326008)(14454004)(7696005)(102836004)(9686003)(6506007)(33656002)(66066001)(53546011)(966005)(8676002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2802;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: OxNCliyGcDLVjVQjY5zb78/p6J9Whyj7OZSg1Mp0wu7aUSM/FidwpmdvvV7As3T8XCs/GkbTh17Q+YkIHkbKKHJlO1izUew6118w3goZGO0oCgxtsu3DnCzKfuWodcq1GpTu5IBfpPWnRJatqI4j6byKcTZIsSS8tUPpWcHCVV6/ubuD0W3akS18GnhI0XPQCWB5v8Vjy2PdW8a2H5jMG+3Cm6V+X13ZXraNxWt6og7ehuElPkd3ALtIfH85l6fhoEwoEeOc22DY8M3cIvi1kOdTKlqGUQiKxLakosY8tTy8sJzlUb/2t529WkJA0iO3zmyX/8edGnU902ryRyxlnOe6WvOr+HEg3HsdvGvMy0b8BUu8ESaAFrxdoEpbXh7JrjCVVW5r9HDleXLGAP+5GikM0myCiTpoPKQWPNA/k+E=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b23dcff-5563-4ecf-826b-08d6df537e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2019 07:51:41.3155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2802
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On Thursday, May 23, 2019 15:43, Shawn Guo wrote:
>=20
> On Wed, May 15, 2019 at 02:04:34PM +0800, Ran Wang wrote:
> > Enable USB3 HW LPM feature for lx2160a and active patch for snps
> > erratum A-010131. It will disable U1/U2 temperary when initiate U3
> > request.
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > ---
> > Depend on:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fpatchwork%2Fpatch%2F870134%2F&amp;data=3D02%7C01%7Cr
> an.wan
> >
> g_1%40nxp.com%7Cc6df41748bc243397d3008d6df526c04%7C686ea1d3bc2b4c
> 6fa92
> >
> cd99c5c301635%7C0%7C0%7C636941942428322802&amp;sdata=3DNR2zs8BE%2
> FNn8KdP
> > do6%2FsNwJJdx2VgaQTy5H4bAlTJgw%3D&amp;reserved=3D0
>=20
> Is the dependency accepted?

No, I got no comment for that post since then.
lore.kernel.org/patchwork/patch/870134/

Regards,
Ran
=20
>=20
> >
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi |    4 ++++
> >  1 files changed, 4 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > index 125a8cc..0073df3 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > @@ -696,6 +696,8 @@
> >  			interrupts =3D <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
> >  			dr_mode =3D "host";
> >  			snps,quirk-frame-length-adjustment =3D <0x20>;
> > +			usb3-lpm-capable;
> > +			snps,dis-u1u2-when-u3-quirk;
> >  			snps,dis_rxdet_inp3_quirk;
> >  			snps,incr-burst-type-adjustment =3D <1>, <4>, <8>, <16>;
> >  			status =3D "disabled";
> > @@ -707,6 +709,8 @@
> >  			interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> >  			dr_mode =3D "host";
> >  			snps,quirk-frame-length-adjustment =3D <0x20>;
> > +			usb3-lpm-capable;
> > +			snps,dis-u1u2-when-u3-quirk;
> >  			snps,dis_rxdet_inp3_quirk;
> >  			snps,incr-burst-type-adjustment =3D <1>, <4>, <8>, <16>;
> >  			status =3D "disabled";
> > --
> > 1.7.1
> >
