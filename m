Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECE0C04AAB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9984D21479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m9ukk62z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbfEHKfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:35:33 -0400
Received: from mail-eopbgr130044.outbound.protection.outlook.com ([40.107.13.44]:23427
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbfEHKfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:35:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9NhfFMu93xfl0CWUaGF9oD/zfbeliOHhlwzrPu3zIs=;
 b=m9ukk62zbV/MFyKGu1qjPuaUgOPKwtrcJi94eUwP7OGiPzYmKdTVoibRg8cudgcIpa/YePYVxn2t6xf9cjGjhLlW4+SHWQskoZPXr1x/CrbDeNwQSUbJz+vyVhYk7c8Gg7O9J+S21ILAj3Y+ghqPoF7lvN53tK/Qm8KRdSH68XA=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB4962.eurprd04.prod.outlook.com (20.177.41.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.12; Wed, 8 May 2019 10:35:28 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 10:35:28 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Wen He <wen.he_1@nxp.com>
Subject: [v1 2/4] arm64: dts: ls1028a: Add properties for HDP Controller.
Thread-Topic: [v1 2/4] arm64: dts: ls1028a: Add properties for HDP Controller.
Thread-Index: AQHVBYnAtCzb3wJHv0OIGxIVzag2KA==
Date:   Wed, 8 May 2019 10:35:27 +0000
Message-ID: <20190508103703.40885-2-wen.he_1@nxp.com>
References: <20190508103703.40885-1-wen.he_1@nxp.com>
In-Reply-To: <20190508103703.40885-1-wen.he_1@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0037.apcprd03.prod.outlook.com
 (2603:1096:203:2f::25) To AM0PR04MB4865.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cdeb172-3138-42ae-cb97-08d6d3a0e30c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4962;
x-ms-traffictypediagnostic: AM0PR04MB4962:
x-microsoft-antispam-prvs: <AM0PR04MB4962540C2521C692653DA6EDE2320@AM0PR04MB4962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(478600001)(66946007)(186003)(2616005)(476003)(53936002)(66556008)(99286004)(4326008)(66066001)(73956011)(1076003)(66446008)(36756003)(64756008)(305945005)(316002)(7736002)(54906003)(2501003)(110136005)(76176011)(52116002)(6506007)(386003)(256004)(2201001)(102836004)(86362001)(446003)(11346002)(66476007)(5660300002)(26005)(6116002)(3846002)(14454004)(2906002)(6512007)(8936002)(71190400001)(71200400001)(486006)(50226002)(6486002)(6436002)(68736007)(25786009)(8676002)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4962;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 09Y5cqYZJB57YnHWgzPWlv9gdbetUmmPi7He22S711scsjuUmN5b7HjUjdXG1tic4Qd4+u8AFaaWG9vHuCF2TcRa7+Oiky3WXIOFQQS0llDirNAR0//n0CdDnxqvKWxm/hSQ4KLHoeSSb+0m/WGaJYJhS6WXAgLpiCPOKrCHp/CAVTp8+rCfzeLsK8I4KvoabXOyguBYsa1Wq6bATFYpi4+2LR607WwanKu8rAKwKZAKLpK0KqYYHHEhwCDj09awgXrBYdwQ1FyT2gIVV//xh5PHpl2cCdlWTvV7QASI8xTRhetASm4B6Fr6jlq/S/eht1XkYg9dIof0RCxLZ4O25oUdjZMDx6AB1+fbYxsXmGw8r2sjZyzYZSNN+CfTlIRZ2AEgnEbZQntRHm/R9qNVIL+tvooDsOoKPCvBFOygBLI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cdeb172-3138-42ae-cb97-08d6d3a0e30c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 10:35:27.9756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBlbmFibGVzIHRoZSBIRFAgY29udHJvbGxlciBkcml2ZXIgb24gdGhlIExTMTAy
OEEuDQoNClNpZ25lZC1vZmYtYnk6IEFsaXNvbiBXYW5nIDxhc2xpb24ud2FuZ0BueHAuY29tPg0K
U2lnbmVkLW9mZi1ieTogV2VuIEhlIDx3ZW4uaGVfMUBueHAuY29tPg0KLS0tDQogLi4uL2FybTY0
L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpIHwgMjUgKysrKysrKysrKysrKysr
KysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHMxMDI4YS5kdHNpIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaQ0KaW5kZXggYzBhMTNmOWU1Yjk1
Li4xNThmZGYyNmExMTcgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2Fs
ZS9mc2wtbHMxMDI4YS5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHMxMDI4YS5kdHNpDQpAQCAtOTEsNiArOTEsMTMgQEANCiAJCWNsb2NrLW91dHB1dC1uYW1l
cz0gInBjbGsiOw0KIAl9Ow0KIA0KKwloZHBjbGs6IGNsb2NrLWhkcGNvcmUgew0KKwkJY29tcGF0
aWJsZSA9ICJmaXhlZC1jbG9jayI7DQorCQkjY2xvY2stY2VsbHMgPSA8MD47DQorCQljbG9jay1m
cmVxdWVuY3kgPSA8MTYyNTAwMDAwPjsNCisJCWNsb2NrLW91dHB1dC1uYW1lcz0gImhkcGNsayI7
DQorCX07DQorDQogCXJlYm9vdCB7DQogCQljb21wYXRpYmxlID0ic3lzY29uLXJlYm9vdCI7DQog
CQlyZWdtYXAgPSA8JmRjZmc+Ow0KQEAgLTQ2Nyw3ICs0NzQsMjUgQEANCiANCiAJCXBvcnQgew0K
IAkJCWRwMF9vdXQ6IGVuZHBvaW50IHsNCisJCQkJcmVtb3RlLWVuZHBvaW50ID0gPCZkcDFfb3V0
PjsNCisJCQl9Ow0KKwkJfTsNCisJfTsNCiANCisJaGRwOiBkaXNwbGF5QGYyMDAwMDAgew0KKwkJ
Y29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YS1kcCI7DQorCQlyZWcgPSA8MHgwIDB4ZjFmMDAwMCAw
eDAgMHhmZmZmPiwNCisJCSAgICA8MHgwIDB4ZjIwMDAwMCAweDAgMHhmZmZmZj47DQorCQlpbnRl
cnJ1cHRzID0gPDAgMjIxIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJY2xvY2tzID0gPCZzeXNj
bGs+LCA8JmhkcGNsaz4sIDwmZHBjbGs+LA0KKwkJCSA8JmRwY2xrPiwgPCZkcGNsaz4sIDwmcGNs
az4sIDwmZHBjbGs+Ow0KKwkJY2xvY2stbmFtZXMgPSAiY2xrX2lwZyIsICJjbGtfY29yZSIsICJj
bGtfcHhsIiwNCisJCQkgICAgICAiY2xrX3B4bF9tdXgiLCAiY2xrX3B4bF9saW5rIiwgImNsa19h
cGIiLA0KKwkJCSAgICAgICJjbGtfdmlmIjsNCisNCisJCXBvcnQgew0KKwkJCWRwMV9vdXQ6IGVu
ZHBvaW50IHsNCisJCQkJcmVtb3RlLWVuZHBvaW50ID0gPCZkcDBfb3V0PjsNCiAJCQl9Ow0KIAkJ
fTsNCiAJfTsNCi0tIA0KMi4xNy4xDQoNCg==
