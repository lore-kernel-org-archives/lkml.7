Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D4DC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16FB720848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 11:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="a+4DPyOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfEPLeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 07:34:36 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:58758
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726260AbfEPLef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 07:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ktt6IBb2PIgG4FRoWaJBgn4hBBUMDppcHJ9/MXye6pE=;
 b=a+4DPyOTQkeWpsXDHNMRDB9d/SbL0pAnZAFqNsT+i0n4wGxWs4rRR8xmpaDeAIq+S5dUy5Vzmo9Hj0UlUnvUSD7+uQeSgj3XJRvsDnsRnqIT2Qh+CfJvZp+l57kNprVLTcvkiq3b5mJTNVOwwHpzWKOaKKmdwWFTKblfBsEa8WY=
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) by
 VE1PR04MB6479.eurprd04.prod.outlook.com (20.179.233.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Thu, 16 May 2019 11:34:32 +0000
Received: from VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30]) by VE1PR04MB6479.eurprd04.prod.outlook.com
 ([fe80::a5b5:13f5:f89c:9a30%7]) with mapi id 15.20.1900.010; Thu, 16 May 2019
 11:34:31 +0000
From:   "S.j. Wang" <shengjiu.wang@nxp.com>
To:     "brian.austin@cirrus.com" <brian.austin@cirrus.com>,
        "Paul.Handrigan@cirrus.com" <Paul.Handrigan@cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH V4] ASoC: cs42xx8: add reset-gpios in binding document
Thread-Topic: [PATCH V4] ASoC: cs42xx8: add reset-gpios in binding document
Thread-Index: AQHVC9tUn8z4YEFcnEGkz5K0aeRRDA==
Date:   Thu, 16 May 2019 11:34:31 +0000
Message-ID: <7df2d60911f6c4323c9d11b5fe5341ee31e3940c.1558006342.git.shengjiu.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK0PR01CA0037.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::25) To VE1PR04MB6479.eurprd04.prod.outlook.com
 (2603:10a6:803:11e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shengjiu.wang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a64a0b65-1e59-4139-7358-08d6d9f2769c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VE1PR04MB6479;
x-ms-traffictypediagnostic: VE1PR04MB6479:
x-microsoft-antispam-prvs: <VE1PR04MB64792E98E7854680133D2082E30A0@VE1PR04MB6479.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0039C6E5C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(366004)(39860400002)(376002)(396003)(136003)(346002)(189003)(199004)(68736007)(66556008)(64756008)(66446008)(66476007)(7736002)(81166006)(102836004)(305945005)(81156014)(8676002)(66066001)(2616005)(36756003)(476003)(486006)(6116002)(3846002)(66946007)(256004)(25786009)(4326008)(186003)(6506007)(386003)(14444005)(26005)(71200400001)(71190400001)(52116002)(110136005)(14454004)(118296001)(99286004)(316002)(2201001)(6436002)(53936002)(2501003)(73956011)(86362001)(8936002)(478600001)(2906002)(50226002)(5660300002)(6512007)(6486002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:VE1PR04MB6479;H:VE1PR04MB6479.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0No5E2PlayTMkfm2TQwZ73Lik2X/AsySdv6oSuXxEaQKs36ML68l3WW+CPblr4iOdanynkXwrIvUl86UJcmpql4XPJAk5esdQ1H9Rmsvow3NDXa4XHCmwHWJYENxE58vAi6c4iQ6GNlphjeoI6W97SlTdeZBCBQo30WkSKdBcy8JvS+HBCg0ND17kR95DWjhQbPWbH0rRbQMDRpgsF9ryUPsOSftHJHrYmUFeUK+ruSTdov9z95k/4oXapsXBJhXdsQaJDHI1hDbTNE1o38knK6LfGNce249bPZ61fzUrkwL42fMwRfigjoOb7unnUxxcFTSnxMxq/fG17j0FhDjHRzp/7172kpOHgAl9foW3/yATM8xVPhndJRzWyXnIA7XqdllKGqM3eupbkLEQBRTC5lsruryVKmopl8ucgFjYZ4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EBC99753B6350F44B2C3A0974A3E1C95@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a64a0b65-1e59-4139-7358-08d6d9f2769c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2019 11:34:31.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6479
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add reset-gpios property, which is optional.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
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
index 8619a156d038..0138ef559cc4 100644
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
+	reset-gpios =3D <&pca9557_b 1 1>;
 };
--=20
2.21.0

