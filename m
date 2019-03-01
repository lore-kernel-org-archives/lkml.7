Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC439C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FE6C20842
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 01:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ekiWPMuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbfCABYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 20:24:24 -0500
Received: from mail-eopbgr80044.outbound.protection.outlook.com ([40.107.8.44]:23616
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726088AbfCABYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 20:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbTVdL50FF+r5yKuvVMQtilzKd/gXJTelKO/VTKUpUA=;
 b=ekiWPMuqeBegbJTXzNdPQLEZ+2X6qd/1FhWvx161eckXT3hgT9tUc8xf4jAHoXR0WxyetO/a45XP1Nz8q4RILPpz5q2i4/Q3D0F4cX1vbVb3s3kiv7DJoY5hiyLLxzvJN4qOtN+9cXO+nGXf90nLdZOBY8GXxIkjseJce9XnBaY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3756.eurprd04.prod.outlook.com (52.134.73.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Fri, 1 Mar 2019 01:24:18 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 01:24:18 +0000
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
Subject: [PATCH V4 1/3] dt-bindings: memory-controllers: freescale: add MMDC
 binding doc
Thread-Topic: [PATCH V4 1/3] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
Thread-Index: AQHUz819CWq3wsojT0+oGW04Z701rg==
Date:   Fri, 1 Mar 2019 01:24:18 +0000
Message-ID: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: d4fa7521-2a8b-4a1a-554f-08d69de49fd0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3756;
x-ms-traffictypediagnostic: DB3PR0402MB3756:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3756;23:8Y4JzKAhN/w4QBwqv/zlBzbrOXqrQEoSyJEFj?=
 =?iso-8859-1?Q?yxaRuszh0kdMZ23NMCQN9xjTcEZmQ5mLM9k+yHIaPML4tX6z4k1s++RFFb?=
 =?iso-8859-1?Q?5fXT/K0p32GITAgw0fDwhCClA2CVz+hWNITVWPAP5PutW0GG1LdV5kRnuG?=
 =?iso-8859-1?Q?I3pHSIXoa9SwxdB3GmYEuvxO8bkp/uwpLDlr6dym9gK0YRFcyptDc6eloN?=
 =?iso-8859-1?Q?28fYkUednR1w4T6fDM5TkRuXl1iFpZVpBQLcViO8xqMioJqrTx0PoQnTya?=
 =?iso-8859-1?Q?qVYRMYWwUsykZOp9N/vSgRPc9Uro13ca3b/bh/1UOZAEXoyMUMWBPun9cW?=
 =?iso-8859-1?Q?/J179E57Td0rDWitQUaZGtgifAMxpHT6SNSsXeE3eYXLJfKh1CBaGjcOQL?=
 =?iso-8859-1?Q?1QCRxaUEHTBJ5DyriwtuISYfILcMofX5I7L1FEPc1ejkypiQ5CO8DhbclW?=
 =?iso-8859-1?Q?O7bG6vt+mi6qt8Ots5UWUy3iDZK2lPBy8Io2HQepPHzeYUcvZRqvjgnHtp?=
 =?iso-8859-1?Q?YYZpO+oYrUPyH+r3dN1TOugwRVcr7Drfw5vOtLDIhvo0iCTUdMtdn3HuFt?=
 =?iso-8859-1?Q?OGGDYwC2RvwKF0daTcN7E6Ab2D837UzLV13+T0hrXke2n7cUEcZgZ8tgTS?=
 =?iso-8859-1?Q?5DMwOEWp1e11tKAULo4Iyu9nzggJYsw+7ZyfsxJm9sb27F9ceqax/YeN9W?=
 =?iso-8859-1?Q?IyDPeWafnd0kiUo1jHkOUIM0xqolIngTEr0oHEaUHtWIZY1VQK3QRYLtlQ?=
 =?iso-8859-1?Q?QFJmjVq0ta5ZKvjfMmpGsjciSIzoqjEfM36ercteog5bFGMBqHMJ+cD4Dr?=
 =?iso-8859-1?Q?iKmmPNS4sLA+CVAHicC1YxQCBcNDr70viIPTrtdiejk+3gakkm0MaDkYze?=
 =?iso-8859-1?Q?34gzDB5Kma3OcmR4I0K4GIWsOHBtKetqETTMu0FzRymcm+suOeObNuhEbb?=
 =?iso-8859-1?Q?7NAmCIvBDgJjnLD+cMMoR5aWVZgwQqzXcSMYRw2K2AdOBeBGtKfT98UkwM?=
 =?iso-8859-1?Q?9LCicvkydCO7cjj3/EsqWPWGrBFU+NDzMig7+g/URCc1DUIP8gg1muxRs8?=
 =?iso-8859-1?Q?JPZ5bZSjMN4Zepe1obh0qujMlaRzbUQ6ztutntOXPyg7yBxjk19OaY5Xwp?=
 =?iso-8859-1?Q?YBz7VJGnY6qnYGsxnjw1Wtz9F7NnVG4WNskHzmakHXP5ah3t/lzLSUDNeQ?=
 =?iso-8859-1?Q?S7h9FHmQJ7vXLkHXyKseiXv8uvb54LqyzCQ=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB37565528EF7190148B817959F5760@DB3PR0402MB3756.eurprd04.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(39840400004)(346002)(199004)(189003)(5660300002)(53936002)(478600001)(305945005)(52116002)(6512007)(7736002)(256004)(14454004)(14444005)(6506007)(386003)(2906002)(476003)(486006)(4326008)(2616005)(25786009)(8936002)(81166006)(81156014)(50226002)(8676002)(99286004)(68736007)(2201001)(110136005)(2501003)(316002)(6436002)(102836004)(66066001)(86362001)(97736004)(3846002)(6116002)(6486002)(186003)(26005)(105586002)(36756003)(106356001)(71190400001)(71200400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3756;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3r25SUXV6+POExA4ABVylboN4NgshpthrZ5Q1QUqvtrSrWZsgi8mtHG6cBuELT3VrosZRrZ16JDMt4IMNnvAKX883PwZXMdsloBrs1SL71itMPhMKxQI6afRGOCRAPlS2IMPMcz8zUpOI3AtDjgVjiXlGvtbGnuqnbdfLBjBKVdZV3/SLqbA2gJnxfiUpqWIckZ2Oj7Ii6JkldSWpgzRs1iXEuJQHud6Um0w6Ol5Akzhl2KHwiIrcKLuUvDRC5ymFK7lK9zkLip3fc4iU+TedgSfsEBCmkI3s5/OempMBIVMyjhVJzveYgg5Y0nc3HRDYhVrQ23tpJcs5JGRF0R0LIES9UfmouFuSS+j3LPf4flRB7eZnnuW6uYeouYVK4BSNtvacGyzXB9C74Ep8+lCaujaVakfO5MCh+oLjkoBumk=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fa7521-2a8b-4a1a-554f-08d69de49fd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 01:24:18.3962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3756
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale MMDC (Multi Mode DDR Controller) driver is supported
since i.MX6Q, but not yet documented, this patch adds binding
doc for MMDC module driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- add i.MX6QP compatible name.
---
 .../bindings/memory-controllers/fsl/mmdc.txt       | 33 ++++++++++++++++++=
++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fs=
l/mmdc.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.=
txt b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
new file mode 100644
index 0000000..e4e0b50
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/fsl/mmdc.txt
@@ -0,0 +1,33 @@
+Freescale Multi Mode DDR controller (MMDC)
+
+Required properties :
+- compatible : should be one of following:
+	for i.MX6Q/i.MX6DL:
+	- "fsl,imx6q-mmdc";
+	for i.MX6QP:
+	- "fsl,imx6qp-mmdc", "fsl,imx6q-mmdc";
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

