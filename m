Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40612C10F05
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05AFE20872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 03:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gxlON//G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfCRDJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 23:09:55 -0400
Received: from mail-eopbgr20043.outbound.protection.outlook.com ([40.107.2.43]:56486
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbfCRDJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 23:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0r8y4K7V8ktZn58WAHt3QOIfAH4Tylf2QEjg3v74Ar4=;
 b=gxlON//GUYTz7urwvZLZezQvrXQDxoLTSBDvYMrap9K6UB9HhId0mJ5HxWT9IcLmuPIhUoW/yhLO39HiGSSedUjoWYawf0c6+Ja0R4AmpMszg3EGYHCeRZFCjcQWR5ZzGp3J/7nYVJ/XrvNmk/5q32arokh3scnPD5GHtanok3c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3883.eurprd04.prod.outlook.com (52.134.71.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Mon, 18 Mar 2019 03:09:50 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%6]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 03:09:50 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V5 1/4] dt-bindings: fsl: scu: add general interrupt support
Thread-Topic: [PATCH V5 1/4] dt-bindings: fsl: scu: add general interrupt
 support
Thread-Index: AQHU3TgMmDp2QtLWCEidsBGFRWrSFA==
Date:   Mon, 18 Mar 2019 03:09:49 +0000
Message-ID: <1552878291-22866-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::35) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c531f3b7-3468-47f6-f0a0-08d6ab4f2ecd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3883;
x-ms-traffictypediagnostic: DB3PR0402MB3883:
x-microsoft-antispam-prvs: <DB3PR0402MB38839CB97C2CCD614AB4229EF5470@DB3PR0402MB3883.eurprd04.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(39860400002)(366004)(346002)(199004)(189003)(6512007)(256004)(386003)(6486002)(6436002)(97736004)(106356001)(6116002)(3846002)(52116002)(486006)(6506007)(186003)(26005)(53936002)(4326008)(476003)(316002)(2616005)(2501003)(2201001)(86362001)(25786009)(7416002)(305945005)(478600001)(110136005)(99286004)(7736002)(5660300002)(36756003)(50226002)(68736007)(66066001)(2906002)(105586002)(14454004)(81166006)(8676002)(81156014)(71200400001)(102836004)(71190400001)(8936002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3883;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: SaujgbNNUREbEHEqC03iydzTD5aSnCVJtUeZttF5Q/iU6op7iMD2pa6Y1N3xSm6YS2i9zGw+6NW+3ku7hpZWbfkcmNMsnFV1Qn26p2bdHB3XH+lVwphmK+Hu791vFgVLE69P8tmFQERTGWjz2pKO8RpV2VkjO0ghWXInjOLhxM/4RXoQ7AvWO4JCVFGgdF0GpeVLzZKcdoeA3VQWJ8BVdgV5MiK45k3j1uCEQfhmM9EBcUOHH608Npr+cjYKpFMrbqM/3zCeZ1A8KpUnJip8/eTZd91soFW4yAY0Mt1gn2lYq8MUO7XB/VwytHu3p46klTm/aFEL0LjRHfHeJTIzDTbjpkVf26T8iyZVKB/SlMgZBp2uGNiJOWNlnt3HVAtjOojSvVYEjELdkvsp2ff+X8ga6kMQXjoUdWa/W2GikYM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c531f3b7-3468-47f6-f0a0-08d6ab4f2ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 03:09:49.9080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3883
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scu general interrupt function support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
Changes since V4:
	- add mu aliase info and example in binding doc.
---
 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 29 +++++++++++++++++-=
----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/=
Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
index 72d481c..5d7dbab 100644
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
@@ -22,9 +22,11 @@ Required properties:
 -------------------
 - compatible:	should be "fsl,imx-scu".
 - mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
-			       "rx0", "rx1", "rx2", "rx3".
-- mboxes:	List of phandle of 4 MU channels for tx and 4 MU channels
-		for rx. All 8 MU channels must be in the same MU instance.
+			       "rx0", "rx1", "rx2", "rx3";
+		include "gip3" if want to support general MU interrupt.
+- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
+		rx, and 1 optional MU channel for general interrupt.
+		All MU channels must be in the same MU instance.
 		Cross instances are not allowed. The MU instance can only
 		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
 		to make sure use the one which is not conflict with other
@@ -34,6 +36,7 @@ Required properties:
 		Channel 1 must be "tx1" or "rx1".
 		Channel 2 must be "tx2" or "rx2".
 		Channel 3 must be "tx3" or "rx3".
+		General interrupt rx channel must be "gip3".
 		e.g.
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
@@ -42,10 +45,18 @@ Required properties:
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
 		See Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 		for detailed mailbox binding.
=20
+Note: Each mu which supports general interrupt should have an alias correc=
tly
+numbered in "aliases" node.
+e.g.
+aliases {
+	mu1 =3D &lsio_mu1;
+};
+
 i.MX SCU Client Device Node:
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -124,6 +135,10 @@ Required properties:
=20
 Example (imx8qxp):
 -------------
+aliases {
+	mu1 =3D &lsio_mu1;
+};
+
 lsio_mu1: mailbox@5d1c0000 {
 	...
 	#mbox-cells =3D <2>;
@@ -133,7 +148,8 @@ firmware {
 	scu {
 		compatible =3D "fsl,imx-scu";
 		mbox-names =3D "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3";
+			     "rx0", "rx1", "rx2", "rx3",
+			     "gip3";
 		mboxes =3D <&lsio_mu1 0 0
 			  &lsio_mu1 0 1
 			  &lsio_mu1 0 2
@@ -141,7 +157,8 @@ firmware {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 1 1
 			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3>;
+			  &lsio_mu1 1 3
+			  &lsio_mu1 3 3>;
=20
 		clk: clk {
 			compatible =3D "fsl,imx8qxp-clk", "fsl,scu-clk";
--=20
2.7.4

