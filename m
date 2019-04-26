Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF1BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DCB82084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V7O8aPsA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfDZIGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:06:24 -0400
Received: from mail-eopbgr50060.outbound.protection.outlook.com ([40.107.5.60]:21934
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725995AbfDZIGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=afq5IVLNDCFuCL2IDppdbya7BAAWAEDF6Cf4vK1zc7E=;
 b=V7O8aPsATUpIP7vUW2xVaB3mfHxm20UF034tYzWm9M1DKq9U8uTX/XFPIUjqdcdV7UhjsCQ7l/gydcGr16L/FcxLJg9xo9M+yLw/twtwrJFBM2TXgCaD0IVn+qjC/QsnL6yxsXkC59DAFrluDd8vZAnQtFWszNbgeo4Ra9EQT6I=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:06:15 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:06:15 +0000
From:   Robin Gong <yibin.gong@nxp.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: [PATCH v2 12/15] ARM64: dts: freescale: imx8mm/8mq: update new
 compatible name for ecspi and sdma
Thread-Topic: [PATCH v2 12/15] ARM64: dts: freescale: imx8mm/8mq: update new
 compatible name for ecspi and sdma
Thread-Index: AQHU/AbrVrLmAeOn1E+XdO2t5q6+Jg==
Date:   Fri, 26 Apr 2019 08:06:15 +0000
Message-ID: <1556265512-9130-13-git-send-email-yibin.gong@nxp.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
In-Reply-To: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::36) To VI1PR04MB4543.eurprd04.prod.outlook.com
 (2603:10a6:803:6d::26)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yibin.gong@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4423c64b-8b07-4cc0-6774-08d6ca1e0de1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-microsoft-antispam-prvs: <VI1PR04MB6109B08F7F3ACAC266858640893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(99286004)(186003)(53936002)(102836004)(76176011)(25786009)(386003)(6506007)(2501003)(4326008)(52116002)(446003)(11346002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(7736002)(54906003)(71190400001)(305945005)(71200400001)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /HaIS3TMLBLgvNRogGuQoOP3+J0+lPNNgE+DMrTuWhqxL7LvjyNdSJ34JKvgp0/KKYZyV2aLYeXLW9nJuLjqBB6rSPJokuwvUOhtG5akbO5XTpmIjdy+3zu6yRj6mwXvUgkcz1kHX5Z9laPRwCxEWo+y8rEXAB2p9zvw1UBgZus9COpl+uxshlrbobBuy0LGjCWGcgowyJPT58/JwHEQnpdsn3/dIY0fq92hKeRV7V4Kba/CZYRNjzGg2xXK+AWpKAb4goQ2ADJ/V4aY9oOH4ihtPwqS/T1mV8TneUKmn+iYunDOMBFZbZ+jRVpNmW0jBC2TCptrQtPibyHmqkKZbcHmmb6U/v//UtWJ6B0c4wXCgvwrW61il7oZcC2gEeWvs4mIib2xbOb3wntnplfQ+ma5hdUKnJEg3WOqq7yuVBU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4423c64b-8b07-4cc0-6774-08d6ca1e0de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:06:15.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIG5ldyAnaW14NnVsLWVjc3BpJyBjb21wYXRpYmxlIG5hbWUgZm9yIGVjc3BpIGFuZCBuZXcg
J2lteDhtcS1zZG1hJyBuYW1lDQpmb3Igc2RtYSBzaW5jZSBvbiBpLm14OG1tL21xIGNoaXAgZml4
IGVjc3BpIGVycmF0YS4NCg0KU2lnbmVkLW9mZi1ieTogUm9iaW4gR29uZyA8eWliaW4uZ29uZ0Bu
eHAuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kg
fCAxNCArKysrKysrLS0tLS0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDht
cS5kdHNpIHwgIDYgKysrLS0tDQogMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAx
MCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDhtbS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0
c2kNCmluZGV4IGRlMzQ5OGMuLjE5NDVhYTMgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvaW14OG1tLmR0c2kNCkBAIC0yNTEsNyArMjUxLDcgQEANCiAJCQl9Ow0KIA0KIAkJCXNk
bWEyOiBkbWEtY29udHJvbGxlckAzMDJjMDAwMCB7DQotCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtbS1zZG1hIiwgImZzbCxpbXg3ZC1zZG1hIjsNCisJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14
OG1tLXNkbWEiLCAiZnNsLGlteDhtcS1zZG1hIjsNCiAJCQkJcmVnID0gPDB4MzAyYzAwMDAgMHgx
MDAwMD47DQogCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAxMDMgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQogCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0RNQTJfUk9PVD4sDQpAQCAtMjYy
LDcgKzI2Miw3IEBADQogCQkJfTsNCiANCiAJCQlzZG1hMzogZG1hLWNvbnRyb2xsZXJAMzAyYjAw
MDAgew0KLQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0tc2RtYSIsICJmc2wsaW14N2Qtc2Rt
YSI7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1zZG1hIiwgImZzbCxpbXg4bXEtc2Rt
YSI7DQogCQkJCXJlZyA9IDwweDMwMmIwMDAwIDB4MTAwMDA+Ow0KIAkJCQlpbnRlcnJ1cHRzID0g
PEdJQ19TUEkgMzQgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrIElN
WDhNTV9DTEtfU0RNQTNfUk9PVD4sDQpAQCAtMzkzLDcgKzM5Myw3IEBADQogCQkJcmFuZ2VzOw0K
IA0KIAkJCWVjc3BpMTogc3BpQDMwODIwMDAwIHsNCi0JCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14
OG1tLWVjc3BpIiwgImZzbCxpbXg1MS1lY3NwaSI7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlt
eDhtbS1lY3NwaSIsICJmc2wsaW14NnVsLWVjc3BpIjsNCiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQogCQkJCSNzaXplLWNlbGxzID0gPDA+Ow0KIAkJCQlyZWcgPSA8MHgzMDgyMDAwMCAweDEw
MDAwPjsNCkBAIC00MDcsNyArNDA3LDcgQEANCiAJCQl9Ow0KIA0KIAkJCWVjc3BpMjogc3BpQDMw
ODMwMDAwIHsNCi0JCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLWVjc3BpIiwgImZzbCxpbXg1
MS1lY3NwaSI7DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS1lY3NwaSIsICJmc2wsaW14
NnVsLWVjc3BpIjsNCiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQogCQkJCSNzaXplLWNlbGxz
ID0gPDA+Ow0KIAkJCQlyZWcgPSA8MHgzMDgzMDAwMCAweDEwMDAwPjsNCkBAIC00MjEsNyArNDIx
LDcgQEANCiAJCQl9Ow0KIA0KIAkJCWVjc3BpMzogc3BpQDMwODQwMDAwIHsNCi0JCQkJY29tcGF0
aWJsZSA9ICJmc2wsaW14OG1tLWVjc3BpIiwgImZzbCxpbXg1MS1lY3NwaSI7DQorCQkJCWNvbXBh
dGlibGUgPSAiZnNsLGlteDhtbS1lY3NwaSIsICJmc2wsaW14NnVsLWVjc3BpIjsNCiAJCQkJI2Fk
ZHJlc3MtY2VsbHMgPSA8MT47DQogCQkJCSNzaXplLWNlbGxzID0gPDA+Ow0KIAkJCQlyZWcgPSA8
MHgzMDg0MDAwMCAweDEwMDAwPjsNCkBAIC01NjcsMTEgKzU2NywxMSBAQA0KIAkJCX07DQogDQog
CQkJc2RtYTE6IGRtYS1jb250cm9sbGVyQDMwYmQwMDAwIHsNCi0JCQkJY29tcGF0aWJsZSA9ICJm
c2wsaW14OG1tLXNkbWEiLCAiZnNsLGlteDdkLXNkbWEiOw0KKwkJCQljb21wYXRpYmxlID0gImZz
bCxpbXg4bW0tc2RtYSIsICJmc2wsaW14OG1xLXNkbWEiOw0KIAkJCQlyZWcgPSA8MHgzMGJkMDAw
MCAweDEwMDAwPjsNCiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIgSVJRX1RZUEVfTEVWRUxf
SElHSD47DQogCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfU0RNQTFfUk9PVD4sDQotCQkJ
CQkgPCZjbGsgSU1YOE1NX0NMS19TRE1BMV9ST09UPjsNCisJCQkJCSA8JmNsayBJTVg4TU1fQ0xL
X0FIQj47DQogCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJhaGIiOw0KIAkJCQkjZG1hLWNlbGxz
ID0gPDM+Ow0KIAkJCQlmc2wsc2RtYS1yYW0tc2NyaXB0LW5hbWUgPSAiaW14L3NkbWEvc2RtYS1p
bXg3ZC5iaW4iOw0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lt
eDhtcS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLmR0c2kNCmlu
ZGV4IDdjMGIxMmEuLmYyYTVkMTIgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg4bXEuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
aW14OG1xLmR0c2kNCkBAIC02MDcsNyArNjA3LDcgQEANCiAJCQllY3NwaTE6IHNwaUAzMDgyMDAw
MCB7DQogCQkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KIAkJCQkjc2l6ZS1jZWxscyA9IDwwPjsN
Ci0JCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLWVjc3BpIiwgImZzbCxpbXg1MS1lY3NwaSI7
DQorCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1lY3NwaSIsICJmc2wsaW14NnVsLWVjc3Bp
IjsNCiAJCQkJcmVnID0gPDB4MzA4MjAwMDAgMHgxMDAwMD47DQogCQkJCWludGVycnVwdHMgPSA8
R0lDX1NQSSAzMSBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCiAJCQkJY2xvY2tzID0gPCZjbGsgSU1Y
OE1RX0NMS19FQ1NQSTFfUk9PVD4sDQpAQCAtNjE5LDcgKzYxOSw3IEBADQogCQkJZWNzcGkyOiBz
cGlAMzA4MzAwMDAgew0KIAkJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCiAJCQkJI3NpemUtY2Vs
bHMgPSA8MD47DQotCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtcS1lY3NwaSIsICJmc2wsaW14
NTEtZWNzcGkiOw0KKwkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtZWNzcGkiLCAiZnNsLGlt
eDZ1bC1lY3NwaSI7DQogCQkJCXJlZyA9IDwweDMwODMwMDAwIDB4MTAwMDA+Ow0KIAkJCQlpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMzIgSVJRX1RZUEVfTEVWRUxfSElHSD47DQogCQkJCWNsb2NrcyA9
IDwmY2xrIElNWDhNUV9DTEtfRUNTUEkyX1JPT1Q+LA0KQEAgLTYzMSw3ICs2MzEsNyBAQA0KIAkJ
CWVjc3BpMzogc3BpQDMwODQwMDAwIHsNCiAJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQogCQkJ
CSNzaXplLWNlbGxzID0gPDA+Ow0KLQkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bXEtZWNzcGki
LCAiZnNsLGlteDUxLWVjc3BpIjsNCisJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1xLWVjc3Bp
IiwgImZzbCxpbXg2dWwtZWNzcGkiOw0KIAkJCQlyZWcgPSA8MHgzMDg0MDAwMCAweDEwMDAwPjsN
CiAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDMzIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KIAkJ
CQljbG9ja3MgPSA8JmNsayBJTVg4TVFfQ0xLX0VDU1BJM19ST09UPiwNCi0tIA0KMi43LjQNCg0K
