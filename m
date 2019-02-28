Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9618BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5381B20851
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 01:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kLazS/Xl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfB1BXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 20:23:54 -0500
Received: from mail-eopbgr130082.outbound.protection.outlook.com ([40.107.13.82]:56195
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730240AbfB1BXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 20:23:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NTn4+nuuXqymDgG47Mzd/XAv0AULqA8x4t9IJZw6Wok=;
 b=kLazS/XlCINlO2bdMdjPHuKw5qBrr4i/SmZGns5XbK17VS9/l1WwORTmADLYlJjAKi6BkdDr98axMZ1TdKfGsuNGApFLzZve7MkgybpNVsOP/nuXejYAhRZVKW0vdkHKTXp2ju5p/TeHgoCCD2wd7bfd09NYuIjN/wuV9qABJWY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3898.eurprd04.prod.outlook.com (52.134.65.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 01:23:48 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1643.019; Thu, 28 Feb 2019
 01:23:48 +0000
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
Subject: [PATCH V2 1/3] dt-bindings: memory-controllers: freescale: add MMDC
 binding doc
Thread-Topic: [PATCH V2 1/3] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
Thread-Index: AQHUzwRBQnaGtby3d0KJgz1cGu78Dw==
Date:   Thu, 28 Feb 2019 01:23:48 +0000
Message-ID: <1551316741-7848-1-git-send-email-Anson.Huang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 1642ace2-92a6-415a-e37a-08d69d1b63a9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3898;
x-ms-traffictypediagnostic: DB3PR0402MB3898:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DB3PR0402MB3898;23:sRixBuDGvZVDFVkb5KQGIgeH3huffY4GQPGfc?=
 =?iso-8859-1?Q?bhU25eKYqvGanqIL2b8Q0yEQ5UIzE4hb0RzCa/TdYOhY3IQhZ2osJ0Dyrq?=
 =?iso-8859-1?Q?hxtKO1XtVLiImHCHsYERUaAkxDuzT9O6N7yPYTD1JRC7RHQEIeono1HSzD?=
 =?iso-8859-1?Q?YlQWPHoEgiqCYpOc7lY7vNCyY5JJXWEF7forIfGg6FZ0uuy/LuF4BGb2Tc?=
 =?iso-8859-1?Q?JzBS+ufhmJP9jq5GdC3HnsQfscueQGyI7KEVj1EoHxeXh5mJ1gTq1VieZz?=
 =?iso-8859-1?Q?755NnYtneBLAu1cdxMWoV7cGJDeblt2y1bq647SD0PAFFHTNbNV2cmicdm?=
 =?iso-8859-1?Q?eDH2P2Ymd1xU06ljjSQQgRWM/zj1lC7yRjFCzFU0ph3uWP+h9vosyA47BD?=
 =?iso-8859-1?Q?CY1oHA8l22FYlWwqXWqwqdMrBhW97nUt2XigreQn1OO3n+9+q4HcudgNXr?=
 =?iso-8859-1?Q?jwQCXs/EWzv8RuxEYDzGvHiIK8SRSVGmXExGmSloLmaPGwSYDptZf31W3K?=
 =?iso-8859-1?Q?aTPvLDMWUHlnYrSdDyv2Fo7VR8KtGQrlhLJQ30l9akAeQe9eARMnFeOCUI?=
 =?iso-8859-1?Q?1XtwcqpXuBl2Vbp9Z3sAOFJX0JVyLcqJm4rH2n1/ZcHZ32+EO3tSLbALiK?=
 =?iso-8859-1?Q?ciBJgoQiFUP8vbOy7S+4f9BqcT4wqPQ8pl4ttNnHg8mG4bAr02ZZ5SGrY0?=
 =?iso-8859-1?Q?ZlufPJv9XWe+QtqMlrszxp3A02eR/yXBy71TXjArCJ6C2TBQo7XtuzIdC/?=
 =?iso-8859-1?Q?8zCBq2j+m5s9ELt1qMZFVCi9nRLSgWPzNr0fKL4HwjKcyXs3mfLlztE+Xh?=
 =?iso-8859-1?Q?TcBz/Kd2bx6U0iIi0bbE0loPBUlPwWIWZ5Pf6Ce+RtapNWYvQbVJnsf0IZ?=
 =?iso-8859-1?Q?pawKKwBe1wCk39b1SIILrQ7PVWGZ2TjJjgyfEyEU7EVOB/pEyF6Q8vTyXp?=
 =?iso-8859-1?Q?umFw6SYpm87mfRVIDfszhyxcxY0XSTXjQu+W+Qa6hC552W50HJ3IkdG/2u?=
 =?iso-8859-1?Q?IoYDGmhbBY34QfGtxZxJM1wzC9E4VBiAqt9c/zCRIstC4xz/PlpjnXtSCb?=
 =?iso-8859-1?Q?/HcdbmyRv3z9GWFmzk3YtD3TEvzR5yFBqbfPOzD6uVdQw/kWhscZ7kweHm?=
 =?iso-8859-1?Q?einAOL/Dh61Aq1rBEQG1zB4KzINI5whpJGf9fpNMKqepE30XckvGhi0fE8?=
 =?iso-8859-1?Q?8VntYcW+PbBMybvZHQP5T03m70sRIlFlH7Q=3D=3D?=
x-microsoft-antispam-prvs: <DB3PR0402MB389856D26781117600689DE0F5750@DB3PR0402MB3898.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(71200400001)(4326008)(71190400001)(478600001)(81156014)(81166006)(8676002)(66066001)(7736002)(14454004)(316002)(256004)(2616005)(2906002)(68736007)(26005)(476003)(97736004)(25786009)(305945005)(5660300002)(486006)(14444005)(99286004)(2501003)(6486002)(2201001)(36756003)(53936002)(86362001)(6116002)(3846002)(6512007)(52116002)(105586002)(186003)(102836004)(110136005)(8936002)(386003)(6506007)(106356001)(6436002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3898;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FFX7vxjPBM5DER5jVmAym3T7yxlrLHEE/h0/yaWqiCZDZ6hrp2Sa/r0qlVHmtHxFla0Oz8/E06u7+xogCbD2q+rEv3J+jTLn6FJtLCz6YEm6/K+vSuUDSGuR40vc4Omq6Y/Z+mBPZXn0hKs18Xs2aqK3ISpx/9Thj5EKgx4EcxjRVEUG71rLi81WZFl4ufC5sDDf+9cToyErlig0pGnmKOk2d2K10ninrZ/7aVcfoP+oKSpfzbgGssYcjZ4mQJtDTkGh1Z9JgdijELXS8hL7QKGQUhOalIVkMmgf8vTnan5DhQo471qYTSsa9H2nBppSi35DZkRQoVylzNR49U/Lvmf0+TFw8BhCo1AD1VlNtGxcM3vjCAJUNwlhITDwkVEIxMydbLdw9ecD6aOgm9WCkmx3y4xIqbHuCEQlzPUQFpU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1642ace2-92a6-415a-e37a-08d69d1b63a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 01:23:44.8826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale MMDC (Multi Mode DDR Controller) driver is supported
since i.MX6Q, but not yet documented, this patch adds binding
doc for MMDC module driver.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- use "memory-controller" as MMDC node name and update examples.
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

