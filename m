Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD9CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A75206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 19:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y0cb2IgC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389580AbfC0TDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:03:24 -0400
Received: from mail-eopbgr60054.outbound.protection.outlook.com ([40.107.6.54]:53635
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389975AbfC0TDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 15:03:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUV4AcIG1al9y1jgTDNk8JGXXDoetIP5TLsb7t/9d60=;
 b=Y0cb2IgCJGOokUAOSJDODB0qPG/FKQ95Pjyqxx2jf+29/Qmyjhj30DjLzG++Pv7w1f91QUwtCxvnvjyQFfYlH1NDgsmSDQtTipZc9/TnBxRuxf79VyupAJcpMwjFbl10KXNhW7Cl31BZn1aVSElEzBizK+uPqtZ3zL9H4D1SFj4=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3646.eurprd04.prod.outlook.com (52.134.14.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Wed, 27 Mar 2019 19:03:15 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::7cee:3159:6414:9cc5%4]) with mapi id 15.20.1750.014; Wed, 27 Mar 2019
 19:03:15 +0000
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
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Teo Hall <teo.hall@nxp.com>
Subject: [PATCH v2 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Topic: [PATCH v2 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Index: AQHU5M+7954B9gl89UeTOv8b+X9Xvw==
Date:   Wed, 27 Mar 2019 19:03:15 +0000
Message-ID: <20190327190244.9208-3-daniel.baluta@nxp.com>
References: <20190327190244.9208-1-daniel.baluta@nxp.com>
In-Reply-To: <20190327190244.9208-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0157.eurprd07.prod.outlook.com
 (2603:10a6:802:16::44) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d3002f1-cd86-4a99-8331-08d6b2e6dba6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3646;
x-ms-traffictypediagnostic: VI1PR0402MB3646:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB364631F89E1E6D579FAFB90FF9580@VI1PR0402MB3646.eurprd04.prod.outlook.com>
x-forefront-prvs: 0989A7979C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(366004)(346002)(136003)(396003)(189003)(199004)(186003)(2616005)(966005)(476003)(11346002)(5640700003)(6436002)(446003)(44832011)(486006)(6512007)(6306002)(8936002)(50226002)(478600001)(68736007)(6486002)(386003)(6506007)(105586002)(106356001)(25786009)(99286004)(4326008)(52116002)(76176011)(1076003)(26005)(2351001)(256004)(305945005)(102836004)(71190400001)(5660300002)(14454004)(53936002)(66066001)(6116002)(6916009)(3846002)(2906002)(36756003)(7736002)(97736004)(316002)(8676002)(1730700003)(81156014)(81166006)(2501003)(86362001)(54906003)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3646;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MmNFguaox4sRum65F+/JiIVqZs2TnTW+/aiyZotRF5N6rjH4y6iGrZkiBxebboR9RugCjncHRI2RXP41rK9G1HksOggEZhrOPKcGyrgcjgAz7a/1rVKSL5gDft8rM3Pv0I3DZ/8ESUcOPjqAcAKQkLDUTLsXnKa34LeJ9rZw4prqIk8wPMGBRirPgQ8OJrdGEEaaMXzWpB7El5+OJCFO6gqs8Fxo7Gzu74xp1zIdkgjx8R0plbMBrQeHSG3zkqTcxew8hj/5X1Nbh0b5sggmdIgFW20fWKL9j0cBKtmp9i5r2YnGu75H8ixQxDYakxhlcrj8BKZuE7MQi2XHwyNYQRh8Ju+x6kGftgrf2nhLL2bV1nJqzWag6ZTn1hMxbR1C4PHEIK2s5uyHCNApdwLGROJYyPYriMPyCFQjZhsXUbc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3002f1-cd86-4a99-8331-08d6b2e6dba6
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2019 19:03:15.1383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3646
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8QXP contains a total of 4 EDMA controllers of which
two are primarily for audio components and the other two
are for non-audio periperhals.

This patch adds the EDMA0/EDMA1 nodes used by audio peripherals.

EDMA0 contains channels for:
	* ASRC0
	* ESAI0
	* SPDIF0
	* SAI0, SAI1, SAI2, SAI3

EDMA1 contains channels for:
	* ASRC1
	* SAI4, SAI5

See chapter Audio DMA Memory Maps (2.2.3) from i.MX8QXP RM [1]

This patch is based on the dtsi file initially submitted by
Teo Hall in i.MX NXP internal tree.

[1] https://www.nxp.com/docs/en/reference-manual/IMX8DQXPRM.pdf

Cc: Teo Hall <teo.hall@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/d=
ts/freescale/imx8qxp.dtsi
index 0cb939861a60..84c7c3eca1a1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -182,6 +182,78 @@
 			#clock-cells =3D <1>;
 		};
=20
+		edma0: dma-controller@591f0000 {
+			compatible =3D "fsl,imx8qxp-edma";
+			reg =3D <0x59200000 0x10000>,   /* asrc0 pair A input req */
+				<0x59210000 0x10000>, /* asrc0 pair B input req */
+				<0x59220000 0x10000>, /* asrc0 pair C input req */
+				<0x59230000 0x10000>, /* asrc0 pair A output req */
+				<0x59240000 0x10000>, /* asrc0 pair B output req */
+				<0x59250000 0x10000>, /* asrc0 pair C output req */
+				<0x59260000 0x10000>, /* esai0 rx */
+				<0x59270000 0x10000>, /* esai0 tx */
+				<0x59280000 0x10000>, /* spdif0 rx */
+				<0x59290000 0x10000>, /* spdif0 tx */
+				<0x592c0000 0x10000>, /* sai0 rx */
+				<0x592d0000 0x10000>, /* sai0 tx */
+				<0x592e0000 0x10000>, /* sai1 rx */
+				<0x592f0000 0x10000>, /* sai1 tx */
+			#dma-cells =3D <3>;
+			shared-interrupt;
+			dma-channels =3D <14>;
+			interrupts =3D <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>,    /* asrc 0 */
+					<GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>, /* esai0 */
+					<GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 457 IRQ_TYPE_LEVEL_HIGH>, /* spdif0 */
+					<GIC_SPI 459 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>, /* sai0 */
+					<GIC_SPI 315 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>, /* sai1 */
+					<GIC_SPI 317 IRQ_TYPE_LEVEL_HIGH>,
+			interrupt-names =3D "edma0-chan0-rx", "edma0-chan1-rx", /* asrc0 */
+					"edma0-chan2-rx", "edma0-chan3-tx",
+					"edma0-chan4-tx", "edma0-chan5-tx",
+					"edma0-chan6-rx", "edma0-chan7-tx",   /* esai0 */
+					"edma0-chan8-rx", "edma0-chan9-tx",   /* spdif0 */
+					"edma0-chan12-rx", "edma0-chan13-tx", /* sai0 */
+					"edma0-chan14-rx", "edma0-chan15-tx", /* sai1 */
+		};
+
+		edma1: dma-controller@599F0000 {
+			compatible =3D "fsl,imx8qxp-edma";
+			reg =3D <0x0 0x59A00000 0x0 0x10000>, /* asrc1 */
+				<0x0 0x59A10000 0x0 0x10000>,
+				<0x0 0x59A20000 0x0 0x10000>,
+				<0x0 0x59A30000 0x0 0x10000>,
+				<0x0 0x59A40000 0x0 0x10000>,
+				<0x0 0x59A50000 0x0 0x10000>,
+				<0x0 0x59A80000 0x0 0x10000>, /* sai4 rx */
+				<0x0 0x59A90000 0x0 0x10000>, /* sai4 tx */
+				<0x0 0x59AA0000 0x0 0x10000>; /* sai5 tx */
+			#dma-cells =3D <3>;
+			shared-interrupt;
+			dma-channels =3D <9>;
+			interrupts =3D <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>, /* asrc 1 */
+					<GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 384 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 385 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 386 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 387 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>, /* sai4 */
+					<GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
+					<GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH>; /* sai5 */
+			interrupt-names =3D "edma1-chan0-rx", "edma1-chan1-rx", /* asrc1 */
+					"edma1-chan2-rx", "edma1-chan3-tx",
+					"edma1-chan4-tx", "edma1-chan5-tx",
+					"edma1-chan8-rx", "edma1-chan9-tx", /* sai4 */
+					"edma1-chan10-tx"; /* sai5 */
+		};
+
 		adma_lpuart0: serial@5a060000 {
 			compatible =3D "fsl,imx8qxp-lpuart", "fsl,imx7ulp-lpuart";
 			reg =3D <0x5a060000 0x1000>;
--=20
2.17.1

