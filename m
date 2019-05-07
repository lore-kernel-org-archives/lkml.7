Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129A5C04A6B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD17C20835
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RBTacOCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfEGDCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:02:51 -0400
Received: from mail-eopbgr10080.outbound.protection.outlook.com ([40.107.1.80]:10814
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726346AbfEGDCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saxqos/nQDJQsNSHnss4DxFfxmLYJwOdkuVt9kRLtKI=;
 b=RBTacOCkkDIBwkZMccViSTq8vS2sSBUDdxM+JhI2X2j7Gg0xyNNDt3+LoNbyiKlQKDmCW/BTprFm25RO4/t3cFhj7HNwlrmpw4ZpdOu6eCJx8ahi73ZBy7F1VmZonb1fkyJDya+oLl1C9XYMxXCX6mbnVWvSVU35B9H7NfL16i0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3754.eurprd04.prod.outlook.com (52.134.67.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 03:02:45 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 03:02:45 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH] ARM: dts: imx6ul: add clock-frequency to CPU node
Thread-Topic: [PATCH] ARM: dts: imx6ul: add clock-frequency to CPU node
Thread-Index: AQHVBIFYqIWZIuwvrU2KnaxGQFBgOQ==
Date:   Tue, 7 May 2019 03:02:45 +0000
Message-ID: <1557197868-6963-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:203:3e::28) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c20c8842-c5ee-4aef-245e-08d6d2987a77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3754;
x-ms-traffictypediagnostic: DB3PR0402MB3754:
x-microsoft-antispam-prvs: <DB3PR0402MB3754CDDA57C6E4FC697AB798F5310@DB3PR0402MB3754.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(366004)(39860400002)(199004)(189003)(2906002)(102836004)(478600001)(386003)(6506007)(99286004)(5660300002)(66066001)(486006)(2501003)(305945005)(86362001)(52116002)(2201001)(3846002)(6116002)(4744005)(68736007)(14454004)(6436002)(8936002)(53936002)(7736002)(25786009)(6486002)(66476007)(73956011)(66946007)(66556008)(64756008)(66446008)(4326008)(186003)(316002)(50226002)(256004)(26005)(36756003)(476003)(2616005)(6512007)(14444005)(71190400001)(110136005)(71200400001)(8676002)(81166006)(81156014)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3754;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q58S0t6lLK8acWWH0KWoR8NWY3ZFrWOpZKRsULrvWK+FYCgV0eegaR5cm5tAGS+5lWfW1Qt5YjAKeg9Pc5FFVTp1pWA3P2+4S2Qd7iG68Z5uyF4jQGMiwxTZUo2vOHMJElBg6vI6vSB2EyjbKqs/Sgj6VihFibdyZ9l0d6sNwG5keAlhyDI0D6nf6je7jlu840bc44qSFmmtHN8zvf1eISruR6jFDj75BMGuC0mzKCA1olmPug4FSVhlWSbX6qvhh5WWA23fe4jzZMLDaLMMvcCh/mDWrtMObbc4c9p4iqye8jYJ9T+QNPGJp/hmFvOvslLJ3uatlG3+c27/Rs4IOUUfLMyfsved7tbXBCpfThEFKfBgTMad9o3hN7ahSAaQChHkJWzzJlhcovcNF9CFLtM2FmGlIw/n1z3rotqeagQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20c8842-c5ee-4aef-245e-08d6d2987a77
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 03:02:45.6328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3754
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGNsb2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eSB0byBDUFUgbm9kZS4gQXZvaWRzIHdhcm5pbmdz
IGxpa2UNCiIvY3B1cy9jcHVAMCBtaXNzaW5nIGNsb2NrLWZyZXF1ZW5jeSBwcm9wZXJ0eSIgZm9y
ICJhcm0sY29ydGV4LWE3Ii4NCg0KU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcgPEFuc29uLkh1
YW5nQG54cC5jb20+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSAgfCAxICsN
CiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLmR0c2kgfCAxICsNCiAyIGZpbGVzIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVs
LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaQ0KaW5kZXggYmJmMDEwYy4uZmMz
ODhiOCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC5kdHNpDQorKysgYi9h
cmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaQ0KQEAgLTU5LDYgKzU5LDcgQEANCiAJCQljb21w
YXRpYmxlID0gImFybSxjb3J0ZXgtYTciOw0KIAkJCWRldmljZV90eXBlID0gImNwdSI7DQogCQkJ
cmVnID0gPDA+Ow0KKwkJCWNsb2NrLWZyZXF1ZW5jeSA9IDw2OTYwMDAwMDA+Ow0KIAkJCWNsb2Nr
LWxhdGVuY3kgPSA8NjEwMzY+OyAvKiB0d28gQ0xLMzIgcGVyaW9kcyAqLw0KIAkJCSNjb29saW5n
LWNlbGxzID0gPDI+Ow0KIAkJCW9wZXJhdGluZy1wb2ludHMgPSA8DQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnVsbC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC5k
dHNpDQppbmRleCAyMmU0YTMwLi43MjdiOTJmIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnVsbC5kdHNpDQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWxsLmR0c2kNCkBA
IC0xMiw2ICsxMiw3IEBADQogL2RlbGV0ZS1ub2RlLyAmY3J5cHRvOw0KIA0KICZjcHUwIHsNCisJ
Y2xvY2stZnJlcXVlbmN5ID0gPDkwMDAwMDAwMD47DQogCW9wZXJhdGluZy1wb2ludHMgPSA8DQog
CQkvKiBrSHoJdVYgKi8NCiAJCTkwMDAwMAkxMjc1MDAwDQotLSANCjIuNy40DQoNCg==
