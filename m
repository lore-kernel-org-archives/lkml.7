Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B753C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CC0214AE
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 07:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eZqj5Zu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfEGHnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 03:43:45 -0400
Received: from mail-eopbgr140071.outbound.protection.outlook.com ([40.107.14.71]:39593
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726418AbfEGHnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 03:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHU13rTKYTz+Va7OyPr6XsWt7s6RMld+hzaCtV3Thq0=;
 b=eZqj5Zu6V48sICxl0wzEeNUCahNAaIuazRLWHmSpbliSmrFc7n2/RYAgPW1pTirMQ7yFQ1l1KxJDm8aFNHdx5XPfE5a8ra5dZOzOW6pMz9fnDTuc33HT1WIX5LGR5xkW1LKlpYxtZJ24xsods2zU19xDYgpP1X3UTWhEWwoLmqQ=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.44.16) by
 AM5PR0402MB2803.eurprd04.prod.outlook.com (10.175.45.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Tue, 7 May 2019 07:43:37 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::d8ed:b418:4ee9:a51%9]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 07:43:37 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, Leo Li <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] arm64: dts: ls1028a: Fix CPU idle fail.
Thread-Topic: [PATCH] arm64: dts: ls1028a: Fix CPU idle fail.
Thread-Index: AQHVBKiUKthuJMWQ50upa4TU1imk1w==
Date:   Tue, 7 May 2019 07:43:37 +0000
Message-ID: <20190507074454.41589-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0198.apcprd02.prod.outlook.com
 (2603:1096:201:21::34) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:9e::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f9ccb5e-9e18-4a3e-8072-08d6d2bfb73e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM5PR0402MB2803;
