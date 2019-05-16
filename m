Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DCDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75B432089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YDhej+so"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfEPLlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:41:03 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:44539
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727964AbfEPLk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmd5uyoXspeGw9a1scta0xCgKVhZ6BhnwWPIBkaeKe4=;
 b=YDhej+sombU9zT5mIOdAvFiUqp6aWSx7wXDBDXRzBI/Sb+2sK8D53378YZ/NVpVv1QR1awoEk3INLz3ssRexsUVB+7M14dLo0aRsAcHUJYskVRnPRTq3TGQoWTmBzfCfQtZGpgU9KHNMhlu+FWq0VXOSBgxYl+alSxF8ANpI7Ig=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6623.eurprd04.prod.outlook.com (20.179.235.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 11:40:56 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:40:56 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V5] ASoC: cs42xx8: add reset-gpios in binding document
Thread-Topic: [PATCH V5] ASoC: cs42xx8: add reset-gpios in binding document
Thread-Index: AQHVC9w51n/Go/hZQkqdj0LpyBc8Ww==
Date:   Thu, 16 May 2019 11:40:56 +0000
Message-ID: <3e15abaee348468a69005e4240346822320c7f69.1558006714.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK0PR04CA0022.apcprd04.prod.outlook.com
 (2603:1096:203:36::34) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 93a8d3c2-d43e-44bd-53df-08d6d9f35bc0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6623;
x-ms-traffictypediagnostic: VE1PR04MB6623:
x-microsoft-antispam-prvs: <VE1PR04MB662338EF0F0F2E91B1CD08F9E30A0@VE1PR04MB6623.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(376002)(346002)(396003)(199004)(189003)(68736007)(36756003)(110136005)(118296001)(66556008)(316002)(64756008)(2501003)(486006)(186003)(3846002)(6116002)(53936002)(66446008)(71200400001)(71190400001)(66946007)(26005)(73956011)(86362001)(2201001)(66476007)(52116002)(478600001)(2906002)(5660300002)(25786009)(14444005)(6512007)(256004)(99286004)(14454004)(6436002)(4326008)(81166006)(6506007)(386003)(66066001)(2616005)(476003)(8936002)(102836004)(81156014)(305945005)(6486002)(8676002)(7736002)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6623;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AV4DoTIIPiz+OmsUjZf7/eYaC3a6OVe39CrTxk/eTNMZk3Gd2O7YayNjV0PXSy+zmTpiGZdW8sFWFEjbhpX3yvWm1Q5NSMmV3+tGL1r9xqOiNUYqoLOpEFM6097RwMT/aF4z2nGFAzeKQQKAXY+axrJTpsLDTrJ4clmNTGQi1Uj6JzLGbOwR5enIw7BagqFcxZS/N3sFAAPiOPioQoqI9rTUBQJG1l8lTXomlZb7QPtHOp1geNY9Ec3IcYzwHJAQpFDGf0DsR4mEzAYjONt/oH4Dl/ESlQYq1QGTiU/3BAR5/mROzEdWPOPMPDrhTzivEKhaBUahnlYRemLVaKJ2t/gOPpyOBMksdGsa883uhMncd2is/FNPFEjbjSI+954pvE5da5IZbBtXaPiWALTedztJgeq8IX4xy3OU/BWI1mw=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <B74D0E497AF0AA44BEE6A4D2CF2369CA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a8d3c2-d43e-44bd-53df-08d6d9f35bc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:40:56.3372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-gpios property, which is optional.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in V5
- use GPIO_ACTIVE_LOW

Changes in V4
- use gpios instead of gpio

Changes in RESEND v3
- send updated binding document only

Changes in v3
- update binding document.

Changes in v2
- use devm_gpiod_get_optional instead of of_get_named_gpio

 Documentation/devicetree/bindings/sound/cs42xx8.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42xx8.txt b/Document=
ation/devicetree/bindings/sound/cs42xx8.txt
index 8619a156d038..bbfe39347c20 100644
--- a/Documentation/devicetree/bindings/sound/cs42xx8.txt
+++ b/Documentation/devicetree/bindings/sound/cs42xx8.txt
@@ -14,6 +14,11 @@ Required properties:
   - VA-supply, VD-supply, VLS-supply, VLC-supply: power supplies for the d=
evice,
     as covered in Documentation/devicetree/bindings/regulator/regulator.tx=
t
=20
+Optional properties:
+
+  - reset-gpios : a GPIO spec to define which pin is connected to the chip=
's
+    !RESET pin
+
 Example:
=20
 cs42888: codec@48 {
@@ -25,4 +30,5 @@ cs42888: codec@48 {
 	VD-supply =3D <&reg_audio>;
 	VLS-supply =3D <&reg_audio>;
 	VLC-supply =3D <&reg_audio>;
+	reset-gpios =3D <&pca9557_b 1 GPIO_ACTIVE_LOW>;
 };
--=20
2.21.0

