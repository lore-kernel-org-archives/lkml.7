Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F429C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3348520866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZqlK5KwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731037AbfCZJnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:43:09 -0400
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:10787
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbfCZJnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vYoz2NR5FxGxesMwqRYEwbXGwvIn+88o32QCYgOBmmQ=;
 b=ZqlK5KwN6o0YmKGKv7btjqudnbSGxxv9ULAJlaem/ff9aUgKCxUp2I51zP/L9nEB0NlsvX2Kmkc5oyYViBAQI+LbeCnRjnhlJ0z2+HXPg6lSq0Y4YK3PvyIA98yBVkHQpZ+dLLOc4MdMLlHNg97xUbJHEoh1BLFEhEgr2U+d/4g=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3693.eurprd04.prod.outlook.com (52.134.15.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 09:43:01 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::ddb1:9613:3e6d:eac5%3]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 09:43:01 +0000
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
        Teo Hall <teo.hall@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Topic: [PATCH 2/2] arm64: dts: imx8qxp: Add EDMA0/EDMA1 nodes
Thread-Index: AQHU47hNNps50UbnM0mW6a12KOqBSg==
Date:   Tue, 26 Mar 2019 09:43:01 +0000
Message-ID: <20190326094239.5910-3-daniel.baluta@nxp.com>
References: <20190326094239.5910-1-daniel.baluta@nxp.com>
In-Reply-To: <20190326094239.5910-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0235.eurprd07.prod.outlook.com
 (2603:10a6:802:58::38) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d20061b9-fbaf-4785-a4cb-08d6b1cf6fe8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3693;
x-ms-traffictypediagnostic: VI1PR0402MB3693:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR0402MB369377078F3BA146B8D43C66F95F0@VI1PR0402MB3693.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(366004)(396003)(346002)(39860400002)(136003)(199004)(189003)(81166006)(6506007)(4326008)(1730700003)(25786009)(81156014)(966005)(66066001)(102836004)(76176011)(86362001)(5660300002)(2351001)(105586002)(1076003)(478600001)(8676002)(6512007)(14454004)(3846002)(99286004)(52116002)(6116002)(68736007)(50226002)(106356001)(6306002)(8936002)(36756003)(256004)(26005)(53936002)(5640700003)(44832011)(97736004)(7736002)(386003)(6436002)(2501003)(446003)(316002)(2616005)(6486002)(54906003)(476003)(6916009)(486006)(11346002)(71200400001)(305945005)(186003)(71190400001)(2906002)(32563001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3693;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FWOnUyOfi8cvTGRAiWmD8smN/dTGmAw6Hzdc2MQZ7fbcKP/kcl6vPgr7uoQJDXF8Ce1v5hq6UhSu4wQqgPWoVDtrVmERKkCPK/fcvZIPv+OwuQW7mXh+ZaF7erG8+YsHQj2Wk12yjBL/7Wygo5xdMUxWkcruCXRz0ivVLmnXvtXugO92wjKRF8jIfLc/lPlu6xew978FCaoOEYw7XWaK7Cxvwcp7wz/lmfwlr7weR45rS+LQwT/qB8sKNX634Ezb7QRNrxP9yuw0RRApKL7nqVn18FbXIcJE5OOIS8ENqjWt6HK/Bm3Trlf136HJBC/n855GtxKW6to+79zCGJiJpSLEg1sIQb2g2LQ+bu3Jp4WgSpyapjjh1xoS7NcuQGhHg3XIhoB7uGdPAz+Ybmoyiii6K+BtHkEOEmqa7xkHpRA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20061b9-fbaf-4785-a4cb-08d6b1cf6fe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 09:43:01.6250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3693
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
index 0cb939861a60..9e959deb2499 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -182,6 +182,78 @@
 			#clock-cells =3D <1>;
 		};
=20
+		edma0: dma-controller@591f0000 {
+			compatible =3D "fsl,imx8qm-edma";
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
+			compatible =3D "fsl,imx8qm-edma";
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

