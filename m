Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9B7C04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35F82087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 09:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TvIO0gsL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfEFJSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 05:18:16 -0400
Received: from mail-eopbgr00047.outbound.protection.outlook.com ([40.107.0.47]:49955
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725851AbfEFJSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 05:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTH66Y7gx2PznVeFcXrCzxtXGJaCLbHsD8QJpobl96c=;
 b=TvIO0gsLJbk0UDPaSs2MqqHAnjKKQGFTR+0QeoMaaectdJKzyBPo3YtDtsrZ62hFRBJRzpR19MxS5eiZrZ8fuiTFRi3B6Bm4uBM4XhxuuVz9iFIXf5tj1F4Mjd2h7IZBJ9FBKYkmR7F9MSVD1HWFTOztE8dmwZ7AHbucGQesqdw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3833.eurprd04.prod.outlook.com (52.134.67.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Mon, 6 May 2019 09:18:10 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Mon, 6 May 2019
 09:18:10 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] dt-bindings: clock: imx8mm: Add GPIO clocks
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx8mm: Add GPIO clocks
Thread-Index: AQHVA+yfLsIhjcoiP0Cce7rahIcrWQ==
Date:   Mon, 6 May 2019 09:18:10 +0000
Message-ID: <1557133994-5061-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0023.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::33) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2079d66-20de-4a61-c1a5-08d6d203c1ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3833;
x-ms-traffictypediagnostic: DB3PR0402MB3833:
x-microsoft-antispam-prvs: <DB3PR0402MB3833F6D42C58604B4BC4023FF5300@DB3PR0402MB3833.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0029F17A3F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(486006)(68736007)(8936002)(3846002)(2906002)(99286004)(386003)(6506007)(52116002)(476003)(2616005)(6116002)(4326008)(7736002)(25786009)(305945005)(2201001)(110136005)(7416002)(478600001)(86362001)(316002)(81156014)(66066001)(4744005)(6486002)(66946007)(66476007)(64756008)(66446008)(73956011)(14454004)(66556008)(71200400001)(71190400001)(14444005)(36756003)(256004)(8676002)(186003)(6512007)(26005)(102836004)(2501003)(50226002)(6436002)(5660300002)(81166006)(53936002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3833;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t/g8YzcsCOkgO3XcZ+VYqwJ2XlTkidhKAYOsUWi6K+xI3tM6VRZ7jiyIUaxSH5MJ8f/QMtl421Z/Cszr10J58747fDWxOhgkLxMAot7ylPWxQ2a5m6YedkphqD+eXpQu8Yif+hx5xUxUon610l7n+pZA23dWvBE0zEJ/eEbMKwpcf8liBCw/gpYVRLrODDgMqnJ78HR1Vl64PFmmfayWEhlP8n2/VMCQ2gJT/do/K3ZIShZoOOkwqiz/34ZDXbWmqNOCgtEKbF5OKa6vsFE5qjVsYQoV1ccqZFy/qUYtp7d0MCAvwjfYwgWxygX1fXu61JAiI8PxRMHkOzyCscdSTTZ/j/fAIamyfJsdkgIDEgH0enRgtPuUG+jvRtvEhjTA3VqpcK+ygwVSzOToSz/0dTqdTsTXCR+uZ8RzULdeLxc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2079d66-20de-4a61-c1a5-08d6d203c1ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2019 09:18:10.1258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG1hY3JvIGZvciB0aGUgR1BJTyBjbG9ja3Mgb2YgdGhlIGkuTVg4TU0uDQoNClNpZ25lZC1v
ZmYtYnk6IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQogaW5jbHVkZS9k
dC1iaW5kaW5ncy9jbG9jay9pbXg4bW0tY2xvY2suaCB8IDggKysrKysrKy0NCiAxIGZpbGUgY2hh
bmdlZCwgNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9pbmNs
dWRlL2R0LWJpbmRpbmdzL2Nsb2NrL2lteDhtbS1jbG9jay5oIGIvaW5jbHVkZS9kdC1iaW5kaW5n
cy9jbG9jay9pbXg4bW0tY2xvY2suaA0KaW5kZXggMWI0MzUzZS4uZmU0Nzc5OCAxMDA2NDQNCi0t
LSBhL2luY2x1ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1tLWNsb2NrLmgNCisrKyBiL2luY2x1
ZGUvZHQtYmluZGluZ3MvY2xvY2svaW14OG1tLWNsb2NrLmgNCkBAIC0yMzksNiArMjM5LDEyIEBA
DQogDQogI2RlZmluZSBJTVg4TU1fQ0xLX05BTkRfVVNESENfQlVTX1JBV05BTkRfQ0xLCTIyMg0K
IA0KLSNkZWZpbmUgSU1YOE1NX0NMS19FTkQJCQkJMjIzDQorI2RlZmluZSBJTVg4TU1fQ0xLX0dQ
SU8xX1JPT1QJCQkyMjMNCisjZGVmaW5lIElNWDhNTV9DTEtfR1BJTzJfUk9PVAkJCTIyNA0KKyNk
ZWZpbmUgSU1YOE1NX0NMS19HUElPM19ST09UCQkJMjI1DQorI2RlZmluZSBJTVg4TU1fQ0xLX0dQ
SU80X1JPT1QJCQkyMjYNCisjZGVmaW5lIElNWDhNTV9DTEtfR1BJTzVfUk9PVAkJCTIyNw0KKw0K
KyNkZWZpbmUgSU1YOE1NX0NMS19FTkQJCQkJMjI4DQogDQogI2VuZGlmDQotLSANCjIuNy40DQoN
Cg==
