Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF1EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC43214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VJ5b090B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbfB1BYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:24:03 -0500
Received: from mail-eopbgr130042.outbound.protection.outlook.com ([40.107.13.42]:64200
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730655AbfB1BYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:24:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wnj3dAZeBNeOM+xTjNX/Ah05Vz0n1IIT0BWfZRzIXrQ=;
 b=VJ5b090BYuEXFMh2LajHOtAenSMQ+ZWV5kTZhlKLoR+facod4S5mEsyox+7FDbfFPcEtFHWC5/FOjLEmEASgTBSyLAu5Y/c9L97rHmwPILRfmtr/8wA6YRcYPgLquIqJYlqAveTWsIvNg07sRZnKmd1z/ffbuEEepTXhCw98Me8=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 01:23:56 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 01:23:56 +0000
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
Subject: [PATCH V2 3/3] ARM: dts: imx: make MMDC node name generic
Thread-Topic: [PATCH V2 3/3] ARM: dts: imx: make MMDC node name generic
Thread-Index: AQHUzwRFZ1TF20r6yUSqdrk6qEjsTg==
Date:   Thu, 28 Feb 2019 01:23:56 +0000
Message-ID: <1551316741-7848-3-git-send-email-Anson.Huang@nxp.com>
References: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::27) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 313dbc05-430d-4980-d8b9-08d69d1b684f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3898;23:ZtpP3zy2bdv6i7aZV8PBTbLiYAACGdgYHJwf5?=
 =?iso-8859-1?Q?VCGpRoAriS6JtdW9uig7qWmlFhv23FXqXwKmNx8G/8fpD4m3fBSHc/yH3T?=
 =?iso-8859-1?Q?tVJpC9Ut9R2K9EUGcO4V06uHezRbXtl6hUXGL+q7L0I7fEv+fKX7n+mxhs?=
 =?iso-8859-1?Q?6EfnOd0XVBnXkdgAGsTpsTQzKI7g0SnmYIJp2WjZTUWvT5VPGznEBOHyZe?=
 =?iso-8859-1?Q?mIJM98VODkmOkLppgkvD076zdzUtSTokYU7t/YmRgugNRR1IWgm1mNeN/r?=
 =?iso-8859-1?Q?+cyDu6CRYNMGM0Enhj+eIZKmC/08YOerr0DAJdHcH4+/g7PB7keTeILBG0?=
 =?iso-8859-1?Q?JATi2P9DZWs6l7xxwr7Ooh1BSqPlPfgU2HhUMpL45JD0j4A6gQcOAzWrZK?=
 =?iso-8859-1?Q?8CoaH3WtLsPy9rTEelBquNXLufWLb2VsYNjqNTmCzHAv8fgjL0L4+FoZag?=
 =?iso-8859-1?Q?GMO84Hqhlw0i19fEw0mTrPEV3HTJgNHo7qEaccE2ohFjRFCZEhtN/n15Iw?=
 =?iso-8859-1?Q?l16bGslXfHdiyVc3y1JaO/8ENLJk4bYIaHfLHIyKUxQbb7XoBdqiLFC+vB?=
 =?iso-8859-1?Q?qdrILrxtTjmY/Zz3ngrr58+zDx8Aa0Pm1T69A42QJ+DIb5d908g38oFZYH?=
 =?iso-8859-1?Q?QrXIL0wThJZgEAX/7GOXAOHRhAqWwe4LuvICysM/c1nlCV1LNiOIGoa8S8?=
 =?iso-8859-1?Q?+SdO4Pxmd/caEgCxufc3PdzoHR+0NuCgqYIzNjzyYj8kvH8ODVK9/qAfJS?=
 =?iso-8859-1?Q?EIKWFZtZ7hd512c5CFUb5hZ71ry045QN7jYH0ZcDYlCL3hzPln3gJa63U1?=
 =?iso-8859-1?Q?F5pd02otfVEc/tHZC0VWzrb6BJ5Vbsun/MFt7IzeSzrBrpFkv9S5ctxOsi?=
 =?iso-8859-1?Q?m5v2g1ec3hLS/tgj3LrfYgsXizz4tdTO4aQwCgKyw7PnnugKsc/2gvUkAJ?=
 =?iso-8859-1?Q?TRMCORImdeyliWCXxmrg/pEAUmkM5ZWQDNOase8A5aQFgnIrHaZg6ig6ZE?=
 =?iso-8859-1?Q?WkyPkauL8FHartKy3A/N9pJFchHhrI+EBlIzYDrLhtAVyGnmvv/me/hC5Z?=
 =?iso-8859-1?Q?Iw+AqvnSA3yD5WUn0yguUo1InsN7QMNOl2XF8MrdTg5as6hYayMmCZbQsT?=
 =?iso-8859-1?Q?BQHbV3tfXtv+m6h1YLRLHTsFlYBqULWclv9A9+92sRzOIvLvSjCgYh/K1K?=
 =?iso-8859-1?Q?glNBTH7OiIc0CdWq1Sy/dn2YfKJHDVvqQZoOZnyWH7BPrVm6QWbCiF27UR?=
 =?iso-8859-1?Q?IRCfr1BizSgGcOcFgecC4IISVYJCR0tv2+zLoY1WMrAxc8h80/zzEo+CXJ?=
 =?iso-8859-1?Q?3NU4=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3898E5B542FA797EFBCC9B4EF5750@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(71200400001)(4326008)(71190400001)(478600001)(81156014)(81166006)(8676002)(66066001)(7736002)(14454004)(316002)(256004)(446003)(2616005)(2906002)(68736007)(26005)(476003)(97736004)(25786009)(305945005)(5660300002)(11346002)(486006)(14444005)(99286004)(2501003)(6486002)(2201001)(36756003)(53936002)(86362001)(6116002)(3846002)(76176011)(6512007)(52116002)(105586002)(186003)(102836004)(110136005)(8936002)(386003)(6506007)(106356001)(6436002)(50226002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zYhUbZ9Y+lvGOOaSqkGJ1cKS5LADApoX9aN9IR0rsEUMUGIAVb21DF6Mgbo/LfyuGFTTcZO34NSDuM4s5GsW5O4rITzRQ/Gb86b8rIdIdBdusQkOQkArBr+mqDDc6q50pVBmqbaOAQPx+Gv7ZaVDvmPYozigdfuQcJXltTBluUGKPWsQuz/PcMPmPQlpmiUpwW7RrD02HwH46AxANyqgg5REmXk0d7Pp+GXzpnrWxZUcs+34tRy0QgebHxbmQ8/KYeSjWCUlvHY4Xi4oF4V8e3ZsRsFBoWAM7DSnTuRYVcqeqkLGmoNW/QeOhKKJ0KaHCwO5cLiIVXB7r1wiyKZjCOgcMpyJ0MIyPD+aq3o5GHxSwR7yQwB3wnYv4zv4QtNFJT4l2iTbhLJ808OiJoYBWy87LfnRwZvRdQr3engNO6s=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313dbc05-430d-4980-d8b9-08d69d1b684f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 01:23:52.7102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node name should be generic, so use "memory-controller"
instead of "mmdc" for MMDC node name.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
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
index 4b4813f..ac57b42 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -922,7 +922,7 @@
 				status =3D "disabled";
 			};
=20
-			mmdc: mmdc@21b0000 {
+			mmdc: memory-controller@21b0000 {
 				compatible =3D "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
 				reg =3D <0x021b0000 0x4000>;
 				clocks =3D <&clks IMX6SL_CLK_MMDC_P0_IPG>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 5b16e65..3de0f3a 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -1017,7 +1017,7 @@
 				status =3D "disabled";
 			};
=20
-			mmdc: mmdc@21b0000 {
+			mmdc: memory-controller@21b0000 {
 				compatible =3D "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
 				reg =3D <0x021b0000 0x4000>;
 				clocks =3D <&clks IMX6SX_CLK_MMDC_P0_IPG>;
diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 62ed30c..8f17a09 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -914,7 +914,7 @@
 				status =3D "disabled";
 			};
=20
-			mmdc: mmdc@21b0000 {
+			mmdc: memory-controller@21b0000 {
 				compatible =3D "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
 				reg =3D <0x021b0000 0x4000>;
 				clocks =3D <&clks IMX6UL_CLK_MMDC_P0_IPG>;
--=20
2.7.4

