Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA73C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8261120842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oZ04M0yp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbfCABYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:24:33 -0500
Received: from mail-eopbgr00074.outbound.protection.outlook.com ([40.107.0.74]:38104
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfCABYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 20:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qb63GLAnUWmW0UlrDAbkTKJr7c9UDDHuNNNG+wmmn6k=;
 b=oZ04M0yp3RS4w1LKAlQZZs+VZFCipd+mMFXxzAH6Qk3emcXftz948K9hM2A/iI/yLoYKTqY5SsAxUmfeBjLQK7ii4TzrsFWu2xEId+3OkxK8gl+gEZM0pb1uLQtswZqx5/bbgEGyXE1TXGAe4lw1VNTh62q8IijQrDIRvYyCkag=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Fri, 1 Mar 2019 01:24:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 01:24:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V4 3/3] ARM: dts: imx: make MMDC node name generic
Thread-Topic: [PATCH V4 3/3] ARM: dts: imx: make MMDC node name generic
Thread-Index: AQHUz82Ca+TcoBHkCUa5Q8bcYBU2sw==
Date:   Fri, 1 Mar 2019 01:24:26 +0000
Message-ID: <1551403185-16314-3-git-send-email-Anson.Huang@nxp.com>
References: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73aea00e-9cbf-4424-9fd3-08d69de4a4bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3756;23:UBMSfZPJz40OfuLDa1+Msc+aojCBECV+393eN?=
 =?iso-8859-1?Q?rQqJ9HYAtHQMDy1z7BturbyST5D8PA3zPOKeuxox5WPDK6xsK1Biezzu1q?=
 =?iso-8859-1?Q?5nHYX+JIdcgO7KWsRp1zO/3WThVH8SFoRdFBsfPeceuRSgwvggjDN85+8s?=
 =?iso-8859-1?Q?vBsxrBlxPoBPJYiFhVCYh36a0tt5xdKd3v0xpytiGXZfAP2LGbNemar89D?=
 =?iso-8859-1?Q?COqY6GHaZlwsjRwMoI0z1+Xw+6f5pVww4W0RLRX2zqqSWR+erlV4X2wiyB?=
 =?iso-8859-1?Q?emFDrJIqazCHSObBwH0iaLCH3Zpr0IWqjM2zR7fr+gv6vQSXVCCcavsRwj?=
 =?iso-8859-1?Q?xjVK49c8hbOB8kzGWGxQC6Xh8RVQJkWp2kgyPI48VUxt8NzxvRGIaRHVlv?=
 =?iso-8859-1?Q?cKgygw7goYsDmRJx4wLtMjR+v6bDAwnBipzEZqFImXreihASJTvmp+lWIX?=
 =?iso-8859-1?Q?BUC7m9spUzPcHTDdRGyREqOrIQuMgcWuWs2MwafE9c7tBT67tpaL0hOI3M?=
 =?iso-8859-1?Q?b1bfeRQikaED9Xb2Rb/53apvy92WWzAQ/GS/wN0uSAwL7q6KeR9/enkhGj?=
 =?iso-8859-1?Q?RSnCNpTRWMrp3t1m8P6QPsQ9hh6DhgHzAx8cEaBdGBSvzpdpDCBgaYtYyz?=
 =?iso-8859-1?Q?4Q9q2D0jX9Aa2hH9J9siB015MrysX2LgBHNwalEIHE+9M7a5oP4u+Hv4x+?=
 =?iso-8859-1?Q?w/TdBiY1fbf8kHT624osAQvVkbSbbqDjIMGkAc/NDVS9p/s4NgKRKI+3Pl?=
 =?iso-8859-1?Q?R6Y1HzSilWvPoJXxRu0Xn+4iXOYUN0Po1rqUKCD4VGjYjYia8IpcMzI2E+?=
 =?iso-8859-1?Q?tljIjFOZlvBs8rFfZGXdRb4gbhQKkaJHU2gHmPA0XvvUxdfbfardmBOzM9?=
 =?iso-8859-1?Q?uPvnpWPDRZvC87doGqFzcNvjy0KMlBm58XilJEtgGqSZdOmV3LuxavFuoK?=
 =?iso-8859-1?Q?Leo3ST1uIKKh51JowdnZj0UM5Sf1KtwwDKRELQd5/zxGbN4kgWIPkY0vCn?=
 =?iso-8859-1?Q?Ysbc5gkdXR3TFaqD0i5PoNEGuEtuQ5yvqqmDakpbXPNDrdGUWnpj4cViq9?=
 =?iso-8859-1?Q?yZ0hB6dhjLqXChZbvpnIsy6xlZTHHtCae39MmrkIT5+Yj7bqsDJg6j5ZpP?=
 =?iso-8859-1?Q?MNXpPRPoa45hT//BXiMM+dsKKmAhca6evKKPGDdVUjuUk+lV3oZ6Y0lA3a?=
 =?iso-8859-1?Q?5tZiEn+npwdIbyIbA941Ja0RsxDbKk8eDnmy2lBAkydRp1NY9sSI7sFzz/?=
 =?iso-8859-1?Q?io1HN6ADDY+mtuTDXO3i/pdGNEMUOJ3G5qYh7YzjvEhXA/1gNSVXzNtMrl?=
 =?iso-8859-1?Q?d2sM=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3756D09E2421F24CA247E1D3F5760@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39840400004)(346002)(199004)(189003)(5660300002)(76176011)(53936002)(478600001)(305945005)(52116002)(6512007)(7736002)(256004)(446003)(14454004)(14444005)(6506007)(386003)(2906002)(476003)(486006)(4326008)(2616005)(25786009)(8936002)(81166006)(81156014)(11346002)(50226002)(8676002)(99286004)(68736007)(2201001)(110136005)(2501003)(316002)(6436002)(102836004)(66066001)(86362001)(97736004)(3846002)(6116002)(6486002)(186003)(26005)(105586002)(36756003)(106356001)(71190400001)(71200400001)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BUUNj1EtfVz2olKFkmcSpmgyxcFLLzix+Wf4B7eIgQ0ZTNH1ZA/WZacB8v5n3qAW7gn5Rf7nQ5co/RtNHuI2YxLrq8Vb3M6SwomKjbTiGbl17CRYgg+DFSand/ZcPJ+8RUrtOfyOVNv0QzEagE2bKlzcdjgK96iC533/QkWDZALBz/CxgcpRJxaJK5m/9Za4VXxtnCbLAGS17N5n6ZtY2mhZS87aXH85ToBpD8Or+ei4/qwmWjNeDK3eaYmZFfMZWM4kjERU35z1mYf+I6a+cp7pVcYDlJGhCjiNINY6CYJOxNKsqjEN3Z5yS1Z+BadoBBiq5Bb7fZolSO3opZN7PuRbobDzeWG8aVPHM3xHR5bZcXZ+9Ocbae57lmowSta42SQF422Ks1dJL+Lf69dxG8GrvCGFQmwesm4vrMzPB+o=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73aea00e-9cbf-4424-9fd3-08d69de4a4bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 01:24:26.3370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node name should be generic, so use "memory-controller"
