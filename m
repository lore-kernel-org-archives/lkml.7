Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248AFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC96E218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pe1cnOqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfCOKXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:23:36 -0400
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:57582
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfCOKXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQyD8BOoSKV4B9rB2ag4Sj1Ml1Emy+EGiZTUoInaGgw=;
 b=pe1cnOqLWl/cPLLs6w5YzHss3Vy3PTlEHDTILkaXehj/LX2Ba/faA9pSUSI24EKIM94iXk6kjUL61Qb7ktyz05zNjYgW3dY491g3V8MSO2jPy/rdlJHTGS4gTLDD93Hb+GpM4Ak6PJ5J3Xqzs+4TpVugfNDJ/CzQn7tknQzwX70=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5361.eurprd04.prod.outlook.com (20.178.113.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 15 Mar 2019 10:23:33 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 10:23:33 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH] arm64: dts: imx8qxp: fix mbox-cells
Thread-Topic: [PATCH] arm64: dts: imx8qxp: fix mbox-cells
Thread-Index: AQHU2X6JXRYV9xh9YkiIRxWD43fsCaYMfvOw
Date:   Fri, 15 Mar 2019 10:23:33 +0000
Message-ID: <AM0PR04MB4211910FCC3CEDF11EE4B10380440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313093626.18589-1-peng.fan@nxp.com>
In-Reply-To: <20190313093626.18589-1-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a9a9133-7ae4-4efc-4b96-08d6a93046fa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5361;
x-ms-traffictypediagnostic: AM0PR04MB5361:
x-microsoft-antispam-prvs: <AM0PR04MB53615D7099BA247D9C7BBF6B80440@AM0PR04MB5361.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(136003)(396003)(346002)(189003)(199004)(486006)(74316002)(446003)(11346002)(476003)(97736004)(71190400001)(71200400001)(2201001)(6506007)(76176011)(316002)(9686003)(86362001)(6246003)(186003)(44832011)(33656002)(5660300002)(52536014)(478600001)(110136005)(8676002)(106356001)(25786009)(2501003)(6436002)(81156014)(81166006)(105586002)(53936002)(229853002)(102836004)(256004)(68736007)(26005)(7736002)(55016002)(4326008)(7416002)(99286004)(7696005)(14444005)(8936002)(305945005)(3846002)(14454004)(6116002)(2906002)(66066001)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5361;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EFJHwaMnExroRZZfpa+DlK0KZtvDst/7S0re4iBpoSEWFB9HMK/ssV2rFgASrp1zCzbxT4M66Wsfzxf/lxxQq5q4yalvGkxpFi+uJiqrnKNyMkKN4RpZCaobc5jGQs0SUrDMb8K9Icvvh2B2hneq6X+huNA8vAoixq4DjZZcnH1Ro3kFz/e4DTo4ShjUIhXKevu7AxTr1Yi0i8P6Cyd5niG3zRGkFxIw2iHw89pjnOjPh2nvr/9IHLixYNaVrtB4bHgv38sr4psCgq/1Bj9oZSKB2YF7g40Pg8mBz6cKp01r+3cuMnv2DL691jj2FV63qR9COkv6QnFlYO4TIO/8zlVDBgyr/XYTy0xqPNPtEo/M0Tn8f2jJ+DVyviWV0NYcSGDVaq7oCIF3FeQyQz+b8Y8mO3YHRw7EydjXkUATdeE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9a9133-7ae4-4efc-4b96-08d6a93046fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 10:23:33.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5361
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Peng Fan
>
> Subject: [PATCH] arm64: dts: imx8qxp: fix mbox-cells
>=20
> Currently lsio_mu1 is used by Linux Kernel with mbox-cells as 2, but actu=
ally
> mu0-4 could be used to communicate with SCU. So fix the mbox-cells.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4c3dd95ed488..16766838ac77 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -328,7 +328,7 @@
>  			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  			reg =3D <0x5d1b0000 0x10000>;
>  			interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> -			#mbox-cells =3D <0>;
> +			#mbox-cells =3D <2>;
>  			status =3D "disabled";
>  		};
>=20
> @@ -343,7 +343,7 @@
>  			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  			reg =3D <0x5d1e0000 0x10000>;
>  			interrupts =3D <GIC_SPI 179 IRQ_TYPE_LEVEL_HIGH>;
> -			#mbox-cells =3D <0>;
> +			#mbox-cells =3D <2>;
>  			status =3D "disabled";
>  		};
>=20
> @@ -351,7 +351,7 @@
>  			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  			reg =3D <0x5d1f0000 0x10000>;
>  			interrupts =3D <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>;
> -			#mbox-cells =3D <0>;
> +			#mbox-cells =3D <2>;
>  			status =3D "disabled";
>  		};
>=20
> --
> 2.16.4

