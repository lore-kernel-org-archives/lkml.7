Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00875C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64E02075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 02:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qD69Lc+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbfC1Cbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 22:31:31 -0400
Received: from mail-eopbgr150070.outbound.protection.outlook.com ([40.107.15.70]:39482
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727662AbfC1Cbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 22:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/f1q63gGg6+wg5krEPGTM0oOmDjgnntMCmrNXmyXpe8=;
 b=qD69Lc+ahhmtrXbrhbsdFP1JEN9EDTesKC9PKVb/tlwbbApCOdrHIj8IH1Hez2L+yQi8jUASXlcIL1toHLUDMto4aVfsHDpGafD7ImBMinFJHl71bFbLkf3zh5iXgjQdDNNdY41fFHz0YG5FQLNxzIAadvHYaAVnKhJxoDU9c4I=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5923.eurprd04.prod.outlook.com (20.178.117.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Thu, 28 Mar 2019 02:31:25 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Thu, 28 Mar 2019
 02:31:25 +0000
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
Subject: RE: [PATCH v2 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Topic: [PATCH v2 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Index: AQHU5M+7DOoA/eJp7kqEHAMC8ZrFEaYgUZAQ
Date:   Thu, 28 Mar 2019 02:31:25 +0000
Message-ID: <AM0PR04MB4211B89650EA1AC9133F4EBE80590@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190327190244.9208-1-daniel.baluta@nxp.com>
 <20190327190244.9208-3-daniel.baluta@nxp.com>
In-Reply-To: <20190327190244.9208-3-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc3eb123-cc04-4974-2412-08d6b325798f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5923;
x-ms-traffictypediagnostic: AM0PR04MB5923:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <AM0PR04MB5923FA0E24189B9C09799C0B80590@AM0PR04MB5923.eurprd04.prod.outlook.com>
x-forefront-prvs: 0990C54589
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(39860400002)(396003)(199004)(189003)(7696005)(9686003)(106356001)(105586002)(53936002)(6306002)(55016002)(14444005)(6116002)(110136005)(478600001)(5660300002)(3846002)(14454004)(54906003)(6246003)(52536014)(305945005)(25786009)(2906002)(74316002)(316002)(97736004)(86362001)(7736002)(44832011)(966005)(256004)(229853002)(81166006)(8936002)(102836004)(33656002)(6506007)(66066001)(2501003)(26005)(68736007)(486006)(81156014)(8676002)(76176011)(446003)(99286004)(71190400001)(6436002)(186003)(71200400001)(4326008)(11346002)(476003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5923;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sRRnVEPzjxKkV/wqSeKIwDdAtPJqRhZpyCy05timCZWuxVzVqdYVwqlT8wT1nYtVCDi+FnH+4p4WY+jNOrbcxgKCEGA8BO6DMhIMsxM65MoEQ0++xm3lLDLGf4q77OVHhLgH43+j3LWanDxpwWaAr+UOzAiymCgBs7IEiVoQwQpcaNnk7qaVfifdX36XywxwoEze8e4gD20vm8Zg+5noDbl8jYYQEfDaxp+mjRhv9eS+YNuZDFagQFsrk1yRSxtqKsxoReelh1FtmBRyuZsnmPxwjknARa4Kj29ahuQqbd98pfErgM6mbvaLriehvI0KPAYXDjaJ7ELNi8DTYm6RUdJ5cgRj4Q7RRhSAp/4YZc5gpf8HZNDTV3o6+aIKZCA6wVv+hYvDtAcpI+T8N8E844z5N1ONzg9q3/V84wWG9Tw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3eb123-cc04-4974-2412-08d6b325798f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2019 02:31:25.3049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5923
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Baluta
> Sent: Thursday, March 28, 2019 3:03 AM
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
> index 0cb939861a60..84c7c3eca1a1 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -182,6 +182,78 @@
>  			#clock-cells =3D <1>;
>  		};
>=20
> +		edma0: dma-controller@591f0000 {
> +			compatible =3D "fsl,imx8qxp-edma";
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

In binding doc, it's 2.
- #dma-cells : Must be <2>.
        The 1st cell specifies the DMAMUX(0 for DMAMUX0 and 1 for DMAMUX1).
        Specific request source can only be multiplexed by specific channel=
s
        group called DMAMUX.
        The 2nd cell specifies the request source(slot) ID.

Need update binding doc?

> +			shared-interrupt;

Undocumented property?

Checkpatch did not complain?

Regards
Dong Aisheng

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
> +			compatible =3D "fsl,imx8qxp-edma";
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

