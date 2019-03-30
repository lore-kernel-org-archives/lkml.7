Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7899C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C77217F5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 17:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WU5Pc1QE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfC3RHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Mar 2019 13:07:49 -0400
Received: from mail-eopbgr10047.outbound.protection.outlook.com ([40.107.1.47]:51645
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730215AbfC3RHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Mar 2019 13:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJko7rFbPpWVOgcjXZS9aS89lJBnm13VV6HVqdt9oZU=;
 b=WU5Pc1QEgO6bIde7Pnir/+NfGr48+IohbevUjSzPSNpp+XXiHmF1WsKflWCdnLuVG7n3ihJLMjT4PuHvrs8h+jRTp0ju2+PcSoftZZrzyytEGGuQ25b5rkoBk3gbMAVHqMbRyoi6Yo/Y7tGcwCU00Yiqb8hmyjlA9oKAmFdQqpU=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2797.eurprd04.prod.outlook.com (10.172.255.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Sat, 30 Mar 2019 17:07:44 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5%4]) with mapi id 15.20.1750.014; Sat, 30 Mar 2019
 17:07:44 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Teo Hall <teo.hall@nxp.com>
Subject: [PATCH] arm64: dts: imx8qxp: Add lpuart1/lpuart2/lpuart3 nodes
Thread-Topic: [PATCH] arm64: dts: imx8qxp: Add lpuart1/lpuart2/lpuart3 nodes
Thread-Index: AQHU5xsXTkClBElNYkSLBv/JPYYQCg==
Date:   Sat, 30 Mar 2019 17:07:44 +0000
Message-ID: <20190330170725.24360-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR0102CA0060.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::37) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6487ce5b-14b6-4f16-38f3-08d6b5323992
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB2797;
x-ms-traffictypediagnostic: VI1PR0402MB2797:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB2797DABD5D0E003685CBDFE0F95B0@VI1PR0402MB2797.eurprd04.prod.outlook.com>
x-forefront-prvs: 09928BEC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(54906003)(52116002)(86362001)(2351001)(486006)(316002)(105586002)(106356001)(2501003)(97736004)(26005)(6916009)(102836004)(25786009)(6486002)(6436002)(14454004)(966005)(478600001)(186003)(6306002)(386003)(2616005)(5640700003)(476003)(36756003)(1076003)(6506007)(4326008)(6512007)(68736007)(81156014)(81166006)(8936002)(2906002)(256004)(14444005)(71190400001)(71200400001)(53936002)(1730700003)(5660300002)(3846002)(8676002)(7736002)(305945005)(99286004)(66066001)(44832011)(50226002)(6116002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2797;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: W+e5N6PDFdJBxZ68OjsoMLX8GM6bUbOX+gtOGDzwm7zqMcP1//5SMCgwuklEvgzLsqBLm40mGYe9SL7JvOQ7DfJnz0oDwJrnK7FYqvFBZjE3idjf3dqzeaZW7+gKaSQkI8G8hAZHF8WTfMSbIAIoWZHDcdUNJbBGa8yuMrGeQMF+WNahhmHhjmgfRk33JT0Sc3Uppe993KmNgicGQCF3C8S7eHfGFYvHZ+138teH+jIV/zese4kduf5FTTL7HaSHuMvsJiyQhT91TgDAFkRS7DeIhIOBHEOO2RdXjJiaiQxooEJqUbHsmxqVZsmtiR3b4G+sb2qgRl9m/q1V9xsY7MMjnFZa1xxM+SRGU711sAw0/TLeFU4ABj2GzJADySXmk2sPkbIA4Hv1X8v7P8054en18Ng/goWIMq7CnMCPGnc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6487ce5b-14b6-4f16-38f3-08d6b5323992
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2019 17:07:44.0872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2797
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lpuart nodes are part of the ADMA subsystem. See Audio DMA
memory map in iMX8 QXP RM [1]

This patch is based on the dtsi file initially submitted by
Teo Hall in i.MX NXP internal tree.

[1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf

Signed-off-by: Teo Hall <teo.hall@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 0cb939861a60..1adfe15c2ea5 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -193,6 +193,39 @@
 			status =3D "disabled";
 		};
=20
+		adma_lpuart1: serial@5a070000 {
+			compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			reg =3D <0x5a070000 0x1000>;
+			interrupts =3D <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent =3D <&gic>;
+			clocks =3D <&adma_lpcg IMX_ADMA_LPCG_UART1_BAUD_CLK>;
+			clock-names =3D "ipg";
+			power-domains =3D <&pd IMX_SC_R_UART_1>;
+			status =3D "disabled";
+		};
+
+		adma_lpuart2: serial@5a080000 {
+			compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			reg =3D <0x5a080000 0x1000>;
+			interrupts =3D <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent =3D <&gic>;
+			clocks =3D <&adma_lpcg IMX_ADMA_LPCG_UART2_BAUD_CLK>;
+			clock-names =3D "ipg";
+			power-domains =3D <&pd IMX_SC_R_UART_2>;
+			status =3D "disabled";
+		}
+
+		adma_lpuart3: serial@5a090000 {
+			compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
+			reg =3D <0x5a090000 0x1000>;
+			interrupts =3D <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent =3D <&gic>;
+			clocks =3D <&adma_lpcg IMX_ADMA_LPCG_UART3_BAUD_CLK>;
+			clock-names =3D "ipg";
+			power-domains =3D <&pd IMX_SC_R_UART_3>;
+			status =3D "disabled";
+		}
+
 		adma_i2c0: i2c@5a800000 {
 			compatible =3D "fsl,imx8qxp-lpi2c", "fsl,imx7ulp-lpi2c";
 			reg =3D <0x5a800000 0x4000>;
--=20
2.17.1

