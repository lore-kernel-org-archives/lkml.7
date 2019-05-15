Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4980EC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C9120843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z64QOZUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfEOOmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:42:36 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:20292
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728029AbfEOOme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmDyJ75AAV4D3OqZaHFQQfngnXvaoDBNAJxaccQ1ksE=;
 b=Z64QOZUiqmFHKGK9Ja2GBsvHT8M9X+AHhf/+U3RXtEXF+qxliSpWEJu6X5T8jMneFGfi8lCzwE+y3/uxQFIjDu4dttqBpzckunfiJc8HW07LFb7ls+Gkl7wGCtW+aqBgjTciymFuG+TzxQBzJhwMGGOY/1Z6ssWo08O1hCO4sio=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB2895.eurprd04.prod.outlook.com (10.175.24.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 14:42:28 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::888f:9ea:6f65:508f%6]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 14:42:28 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v3 1/2] arm64: dts: imx8mm: Add SAI nodes
Thread-Topic: [PATCH v3 1/2] arm64: dts: imx8mm: Add SAI nodes
Thread-Index: AQHVCyxrvA2ojkwsRUKL/oaMs8ztbw==
Date:   Wed, 15 May 2019 14:42:28 +0000
Message-ID: <20190515144210.25596-2-daniel.baluta@nxp.com>
References: <20190515144210.25596-1-daniel.baluta@nxp.com>
In-Reply-To: <20190515144210.25596-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR06CA0094.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::23) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 090119d0-9184-4a0d-76b6-08d6d9438dba
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB2895;
x-ms-traffictypediagnostic: VI1PR0402MB2895:
x-microsoft-antispam-prvs: <VI1PR0402MB28951A6D87CB676F5975CA44F9090@VI1PR0402MB2895.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:549;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(39860400002)(136003)(346002)(189003)(199004)(54906003)(5640700003)(6506007)(76176011)(6916009)(478600001)(6512007)(66446008)(14454004)(99286004)(102836004)(36756003)(52116002)(386003)(73956011)(66946007)(7416002)(3846002)(6116002)(64756008)(66476007)(66556008)(446003)(2616005)(476003)(11346002)(53936002)(316002)(486006)(44832011)(5660300002)(2351001)(71200400001)(71190400001)(1076003)(7736002)(26005)(305945005)(186003)(6486002)(86362001)(2501003)(4326008)(66066001)(25786009)(256004)(14444005)(68736007)(81166006)(8676002)(50226002)(81156014)(1730700003)(6436002)(2906002)(8936002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2895;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Yh9rk4JKjk9KLx6cPP0Lm5UQzFdQiBqCvRdGUhXEs08ezzmbQZgcnKEI4NhZBh2L30b0FLUxzHnnflWqjG9liffqzrEuOMLeFtbDjOcNWnJwkFwbsRWJ63dHpGlYtp+C5fcbT5de5uI4On66/Q2V0AENQMYRdHhFK+UqhigtI2D7bb9g7KWqm1/fS/3UPu9SwwxwGc2+wUxtpOOlEuR1X6XhYOJwXiWFjbE0cJWih5ukcNHXUZhmXgQ5OiJIL3dQ6gt3grT8t/kyh52e+dcvEO/v0h+2Uuoler4/QZ1FRqGWzYYknIyjiYoz9BHrH6TEG+KVYitdEhDFPCNFTp6m4XcxhRuojeYisKy/AE2mMat6A35PAFbPVbcYeesuN3FhTHBxvXYH8KN1gHrVU+qeZU1mx/xyPwDshux0evaFGrc=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <9DD38CC770A78C4284E799FF968FF418@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 090119d0-9184-4a0d-76b6-08d6d9438dba
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 14:42:28.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8MM has 5 SAI instances with the following base
addresses according to RM.

SAI1 base address: 3001_0000h
SAI2 base address: 3002_0000h
SAI3 base address: 3003_0000h
SAI5 base address: 3005_0000h
SAI6 base address: 3006_0000h

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 66 +++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mm.dtsi
index 6b407a94c06e..52abe2d03f31 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -201,6 +201,72 @@
 			#size-cells =3D <1>;
 			ranges;
=20
+			sai1: sai@30010000 {
+				compatible =3D "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+				reg =3D <0x30010000 0x10000>;
+				interrupts =3D <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MM_CLK_SAI1_IPG>,
+					 <&clk IMX8MM_CLK_SAI1_ROOT>,
+					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				dmas =3D <&sdma2 0 2 0>, <&sdma2 1 2 0>;
+				dma-names =3D "rx", "tx";
+				status =3D "disabled";
+			};
+
+			sai2: sai@30020000 {
+				compatible =3D "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+				reg =3D <0x30020000 0x10000>;
+				interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MM_CLK_SAI2_IPG>,
+					<&clk IMX8MM_CLK_SAI2_ROOT>,
+					<&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				dmas =3D <&sdma2 2 2 0>, <&sdma2 3 2 0>;
+				dma-names =3D "rx", "tx";
+				status =3D "disabled";
+			};
+
+			sai3: sai@30030000 {
+				#sound-dai-cells =3D <0>;
+				compatible =3D "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+				reg =3D <0x30030000 0x10000>;
+				interrupts =3D <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MM_CLK_SAI3_IPG>,
+					 <&clk IMX8MM_CLK_SAI3_ROOT>,
+					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				dmas =3D <&sdma2 4 2 0>, <&sdma2 5 2 0>;
+				dma-names =3D "rx", "tx";
+				status =3D "disabled";
+			};
+
+			sai5: sai@30050000 {
+				compatible =3D "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+				reg =3D <0x30050000 0x10000>;
+				interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MM_CLK_SAI5_IPG>,
+					 <&clk IMX8MM_CLK_SAI5_ROOT>,
+					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				dmas =3D <&sdma2 8 2 0>, <&sdma2 9 2 0>;
+				dma-names =3D "rx", "tx";
+				status =3D "disabled";
+			};
+
+			sai6: sai@30060000 {
+				compatible =3D "fsl,imx8mm-sai", "fsl,imx8mq-sai";
+				reg =3D <0x30060000 0x10000>;
+				interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MM_CLK_SAI6_IPG>,
+					 <&clk IMX8MM_CLK_SAI6_ROOT>,
+					 <&clk IMX8MM_CLK_DUMMY>, <&clk IMX8MM_CLK_DUMMY>;
+				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				dmas =3D <&sdma2 10 2 0>, <&sdma2 11 2 0>;
+				dma-names =3D "rx", "tx";
+				status =3D "disabled";
+			};
+
 			gpio1: gpio@30200000 {
 				compatible =3D "fsl,imx8mm-gpio", "fsl,imx35-gpio";
 				reg =3D <0x30200000 0x10000>;
--=20
2.17.1

