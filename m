Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC814C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE0820882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fr66GgJn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfDCKUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:20:31 -0400
Received: from mail-eopbgr20079.outbound.protection.outlook.com ([40.107.2.79]:14350
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725963AbfDCKUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiSWBT8ptY9juWVOy+zF1jJ9M96a9tm8mY8GuMoCL3k=;
 b=fr66GgJnA6YTt8NBTrpLW1k3q4Z1sYxek4CGH1yas8cZXJ0PtHr9lszQdGYCNaHiLBioZ3kUlpexHPzPGOkRFGKak3+jiHTUK+4lHoQn4vZE8z/6r4YNnY5bOldM9V2wGjknJsNfh4BmX5Jz4XF1Rr+6fWlG5y4WJaiuZiTGFtM=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB2750.eurprd04.prod.outlook.com (10.175.22.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.17; Wed, 3 Apr 2019 10:20:26 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::78bc:c1e8:3caf:656b]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::78bc:c1e8:3caf:656b%6]) with mapi id 15.20.1750.014; Wed, 3 Apr 2019
 10:20:26 +0000
From:   Jacky Bai <ping.bai@nxp.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH v3 1/2] dt-bindings: timer: Add binding doc for nxp system
 counter timer
Thread-Topic: [PATCH v3 1/2] dt-bindings: timer: Add binding doc for nxp
 system counter timer
Thread-Index: AQHU6gbaUMi6opXlLUCEb6pueveq7w==
Date:   Wed, 3 Apr 2019 10:20:25 +0000
Message-ID: <1554287101-16189-1-git-send-email-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 1.9.1
x-clientproxiedby: HK0PR03CA0112.apcprd03.prod.outlook.com
 (2603:1096:203:b0::28) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dad16ba-17a1-4070-2aba-08d6b81dfcce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR0402MB2750;
x-ms-traffictypediagnostic: VI1PR0402MB2750:
x-microsoft-antispam-prvs: <VI1PR0402MB2750870222B74D05E9E13DD287570@VI1PR0402MB2750.eurprd04.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(99286004)(54906003)(478600001)(106356001)(3846002)(68736007)(81156014)(71200400001)(53936002)(36756003)(6486002)(6116002)(6436002)(81166006)(6512007)(8936002)(2501003)(86362001)(7736002)(105586002)(25786009)(2906002)(5660300002)(305945005)(4326008)(386003)(316002)(14454004)(14444005)(256004)(50226002)(26005)(186003)(52116002)(102836004)(8676002)(97736004)(66066001)(6506007)(2616005)(6636002)(476003)(71190400001)(486006)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB2750;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qrSOJ+0s7h0Ngd0rgpixeP9az8/3j2IeeRaTvnwOg1/CQjTfU1uOgNIW/ASS8BBs0Pa8oRgUhgdhb1H0CtwaJJ2sZv2uIlvZ0XXDztXkliHTntWU3xUPcWqT4M4W5W2sGK7nbLFRKG6gPoKY9k0Zz96UYj45M3l0/knmYFWeaJznX7X4wTXn+YUUFoopwIEwi4+AvEy0bFShhFuqhm7UxKiriL91Hb5gXzUUbZ/qmUmsvIxkk4sq842ZVfxU8vW3e8NeYJgWpACDK1arbPORhs4EccAugCwbUad8YY++RP/+q5yRkjMgcz4atDIpVQUYLBnLiGXav2gdbBgTj13WmWkZ7M9zKnyOcLmj/5E3aUiIbl/tF7tHyJ5MCVndloB1ST9MJkfdMwaYezSCKlTyLcRNLgo2jfE9WNzwBbKUMgA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dad16ba-17a1-4070-2aba-08d6b81dfcce
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 10:20:26.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bai Ping <ping.bai@nxp.com>

Add the binding doc for nxp system counter timer module.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
---
change v1->v2
 - remove the blank line at EOF
change v2->v3
 - update the binding example based on the driver change
---
 .../devicetree/bindings/timer/nxp,sysctr-timer.txt | 25 ++++++++++++++++++=
++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-time=
r.txt

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt b=
/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
new file mode 100644
index 0000000..d576599
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
@@ -0,0 +1,25 @@
+NXP System Counter Module(sys_ctr)
+
+The system counter(sys_ctr) is a programmable system counter which provide=
s
+a shared time base to Cortex A15, A7, A53, A73, etc. it is intended for us=
e in
+applications where the counter is always powered and support multiple,
+unrelated clocks. The compare frame inside can be used for timer purpose.
+
+Required properties:
+
+- compatible :      should be "nxp,sysctr-timer"
+- reg :             Specifies the base physical address and size of the co=
mapre
+                    frame and the counter control, read & compare.
+- interrupts :      should be the first compare frames' interrupt
+- clocks : 	    Specifies the counter clock.
+- clock-names: 	    Specifies the clock's name of this module
+
+Example:
+
+	system_counter: timer@306a0000 {
+		compatible =3D "nxp,sysctr-timer";
+		reg =3D <0x306a0000 0x20000>;/* system-counter-rd & compare */
+		clocks =3D <&clk_8m>;
+		clock-names =3D "per";
+		interrupts =3D <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+	};
--=20
1.9.1

