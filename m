Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF01EC04AB4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9740520833
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hypZth80"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbfETDGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:06:44 -0400
Received: from mail-eopbgr40089.outbound.protection.outlook.com ([40.107.4.89]:25510
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfETDGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:06:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5fl9/5XXsMpWHM+52CJmqRfSB6cYajFFtCwdVLxlaxs=;
 b=hypZth8095ZC2PzeTbT0GWxkIFiQzOP9bGSZ5xNiBwUsiB0qP9pwWP4jHXRuM+YuCTvyVM8epvlKfCeXjkVUxiiW5t2b1es0hfBTT1gWpXrkXNPajbojzL6aO3ah2TsDpXqGbwQB2A7UHHdIo4H+Frt0d7INUM7JriOMOMGQYSk=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6611.eurprd04.prod.outlook.com (20.179.255.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Mon, 20 May 2019 03:06:39 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::3173:24:d401:2378%6]) with mapi id 15.20.1900.020; Mon, 20 May 2019
 03:06:39 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: [RFC 2/2] ARM: dts: imx6ull/z: add fusable-node property
Thread-Topic: [RFC 2/2] ARM: dts: imx6ull/z: add fusable-node property
Thread-Index: AQHVDrkK3jBoIPPnL0GIqBs7vhW/3w==
Date:   Mon, 20 May 2019 03:06:39 +0000
Message-ID: <20190520032020.7920-2-peng.fan@nxp.com>
References: <20190520032020.7920-1-peng.fan@nxp.com>
In-Reply-To: <20190520032020.7920-1-peng.fan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.16.4
x-clientproxiedby: HK0PR03CA0055.apcprd03.prod.outlook.com
 (2603:1096:203:52::19) To AM0PR04MB4481.eurprd04.prod.outlook.com
 (2603:10a6:208:70::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a70147ba-43c6-4a30-b5f9-08d6dcd02d1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6611;
x-ms-traffictypediagnostic: AM0PR04MB6611:
x-microsoft-antispam-prvs: <AM0PR04MB66113F5900E52D7B8AC97EAD88060@AM0PR04MB6611.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-forefront-prvs: 004395A01C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(136003)(39860400002)(396003)(189003)(199004)(66556008)(4744005)(66946007)(66476007)(64756008)(5660300002)(99286004)(73956011)(6116002)(3846002)(66446008)(53936002)(6486002)(7416002)(1076003)(71190400001)(6436002)(36756003)(6512007)(71200400001)(2201001)(68736007)(86362001)(305945005)(81156014)(81166006)(8936002)(50226002)(25786009)(2906002)(8676002)(478600001)(4326008)(14454004)(7736002)(2501003)(76176011)(11346002)(486006)(316002)(256004)(102836004)(110136005)(14444005)(52116002)(476003)(446003)(2616005)(66066001)(186003)(54906003)(386003)(26005)(44832011)(6506007)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6611;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8s+7+UfHf+iTEMFGrQZkNrAY1EURpMFcl/RRoPNWli/C54VyVo8axIUvYZOCCN16KVguZQTKppPrUiXVyXfKzbZRytEBLthPPqk7hRroUBd3TxYCnYvctzXKfpGbvAVVWnk9QU5bY2d5wDzACKCM9I9CpGNVD1mOBGcBvN41Y/BB/gbdFdVNNUGxXTdGhrgU5E6CNa+SSqDoXBgu8HjS2bXZyeN119vW6qzL7RhvIn8h/sggkb+P4Jn/3ifyGH7+1e4HPIzMPf2LTRK2BtBRluWclA16HX26b8rFlXCKJBg+gJKJlETlnEei7IFlzd/fE3Lpc+lWgYIQXbzDvlo9BVQyVXPBG+nICAk+KTLSY/6XeYO2XUd+fvDSYS5NqWUIUmOOpZkVXsbR3CMJWTU7T4r3Tg7u0vivnA3EQRN+qbc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70147ba-43c6-4a30-b5f9-08d6dcd02d1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2019 03:06:39.1774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIGZ1c2FibGUtbm9kZSBwcm9wZXJ0eSBmb3IgT0NPVFANCg0KU2lnbmVkLW9mZi1ieTogUGVu
ZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQotLS0NCiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWxs
LmR0c2kgfCA3ICsrKysrKysNCiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWx6LmR0c2kgfCA2ICsr
KysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsbC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVs
bC5kdHNpDQppbmRleCAyMmU0YTMwN2ZhNTkuLmI2MTZlZDZlZTRiZiAxMDA2NDQNCi0tLSBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZ1bGwuZHRzaQ0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnVsbC5kdHNpDQpAQCAtMzIsNiArMzIsMTMgQEANCiANCiAmb2NvdHAgew0KIAljb21wYXRpYmxl
ID0gImZzbCxpbXg2dWxsLW9jb3RwIiwgInN5c2NvbiI7DQorDQorCWZ1c2FibGUtbm9kZSA9IDwm
dHNjCTB4YyAyMg0KKwkJCSZjYW4xCTB4YyAyNg0KKwkJCSZjYW4yCTB4YyAyNw0KKwkJCSZ1c2Ro
YzEgMHgxMCA0DQorCQkJJnVzZGhjMiAweDEwIDUNCisJCQk+Ow0KIH07DQogDQogJnVzZGhjMSB7
DQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsei5kdHNpIGIvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnVsei5kdHNpDQppbmRleCAwYjVmMWE3NjM1NjcuLjhlZGQ5MDA4ZTM4YiAx
MDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bHouZHRzaQ0KKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnVsei5kdHNpDQpAQCAtMTksNiArMTksMTIgQEANCiAJfTsNCiB9Ow0K
IA0KKyZvY290cCB7DQorCWZ1c2FibGUtbm9kZSA9IDwmdXNkaGMxIDB4MTAgNA0KKwkJCSZ1c2Ro
YzIgMHgxMCA1DQorCQkJPjsNCit9Ow0KKw0KIC9kZWxldGUtbm9kZS8gJmFkYzE7DQogL2RlbGV0
ZS1ub2RlLyAmZWNzcGkzOw0KIC9kZWxldGUtbm9kZS8gJmVjc3BpNDsNCi0tIA0KMi4xNi40DQoN
Cg==
