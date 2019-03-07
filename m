Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A24AC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D08B20661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g381IUCf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfCGDlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:41:02 -0500
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:2496
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfCGDlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXIi+ENDHBJshqNSADg3NxAmFTxh+R9euepCSvIrsKA=;
 b=g381IUCftsrLJMMqo1OV0E1X+HBT4TCPSPApC1x8T03EjLBpXlZ4DzQ2E3gyZ0D7wP5eLfplc9a9MZPZ901AeTe44zAWVCGd3DH1t1zRTMhbdxxhfNUzjTz3GDE3zGICONuJvuT1IGxo28OZOocHmAERwbYwyvvJp05F/e6PI/E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Thu, 7 Mar 2019 03:40:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.018; Thu, 7 Mar 2019
 03:40:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] dt-bindings: clock: imx8mq: add hdmi phy 27m clock
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx8mq: add hdmi phy 27m clock
Thread-Index: AQHU1JeTcAnJKveUoE2WRuXtJHSgfA==
Date:   Thu, 7 Mar 2019 03:40:57 +0000
Message-ID: <1551929772-22633-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0046.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d6601e0-3fc3-48f0-a7d8-08d6a2aeb562
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:eW5wXK2hGkHC4xjJSsgedufRZDD6JaS39yGG8?=
 =?iso-8859-1?Q?mgmxmCDI7EQpLN75wWk2DX6h8i2cyN8OJtK+yjjIpGF+LvNa2cDy2z3maY?=
 =?iso-8859-1?Q?zvOO0aA2MR/FEjgX1434Yw+l3iJUXji49uTNpiroj6bmkXFTbz3tlTw9LZ?=
 =?iso-8859-1?Q?t0+7pICIq6VP77bm8SLe55mEQ6tKv51fGvratoPA2o2PZMWwW+tZoJ+Sni?=
 =?iso-8859-1?Q?RKgvnKoLPsMzBhZhb3nrIHzCQcH9StL7yLLeOsX76JW5zwyrQGzOY75MCy?=
 =?iso-8859-1?Q?QDdStOjXkNxfqR6uFYYSr75EpdOu2YhU2xFS9xJtWCIlU+3+ig4VLlaRQA?=
 =?iso-8859-1?Q?blCzHCba+3z4wsubbHgTSvk58YtRvtJaHeEzKr1LhLQI6gYFVumVHO/JqK?=
 =?iso-8859-1?Q?EhgAmTnbjT+WFsWwzfZSq0D9iEYO05g+UdmbYCZgtiCdirx+Ad6XKgHWwX?=
 =?iso-8859-1?Q?ZHEjxGs4cp6SrJc6oCdf9MGHCkYaV+NXURdJWQdieu7krhfRaaRLTMCso8?=
 =?iso-8859-1?Q?rjbxGxQNmCHy6EEZgXvic2SBC+ZNCP8u5I+K+MP710j8kWKbS6GHGPpXNt?=
 =?iso-8859-1?Q?6tooBkbtV7oelufQY6ii6wSVqEyL224ZTQdZZKkXrrl/6Zr45KEKTyhJ9u?=
 =?iso-8859-1?Q?IbV3xUaEfrAlNb9zUXDp76saXF6f0eowfw8//FxoN3Nmvc0xKhuaw+Sa4B?=
 =?iso-8859-1?Q?61hDDDXOhIV8Wr31Ysfap3AT9PLKBcgV/Pp/+hU5SdqNLA3I9HU11lAXNj?=
 =?iso-8859-1?Q?fyr3CfQdUU8F6pNBeYu7V9p6zeGu30OL8I3557xgi1kyMkKQbyagyHTFEc?=
 =?iso-8859-1?Q?vCY65UD5crxY5HA5OStdQdiZij8HL7l2jxeeOPl8GQXz04MRKUPly1/7b7?=
 =?iso-8859-1?Q?NwWphhmRYMQ7Yi223MV31zHXoQ8muzuGRy5zeG54YaQW2zVOe6GqD2VAzk?=
 =?iso-8859-1?Q?nS6jcDlqCi2+4i99K/VMlDLiXrOdeVNq9kqsJLQAz4ETYfl2Rx/gamC06R?=
 =?iso-8859-1?Q?5heGX4f5+NL7QdT5VCI1Lt266Vs9KAvyZQobhZZlbzQRsUwMGK9sSu64tu?=
 =?iso-8859-1?Q?58tP1lkPOOxP7AzX7aUaTAvfRAdmUrNGYh4FcQMU9CvQU+lsdaKXB8kBMu?=
 =?iso-8859-1?Q?xD/tTAdHlmpoRhj6cms1nE63or/U5ZyYQdkdbzDafXBNF3izuN4gnwcdCf?=
 =?iso-8859-1?Q?9W4P9uuciRsZ9XLf5+ubkLPqOYJiH2ZEe/0cparikkHRxf/bIP6JZHQVJ/?=
 =?iso-8859-1?Q?LFFqLFMxLhIgmxAExlGF0a3lUdowob3ws7++YWzE/QSiGVGNDpF3rxuLbN?=
 =?iso-8859-1?Q?OrjMUJ03VsYR3KFt3bVvVOiyd?=
x-microsoft-antispam-prvs: <DB3PR0402MB37070A4AED63DB9A26173DD2F54C0@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(376002)(366004)(189003)(199004)(4744005)(99286004)(6116002)(26005)(186003)(6506007)(386003)(102836004)(52116002)(486006)(2616005)(476003)(3846002)(97736004)(50226002)(81156014)(8936002)(2501003)(81166006)(8676002)(68736007)(7736002)(305945005)(7416002)(256004)(478600001)(110136005)(14454004)(105586002)(71200400001)(66066001)(71190400001)(316002)(106356001)(2906002)(6436002)(14444005)(6486002)(5660300002)(36756003)(53936002)(6512007)(2201001)(86362001)(4326008)(25786009)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7a51Evb3qIm2iLYAuTjWeG/G4WegrgrpgE0XcfekdE99BJVh/7GfwPPShemA3FDdWlXLfqYB9jfnBYwOKR/F6ioHMGEQzkuuViqLyz3kTJipFPZwloHqnKp740xJkahTQMsr/6pS120e0S59bdqcykGOtQWacT6kPOp6fp7k1WGbkTLbMR7dDXhf5PaINEdM/TNJEqOAQR8Q9h0u5MUeBt/CLKMYaS2sfs9pweyz85rxy7oW7GVvR37Jv3tgAWa58W1wgdSRYVWF+XW+XExywvbgDyplj5GtuQM/ViMvMVeC+vnr1GOxv+oBoS3FDafv4Cdp7G/PK3N3YhQbeHN58yX5b5eKW1hus+/VOxyL1FOX4T6mSDd2FNgFJtC3cnBhg0UbP+X9J+gxOgXlrPIx/DVHiPCCxul5xHW5o+WpfYY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d6601e0-3fc3-48f0-a7d8-08d6a2aeb562
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 03:40:57.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add IMX8MQ_CLK_HDMI_PHY_27M clock for i.MX8MQ clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings=
/clock/imx8mq-clock.h
index b58cc64..f50ef4e9 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -400,5 +400,7 @@
 #define IMX8MQ_CLK_GPIO4_ROOT			273
 #define IMX8MQ_CLK_GPIO5_ROOT			274
=20
-#define IMX8MQ_CLK_END				275
+#define IMX8MQ_CLK_HDMI_PHY_27M			275
+
+#define IMX8MQ_CLK_END				276
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.7.4

