Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B721BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7274D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 02:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ddnBtmlf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCLCYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 22:24:24 -0400
Received: from mail-eopbgr70078.outbound.protection.outlook.com ([40.107.7.78]:15140
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726849AbfCLCYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 22:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tm65S3ekNgWKOoZniH+DWaFuy0XO6ods+e4T9+Nob04=;
 b=ddnBtmlfEqp1IbKXzy1r0fkCzk7/EZxzQk+iTqqHmtP6qSbcXw9gMG87sSUEYX2fAC5Rtf2Yj2yGE5Xr+f+sIq/yWbQvm9dvGFxyjCU5QMOtxDJzRXXVnHMDjzzmCkM5LfOqWB2/pGMLrmLEYlX2SREY+Y5lpprE2ZyYcweOmCs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3707.eurprd04.prod.outlook.com (52.134.65.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 02:24:16 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 02:24:16 +0000
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
Subject: [PATCH V5 3/4] ARM: dts: imx: make MMDC node name generic
Thread-Topic: [PATCH V5 3/4] ARM: dts: imx: make MMDC node name generic
Thread-Index: AQHU2HqwEuwtf9zv/0GnVc9P2hCmQQ==
Date:   Tue, 12 Mar 2019 02:24:16 +0000
Message-ID: <1552357127-1283-3-git-send-email-Anson.Huang@nxp.com>
References: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1552357127-1283-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::19) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd32f920-7523-4b20-1734-08d6a691d305
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3707;
x-ms-traffictypediagnostic: DB3PR0402MB3707:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3707;23:gNGyFzAU+dG3+yQ/cNENfU9FSCtuUP/7Zs5jZ?=
 =?iso-8859-1?Q?zpSVMVwHg2XjEJk39nZ/WUy5RZPdYckbJa6RVPyIPU1bRVji5d+sIFDkm9?=
 =?iso-8859-1?Q?WRtQhdcLaxBkAISkHdo53JYG3mhD9qYuBKR3ZM9rmO6KYnwJjmqa53u/QQ?=
 =?iso-8859-1?Q?ouwJ066cOf28xhUwoRY8qf7Togwm+KfaJGKWBvLdOzMqywXpRX5flG/WRL?=
 =?iso-8859-1?Q?z9vjcQIcpe31spRDBdxcVInlcyvCTD00vtkGhEV35qqyWCX+7eUk3k9IdQ?=
 =?iso-8859-1?Q?ZIXkhjXi0BkJpwi8BVtW3Xe1fOsojxEVbBPPkaw+OQvfT6HMHQLtgjSIRJ?=
 =?iso-8859-1?Q?ycT8AHYM0caPxXpoQPolPWegQQ10IACUELeuR4mudM0eYvzuM1AsV24t6E?=
 =?iso-8859-1?Q?gQu/yKZInXlQgc0xu7iFC+wqTM6QOn9g7zbU0ntXkFZqEP5wRsx0HhXK4m?=
 =?iso-8859-1?Q?ayQse5LMgu9UHRHQJgTzy5I3CVsBxPVRi3knQkIw9x+WWEwkt1UiQQSulQ?=
 =?iso-8859-1?Q?2xiqii5Kg4gi3izExe3hz77D3gOcH2R3Mw1VDV5YZxsCRPziomBY1f8voh?=
 =?iso-8859-1?Q?Gsu5p0HQc227WtAo15zHUTpeDE4qRKTjcgriSsdGS6D0B+rBjBCzHG5T5+?=
 =?iso-8859-1?Q?wwzHJ7PuEoNG1FNC4IDfhRHMYBhVZdi05UYJt7bbFtIP7q+0DILHIoCeuF?=
 =?iso-8859-1?Q?dWXlch5SCLEFyVq0icexY4RYYtikDSlnxCwcUldZ8/LDqdacamKMDzL2dH?=
 =?iso-8859-1?Q?jktPDBQod+2QJ0K/Ebfl+nE0o5svXl1SzP5SMKurPxgTNuZee6Tq1rXOZ8?=
 =?iso-8859-1?Q?RisPbTkobGiXy4UvXqcDJ9uDZRK78txqTCfu1O5HOoA5TDfHBE7AyE9OWW?=
 =?iso-8859-1?Q?oMJjD9gbcy8f1jmKR0WuFrYGhOav927MBpMJbiRvnCLCKr6jQVQXfP3CMB?=
 =?iso-8859-1?Q?lApcOI6L2z6SQOiS2xFe6izaGfMXEDUe6stFGjsqoxNQ88g3C2La0SXDiW?=
 =?iso-8859-1?Q?QBiSNWdZOS5JtG1Z6Yzl5oLK5nbGnkZxIh+GtT9zr7dyk6buxyRHTYrmg9?=
 =?iso-8859-1?Q?5RJz0NTIjJd5OmG19v1Ew1Avsbnnr5upXIAPZwcc+xXUJt1uHMQE8rAwpH?=
 =?iso-8859-1?Q?9kiQpUq5FNYDE86+EHykhy0oXJXpAKIfvz9KQTQVKxyjFz9waEQt/UWD8d?=
 =?iso-8859-1?Q?H6+Revv+7hR6Pz6+2EsNThnVhIp7tZsw2mHMbC9CIoDp3UUeC3PpkopENo?=
 =?iso-8859-1?Q?L7ppsdmNW0lDXap7SQIyuG8ZC+/kT37W9P4WBY8hZnVl8EClw5B07cojKa?=
 =?iso-8859-1?Q?CSYA=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3707A78CC473254ED2334AC1F5490@DB3PR0402MB3707.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(366004)(189003)(199004)(2906002)(106356001)(110136005)(316002)(7736002)(486006)(50226002)(476003)(305945005)(6512007)(97736004)(4326008)(6436002)(3846002)(105586002)(25786009)(53936002)(86362001)(6116002)(2201001)(6486002)(14444005)(66066001)(14454004)(478600001)(256004)(71200400001)(71190400001)(8936002)(26005)(8676002)(102836004)(36756003)(81156014)(11346002)(81166006)(2501003)(186003)(76176011)(68736007)(2616005)(6506007)(386003)(52116002)(5660300002)(446003)(99286004)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3707;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Gb0UzFNhzULoRFJr2XdD/PipVECAA2LNpEREyUIKsocdpUHXi81wB+R0hSP8r6Jeik3fRh7Q0wqCjBMvuhE0psQOMoT0Gz8wsWh67zV4d/1SA5/oUB7Vz5gbhkEL7mNOk+0yKEjwEEkNxWNWqoV1QGBR/KMymT8393dWTyqurDdQRx6LNP9AltNk1o+NGENHuOcYq2nDXgrD9qTHiPoQcIn6/hT6OKCfFWKjhE1sEvSXLxohSIOhjLAkz41lzz95kLQ9h+MDD+hfRcuTr1Byn49RdYxVihNbzAjHQxw73QzQfMM8KwxgQSrFONx2dybliAyYSrHbQ7CABHw7TgUUp+vd0AfaE1MIQKet8Q/dE+R6nTCqNbuXfFiEnJUiqObBOSQ7MrEwo3CcWJQrzl9f92Q/J4VhIlVPpmmMHgYj6fw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd32f920-7523-4b20-1734-08d6a691d305
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 02:24:16.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3707
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
No changes.
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

