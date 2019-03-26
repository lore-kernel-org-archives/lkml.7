Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DB0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078722084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 13:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QtSxc/Vm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbfCZNas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 09:30:48 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:1506
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726140AbfCZNar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 09:30:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgBwEpYUSXDiNeMjvrMGA7xCrOO2B8blcoh7j6tgE18=;
 b=QtSxc/VmJycwxO274tnjtmsHWyfOiYdl6jrmYQnVMyJZdcrjEBQ7svwJ4VCBwxZXaPgvzZSzxCj6B0HW3UliTxJsWtQe/Y6m+hNOLm5nvrFuFVFM4AzC9iSnuuOztkcF8Mfpf+5b+Lv779RVKvkGmOzNqbEVhEFf/Y2ij6fl1YI=
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com (52.134.31.21) by
 VI1PR04MB5919.eurprd04.prod.outlook.com (20.178.205.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Tue, 26 Mar 2019 13:30:41 +0000
Received: from VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::c02c:b02b:fec5:577b]) by VI1PR04MB4222.eurprd04.prod.outlook.com
 ([fe80::c02c:b02b:fec5:577b%4]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 13:30:41 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Teo Hall <teo.hall@nxp.com>
Subject: RE: [PATCH 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Topic: [PATCH 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Index: AQHU47hO5SJSbW1/nU6UR158xS/KPKYd5ucQ
Date:   Tue, 26 Mar 2019 13:30:41 +0000
Message-ID: <VI1PR04MB4222A8DBC2312E72AAD3AFAE805F0@VI1PR04MB4222.eurprd04.prod.outlook.com>
References: <20190326094239.5910-1-daniel.baluta@nxp.com>
 <20190326094239.5910-3-daniel.baluta@nxp.com>
In-Reply-To: <20190326094239.5910-3-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd182561-44d2-47d0-e43c-08d6b1ef3ddf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB5919;
x-ms-traffictypediagnostic: VI1PR04MB5919:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB59195D05A1AF3459EB1DB34E805F0@VI1PR04MB5919.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(366004)(396003)(39860400002)(199004)(189003)(305945005)(229853002)(76176011)(8676002)(486006)(186003)(256004)(26005)(33656002)(7696005)(6116002)(11346002)(102836004)(53936002)(6506007)(44832011)(6246003)(3846002)(7736002)(25786009)(86362001)(966005)(478600001)(4326008)(476003)(446003)(68736007)(8936002)(52536014)(6436002)(55016002)(74316002)(6306002)(81166006)(5660300002)(71200400001)(110136005)(106356001)(71190400001)(9686003)(54906003)(66066001)(97736004)(99286004)(316002)(2501003)(2906002)(105586002)(81156014)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5919;H:VI1PR04MB4222.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: erneSKItVlCmIfQl0cwUefdzOZcbQG+sQ8nX83dlzaPd1QJEN5wt+vo6ziKgMAzrUtVErdBFZarh5CJ+Dd955CEvX/nEhxb30z+TWN1rwGdufRtM4Dbco71MUxFX1/Hj+5SV36oZ+PIkTtK8t/1LyBLs+XE1104926pg41j6ko1TjlD3w6iQ9xynDk2LgH7kQqtxgAvK8jtvpdtK4j+RZLE6ILBNxTHuKwEDr5JrfDFAM9u1B0yKGxoWuB3SxZ604562NjmgXh1WoRYajGjl/p6OZi4cU/iUgacqjFnvzRpMW3XpBhNXfMCzHx6Aofu1Q5WrGw/qitHXfVnNeTXzAqAP7Tiy6WvFJ/UJHDaqi4rv+tEcLt99+/Qqiblk1G8eq9yz6gmiq56AJ95MvPXzMonB6yfvHeCROQObDFRI/o4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd182561-44d2-47d0-e43c-08d6b1ef3ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 13:30:41.1015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5919
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Baluta
> Sent: Tuesday, March 26, 2019 5:43 PM
>=20
> i.MX8QXP contains a total of 4 EDMA controllers of which two are primaril=
y
> for audio components and the other two are for non-audio periperhals.
>=20
> This patch adds the EDMA0/EDMA1 nodes used by audio peripherals.
>=20
> EDMA0 contains channels for:
> 	* ASRC0
> 	* ESAI0
> 	* SPDIF0
> 	* SAI0, SAI1, SAI2, SAI3
>=20
> EDMA1 contains channels for:
> 	* ASRC1
> 	* SAI4, SAI5
>=20
> See chapter Audio DMA Memory Maps (2.2.3) from i.MX8QXP RM [1]
>=20
> This patch is based on the dtsi file initially submitted by Teo Hall in i=
.MX NXP
> internal tree.
>=20
> [1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
>=20
> Cc: Teo Hall <teo.hall@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 72
> ++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 0cb939861a60..9e959deb2499 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -182,6 +182,78 @@
>  			#clock-cells =3D <1>;
>  		};
>=20
> +		edma0: dma-controller@591f0000 {
> +			compatible =3D "fsl,imx8qm-edma";

Should this be "fsl,imx8qxp-edma"?
or
"fsl,imx8qxp-edma", "fsl,imx8qm-edma"?

Regards
Dong Aisheng

> +			reg =3D <0x59200000 0x10000>,   /* asrc0 pair A input req */
> +				<0x59210000 0x10000>, /* asrc0 pair B input req */
> +				<0x59220000 0x10000>, /* asrc0 pair C input req */
> +				<0x59230000 0x10000>, /* asrc0 pair A output req */
> +				<0x59240000 0x10000>, /* asrc0 pair B output req */
> +				<0x59250000 0x10000>, /* asrc0 pair C output req */
> +				<0x59260000 0x10000>, /* esai0 rx */
> +				<0x59270000 0x10000>, /* esai0 tx */
> +				<0x59280000 0x10000>, /* spdif0 rx */
> +				<0x59290000 0x10000>, /* spdif0 tx */
> +				<0x592c0000 0x10000>, /* sai0 rx */
> +				<0x592d0000 0x10000>, /* sai0 tx */
> +				<0x592e0000 0x10000>, /* sai1 rx */
> +				<0x592f0000 0x10000>, /* sai1 tx */
> +			#dma-cells =3D <3>;
> +			shared-interrupt;
> +			dma-channels =3D <14>;
> +			interrupts =3D <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,    /* asrc 0
> */
> +					<GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* esai0 */
> +					<GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>, /* spdif0 */
> +					<GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* sai0 */
> +					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* sai1 */
> +					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
> +			interrupt-names =3D "edma0-chan0-rx", "edma0-chan1-rx", /*
> asrc0 */
> +					"edma0-chan2-rx", "edma0-chan3-tx",
> +					"edma0-chan4-tx", "edma0-chan5-tx",
> +					"edma0-chan6-rx", "edma0-chan7-tx",   /* esai0 */
> +					"edma0-chan8-rx", "edma0-chan9-tx",   /* spdif0 */
> +					"edma0-chan12-rx", "edma0-chan13-tx", /* sai0 */
> +					"edma0-chan14-rx", "edma0-chan15-tx", /* sai1 */
> +		};
> +
> +		edma1: dma-controller@599F0000 {
> +			compatible =3D "fsl,imx8qm-edma";
> +			reg =3D <0x0 0x59A00000 0x0 0x10000>, /* asrc1 */
> +				<0x0 0x59A10000 0x0 0x10000>,
> +				<0x0 0x59A20000 0x0 0x10000>,
> +				<0x0 0x59A30000 0x0 0x10000>,
> +				<0x0 0x59A40000 0x0 0x10000>,
> +				<0x0 0x59A50000 0x0 0x10000>,
> +				<0x0 0x59A80000 0x0 0x10000>, /* sai4 rx */
> +				<0x0 0x59A90000 0x0 0x10000>, /* sai4 tx */
> +				<0x0 0x59AA0000 0x0 0x10000>; /* sai5 tx */
> +			#dma-cells =3D <3>;
> +			shared-interrupt;
> +			dma-channels =3D <9>;
> +			interrupts =3D <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>, /* asrc 1 */
> +					<GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
> +					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
> +			interrupt-names =3D "edma1-chan0-rx", "edma1-chan1-rx", /*
> asrc1 */
> +					"edma1-chan2-rx", "edma1-chan3-tx",
> +					"edma1-chan4-tx", "edma1-chan5-tx",
> +					"edma1-chan8-rx", "edma1-chan9-tx", /* sai4 */
> +					"edma1-chan10-tx"; /* sai5 */
> +		};
> +
>  		adma_lpuart0: serial@5a060000 {
>  			compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
>  			reg =3D <0x5a060000 0x1000>;
> --
> 2.17.1

