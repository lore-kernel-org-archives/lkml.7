Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA20C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5842186A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 02:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DFtrVF7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbfB1Csi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 21:48:38 -0500
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:65185
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730575AbfB1Csi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 21:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iP/KcuOInLn3AGRqMDfv/FPPYhcro1rh3ydErBemZ0A=;
 b=DFtrVF7HZbb+PEl9crZCkHya5Mz0+APjpVX45tCB6eqvtv+KK4BYCyC/UeLdkB8iWaPn7x2oOTZuIxiXmdBICgIh0vfufOzKE67NtUj3BbX3bRMm92tryQyxvwocmEgkgcJy/EoxAd76wzeDDBEZ7srXyBfu5G/OyIzYfngrnDU=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Thu, 28 Feb 2019 02:48:35 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 02:48:35 +0000
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
Subject: [PATCH V3 1/3] dt-bindings: memory-controllers: freescale: add MMDC
 binding doc
Thread-Topic: [PATCH V3 1/3] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
Thread-Index: AQHUzxAZE3OHw63WqUeBO/zPSoEUnw==
Date:   Thu, 28 Feb 2019 02:48:35 +0000
Message-ID: <1551321831-11597-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 843660ac-625a-4b6e-0ebe-08d69d273b88
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3833;23:fDoJSYk2YxSxduYyDuqIhV8UFgynpyRqvKrLJ?=
 =?iso-8859-1?Q?0wTiUBMbmq6iQfVsn/Vptx4LA+W0tFiV2w1XZqAd25uicOuX+U0PqQ1wbV?=
 =?iso-8859-1?Q?p/W8aOjs/o+2uypYumtsDa9vfD3zUNGUXig+1U26Mo7DeTC8+l9k1Vshiq?=
 =?iso-8859-1?Q?/JZ7IDV3+i6+0ge3OOMjiGfXgJEoj3mTRK0fzToPRlD6cfVnO4VrY43J8Z?=
 =?iso-8859-1?Q?0D/igBD09XqRgREN+adr3byqhwe54myDHSE1Cx1gqSpvq4WznKP8A2zkoW?=
 =?iso-8859-1?Q?pdkotaDDTbw+oMDfYTNvNOoWiyKa6wSyVzDSYbYfiu7rcSsyJzc3YwKEIG?=
 =?iso-8859-1?Q?fX9iXdVDVZtrNuHlspyP/wOZclQcLeVfltdCgO+xItPkaKXU0iuJB1pjyt?=
 =?iso-8859-1?Q?EnHWbsT2uYx1LphGglK+OTpHrIPsdSSE2qt2fu5s0DEJE09NAXbMbQ1rDo?=
 =?iso-8859-1?Q?00nQasMbHRf6UUneqoV3FcLA+YoXTDkt5N3xJ/iWd7MqP58SHbGqnZstxl?=
 =?iso-8859-1?Q?GCyLkmZAQrRXU4iD4IEeHdC8MmGnzF3XrZ/EZRlVetvH81WLxrLyoiwSkz?=
 =?iso-8859-1?Q?7is1ptY3kdNZ5dvNRH+jvDhU1Exzt9wy7/urzrRplCJQAZ5j8Fq/xwittX?=
 =?iso-8859-1?Q?fSEHjjN9ImvdZ74yibUc4Jq1TkDx/nRYGlQSIC2dS/JWx2j0Z4fmBt6PRN?=
 =?iso-8859-1?Q?XwTj2nFlj1q7Oy45kIuW6AA6O9fHlQPdbaOWY/6Rn4nyHP9mj69rSCw4WX?=
 =?iso-8859-1?Q?ifeq/eT70uEocxb1Z+w4P7iOR34Admj3MPv+RSRPGpsPy6ktAiXzIvntJ8?=
 =?iso-8859-1?Q?WcbimMb/gIQraAUWgi22ZuOtucRI4U9tDBzzpgNfctNt89xrR2kgaJM0P1?=
 =?iso-8859-1?Q?gjmKcPcL7FaIhQyWZu6oNl+6m1g6qwD0uRuU2YLmbFcTVqY7+h1gCcHgQ6?=
 =?iso-8859-1?Q?6Exn1Nzie+/iaE/7vE1R8BICGF1jp4+M+SkJmMb4+fqfoSYM1jCfh/YbKM?=
 =?iso-8859-1?Q?IXmk5MLFFytX+Ahi1BRJf2yTq9C3oHS5IxUUHzzXE9OhxDDbmWWc6GpVS7?=
 =?iso-8859-1?Q?3yTxFGAayQ4fUhDdL2gQeP2G3REFUGon8M1heyWYyVaLwE35Tpv3mzPKzc?=
 =?iso-8859-1?Q?iGN2lnl/W+ACVkC4JDvD2nIdg8TevYmuGKSH13QemQBtfcLBIkZEk6dGfh?=
 =?iso-8859-1?Q?eEaEossrXJI1XmoDFSe3FbHfdeN6olj98pQ=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB3833CA8D65B9C8642DEFF272F5750@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(97736004)(102836004)(316002)(6506007)(386003)(186003)(8676002)(486006)(99286004)(81166006)(50226002)(81156014)(26005)(2616005)(476003)(52116002)(36756003)(5660300002)(14454004)(305945005)(7736002)(14444005)(256004)(3846002)(6116002)(25786009)(6436002)(86362001)(71200400001)(2201001)(71190400001)(66066001)(106356001)(2501003)(53936002)(110136005)(8936002)(6512007)(6486002)(478600001)(105586002)(68736007)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZfAOo+zmPQkmunmB/JUFa0gMDNl+2Bmy23L0IeeWea1PQBz8R98aw5+PebLQn0gz6EAvz2O9olu9Tabpm80UwEReT6HytGLi9ZHtGQiAI+UqnqGLbA2zKU8Qk5pPsOmM4ql858Uqe3Lg+SFePIEHprjxllHQKgz75SbYnIaq9cItNNrwpHTdYCeRWqyeJJCUbH1d3VVBaMcY/ENPoI74fF6DutbHdABUBD2kqh4Vh0wSXa6LyOVQrQkqwXSPRnj+kIwPG3kQXEN09/jPqIGebLTHJo0RRfhsA5VwwV0eZ3AU/cG9KUgtu1KcFJT95SRpsxgjXcN/raW6CRAYpIVs6NCki4CpGDIilM+WPQIaFmYqyvHSiRGZKkheSEJA2DpUubQdkbKIvdHwnOY31mD2P1exwx+1KR80ONr0Pb0bw5Q=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843660ac-625a-4b6e-0ebe-08d69d273b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 02:48:31.4818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale MMDC (Multi Mode DDR Controller) driver is supported