x-ms-traffictypediagnostic: AM5PR0402MB2803:
x-microsoft-antispam-prvs: <AM5PR0402MB28035712D3C2E3B5F9C1893FF1310@AM5PR0402MB2803.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(110136005)(14454004)(68736007)(99286004)(36756003)(186003)(478600001)(54906003)(316002)(73956011)(6506007)(52116002)(102836004)(26005)(86362001)(6436002)(386003)(66066001)(6486002)(6116002)(7736002)(6512007)(53936002)(5660300002)(2906002)(1076003)(66446008)(64756008)(66556008)(66476007)(8676002)(66946007)(256004)(305945005)(81166006)(81156014)(2616005)(71200400001)(14444005)(476003)(486006)(50226002)(8936002)(71190400001)(25786009)(4326008)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2803;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IcKh9CFK2nALr2iZ9fUlpTvK/eqERFPuyov83VsVus4pOJzQdmzcd8J6EIuutuZKCtr3xpOVqcHJ4bBEvYd6rxPkIr0uBl1sunGu/MjRVFHuz/1eVglkG43QNAIO+JGfJ21KvHCM0UHnNkyxFy62Tob6Xoz43C1H9MUzw0CJlMFZ/r3ctZGpY6f7Ri01QNJ9fAXbT+KSfJh02O12MUurt2I+biWmYES7L9yAWVuHk/ZdINGnDjgby/CysJDKYBn141OH0CpU4w9rxsjXwSih/cr00VtGorEMvx878tRPLLPp3NvLE39Vs4GFBLcRURntd9Wq5qMJ/khD3SsRB7CBxae5RxuEmSoqJeVSnIbiBLnd6S0CfYl52uArZ39tspeDh+WgCCg3yolBmYCjyugz67hUCa5WTrMWTQ030V0lcSA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f9ccb5e-9e18-4a3e-8072-08d6d2bfb73e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 07:43:37.7539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2803
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UFNDSSBzcGVjIGRlZmluZSAxc3QgcGFyYW1ldGVyJ3MgYml0IDE2IG9mIGZ1bmN0aW9uIENQVV9T
VVNQRU5EIHRvDQppbmRpY2F0ZSBDUFUgU3RhdGUgVHlwZTogMCBmb3Igc3RhbmRieSwgMSBmb3Ig
cG93ZXIgZG93bi4gSW4gdGhpcw0KY2FzZSwgd2Ugd2FudCB0byBzZWxlY3Qgc3RhbmRieSBmb3Ig
Q1BVIGlkbGUgZmVhdHVyZS4gQnV0IGN1cnJlbnQNCnNldHRpbmcgd3JvbmdseSBzZWxlY3QgcG93
ZXIgZG93biBhbmQgY2F1c2UgQ1BVIFNVU1BFTkQgZmFpbCBldmVyeQ0KdGltZS4gTmVlZCB0aGlz
IGZpeC4NCg0KU2lnbmVkLW9mZi1ieTogUmFuIFdhbmcgPHJhbi53YW5nXzFAbnhwLmNvbT4NCi0t
LQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kgfCAgIDE4
ICsrKysrKysrKy0tLS0tLS0tLQ0KIDEgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCA5
IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvZnNsLWxzMTAyOGEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1s
czEwMjhhLmR0c2kNCmluZGV4IGIwNDU4MTIuLmJmN2Y4NDUgMTAwNjQ0DQotLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQorKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpDQpAQCAtMjgsNyArMjgsNyBAQA0K
IAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7DQogCQkJY2xvY2tzID0gPCZjbG9ja2dlbiAxIDA+
Ow0KIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JmwyPjsNCi0JCQljcHUtaWRsZS1zdGF0ZXMgPSA8
JkNQVV9QSDIwPjsNCisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9QVzIwPjsNCiAJCX07DQog
DQogCQljcHUxOiBjcHVAMSB7DQpAQCAtMzgsNyArMzgsNyBAQA0KIAkJCWVuYWJsZS1tZXRob2Qg
PSAicHNjaSI7DQogCQkJY2xvY2tzID0gPCZjbG9ja2dlbiAxIDA+Ow0KIAkJCW5leHQtbGV2ZWwt
Y2FjaGUgPSA8JmwyPjsNCi0JCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9QSDIwPjsNCisJCQlj
cHUtaWRsZS1zdGF0ZXMgPSA8JkNQVV9QVzIwPjsNCiAJCX07DQogDQogCQlsMjogbDItY2FjaGUg
ew0KQEAgLTUzLDEzICs1MywxMyBAQA0KIAkJICovDQogCQllbnRyeS1tZXRob2QgPSAiYXJtLHBz
Y2kiOw0KIA0KLQkJQ1BVX1BIMjA6IGNwdS1waDIwIHsNCi0JCQljb21wYXRpYmxlID0gImFybSxp
ZGxlLXN0YXRlIjsNCi0JCQlpZGxlLXN0YXRlLW5hbWUgPSAiUEgyMCI7DQotCQkJYXJtLHBzY2kt
c3VzcGVuZC1wYXJhbSA9IDwweDAwMDEwMDAwPjsNCi0JCQllbnRyeS1sYXRlbmN5LXVzID0gPDEw
MDA+Ow0KLQkJCWV4aXQtbGF0ZW5jeS11cyA9IDwxMDAwPjsNCi0JCQltaW4tcmVzaWRlbmN5LXVz
ID0gPDMwMDA+Ow0KKwkJQ1BVX1BXMjA6IGNwdS1wdzIwIHsNCisJCQkgIGNvbXBhdGlibGUgPSAi
YXJtLGlkbGUtc3RhdGUiOw0KKwkJCSAgaWRsZS1zdGF0ZS1uYW1lID0gIlBXMjAiOw0KKwkJCSAg
YXJtLHBzY2ktc3VzcGVuZC1wYXJhbSA9IDwweDA+Ow0KKwkJCSAgZW50cnktbGF0ZW5jeS11cyA9
IDwyMDAwPjsNCisJCQkgIGV4aXQtbGF0ZW5jeS11cyA9IDwyMDAwPjsNCisJCQkgIG1pbi1yZXNp
ZGVuY3ktdXMgPSA8NjAwMD47DQogCQl9Ow0KIAl9Ow0KIA0KLS0gDQoxLjcuMQ0KDQo=
