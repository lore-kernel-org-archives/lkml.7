Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B695DC10F0E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77305217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 01:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kY9a2Up8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfDJBsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 21:48:05 -0400
Received: from mail-eopbgr130074.outbound.protection.outlook.com ([40.107.13.74]:20494
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726895AbfDJBsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 21:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NJCfw3brm6GOvjt8A8snwc44x9NEZEUWNEJnoI/FkI=;
 b=kY9a2Up83Q6UlNiswMyrqCYhHXFN9lf5WdoKS7AGEH7gnh0/q8VfoGTT9HVwDPnQH5vg6HwDYC6SsQkbC3zmcsBvOC2sITXzP4klxeD7oCii2ne8doeNvJNYeqEGSqHaEnOw2tgB362N3s5UOCQ4NMQT2EOa59vUkJCQunhqvVs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3721.eurprd04.prod.outlook.com (52.134.67.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.14; Wed, 10 Apr 2019 01:47:57 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1771.016; Wed, 10 Apr 2019
 01:47:57 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V11 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Topic: [PATCH V11 5/5] ARM: dts: imx7ulp-evk: Add backlight support
Thread-Index: AQHU7z9rUblOBfVQSk+6QrO16tHxow==
Date:   Wed, 10 Apr 2019 01:47:57 +0000
Message-ID: <1554860547-18237-6-git-send-email-Anson.Huang@nxp.com>
References: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1554860547-18237-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 603e6114-b093-4e7c-31d4-08d6bd568e1e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3721;
x-ms-traffictypediagnostic: DB3PR0402MB3721:
x-microsoft-antispam-prvs: <DB3PR0402MB372177324287616D7831C7A4F52E0@DB3PR0402MB3721.eurprd04.prod.outlook.com>
x-forefront-prvs: 00032065B2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(2201001)(71190400001)(71200400001)(97736004)(105586002)(68736007)(6436002)(14454004)(8676002)(8936002)(478600001)(50226002)(81166006)(81156014)(7736002)(256004)(53936002)(25786009)(6512007)(305945005)(4326008)(6486002)(26005)(7416002)(106356001)(36756003)(66066001)(186003)(3846002)(6116002)(52116002)(316002)(102836004)(6506007)(386003)(446003)(486006)(2906002)(76176011)(110136005)(86362001)(2616005)(476003)(2501003)(11346002)(5660300002)(99286004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3721;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: wZuuAZRGKQGYRMcYbvL5YxTV/Pz8otq/r3ERnfxhFPjqxzj2MBts0Xe2F6cK/dQvwTpOQfLITOxwkKFFVK2Cu21t1x6VQacBdYkzCU/eVWrAdL/qZFeuBGfVLCU+G2KvQS7ymFwmr6ltuzXM+Chs/Jr+lBxSdxOWPdRUkAD8bRm/Zao9ksn1mAn+XtFxG14Qo13H4+npBelHGUrVqxhe/LBxnsaxtOw5WX19ZEYo1kHUW0HAvn2/MttWpXTl9C44w/deVeBi6JMMNRlJS1NlvGlBBKXJYysNZYhWOE8Wz5ejMA58SBSJuLFVb8qUMAeme6WL8PijueFvTR2N0445EMIY65ycxintD4v8SOX4Yd/Hrxikn4hcXVgpvmSsSiS1EBP9noHXlOkmo7jQKmoQc+c/h2ZUoFEUVDNAJg18fkI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603e6114-b093-4e7c-31d4-08d6bd568e1e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2019 01:47:57.1636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBhZGRzIGkuTVg3VUxQIEVWSyBib2FyZCBNSVBJLURTSSBiYWNrbGlnaHQgc3Vw
cG9ydC4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+
DQotLS0NCk5vIGNoYW5nZXMuDQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLWV2ay5k
dHMgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0
aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1ldmsuZHRz
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1ldmsuZHRzDQppbmRleCBhMDkwMjZhLi45NDg5
MWM3IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14N3VscC1ldmsuZHRzDQorKysg
Yi9hcmNoL2FybS9ib290L2R0cy9pbXg3dWxwLWV2ay5kdHMNCkBAIC04LDYgKzgsNyBAQA0KIC9k
dHMtdjEvOw0KIA0KICNpbmNsdWRlICJpbXg3dWxwLmR0c2kiDQorI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3B3bS9wd20uaD4NCiANCiAvIHsNCiAJbW9kZWwgPSAiTlhQIGkuTVg3VUxQIEVWSyI7DQpA
QCAtMjIsNiArMjMsMTQgQEANCiAJCXJlZyA9IDwweDYwMDAwMDAwIDB4NDAwMDAwMDA+Ow0KIAl9
Ow0KIA0KKwliYWNrbGlnaHQgew0KKwkJY29tcGF0aWJsZSA9ICJwd20tYmFja2xpZ2h0IjsNCisJ
CXB3bXMgPSA8JnRwbTQgMSA1MDAwMCAwPjsNCisJCWJyaWdodG5lc3MtbGV2ZWxzID0gPDAgMjAg
MjUgMzAgMzUgNDAgMTAwPjsNCisJCWRlZmF1bHQtYnJpZ2h0bmVzcy1sZXZlbCA9IDw2PjsNCisJ
CXN0YXR1cyA9ICJva2F5IjsNCisJfTsNCisNCiAJcmVnX3ZzZF8zdjM6IHJlZ3VsYXRvci12c2Qt
M3YzIHsNCiAJCWNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCiAJCXJlZ3VsYXRvci1u
YW1lID0gIlZTRF8zVjMiOw0KQEAgLTQwLDYgKzQ5LDEyIEBADQogCXN0YXR1cyA9ICJva2F5IjsN
CiB9Ow0KIA0KKyZ0cG00IHsNCisJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCisJcGluY3Ry
bC0wID0gPCZwaW5jdHJsX3B3bTA+Ow0KKwlzdGF0dXMgPSAib2theSI7DQorfTsNCisNCiAmdXNk
aGMwIHsNCiAJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCiAJcGluY3RybC0wID0gPCZwaW5j
dHJsX3VzZGhjMD47DQpAQCAtNTcsNiArNzIsMTIgQEANCiAJCWJpYXMtcHVsbC11cDsNCiAJfTsN
CiANCisJcGluY3RybF9wd20wOiBwd20wZ3JwIHsNCisJCWZzbCxwaW5zID0gPA0KKwkJCUlNWDdV
TFBfUEFEX1BURjJfX1RQTTRfQ0gxCTB4Mg0KKwkJPjsNCisJfTsNCisNCiAJcGluY3RybF91c2Ro
YzA6IHVzZGhjMGdycCB7DQogCQlmc2wscGlucyA9IDwNCiAJCQlJTVg3VUxQX1BBRF9QVEQxX19T
REhDMF9DTUQJMHg0Mw0KLS0gDQoyLjcuNA0KDQo=
