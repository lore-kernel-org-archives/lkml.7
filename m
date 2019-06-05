Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E48C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90A920866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LyC9LMOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbfFEGk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:40:57 -0400
Received: from mail-eopbgr20073.outbound.protection.outlook.com ([40.107.2.73]:63878
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726086AbfFEGk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQAFldp7YMqcp0/BQ07SEdE60//P9hdyz6bDDLsN1Zc=;
 b=LyC9LMOP1VM9LPkVM/ID3dzNaALCTvMonfV+IMkPguncIyYfA9REV2aeDR+h5+TfwUlov559BCfFq7gyhTYOd/Zj2cOQlvNnrLOD4DxYl64o5UIzgDRYcHrypRxGwUC2XpPu6SdJaukgJiMZsCZk/D6Wz0Ia5Jv5qZ9zs2VByxY=
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com (20.176.236.22) by
 DB7PR04MB4924.eurprd04.prod.outlook.com (20.176.234.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Wed, 5 Jun 2019 06:40:53 +0000
Received: from DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::24da:94bd:6034:4d45]) by DB7PR04MB5178.eurprd04.prod.outlook.com
 ([fe80::24da:94bd:6034:4d45%4]) with mapi id 15.20.1965.011; Wed, 5 Jun 2019
 06:40:53 +0000
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
Subject: [PATCH v5 1/2] dt-bindings: timer: Add binding doc for nxp system
 counter timer
Thread-Topic: [PATCH v5 1/2] dt-bindings: timer: Add binding doc for nxp
 system counter timer
Thread-Index: AQHVG2mejuiyXbx6C06qLbcoYpslMg==
Date:   Wed, 5 Jun 2019 06:40:52 +0000
Message-ID: <20190605064546.29249-1-ping.bai@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.21.0
x-clientproxiedby: HK0P153CA0029.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::17) To DB7PR04MB5178.eurprd04.prod.outlook.com
 (2603:10a6:10:20::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ping.bai@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08dd0eff-011a-4735-407a-08d6e980c144
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB7PR04MB4924;
x-ms-traffictypediagnostic: DB7PR04MB4924:
x-microsoft-antispam-prvs: <DB7PR04MB492444D8C6890BD17F14F6A687160@DB7PR04MB4924.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00594E8DBA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(366004)(396003)(346002)(189003)(199004)(4326008)(8936002)(2501003)(71200400001)(71190400001)(6436002)(1076003)(68736007)(486006)(86362001)(6116002)(2616005)(6486002)(8676002)(81156014)(476003)(50226002)(36756003)(81166006)(66066001)(53936002)(305945005)(5660300002)(6506007)(110136005)(386003)(26005)(186003)(66556008)(64756008)(99286004)(66946007)(66476007)(66446008)(73956011)(25786009)(478600001)(7736002)(14444005)(256004)(6512007)(52116002)(6636002)(3846002)(14454004)(316002)(54906003)(102836004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4924;H:DB7PR04MB5178.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3J19WYzFcfplhLCV/7Z1Tvl0YezT7iaVJgxpckP9zOKHxfl3kkJtGvwoRtQmPvh/4X7ps1lSdQfHvxszPi3V6xs+Y/eFwXbmi0ZzEoAkVe65PEZBrkcCkjWvanh72lOgJPwo9LT/W3u1VuV/Jl/cxpsFjXA2Nl2LwMoWDg4abvS0kZBMwtJnpE+ETeu5KHFbj4Xp4GekMlE32H4+xnz8slnfNvegL+vwWHwr6SaBowIkrFplOojRZVsHSWBIstv6j/MHeaCnC1lgknZDM6eLRYeHSRSRQJSSvuATAFb+tbtlUbNp5vpRT+xaJXxu9dVXZvxxDyCvT1uPEbe5+ZPgx+zRVNeYEEShBI2jyY2wTjeKEMopHAySjBCiWzuk43VbNYKPVUhuC+KD+ncGVBcyDzEEdFxQHKbKHj1+oaH9yYk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <82FBF9FC5424C0498FBDE889F75776F2@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dd0eff-011a-4735-407a-08d6e980c144
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2019 06:40:53.0253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ping.bai@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4924
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
change v4->v5
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

