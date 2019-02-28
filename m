Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DE07C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FF22186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="D4VEFvm7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfB1Csr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:48:47 -0500
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:5872
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730575AbfB1Csr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:48:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wc0Xfg/6INzki4XegkA32SkP/y/bxsiJDHrafJUoQrI=;
 b=D4VEFvm7FPOMow8IKGZkEHuM9th5fVvCT+vIMtE1ebXdjV1uenGw75gRfLn3+03jIUoNaDz9mXOMtSpvQ/sL1vbil11YH1e2TLuQb6k8Du1xzl7JdsSXT8HMn2i73JRAytm7yThlN2UzWbJJNiK2HNH1vyDeK7Ga7026EhdtAlo=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Thu, 28 Feb 2019 02:48:42 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 02:48:42 +0000
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
Subject: [PATCH V3 3/3] ARM: dts: imx: make MMDC node name generic
Thread-Topic: [PATCH V3 3/3] ARM: dts: imx: make MMDC node name generic
Thread-Index: AQHUzxAdAcrTth9/skW5cUDirG3XZA==
Date:   Thu, 28 Feb 2019 02:48:42 +0000
Message-ID: <1551321831-11597-3-git-send-email-Anson.Huang@nxp.com>
References: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::23) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 725735f0-8d86-4876-b3bb-08d69d274043
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3833;23:RrXi/L6cZrQt/rJ4qm1u8FWS98HOM7QS07t4K?=
 =?iso-8859-1?Q?NBfILDAohIf9Jom40XUfBT/dp5DkB4vKcWSFImkFYj3blBmL4y54OkiYWh?=
 =?iso-8859-1?Q?438KT+0DfywbwZlHNjdp50dBUI1FEQSQXJSVTzZppE6nFoGO4wkHgBMnzc?=
 =?iso-8859-1?Q?EEU2bApYLwvL8wlTMm6XaumvHd9vfTghoJ/bvVjgOgYlIJo5d4M+U1nMQ0?=
 =?iso-8859-1?Q?1UkaIrjDt4DLaUYCsEs1AThy72lqvAnQAZB9A6fb2t/PElHSWwn/Zen7nc?=
 =?iso-8859-1?Q?PAwqU7gqXxr4sD4G0nu80+jziPvipGxv142oYXq2OhJCevuHkxL3g+hQJQ?=
 =?iso-8859-1?Q?03Li8Y1nSmEG+sUnGZLNxr1L1oR/2un3bPQWO3TzPZ1QXcxdJN0zzkMZnt?=
 =?iso-8859-1?Q?J+ibNH0OI6P1lgqzpobOIyueERbAxa9IJOtg9MYvi7/abghBh6EVIT5y76?=
 =?iso-8859-1?Q?wsh7rdtUdw201mcGynhAL2X8AT1w97OhZbYeHrPq9OJiLQ6GK8YoZIM8SB?=
 =?iso-8859-1?Q?MZFZdHR8XPwfp/OtgvyvqmUihwO33uvGU2/5+LHaAVC5e99WWsdXkInwDB?=
 =?iso-8859-1?Q?QTMTkQyPsD/hEeFBaW1EpIIquP6+udrAsMrBN7gQH8ywIozIKV8j3dCPhx?=
 =?iso-8859-1?Q?ew0VWiOUtJhgHGt/GwwOEeZLslhvqCqcRAA2Osy2wd/Ko8qgSGVVVusy+e?=
 =?iso-8859-1?Q?uoHmfA0H4wISlUWehtf5TRka+EhlS0xUtDzJb6s4TwQ1cAS/hzIoH1pAOe?=
 =?iso-8859-1?Q?zFllnFHcK0HEwb7hd7V8a6vtBUy89ERRD5dbrwgeX6hV33M3Tpo1T4WIlA?=
 =?iso-8859-1?Q?phPf4T7jqmvWWU3a4AFP5llDrb4rFTqAdwpU4FEtvtoyaJlpCm3988Kz1F?=
 =?iso-8859-1?Q?K3h+g/8JxSEsxq2l+l0p94YBi0/CygM6Yp72oFlnXXMinzQ8KKY1+9qVkw?=
 =?iso-8859-1?Q?5a4KMHfwtAANVeMyvsJLfko8pgvryortgkbxCDCnLYome+PlDJQNGAZUj9?=
 =?iso-8859-1?Q?DUdx7T5WlZqcvyF1ZPKMUCh4FBhf8jB1Msyh20hh8h9E/Sj3LIzdOwOtSJ?=
 =?iso-8859-1?Q?fHMH7WC7BPmQVuOzcQpXroRx14oHaBOTriRRnwn0sprd7Z0MaD5dYTRk5A?=
 =?iso-8859-1?Q?SwwvhP42y0cvK8jS9aQyzEjdFOcZWZpcwl/4KjlqSOyMHwrmwd7W+G7ppB?=
 =?iso-8859-1?Q?9eask9PloCv14K69WPnPjPOnzGUOthMHw7W7zDopxZZwnXftW4FAuaI/LG?=
 =?iso-8859-1?Q?1LJ/UeESop19DWSyBN5N4UJy6Snn9RxQ5QFaqzFBLxSP9g/w7Pph/rPynO?=
 =?iso-8859-1?Q?i2UA=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB383389751BCCBF4E63DF43CAF5750@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(97736004)(102836004)(316002)(6506007)(386003)(186003)(8676002)(486006)(99286004)(81166006)(50226002)(81156014)(76176011)(26005)(2616005)(476003)(52116002)(36756003)(5660300002)(14454004)(305945005)(7736002)(14444005)(256004)(3846002)(6116002)(25786009)(6436002)(86362001)(71200400001)(2201001)(71190400001)(66066001)(106356001)(2501003)(53936002)(110136005)(11346002)(8936002)(446003)(6512007)(6486002)(478600001)(105586002)(68736007)(4326008)(2906002)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZUGx/0eK2EYi9Q9qEobFrnpyB8HhK0Gf3pm0MJ2PaBjLHlzDMzmBN2TJK5kIL4mZOfc0bNmTZObmMgrQ5bAm0nZ1kEziaUAD/0Q4stTzxUCrqq9r6NPX+e0qUjH+QWGQrRP/v4eBCtNa8peM3I+kpLc5t1oLNMB8LkPwvMo4lLj7BwqkZ6Xhz+lg/DAZrIQA3LRnZAZ9oxt3cGf76F1k/vqL/WprMg15mCDGDiA6p0e72ZJX+YheUS7T1EJ52MzFSdNaHBLRWraSX3CqRNbUr13bwWIOIw5xlR+Cp4SHspNGDXVgEVpwLDhyeWVrsrNsrtIFX3xGPEBFcl7IcIsuGP1wRsxU5JTxkxyPSAXFkiGQlHqpWW7iysODloqEgdu33NUHGXmB4rNsHnnpQqSmOODzmML1yhVgej3eFqBVwy0=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725735f0-8d86-4876-b3bb-08d69d274043
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 02:48:39.4034
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Node name should be generic, so use "memory-controller"
instead of "mmdc" for MMDC node name, also remove "mmdc"
label for platforms with single MMDC node.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V2:
	- remove "mmdc" label for single MMDC node.
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

