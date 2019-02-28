Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699E3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B68E218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 21:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pl09S2AV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733055AbfB1VnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:43:03 -0500
Received: from mail-eopbgr20081.outbound.protection.outlook.com ([40.107.2.81]:35150
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731040AbfB1VnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 16:43:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp514eg/OX8V6QNVIzJ1xpZwpJ1syOsO+tfxVG8b5c8=;
 b=Pl09S2AVWKXvA2gKQ8pBlzpWkfSFM+ou4+hLL1YBocgNlzmYmHFbOSkIGLn+tu0D4ZlmCnM7jNMC1MzVBcakU1SaByhxBYOoCKBoHAds6apJyoic8IFPhAAAXLKlqJ8nw7sAM4ZYBZ8eLH/zK85INRsSmrRj73X/1zBIuuKcqsA=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5795.eurprd04.prod.outlook.com (20.178.118.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 21:42:46 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 21:42:46 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Anson Huang <anson.huang@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v3 3/3] arm64: dts: imx8mq: Add the opp table and cores opp
 properties
Thread-Topic: [PATCH v3 3/3] arm64: dts: imx8mq: Add the opp table and cores
 opp properties
Thread-Index: AQHUz66Lx4DeyzncSkqi9Xd25tZqeA==
Date:   Thu, 28 Feb 2019 21:42:46 +0000
Message-ID: <1551390149-15443-4-git-send-email-abel.vesa@nxp.com>
References: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
In-Reply-To: <1551390149-15443-1-git-send-email-abel.vesa@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P194CA0012.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::22) To AM0PR04MB5779.eurprd04.prod.outlook.com
 (2603:10a6:208:131::23)
x-originating-ip: [95.76.156.53]
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 760854c0-30e1-4982-e4b7-08d69dc5ad5a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5795;
x-ms-traffictypediagnostic: AM0PR04MB5795:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5795;23:4dD0tNWggSm+7YZwwsIaVMfdaQbmO6aFSwAq4po?=
 =?iso-8859-1?Q?iqwlZRzZiZLfhhikuc+g6zniFd2sNtC7zyVvWeUDGt/8N5Ju1Pcxp7O7W4?=
 =?iso-8859-1?Q?0BisSJOmeuJhTzk93yWXQTN6lg17EDHnXiE7ZMpjQKpvo+Svwnc5ncS3//?=
 =?iso-8859-1?Q?Gm9/7FwZ4UDrnNWTa1niWJj2tCKlkDozsimE2tRVaXjNuvSyHEKNDlz1Yn?=
 =?iso-8859-1?Q?XWgXbnSH8i+U2hw7WY6fQxXu3e4jMhwp/GpdDFGvT8GEH5kk8ryffMuDIn?=
 =?iso-8859-1?Q?MEuVOoIC5M8la0QXSb9yoiRtpLYDPvGmxLNvHlTcc8zRut0TusozYzKn22?=
 =?iso-8859-1?Q?ZlzUXRpQdF9CLzhvoRoze+OWRUZKpABxIQkOsyGtXI4AZrfYlwXFrcBeuR?=
 =?iso-8859-1?Q?9jOeXvVszbKkOm3ze1KhVuNzXT4MPf0GEXio7583659NrDHfdvqq1+hsc5?=
 =?iso-8859-1?Q?1R+9fa/blHF5TuLCZzWdK4t4eTBHXflVbIIvcWSARnryrEm/w2V2e3rtc0?=
 =?iso-8859-1?Q?uyIKFX93/GIgiL+MyPQEs9xpncJ0MOtBP+leaq2NrPfoW7HTGAvIpdpaez?=
 =?iso-8859-1?Q?WHSUBhe5sA9nuhve7zHKM3uUK+GQbKpYcSmWxR79VL00Z5mb85ZlaKnpdk?=
 =?iso-8859-1?Q?tLPmZkqYwQG4s1RUBUH2+rW9lWSLMYEbAqtvqmyBd/6Hz1ar65BNIgJQDV?=
 =?iso-8859-1?Q?utVOhzczG/nz4tdxAlsHfhuq+Nczo30bWZ4YIHPW643qLuwhcvWctnLXJv?=
 =?iso-8859-1?Q?zR7kaYPjVtlHsAP6Y3Ppj/sNMKWVuufDVsS8R/6VDv+i5lmasoI7A8iBDu?=
 =?iso-8859-1?Q?vxf/Bi4kdFSz0G7+Hgw+N7uQlPT7dLrUDJDu3AIDrpPiJI4P7F6+gcGFpP?=
 =?iso-8859-1?Q?CMQXG55s7pZusV2MlI687/ZNxzana/fc9FWAwRmqnUgPVrnMXYdN139yhB?=
 =?iso-8859-1?Q?Ag6d2jTQ6PIkuGaSAGaLRp+SoSEIYXc4UE8mz9IQHox3hKg5GVk9pkVPq8?=
 =?iso-8859-1?Q?aN9cOVkfEybrVcdc5l5V6KTbMLpxq2/c07vBzEeb8PH+RYUeHKjgo+k+Xt?=
 =?iso-8859-1?Q?iKHG+0TTWPiBABcIlyWHaG//yxcQIlQDpZAL/wUmjzZd+SQ9PwuxWeqzCj?=
 =?iso-8859-1?Q?PhdVKKmHtkITlTHU2ebKdWkuAe63sV6nJlaQlfpoSyKaUdSbsJff2S7qh0?=
 =?iso-8859-1?Q?K8y5yBGFk3hJPPkJHTF7KKbAfyNTgVsIj3dqvMfum9cZf4qtOqj2Ge2Zuj?=
 =?iso-8859-1?Q?geV6WIB2iAfr3f5yAAn0OIY2EABkEtlPBtDyGikSkHI2uh/8T8O3kmRnD9?=
 =?iso-8859-1?Q?++VDBINTvtxxXI4bZMhdtoBQhgOty4beUsarH7yfJqeT8RnqUbTSvQyZWq?=
 =?iso-8859-1?Q?qKSu77yY=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB5795D541081AD7CDE1E20A56F6750@AM0PR04MB5795.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(366004)(346002)(376002)(189003)(199004)(25786009)(316002)(446003)(3846002)(2616005)(476003)(6436002)(110136005)(486006)(54906003)(44832011)(76176011)(106356001)(11346002)(99286004)(6486002)(105586002)(14454004)(102836004)(8936002)(68736007)(186003)(66066001)(966005)(6306002)(26005)(36756003)(71190400001)(71200400001)(6512007)(5660300002)(50226002)(305945005)(53936002)(8676002)(7416002)(81166006)(81156014)(6116002)(2906002)(256004)(14444005)(478600001)(386003)(7736002)(52116002)(86362001)(97736004)(6506007)(6636002)(4326008)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5795;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XF2qOHvwKE9UlfZhx1iH+tWICltGKWWJC0zeGIaDRMFnp49AuWEQzrpZnHnPrAwztl50kMsQZUpFtPRw7KvB7LsVTHp5neekcxgY07ojWAE55nCXQAPJdlCmAMfjqO1j8QMCZRSZVIrbDONfp0hCwQIlYPgts12JWE+GDXu1WjfDz/rm+mqmnQEJVOT9a5myd1X+Y6IBrfhIxEsUSil9ax26zS6SX+AYlczRLxt8KxK6480Aix3/Iy5hRmn753kzTG14ceWjhn7ZYbzFxZbs00J4LicuA+BCkUxK8/oSYS53w5wxbXZppC8FsarERqJJnhDTf0t8yx6uC5Ay8UvpcpCVZ5xUAmJINQxAlkJ4zlMRmUjGSULpHPnbwHgpm3Gsp2LEayKjHJt1wtz3szEG7kX2FNCCrMa+OY/WqOOxhQw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760854c0-30e1-4982-e4b7-08d69dc5ad5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 21:42:45.5082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5795
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the 0.8GHz and 1GHz opps. According to the datasheet:
https://www.nxp.com/docs/en/data-sheet/IMX8MDQLQIEC.pdf
section 3.1.3 Operating ranges.

