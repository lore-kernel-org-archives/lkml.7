Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A69C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 11:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F772086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 11:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="b0zbtKQR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfCaLUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 07:20:52 -0400
Received: from mail-eopbgr10085.outbound.protection.outlook.com ([40.107.1.85]:44964
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726586AbfCaLUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 07:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7gbwben0hH1TzvLULMbh9GHizTWXU3atfbgia4GUR4=;
 b=b0zbtKQRN+qfbDP3Vv6i4f8jHWP8wolaGmf2gnZxk2C6pGKXzSBfjD89/naMVskOUk1WiSuepOCA+zAXHj2AQFxEh0yxaoG+MqPejQHoz931SLURaOJfeRdUPNaZJOiFQCOyUFkfC+d1gSamQJLmNNjod9zieXemRwwRc6x6PQY=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5106.eurprd04.prod.outlook.com (20.177.40.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Sun, 31 Mar 2019 11:20:47 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Sun, 31 Mar 2019
 11:20:47 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Teo Hall <teo.hall@nxp.com>
Subject: RE: [PATCH] arm64: dts: imx8qxp: Add lpuart1/lpuart2/lpuart3 nodes
Thread-Topic: [PATCH] arm64: dts: imx8qxp: Add lpuart1/lpuart2/lpuart3 nodes
Thread-Index: AQHU5xsXTkClBElNYkSLBv/JPYYQCqYll/1w
Date:   Sun, 31 Mar 2019 11:20:47 +0000
Message-ID: <AM0PR04MB42113D53B7B178BED58B6AB180540@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190330170725.24360-1-daniel.baluta@nxp.com>
In-Reply-To: <20190330170725.24360-1-daniel.baluta@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb87f774-b11d-41cd-c864-08d6b5caeca7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5106;
x-ms-traffictypediagnostic: AM0PR04MB5106:
x-ms-exchange-purlcount: 1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB51069B984DA28B7F37F7D66E80540@AM0PR04MB5106.eurprd04.prod.outlook.com>
x-forefront-prvs: 0993689CD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39860400002)(396003)(136003)(189003)(199004)(8676002)(2501003)(14444005)(86362001)(2906002)(256004)(55016002)(9686003)(6116002)(3846002)(6306002)(229853002)(4326008)(110136005)(74316002)(6506007)(14454004)(7736002)(486006)(476003)(102836004)(54906003)(106356001)(966005)(478600001)(52536014)(26005)(53936002)(25786009)(316002)(71190400001)(71200400001)(6436002)(7696005)(33656002)(446003)(68736007)(105586002)(11346002)(81156014)(186003)(76176011)(66066001)(6246003)(8936002)(44832011)(305945005)(97736004)(99286004)(81166006)(5660300002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5106;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +Y6wQcSBiSaQMM/njtJUZllzOJbGNBSsleyWhxADNlSzJSv1YApqQ85SGbNTt0iz8JABnCh0xIOZ92xSDj4KyqFDPwSUQM2JD6Is8luJmIIoLDjZ3Iou62BOgh7rBFvJg0uKkeWA4tk5Z9wYt0k+QybUi8KrqDA/4Ba8x5L7CQqkhYflTyW+UAzYEEj9WCAU7cLr6DprpNtOYfzzRyOld3TMSa1+9CiWwt44BIps2V+ZGLYFx0cu9Wzt8kD6p40zn1OQOAYmwzNzQ67NTmu5qd5zX7eNhi5Oo2HkngMPpP/gFw/ISbhQvXEKAgZEFV8vRZ6ZlVGMqoTFp4T5D/xyKmTKj1sp/XdQQ7B/zOkv9kgr+j2eYd26MEST1VisX2GqPK5OxMaqxlsM3fbkTTbM4rSpSZiPJDJUCI8A3Dzg2RE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb87f774-b11d-41cd-c864-08d6b5caeca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2019 11:20:47.7473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Daniel Baluta
> Sent: Sunday, March 31, 2019 1:08 AM
>=20
> lpuart nodes are part of the ADMA subsystem. See Audio DMA memory map in
> iMX8 QXP RM [1]
>=20
> This patch is based on the dtsi file initially submitted by Teo Hall in i=
.MX NXP
> internal tree.
>=20
> [1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf
>=20
> Signed-off-by: Teo Hall <teo.hall@nxp.com>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 33
> ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 0cb939861a60..1adfe15c2ea5 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -193,6 +193,39 @@
>  			status =3D "disabled";
>  		};
>=20
> +		adma_lpuart1: serial@5a070000 {
> +			compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +			reg =3D <0x5a070000 0x1000>;
> +			interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent =3D <&gic>;
> +			clocks =3D <&adma_lpcg IMX_ADMA_LPCG_UART1_BAUD_CLK>;
> +			clock-names =3D "ipg";
> +			power-domains =3D <&pd IMX_SC_R_UART_1>;
> +			status =3D "disabled";
> +		};
> +
> +		adma_lpuart2: serial@5a080000 {
> +			compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +			reg =3D <0x5a080000 0x1000>;
> +			interrupts =3D <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent =3D <&gic>;
> +			clocks =3D <&adma_lpcg IMX_ADMA_LPCG_UART2_BAUD_CLK>;
> +			clock-names =3D "ipg";
> +			power-domains =3D <&pd IMX_SC_R_UART_2>;
> +			status =3D "disabled";
> +		}
> +
> +		adma_lpuart3: serial@5a090000 {
> +			compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
> +			reg =3D <0x5a090000 0x1000>;
> +			interrupts =3D <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-parent =3D <&gic>;
> +			clocks =3D <&adma_lpcg IMX_ADMA_LPCG_UART3_BAUD_CLK>;
> +			clock-names =3D "ipg";
> +			power-domains =3D <&pd IMX_SC_R_UART_3>;
> +			status =3D "disabled";
> +		}
> +
>  		adma_i2c0: i2c@5a800000 {
>  			compatible =3D "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
>  			reg =3D <0x5a800000 0x4000>;
> --
> 2.17.1

