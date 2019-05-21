Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD96C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8307721743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 07:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R2vQogFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEUHSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 03:18:53 -0400
Received: from mail-eopbgr130040.outbound.protection.outlook.com ([40.107.13.40]:24549
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbfEUHSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 03:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rLSoyxDF/NxRomskbWHPjlyCS+nIJ17FhxuPWCFFmrY=;
 b=R2vQogFbyKWzO/swQEem8Gu/lV0rbmWopmggcZMO9DwuzljO3bVC/lEy42sQYA9+OskfswmjG5W9UbQmNJOhj7Z0B7D50fREEiqJaxvsjTYjoBhPtz2UNcsI90sSKo+N/lRtfGPOXye6x6fyFBgSkscNEUkM58H/V9rNsLe0KEI=
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com (52.134.4.24) by
 VI1PR0402MB3327.eurprd04.prod.outlook.com (52.134.8.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.22; Tue, 21 May 2019 07:18:48 +0000
Received: from VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::2417:67da:c1aa:29f3]) by VI1PR0402MB3519.eurprd04.prod.outlook.com
 ([fe80::2417:67da:c1aa:29f3%7]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 07:18:48 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: timer: Add binding doc for nxp system
 counter timer
Thread-Topic: [PATCH v4 1/2] dt-bindings: timer: Add binding doc for nxp
 system counter timer
Thread-Index: AQHVD6Vu663GNkqRPk6dV5orvLvwbg==
Date:   Tue, 21 May 2019 07:18:48 +0000
Message-ID: <20190521072355.12928-1-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK2PR02CA0215.apcprd02.prod.outlook.com
 (2603:1096:201:20::27) To VI1PR0402MB3519.eurprd04.prod.outlook.com
 (2603:10a6:803:8::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e24c026a-ec08-4f89-18e2-08d6ddbc9126
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3327;
x-ms-traffictypediagnostic: VI1PR0402MB3327:
x-microsoft-antispam-prvs: <VI1PR0402MB3327A2E17FCCDA6BDAE7A71487070@VI1PR0402MB3327.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39860400002)(136003)(189003)(199004)(8676002)(25786009)(478600001)(14454004)(2906002)(8936002)(36756003)(53936002)(186003)(81156014)(81166006)(2501003)(316002)(6486002)(73956011)(6436002)(4326008)(6636002)(26005)(66946007)(305945005)(7736002)(66556008)(64756008)(66446008)(66476007)(68736007)(66066001)(86362001)(71200400001)(71190400001)(2616005)(110136005)(14444005)(54906003)(476003)(486006)(256004)(99286004)(5660300002)(52116002)(386003)(6506007)(6116002)(102836004)(1076003)(6512007)(50226002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3327;H:VI1PR0402MB3519.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KtJQA1cVLSkZdabXkf5HdK/H+9AcKACVdhJ53f38YBd7rDlU4WUFde85hteD5NuwOwNKY6HMYIFjdIPFKU0XRFQXGJX1Ekm51sIrbs7SmeTdqN7d0RdK0diVeCDvfcv5unpyCf+2eUnHpbYemrvRIvwqsxn4PX1ftN+t4pjh1kRDAjQ7Yb5TqGIYbTsYxb6fIzeGWA2p+MyZ1TmyhqG1q4m/8ud40xCUG2dtGFNU7vAmCPR73QNwpYE50Qas3Nfz3D8gGWjNCnMklWmXuiH1ugUBnEKw//t+uEuyXUEl9JZoCfx71aU21UllR+Z39xP0lEtQB2U8eTKNqKFj0JPvQjIj9WUbaUqPEcEOYMtQyCVTF4c6ReGd3CZydP6fvRtQkrF8O5bgbXMU1zsfth0TmeUNuYBUkFsiTWDOiN2z1r4=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <EC89990D38395545B1C0999B3062C664@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24c026a-ec08-4f89-18e2-08d6ddbc9126
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 07:18:48.2184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3327
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bai Ping <ping.bai@nxp.com>

Add the binding doc for nxp system counter timer module.

Signed-off-by: Bai Ping <ping.bai@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
change v1->v2
 - remove the blank line at EOF
change v2->v3
 - update the binding example based on the driver change
change v3->v4
 - no change
---
 .../bindings/timer/nxp,sysctr-timer.txt       | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,sysctr-time=
r.txt

diff --git a/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt b=
/Documentation/devicetree/bindings/timer/nxp,sysctr-timer.txt
new file mode 100644
index 000000000000..d57659996d62
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
2.21.0