The 0.8GHz opp runs in nominal mode with the regulator set to 0.9V.
The 1GHz runs in overdrive mode with the regulator set to 1V.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dt=
s/freescale/imx8mq.dtsi
index 1a89062..306e3e2 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -91,6 +91,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_opp_table>;
 		};
=20
 		A53_1: cpu@1 {
@@ -101,6 +102,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_opp_table>;
 		};
=20
 		A53_2: cpu@2 {
@@ -111,6 +113,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_opp_table>;
 		};
=20
 		A53_3: cpu@3 {
@@ -121,6 +124,7 @@
 			clocks =3D <&clk IMX8MQ_CLK_ARM>;
 			enable-method =3D "psci";
 			next-level-cache =3D <&A53_L2>;
+			operating-points-v2 =3D <&a53_opp_table>;
 		};
=20
 		A53_L2: l2-cache0 {
@@ -666,6 +670,25 @@
 			status =3D "disabled";
 		};
=20
+
+		a53_opp_table: opp-table {
+			compatible =3D "operating-points-v2";
+			opp-shared;
+
+			opp-800000000 {
+				opp-hz =3D /bits/ 64 <800000000>;
+				opp-microvolt =3D <900000>;
+				clock-latency-ns =3D <150000>;
+			};
+
+			opp-1000000000 {
+				opp-hz =3D /bits/ 64 <1000000000>;
+				opp-microvolt =3D <1000000>;
+				clock-latency-ns =3D <150000>;
+				opp-suspend;
+			};
+		};
+
 		gic: interrupt-controller@38800000 {
 			compatible =3D "arm,gic-v3";
 			reg =3D <0x38800000 0x10000>,	/* GIC Dist */
--=20
2.7.4