since i.MX6Q, but not yet documented, this patch adds binding
doc for MMDC module driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
No changes since V2.
---
 .../bindings/memory-controllers/fsl/mmdc.txt       | 31 ++++++++++++++++++=
++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fs=
l/mmdc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.=
txt b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
new file mode 100644
index 0000000..5750274
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
@@ -0,0 +1,31 @@
+Freescale Multi Mode DDR controller (MMDC)
+
+Required properties :
+- compatible : should be one of following:
+	for i.MX6Q/i.MX6DL:
+	- "fsl,imx6q-mmdc";
+	for i.MX6SL:
+	- "fsl,imx6sl-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6SLL:
+	- "fsl,imx6sll-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6SX:
+	- "fsl,imx6sx-mmdc", "fsl,imx6q-mmdc";
+	for i.MX6UL/i.MX6ULL/i.MX6ULZ:
+	- "fsl,imx6ul-mmdc", "fsl,imx6q-mmdc";
+	for i.MX7ULP:
+	- "fsl,imx7ulp-mmdc", "fsl,imx6q-mmdc";
+- reg : address and size of MMDC DDR controller registers
+
+Optional properties :
+- clocks : the clock provided by the SoC to access the MMDC registers
+
+Example :
+	mmdc0: memory-controller@21b0000 { /* MMDC0 */
+		compatible =3D "fsl,imx6q-mmdc";
+		reg =3D <0x021b0000 0x4000>;
+		clocks =3D <&clks IMX6QDL_CLK_MMDC_P0_IPG>;
+	};
+
+	mmdc1: memory-controller@21b4000 { /* MMDC1 */
+		reg =3D <0x021b4000 0x4000>;
+	};
--=20
2.7.4

