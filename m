Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41478C43219
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05C4C206C1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 03:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="t7cjESbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfD1D1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 23:27:12 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:37765
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfD1D1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 23:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDTSK2+XWeq9bUPnabuSLTxpEZjGWzAO9XUShIlehfI=;
 b=t7cjESbTDIROuOIBL174gaHo3jDNZU661PYyDumta2h08pE5Wz45DI78b8BgtjcmPlrHxRO23YmekAOR6tHNSQWyjwt2qOhteU/oHQzDBLATtk/0H2GVlJVOKDKmto09/APIxMvzMLN2AlpWW4c3zl7zvMwmb7x2J2t4mgIp/1c=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3897.eurprd04.prod.outlook.com (52.134.73.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Sun, 28 Apr 2019 03:27:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1835.015; Sun, 28 Apr 2019
 03:27:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH V2 2/4] arm64: dts: imx8qxp: Move watchdog node into scu node
Thread-Topic: [PATCH V2 2/4] arm64: dts: imx8qxp: Move watchdog node into scu
 node
Thread-Index: AQHU/XJBMePp7oGhF0qxLfGbK1VHkQ==
Date:   Sun, 28 Apr 2019 03:27:06 +0000
Message-ID: <1556421727-7401-2-git-send-email-Anson.Huang@nxp.com>
References: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1556421727-7401-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2P15301CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::22) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5d82cf2-5f3e-4ebd-8378-08d6cb89636e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3897;
x-ms-traffictypediagnostic: DB3PR0402MB3897:
x-microsoft-antispam-prvs: <DB3PR0402MB3897A8D39C56E3A152FB5670F5380@DB3PR0402MB3897.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:514;
x-forefront-prvs: 0021920B5A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(136003)(396003)(366004)(346002)(39860400002)(189003)(199004)(256004)(71190400001)(71200400001)(97736004)(6116002)(186003)(66066001)(86362001)(2201001)(476003)(2616005)(8936002)(36756003)(486006)(11346002)(81156014)(81166006)(25786009)(53936002)(50226002)(3846002)(446003)(2906002)(2501003)(386003)(6506007)(76176011)(68736007)(4326008)(102836004)(64756008)(52116002)(66946007)(66476007)(66556008)(8676002)(66446008)(6486002)(6436002)(7416002)(14454004)(73956011)(7736002)(99286004)(478600001)(316002)(110136005)(305945005)(26005)(6512007)(5660300002)(4744005)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3897;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eYk0a49tUAT3cQtj5lFpmOk+3Zqymmc15xzluBSMmfOGKJmeqoK0Gwh8/xVLnK/BNLNiW8o06nMgizh/XGsqSIcgaoawIN3PhknOjGy9YrZJVwJImLIA+vAjtKpTCD8B6ussqYymKhQcAcznt4tLhSeNFtHvjGrIoZz5DrurENbBxVy6DarsNJwXpSqOj6x0DDaC0MmTqRKWD+5K8e8BxRCWSVWO10Yyv3XD8zMf28o1yddh1gF0n6/DlCH4p9SU2AN3ttSzNU9H6n0SCXV5fPDvhzMtz3YvQIt58ZxYu0Y2mRfUWY+8UrnU+nugVHU3ygmIJhDdbaIWYmS2lQ5BZCQyiD4258c9saylByhqHvQDddEQXVbOJQBuHIrwy9RClUgTSEQtSS359Qrf7bQgaVVZx9E2H7KLzIubKASFtJk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5d82cf2-5f3e-4ebd-8378-08d6cb89636e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2019 03:27:06.3452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3897
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

aS5NWCBzeXN0ZW0gY29udHJvbGxlciB3YXRjaGRvZyBoYXMgcHJldGltZW91dCBmdW5jdGlvbiB3
aGljaA0KZGVwZW5kcyBvbiBpLk1YIFNDVSBkcml2ZXIsIHNvIGl0IHNob3VsZCBiZSBhIHN1Ym5v
ZGUgb2YgU0NVLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhw
LmNvbT4NCi0tLQ0KTmV3IHBhdGNoLg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OHF4cC5kdHNpIHwgMTAgKysrKystLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9pbXg4cXhwLmR0c2kNCmluZGV4IDA2ODNlZTIuLmIxN2MyMmUgMTAwNjQ0DQotLS0gYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4cXhwLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2lteDhxeHAuZHRzaQ0KQEAgLTE0OSw2ICsxNDksMTEgQEANCiAJ
CXJ0YzogcnRjIHsNCiAJCQljb21wYXRpYmxlID0gImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQogCQl9
Ow0KKw0KKwkJd2F0Y2hkb2cgew0KKwkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2Mtd2R0
IiwgImZzbCxpbXgtc2Mtd2R0IjsNCisJCQl0aW1lb3V0LXNlYyA9IDw2MD47DQorCQl9Ow0KIAl9
Ow0KIA0KIAl0aW1lciB7DQpAQCAtNTE3LDkgKzUyMiw0IEBADQogCQkJcG93ZXItZG9tYWlucyA9
IDwmcGQgSU1YX1NDX1JfR1BJT183PjsNCiAJCX07DQogCX07DQotDQotCXdhdGNoZG9nIHsNCi0J
CWNvbXBhdGlibGUgPSAiZnNsLGlteDhxeHAtc2Mtd2R0IiwgImZzbCxpbXgtc2Mtd2R0IjsNCi0J
CXRpbWVvdXQtc2VjID0gPDYwPjsNCi0JfTsNCiB9Ow0KLS0gDQoyLjcuNA0KDQo=
