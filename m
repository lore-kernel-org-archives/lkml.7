Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB61C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3947E21655
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="V9mZKcvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfEHNxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:53:16 -0400
Received: from mail-eopbgr40072.outbound.protection.outlook.com ([40.107.4.72]:35150
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbfEHNxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnXlyytlovrAqvTz3nUYvYWmG2E/tptUFT085C7XrKo=;
 b=V9mZKcvCw5sA1w8wDkc85qS6/Effck6eWLLFcHpBK2eoV7JjuBGjITAeFer/bL/0D+oyiL3OGQ0bS6yjKV4MUaQcEI0t0qtym920XB/f8R130V7zh2OPNMfilNb2+AFiZiz6gIwiGS2U8Zb2O4PEPndhd5Y8I11l2VYyPZ9xB3Y=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6166.eurprd04.prod.outlook.com (20.179.6.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.20; Wed, 8 May 2019 13:53:10 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda%6]) with mapi id 15.20.1856.012; Wed, 8 May 2019
 13:53:10 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 2/2] add dts file to enable support for ls1046afrwy board.
Thread-Topic: [PATCH 2/2] add dts file to enable support for ls1046afrwy
 board.
Thread-Index: AQHVBaVf+VCLC05vFU+xwIgyLZG0QQ==
Date:   Wed, 8 May 2019 13:53:10 +0000
Message-ID: <20190508135501.17578-3-pramod.kumar_1@nxp.com>
References: <20190508135501.17578-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190508135501.17578-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: BM1PR01CA0162.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::32) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 668c026b-d061-4726-e23b-08d6d3bc81a2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6166;
x-ms-traffictypediagnostic: AM6PR04MB6166:
x-microsoft-antispam-prvs: <AM6PR04MB616692DACE3FD134204BA672F6320@AM6PR04MB6166.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0031A0FFAF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(5660300002)(52116002)(99286004)(478600001)(76176011)(68736007)(1076003)(8936002)(102836004)(11346002)(6512007)(50226002)(476003)(446003)(316002)(81156014)(81166006)(53936002)(73956011)(8676002)(2501003)(36756003)(2616005)(486006)(26005)(6436002)(66946007)(64756008)(66446008)(6486002)(66476007)(66556008)(110136005)(14454004)(86362001)(4326008)(186003)(66066001)(54906003)(25786009)(2201001)(386003)(6506007)(2906002)(7736002)(305945005)(256004)(71200400001)(71190400001)(6116002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6166;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ArNNZY5reSgkVo10oN4CzOp4BshfYzOwmK+VRSXZNA7nmBEM208+/zrrmfC7LnLbBsW6P8X3vwXuYC/toU0IHSUq39rgBDQAKhyeKqbS/nvCllAbLXHztT5sJ59oUgHmVxS1lMZHqaMRUcdee9aCyiMiRMTfHqW3doH0+iWUg9QxwjD7pWYKBI21z72yUFyeHo4l0vWdrYAzckOgJoRoyp6nSglmygEYI0K/zWM904UJoBAOfrroDah6A2Hb+K5UpjeK/H5XRBckrNM+5MD4s7XpKGNZYeF9r5hKLCX8yOf81jqM8HNi4vrQ8cq9dOQpMdRG0GmjJsNewjESPsHc0nCwjxSNY7vGAGk/kK9MY8HtDDzVKQSyiNQnx5BhJZURfBhD2N6QHAxK9h7sMC1IrogVkNvcxvMqW6MKUdvjgmI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668c026b-d061-4726-e23b-08d6d3bc81a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2019 13:53:10.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6166
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bHMxMDQ2YWZyd3kgYm9hcmQgaXMgYmFzZWQgb24gbnhwIGxzMTA0NmEgU29DLg0KDQpTaWduZWQt
b2ZmLWJ5OiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1hQG54cC5jb20+DQpTaWduZWQtb2Zm
LWJ5OiBQcmFtb2QgS3VtYXIgPHByYW1vZC5rdW1hcl8xQG54cC5jb20+DQotLS0NCiBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZSAgICAgICAgfCAgIDEgKw0KIC4uLi9ib290
L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEtZnJ3eS5kdHMgICB8IDE1NiArKysrKysrKysrKysr
KysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDE1NyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUg
MTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZhLWZyd3kuZHRz
DQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZSBi
L2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQppbmRleCAxMzYwNGU1NThk
YzEuLjg0ZmY2OTk1YjQxZSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL01ha2VmaWxlDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmls
ZQ0KQEAgLTgsNiArOCw3IEBAIGR0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9IGZzbC1s
czEwMjhhLXFkcy5kdGINCiBkdGItJChDT05GSUdfQVJDSF9MQVlFUlNDQVBFKSArPSBmc2wtbHMx
MDI4YS1yZGIuZHRiDQogZHRiLSQoQ09ORklHX0FSQ0hfTEFZRVJTQ0FQRSkgKz0gZnNsLWxzMTA0
M2EtcWRzLmR0Yg0KIGR0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9IGZzbC1sczEwNDNh
LXJkYi5kdGINCitkdGItJChDT05GSUdfQVJDSF9MQVlFUlNDQVBFKSArPSBmc2wtbHMxMDQ2YS1m
cnd5LmR0Yg0KIGR0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NBUEUpICs9IGZzbC1sczEwNDZhLXFk
cy5kdGINCiBkdGItJChDT05GSUdfQVJDSF9MQVlFUlNDQVBFKSArPSBmc2wtbHMxMDQ2YS1yZGIu
ZHRiDQogZHRiLSQoQ09ORklHX0FSQ0hfTEFZRVJTQ0FQRSkgKz0gZnNsLWxzMTA4OGEtcWRzLmR0
Yg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwNDZh
LWZyd3kuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEtZnJ3
eS5kdHMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmRlMGQxOWMw
Mjk0NA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUv
ZnNsLWxzMTA0NmEtZnJ3eS5kdHMNCkBAIC0wLDAgKzEsMTU2IEBADQorLy8gU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wKyBPUiBNSVQpDQorLyoNCisgKiBEZXZpY2UgVHJlZSBJbmNs
dWRlIGZpbGUgZm9yIEZyZWVzY2FsZSBMYXllcnNjYXBlLTEwNDZBIGZhbWlseSBTb0MuDQorICoN
CisgKiBDb3B5cmlnaHQgMjAxOSBOWFAuDQorICoNCisgKi8NCisNCisvZHRzLXYxLzsNCisNCisj
aW5jbHVkZSAiZnNsLWxzMTA0NmEuZHRzaSINCisNCisvIHsNCisJbW9kZWwgPSAiTFMxMDQ2QSBG
UldZIEJvYXJkIjsNCisJY29tcGF0aWJsZSA9ICJmc2wsbHMxMDQ2YS1mcnd5IiwgImZzbCxsczEw
NDZhIjsNCisNCisJYWxpYXNlcyB7DQorCQlzZXJpYWwwID0gJmR1YXJ0MDsNCisJCXNlcmlhbDEg
PSAmZHVhcnQxOw0KKwkJc2VyaWFsMiA9ICZkdWFydDI7DQorCQlzZXJpYWwzID0gJmR1YXJ0MzsN
CisJfTsNCisNCisJY2hvc2VuIHsNCisJCXN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgi
Ow0KKwl9Ow0KKw0KKwlzYl8zdjM6IHJlZ3VsYXRvci1zYjN2MyB7DQorCQljb21wYXRpYmxlID0g
InJlZ3VsYXRvci1maXhlZCI7DQorCQlyZWd1bGF0b3ItbmFtZSA9ICJMVDg2NDJTRVYtMy4zViI7
DQorCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCisJCXJlZ3VsYXRvci1t
YXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KKwkJcmVndWxhdG9yLWJvb3Qtb247DQorCQlyZWd1
bGF0b3ItYWx3YXlzLW9uOw0KKwl9Ow0KK307DQorDQorJmR1YXJ0MCB7DQorCXN0YXR1cyA9ICJv
a2F5IjsNCit9Ow0KKw0KKyZkdWFydDEgew0KKwlzdGF0dXMgPSAib2theSI7DQorfTsNCisNCism
ZHVhcnQyIHsNCisJc3RhdHVzID0gIm9rYXkiOw0KK307DQorDQorJmR1YXJ0MyB7DQorCXN0YXR1
cyA9ICJva2F5IjsNCit9Ow0KKw0KKyZpMmMwIHsNCisJc3RhdHVzID0gIm9rYXkiOw0KKw0KKwlp
MmMtbXV4QDc3IHsNCisJCWNvbXBhdGlibGUgPSAibnhwLHBjYTk1NDYiOw0KKwkJcmVnID0gPDB4
Nzc+Ow0KKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCQkjc2l6ZS1jZWxscyA9IDwwPjsNCisJ
CWkyYy1tdXgtbmV2ZXItZGlzYWJsZTsNCisNCisJCWkyY0AwIHsNCisJCQkjYWRkcmVzcy1jZWxs
cyA9IDwxPjsNCisJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCisJCQlyZWcgPSA8MD47DQorDQorCQkJ
ZWVwcm9tQDUyIHsNCisJCQkJY29tcGF0aWJsZSA9ICJhdG1lbCwyNGM1MTIiOw0KKwkJCQlyZWcg
PSA8MHg1Mj47DQorCQkJfTsNCisNCisJCQllZXByb21ANTMgew0KKwkJCQljb21wYXRpYmxlID0g
ImF0bWVsLDI0YzUxMiI7DQorCQkJCXJlZyA9IDwweDUzPjsNCisJCQl9Ow0KKw0KKwkJCXBvd2Vy
LW1vbml0b3JANDAgew0KKwkJCQljb21wYXRpYmxlID0gInRpLGluYTIyMCI7DQorCQkJCXJlZyA9
IDwweDQwPjsNCisJCQkJc2h1bnQtcmVzaXN0b3IgPSA8MTAwMD47DQorCQkJfTsNCisNCisJCQly
dGNANTEgew0KKwkJCQljb21wYXRpYmxlID0gIm54cCxwY2YyMTI5IjsNCisJCQkJcmVnID0gPDB4
NTE+Ow0KKwkJCX07DQorDQorCQkJdGVtcGVyYXR1cmUtc2Vuc29yQDRjIHsNCisJCQkJY29tcGF0
aWJsZSA9ICJueHAsc2E1NjAwNCI7DQorCQkJCXJlZyA9IDwweDRjPjsNCisJCQkJdmNjLXN1cHBs
eSA9IDwmc2JfM3YzPjsNCisJCQl9Ow0KKw0KKwkJfTsNCisJfTsNCit9Ow0KKw0KKyZpZmMgew0K
KwkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCisJI3NpemUtY2VsbHMgPSA8MT47DQorCS8qIE5BTkQg
Rmxhc2ggKi8NCisJcmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4N2U4MDAwMDAgMHgwMDAxMDAwMD47
DQorCXN0YXR1cyA9ICJva2F5IjsNCisNCisJbmFuZEAwLDAgew0KKwkJY29tcGF0aWJsZSA9ICJm
c2wsaWZjLW5hbmQiOw0KKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCQkjc2l6ZS1jZWxscyA9
IDwxPjsNCisJCXJlZyA9IDwweDAgMHgwIDB4MTAwMDA+Ow0KKwl9Ow0KKw0KK307DQorDQorI2lu
Y2x1ZGUgImZzbC1sczEwNDYtcG9zdC5kdHNpIg0KKw0KKyZmbWFuMCB7DQorCWV0aGVybmV0QGUw
MDAwIHsNCisJCXBoeS1oYW5kbGUgPSA8JnFzZ21paV9waHk0PjsNCisJCXBoeS1jb25uZWN0aW9u
LXR5cGUgPSAicXNnbWlpIjsNCisJfTsNCisNCisJZXRoZXJuZXRAZTgwMDAgew0KKwkJcGh5LWhh
bmRsZSA9IDwmcXNnbWlpX3BoeTI+Ow0KKwkJcGh5LWNvbm5lY3Rpb24tdHlwZSA9ICJxc2dtaWki
Ow0KKwl9Ow0KKw0KKwlldGhlcm5ldEBlYTAwMCB7DQorCQlwaHktaGFuZGxlID0gPCZxc2dtaWlf
cGh5MT47DQorCQlwaHktY29ubmVjdGlvbi10eXBlID0gInFzZ21paSI7DQorCX07DQorDQorCWV0
aGVybmV0QGYyMDAwIHsNCisJCXBoeS1oYW5kbGUgPSA8JnFzZ21paV9waHkzPjsNCisJCXBoeS1j
b25uZWN0aW9uLXR5cGUgPSAicXNnbWlpIjsNCisJfTsNCisNCisJbWRpb0BmZDAwMCB7DQorCQlx
c2dtaWlfcGh5MTogZXRoZXJuZXQtcGh5QDFjIHsNCisJCQlyZWcgPSA8MHgxYz47DQorCQl9Ow0K
Kw0KKwkJcXNnbWlpX3BoeTI6IGV0aGVybmV0LXBoeUAxZCB7DQorCQkJcmVnID0gPDB4MWQ+Ow0K
KwkJfTsNCisNCisJCXFzZ21paV9waHkzOiBldGhlcm5ldC1waHlAMWUgew0KKwkJCXJlZyA9IDww
eDFlPjsNCisJCX07DQorDQorCQlxc2dtaWlfcGh5NDogZXRoZXJuZXQtcGh5QDFmIHsNCisJCQly
ZWcgPSA8MHgxZj47DQorCQl9Ow0KKwl9Ow0KK307DQotLSANCjIuMTcuMQ0KDQo=
