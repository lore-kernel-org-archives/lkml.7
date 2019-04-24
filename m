Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC36C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CAA218FD
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="wJjh2GeQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfDXOuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:50:25 -0400
Received: from mail-eopbgr150055.outbound.protection.outlook.com ([40.107.15.55]:56485
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732372AbfDXOuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:50:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVs5eZKCVvkJc7BKo1EByA2uEttSTBTDU4Qt/xwRoU8=;
 b=wJjh2GeQiEwReatMZ5iKBzg2etPzdA+PsQv7KPCBQE3RyADR7vB5/GoX8OlwzrdL5ZSMu9d4SStpIGH+nL2xMKVmvy51DpprLpNzE738jPwoYNB5D/ux6KZQOPEbjDxIXONzzdjeOjdHYXI/wAcP99PVtWFYDwIttfys62vZpNY=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB5437.eurprd04.prod.outlook.com (20.178.121.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.12; Wed, 24 Apr 2019 14:50:13 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::9bd:1d31:d6c3:d157%6]) with mapi id 15.20.1813.017; Wed, 24 Apr 2019
 14:50:13 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH] arm64: drivers: clk: qoriq: increase array size of
 cmux_to_group
Thread-Topic: [PATCH] arm64: drivers: clk: qoriq: increase array size of
 cmux_to_group
Thread-Index: AQHU+q0FP2+bGnUPHkiQJgHncASgPA==
Date:   Wed, 24 Apr 2019 14:50:13 +0000
Message-ID: <1556117426-26878-1-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BMXPR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::32) To VI1PR04MB4800.eurprd04.prod.outlook.com
 (2603:10a6:803:53::29)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [92.120.1.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c9b41b8-bef4-48be-b8a4-08d6c8c427fb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB5437;
x-ms-traffictypediagnostic: VI1PR04MB5437:
x-microsoft-antispam-prvs: <VI1PR04MB5437FA3D22114ECCC6A27865F33C0@VI1PR04MB5437.eurprd04.prod.outlook.com>
x-forefront-prvs: 00179089FD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(366004)(136003)(396003)(199004)(189003)(52116002)(305945005)(7736002)(26005)(86362001)(186003)(97736004)(478600001)(68736007)(6512007)(53936002)(6436002)(6486002)(99286004)(66066001)(6116002)(44832011)(3846002)(14454004)(256004)(54906003)(4326008)(476003)(2616005)(36756003)(486006)(110136005)(316002)(5660300002)(2501003)(6506007)(386003)(8676002)(71200400001)(81156014)(71190400001)(25786009)(66446008)(66556008)(64756008)(66476007)(50226002)(2906002)(73956011)(8936002)(81166006)(66946007)(102836004)(14444005)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5437;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tOG3H4Pf/NuyIrfdMpDfNH5ONdv6bSVNH3MIZW5lry2m5CjdyYCQeqcwwqarucm6RY1ccHex7HsKgWegXQwGoZKm1agqa8MstF1/q8HY84UyT5u/zoH/bxCyfPYzokx9FArvxnMm0rQLVXHHUKTa1R65oLDqF09nWCfZLeb4T/fhUWZk4k8N54SLbslW48Byvzm++1vg0vqKRHHNVRx9xXfgfoTt9J2gUPLZDsktYpOmDcR2a6XByUGuqcj8t1uCw6BqZFmypUtz9HmiidA6XpWipnyNJZegj4zqOXJ7mk+neRr+CyLpHfqbYeiq/ARMjaaTOCT24IVLu9eiKtQiHZYSPCppIreElUiD3EYKEhVZCordXzAOWq31mzgzUYKIbmtV/JmqDPsV43jwy/nWz5gcX6zAnvB574qZZVz75JY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c9b41b8-bef4-48be-b8a4-08d6c8c427fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2019 14:50:13.2929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5437
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogWW9nZXNoIEdhdXIgPHlvZ2VzaG5hcmF5YW4uZ2F1ckBueHAuY29tPg0KDQpJbmNyZWFz
ZSBzaXplIG9mIGNtdXhfdG9fZ3JvdXAgYXJyYXksIHRvIGFjY29tZGF0ZSBlbnRyeSBvZg0KLTEg
dGVybWluYXRpb24uDQoNCkFkZGVkIC0xLCB0ZXJtaW5hdGVkLCBlbnRyeSBmb3IgNDA4MF9jbXV4
X2dycFguDQoNClNpZ25lZC1vZmYtYnk6IFlvZ2VzaCBHYXVyIDx5b2dlc2huYXJheWFuLmdhdXJA
bnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFZhYmhhdiBTaGFybWEgPHZhYmhhdi5zaGFybWFAbnhw
LmNvbT4NCkFja2VkLWJ5OiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0Pg0KQWNrZWQtYnk6
IFN0ZXBoZW4gQm95ZCA8c2JveWRAa2VybmVsLm9yZz4NCi0tLQ0KIGRyaXZlcnMvY2xrL2Nsay1x
b3JpcS5jIHwgNCArKy0tDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1xb3JpcS5jIGIvZHJpdmVy
cy9jbGsvY2xrLXFvcmlxLmMNCmluZGV4IDEyMTJhOWIuLmY2NjA2Y2YgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL2Nsay9jbGstcW9yaXEuYw0KKysrIGIvZHJpdmVycy9jbGsvY2xrLXFvcmlxLmMNCkBA
IC03OSw3ICs3OSw3IEBAIHN0cnVjdCBjbG9ja2dlbl9jaGlwaW5mbyB7DQogCWNvbnN0IHN0cnVj
dCBjbG9ja2dlbl9tdXhpbmZvICpjbXV4X2dyb3Vwc1syXTsNCiAJY29uc3Qgc3RydWN0IGNsb2Nr
Z2VuX211eGluZm8gKmh3YWNjZWxbTlVNX0hXQUNDRUxdOw0KIAl2b2lkICgqaW5pdF9wZXJpcGgp
KHN0cnVjdCBjbG9ja2dlbiAqY2cpOw0KLQlpbnQgY211eF90b19ncm91cFtOVU1fQ01VWF07IC8q
IC0xIHRlcm1pbmF0ZXMgaWYgZmV3ZXIgdGhhbiBOVU1fQ01VWCAqLw0KKwlpbnQgY211eF90b19n
cm91cFtOVU1fQ01VWCsxXTsgLyogYXJyYXkgc2hvdWxkIGJlIC0xIHRlcm1pbmF0ZWQgKi8NCiAJ
dTMyIHBsbF9tYXNrOwkvKiAxIDw8IG4gYml0IHNldCBpZiBQTEwgbiBpcyB2YWxpZCAqLw0KIAl1
MzIgZmxhZ3M7CS8qIENHX3h4eCAqLw0KIH07DQpAQCAtNjAxLDcgKzYwMSw3IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgY2xvY2tnZW5fY2hpcGluZm8gY2hpcGluZm9bXSA9IHsNCiAJCQkmcDQwODBf
Y211eF9ncnAxLCAmcDQwODBfY211eF9ncnAyDQogCQl9LA0KIAkJLmNtdXhfdG9fZ3JvdXAgPSB7
DQotCQkJMCwgMCwgMCwgMCwgMSwgMSwgMSwgMQ0KKwkJCTAsIDAsIDAsIDAsIDEsIDEsIDEsIDEs
IC0xDQogCQl9LA0KIAkJLnBsbF9tYXNrID0gMHgxZiwNCiAJfSwNCi0tIA0KMi43LjQNCg0K