instead of "mmdc" for MMDC node name, also remove "mmdc"
label for platforms with single MMDC node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
No changes since V3.
---
 arch/arm/boot/dts/imx6qdl.dtsi | 4 ++--
 arch/arm/boot/dts/imx6sl.dtsi  | 2 +-
 arch/arm/boot/dts/imx6sx.dtsi  | 2 +-
 arch/arm/boot/dts/imx6ul.dtsi  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dts=
i
index fe17a34..4c7278b 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1129,13 +1129,13 @@
 				reg =3D <0x021ac000 0x4000>;
 			};
=20
-			mmdc0: mmdc@21b0000 { /* MMDC0 */
+			mmdc0: memory-controller@21b0000 { /* MMDC0 */
 				compatible =3D "fsl,imx6q-mmdc";
 				reg =3D <0x021b0000 0x4000>;
 				clocks =3D <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
 			};
=20
-			mmdc1: mmdc@21b4000 { /* MMDC1 */
+			mmdc1: memory-controller@21b4000 { /* MMDC1 */
 				reg =3D <0x021b4000 0x4000>;
 			};
=20
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 4b4813f..733ea50 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -922,7 +922,7 @@
 				status =3D "disabled";
 			};
=20
-			mmdc: mmdc@21b0000 {
+			memory-controller@21b0000 {
 				compatible =3D "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
 				reg =3D <0x021b0000 0x4000>;
 				clocks =3D <&clks IMX6SL_CLK_MMDC_P0_IPG>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 5b16e65..df0c595 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1017,7 +1017,7 @@
 				status =3D "disabled";
 			};
=20
-			mmdc: mmdc@21b0000 {
+			memory-controller@21b0000 {
 				compatible =3D "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
 				reg =3D <0x021b0000 0x4000>;
 				clocks =3D <&clks IMX6SX_CLK_MMDC_P0_IPG>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 62ed30c..a77bbca 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -914,7 +914,7 @@
 				status =3D "disabled";
 			};
=20
-			mmdc: mmdc@21b0000 {
+			memory-controller@21b0000 {
 				compatible =3D "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
 				reg =3D <0x021b0000 0x4000>;
 				clocks =3D <&clks IMX6UL_CLK_MMDC_P0_IPG>;
--=20
2.7.4

