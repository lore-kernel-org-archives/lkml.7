Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6ABC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76A620656
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 10:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dsLCj212"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfEHKom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 06:44:42 -0400
Received: from mail-eopbgr60067.outbound.protection.outlook.com ([40.107.6.67]:30137
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725889AbfEHKom (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 06:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UxBJYWaxvo9rtknksJ9kzRu1GddNHkW0b798+MGk4Y=;
 b=dsLCj21253DY0oR3BUIVP+mSUmxy1La6Cw1zKyzJ+PGkTkkHn9RBx34sYCaajuDsitQWzeNtQLzJmdUUN7+UYaLl/PLLadGeynnJEE99vMKvx1bqq5MDup3sgEo8SuSGnx1p36cVqwS1q9ywaPeNDglIYJH0F0dgxjLoOkkXlTw=
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com (20.176.215.158) by
 AM0PR04MB6595.eurprd04.prod.outlook.com (20.179.255.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Wed, 8 May 2019 10:44:39 +0000
Received: from AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be]) by AM0PR04MB4865.eurprd04.prod.outlook.com
 ([fe80::f496:84c1:30b5:43be%7]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 10:44:39 +0000
From:   Wen He <wen.he_1@nxp.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Wen He <wen.he_1@nxp.com>
Subject: [v5] arm64: dts: ls1028a: Add properties for Mali DP500 node
Thread-Topic: [v5] arm64: dts: ls1028a: Add properties for Mali DP500 node
Thread-Index: AQHVBYsJ6isj8SfWxEyYwCBOPeVt9A==
Date:   Wed, 8 May 2019 10:44:39 +0000
Message-ID: <20190508104614.42481-1-wen.he_1@nxp.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR03CA0063.apcprd03.prod.outlook.com
 (2603:1096:202:17::33) To AM0PR04MB4865.eurprd04.prod.outlook.com
 (2603:10a6:208:c4::30)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wen.he_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e24cef5-a368-46f7-0d46-08d6d3a22b99
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6595;
x-ms-traffictypediagnostic: AM0PR04MB6595:
x-microsoft-antispam-prvs: <AM0PR04MB659593C91C8DD2998D933973E2320@AM0PR04MB6595.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(189003)(199004)(110136005)(54906003)(186003)(4326008)(50226002)(6506007)(2201001)(102836004)(26005)(86362001)(386003)(52116002)(99286004)(36756003)(25786009)(14454004)(305945005)(81156014)(8676002)(8936002)(81166006)(7736002)(64756008)(6436002)(6512007)(2906002)(6486002)(71200400001)(68736007)(476003)(2616005)(5660300002)(71190400001)(316002)(478600001)(2501003)(66476007)(53936002)(66066001)(66946007)(73956011)(1076003)(256004)(486006)(66556008)(66446008)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6595;H:AM0PR04MB4865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8WR7yrp4kv0kG3IGk9dZxCWUTWdnfMzNZe5RqzAsap1wgREgAA+LAq6tvIUQInBY9K1wvgB7BbVmpISD6SDbzlAsz7D3uptHqYx2hxD6qeVkaWWQLQ3UEFDdLTMiPyfSoMwzd89Ctw/HxZ78FwhZY2Z20cQzg/ytBhO0qdfLWubllF0TgFKtEdtWyaDp/NJn6F/4tg1nFWYAWe97vcga5LgaxX2eR6eRs8zrLNbIia/xerjSpfWxLkH+1dCIJeUcz5s2x4pfq/QI1EYa0YL0X7c9FZ/az3OMUrXGqPELbMCmJTbbpM32PSJ7Pt1clCfekH6+9eCADsKZ9JAUQMVrk92pyuzZz6vTfij52wYNcv+g9DwpdNvX07uIqbE96CFnG7mewvcxrlpcgN0+dXRRP+4cDpKYDuVaFCOgLFbsgNw=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e24cef5-a368-46f7-0d46-08d6d3a22b99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 10:44:39.1995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6595
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIExTMTAyOEEgaGFzIGEgTENEIGNvbnRyb2xsZXIgYW5kIERpc3BsYXlwb3J0IGludGVyZmFj
ZSB0aGF0DQpjb25uZWN0cyB0byBlRFAgYW5kIERpc3BsYXlwb3J0IGNvbm5lY3RvcnMgb24gdGhl
IExTMTAyOEEgYm9hcmQuDQoNClRoaXMgcGF0Y2ggZW5hYmxlcyB0aGUgTENEIGNvbnRyb2xsZXIg
ZHJpdmVyIG9uIHRoZSBMUzEwMjhBLg0KDQpTaWduZWQtb2ZmLWJ5OiBBbGlzb24gV2FuZyA8YWxp
c29uLndhbmdAbnhwLmNvbT4NClNpZ25lZC1vZmYtYnk6IFdlbiBIZSA8d2VuLmhlXzFAbnhwLmNv
bT4NClJldmlld2VkLWJ5OiBMaXZpdSBEdWRhdSA8bGl2aXUuZHVkYXVAYXJtLmNvbT4NClJldmll
d2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KLS0tDQpjaGFuZ2UgaW4gdjU6
DQogICAgICAgIC0gUmV2aWV3ZWQgYnkgZnJvbSBSb2IsIHRoYW5rcy4NCg0KIC4uLi9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaSB8IDM4ICsrKysrKysrKysrKysrKysr
KysNCiAxIGZpbGUgY2hhbmdlZCwgMzggaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTAyOGEuZHRzaSBiL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2kNCmluZGV4IGIwNDU4MTI0OWYwYi4u
YzBhMTNmOWU1Yjk1IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTAyOGEuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNs
LWxzMTAyOGEuZHRzaQ0KQEAgLTcwLDYgKzcwLDI3IEBADQogCQljbG9jay1vdXRwdXQtbmFtZXMg
PSAic3lzY2xrIjsNCiAJfTsNCiANCisJZHBjbGs6IGNsb2NrLWRwIHsNCisJCWNvbXBhdGlibGUg
PSAiZml4ZWQtY2xvY2siOw0KKwkJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KKwkJY2xvY2stZnJlcXVl
bmN5ID0gPDI3MDAwMDAwPjsNCisJCWNsb2NrLW91dHB1dC1uYW1lcz0gImRwY2xrIjsNCisJfTsN
CisNCisJYWNsazogY2xvY2stYXhpIHsNCisJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0K
KwkJI2Nsb2NrLWNlbGxzID0gPDA+Ow0KKwkJY2xvY2stZnJlcXVlbmN5ID0gPDY1MDAwMDAwMD47
DQorCQljbG9jay1vdXRwdXQtbmFtZXM9ICJhY2xrIjsNCisJfTsNCisNCisJcGNsazogY2xvY2st
YXBiIHsNCisJCWNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOw0KKwkJI2Nsb2NrLWNlbGxzID0g
PDA+Ow0KKwkJY2xvY2stZnJlcXVlbmN5ID0gPDY1MDAwMDAwMD47DQorCQljbG9jay1vdXRwdXQt
bmFtZXM9ICJwY2xrIjsNCisJfTsNCisNCiAJcmVib290IHsNCiAJCWNvbXBhdGlibGUgPSJzeXNj
b24tcmVib290IjsNCiAJCXJlZ21hcCA9IDwmZGNmZz47DQpAQCAtNDMzLDQgKzQ1NCwyMSBAQA0K
IAkJCX07DQogCQl9Ow0KIAl9Ow0KKw0KKwltYWxpZHAwOiBkaXNwbGF5QGYwODAwMDAgew0KKwkJ
Y29tcGF0aWJsZSA9ICJhcm0sbWFsaS1kcDUwMCI7DQorCQlyZWcgPSA8MHgwIDB4ZjA4MDAwMCAw
eDAgMHgxMDAwMD47DQorCQlpbnRlcnJ1cHRzID0gPDAgMjIyIElSUV9UWVBFX0xFVkVMX0hJR0g+
LA0KKwkJCSAgICAgPDAgMjIzIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KKwkJaW50ZXJydXB0LW5h
bWVzID0gIkRFIiwgIlNFIjsNCisJCWNsb2NrcyA9IDwmZHBjbGs+LCA8JmFjbGs+LCA8JmFjbGs+
LCA8JnBjbGs+Ow0KKwkJY2xvY2stbmFtZXMgPSAicHhsY2xrIiwgIm1jbGsiLCAiYWNsayIsICJw
Y2xrIjsNCisJCWFybSxtYWxpZHAtb3V0cHV0LXBvcnQtbGluZXMgPSAvYml0cy8gOCA8OCA4IDg+
Ow0KKw0KKwkJcG9ydCB7DQorCQkJZHAwX291dDogZW5kcG9pbnQgew0KKw0KKwkJCX07DQorCQl9
Ow0KKwl9Ow0KIH07DQotLSANCjIuMTcuMQ0KDQo=
