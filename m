Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6869DC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8EE20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ICYNqFGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389186AbfCAQhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 11:37:16 -0500
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:54658
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389151AbfCAQhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 11:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1VRlsE/KvFCtQHOsg55l43bl/funa37fHf4AC9pZYAE=;
 b=ICYNqFGzKUP3qwRh7KROQ92hpLAKK3G7WqR+SKubnEqBPtCF0BeyER5cFTw0vxDN8rRPLw7OwqeO5LIzATOqWmn0UkkBRpqwO+kXqPGLMY3Ze3HrMa0MEd6FEF5/UAzoWVFlimwacOtLAcEe6dfQnmVrDlopIgDz91BsRk55JPI=
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com (52.134.1.18) by
 VI1PR0402MB3648.eurprd04.prod.outlook.com (52.134.14.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Fri, 1 Mar 2019 16:36:35 +0000
Received: from VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced]) by VI1PR0402MB3357.eurprd04.prod.outlook.com
 ([fe80::f80e:d03f:57bc:aced%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 16:36:35 +0000
From:   Daniel Baluta <daniel.baluta@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "S.j. Wang" <shengjiu.wang@nxp.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "spencercw@gmail.com" <spencercw@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v5 3/4] arm64: dts: imx8mq: Add SAI2 node
Thread-Topic: [PATCH v5 3/4] arm64: dts: imx8mq: Add SAI2 node
Thread-Index: AQHU0EzvyaTp2mobmECpAmJsTZC+BA==
Date:   Fri, 1 Mar 2019 16:36:34 +0000
Message-ID: <20190301163604.10618-4-daniel.baluta@nxp.com>
References: <20190301163604.10618-1-daniel.baluta@nxp.com>
In-Reply-To: <20190301163604.10618-1-daniel.baluta@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0248.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::15) To VI1PR0402MB3357.eurprd04.prod.outlook.com
 (2603:10a6:803:2::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b26b24a8-efee-4d35-1549-08d69e641178
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0402MB3648;
x-ms-traffictypediagnostic: VI1PR0402MB3648:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;VI1PR0402MB3648;23:W+7dyvAFwRKBsYdMpbx0zD/McLz36bmghKy3K?=
 =?iso-8859-1?Q?B0yG/QEM7f/Kag7+0CLKmjQ92uGEUK8o3OtQ/UsD0nPCTn8PQocoj2+VTV?=
 =?iso-8859-1?Q?WpWY/hvMZjnIulFZfK2eJs3Rxwnasb6GHzIVanl24daDKSAKk8VKDcPUmu?=
 =?iso-8859-1?Q?XCsv3uy/83bdUI7pg66qUHOaSbI5tQJvsQLqJMlLvZaZV6/K6Pw+d6HQw3?=
 =?iso-8859-1?Q?ZyNlnuaA6EDnNJqckE0o0/Atb5C2UJGEJ/59UGiqvOr9r47ItZ398DhccI?=
 =?iso-8859-1?Q?oLWE6PCkLxO24crirOQf8gh9UR7ODASL29yuP1laFX5gWFMYuWctyKF//N?=
 =?iso-8859-1?Q?3t02bqIyYrMIJd/twQDN9L5lOFROrDkSgoe6LP+u2fiBlRZPlbiIDqLjFS?=
 =?iso-8859-1?Q?y/pWrNGI4TkjkDud9gyw5Sr5Eekw38oNMAjd6Y2MphCN+H0VbuEKYgwwYX?=
 =?iso-8859-1?Q?hXv8Mbbyf2sSsU5h4xJT/HFEryh/48caNP4KBGM3dUCPHvRl2aIiST76O4?=
 =?iso-8859-1?Q?e4EK69+vnLOpIs4KSlEzKP0DShjl8sSkLA/q5U5PpF54nHR7PWfHX6+Oel?=
 =?iso-8859-1?Q?9ol/gWFhv9OEDtIYACq3AFkB3nJx58JP/09HMW11+hbWatH1EwN4ptfErC?=
 =?iso-8859-1?Q?ZSEFTAFd2hBQwekK4HKkXmB9Ap5Ai3QhGlmg/0ot871YFv9h7Qpd1uRUQO?=
 =?iso-8859-1?Q?OlJjsdaZa+uT/sNdXT+03TdKpMOd8gOx4gjgigIcgPQrGqLpPDhzJQwvdm?=
 =?iso-8859-1?Q?GHQo7Z0s7kkBFBQ+YkbVru9Rp313fHuqCGI0mPnvu+Raiimpqq9LXyPrcs?=
 =?iso-8859-1?Q?92tW2I6A0Bf29Lh2BR6IqE4Xw99hvtA0uoa6DXEjivl1elMEcdDLtlMIC8?=
 =?iso-8859-1?Q?PfOlRDQTU++5MVrPlb3EqfFN3GmbjXGr6GRTmNZsO5SbMZpWxxwkLHR1rJ?=
 =?iso-8859-1?Q?nvrbMvcqrOsGiEtjAHRPIg90q1p5a09R8X3mGuKL182YO2XZh4n+9vwHCx?=
 =?iso-8859-1?Q?4YjNz+6c/ejnxeLYceo02BF98H2KsO2KgWEURiP0CuT1Xf6h+UQU6Idzrb?=
 =?iso-8859-1?Q?9AkjOsZlrPj4fIqb+pNIwF5320NcJ759UM/IYPbkDgOpk1pCbSIUtvPHR6?=
 =?iso-8859-1?Q?4OADol/NIH0jsDS/DB6+5alqqqCwcKRqrmpH9I17AevnCEljIpI4jZbCWF?=
 =?iso-8859-1?Q?zN1kALN2LjS42YrQmKjKc7Lgh5dYySmOtL0TZCbB2fDTRMGTqAQxOyiI3B?=
 =?iso-8859-1?Q?A1CTdVp9hQIRLlUMywrlDaA2aCKpNZJ6IEWB1sBvD50FYirufGmJdFQ3au?=
 =?iso-8859-1?Q?5qxunEs65tR2AwtkuO51+VD3r6wRFCwTkgcuU0uPvrnxGwHrxxdiO3Cc+q?=
 =?iso-8859-1?Q?WtVY+7pKUDe8OwUmWede1q75SraJQSAxUVy+ATaZ39oYXXukCfzjIDo7fT?=
 =?iso-8859-1?Q?x9zm0t/YimVl8TCNXO/W82zRrRBbsEQMvcK4K?=
x-microsoft-antispam-prvs: <VI1PR0402MB36488683B5F0AF16FE2E7FA2F9760@VI1PR0402MB3648.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(366004)(199004)(189003)(68736007)(478600001)(76176011)(6916009)(99286004)(386003)(53936002)(66066001)(52116002)(7416002)(4326008)(2501003)(14454004)(54906003)(6512007)(14444005)(106356001)(2906002)(86362001)(316002)(105586002)(256004)(11346002)(6486002)(486006)(1730700003)(186003)(476003)(102836004)(8676002)(4744005)(25786009)(81166006)(6116002)(2616005)(446003)(5640700003)(3846002)(97736004)(50226002)(26005)(8936002)(71190400001)(5660300002)(6436002)(305945005)(71200400001)(2351001)(6506007)(1076003)(44832011)(7736002)(36756003)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3648;H:VI1PR0402MB3357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6sjSkOM3D/TA+mRUmgJVYGNXMw8Agx6MbiSvKX2eobLu4BGOCB7WFEWwzyk7HTWfY7Ec4s2btt5xkSy5v3E0byymQlxYsS/OxSSL/rBHHOM2wAIQDbyLjdzI514jV/qhunqZrhtFDVw1/ztQuYzq6riKnES3EoCwma+Kb5PkKkF9nLaRH1VW0lPZuU9gPee3Yf/zQSk1EqhA/6YN3IIQ3/r4rpWJwT3eaqSg4IKUlmg7MJOIopyb6Cc/xViRqpsiGSaCo+Ac3Yj3Qj9DcCv9XUcbC6gi/ppnGIB0wqv+2kuXhTa1pV30hC9XTsh309mpZ13oZ3EaeCt3AluEJXq61k4UKn7casTyLgmDwfE8QEVqVmckXwTMeOR0Z04P9qSRwuWjBaYXoTOLWX+bB5t20qf5JT6i2WSb8a6XoOG0kAA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b26b24a8-efee-4d35-1549-08d69e641178
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 16:36:34.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3648
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SAI2 is part of AIPS-3 memory region.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 9d48450453fb..b39c6c75c043 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -489,6 +489,21 @@
 				status =3D "disabled";
 			};
=20
+			sai2: sai@308b0000 {
+				#sound-dai-cells =3D <0>;
+				compatible =3D "fsl,imx8mq-sai",
+					     "fsl,imx6sx-sai";
+				reg =3D <0x308b0000 0x10000>;
+				interrupts =3D <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
+				clocks =3D <&clk IMX8MQ_CLK_SAI2_IPG>,
+					 <&clk IMX8MQ_CLK_SAI2_ROOT>,
+					 <&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
+				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
+				dmas =3D <&sdma1 10 24 0>, <&sdma1 11 24 0>;
+				dma-names =3D "rx", "tx";
+				status =3D "disabled";
+			};
+
 			i2c1: i2c@30a20000 {
 				compatible =3D "fsl,imx8mq-i2c", "fsl,imx21-i2c";
 				reg =3D <0x30a20000 0x10000>;
--=20
2.17.1

