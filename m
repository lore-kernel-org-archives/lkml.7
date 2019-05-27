Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF1C072B1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 522E92146F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 12:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hErrTPb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfE0ME2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 08:04:28 -0400
Received: from mail-eopbgr140080.outbound.protection.outlook.com ([40.107.14.80]:33794
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727065AbfE0ME0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 08:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HryAjwtS3fGdPKnlD3QUhuUDCYaY88h6fcqIGmFPPl4=;
 b=hErrTPb36bZISFiPPTUgrCZyIH7nR1hNdVzZ8ixOY2A2WcPYDweoMw/WyOBbEfXhDa6QepmqPK+hd2+J9vN1uqrF4tG7WelMOwSdpWkARrXKZeyeHeRA9B7pA1FUURwh/GsCMaCBpSR8Bq5ToM6Kau7qbBUB1wLTHILEFYOXKu4=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6421.eurprd04.prod.outlook.com (20.179.244.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.18; Mon, 27 May 2019 12:04:23 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::55a3:c244:9ba:6d21%4]) with mapi id 15.20.1922.021; Mon, 27 May 2019
 12:04:23 +0000
From:   Pramod Kumar <pramod.kumar_1@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "Michal.Vokac@ysoft.com" <Michal.Vokac@ysoft.com>,
        Leo Li <leoyang.li@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 2/3] arm64: dts: nxp: add ls1046a-frwy board support
Thread-Topic: [PATCH 2/3] arm64: dts: nxp: add ls1046a-frwy board support
Thread-Index: AQHVFIRSl94KZu24K0yL5zBt4JH9hA==
Date:   Mon, 27 May 2019 12:04:23 +0000
Message-ID: <20190527120619.30546-3-pramod.kumar_1@nxp.com>
References: <20190527120619.30546-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190527120619.30546-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: BMXPR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::26) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a7c24c4-603e-46fb-c882-08d6e29b7502
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6421;
x-ms-traffictypediagnostic: AM6PR04MB6421:
x-microsoft-antispam-prvs: <AM6PR04MB64213B480523CB9EB464B3E9F61D0@AM6PR04MB6421.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0050CEFE70
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(396003)(39860400002)(366004)(189003)(199004)(6636002)(4326008)(6486002)(256004)(102836004)(99286004)(3846002)(6436002)(8676002)(478600001)(71200400001)(71190400001)(53936002)(305945005)(2501003)(1076003)(2201001)(54906003)(6116002)(8936002)(110136005)(5660300002)(36756003)(14454004)(66446008)(73956011)(186003)(52116002)(86362001)(7736002)(26005)(486006)(2616005)(386003)(446003)(11346002)(81156014)(81166006)(6506007)(476003)(316002)(76176011)(25786009)(6512007)(2906002)(66946007)(66476007)(66556008)(64756008)(66066001)(50226002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6421;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZpqmRFHQAiMyEF9gWtLpb130qBLw67Qq88H3ac2/RyepKWvXgkDLkxkjQ7bbvZwPQqFRYBRA+eBsHdtjDd6zGFAfW2fcI/v1mMs7yX/3qUUUJfvd+wQfe5FBvIV0/kCJFGx5NtIU0T3sJKS3lOL6y746ZCjp1odcxH/WNVZnuiner28+UeoFhXFjqzeqttTteUGTbi+a6kz+VWgJUUFZp25RaLh5UrLLgXwnWC2KJZOe/k3GdfU8NEuVFke/c2c6YTCMT/zduDKTw9qwFLGqSdA2WPexHLbzNXhEGZPaM1Z9OmK10vU5jw8jj4PbrIHnMC/mndPpKfhtRTDoA/P0QEP6wr04fYjLgbHliHSS2XTGBrCAgSyQrEDUZ8sQQdFlS20bAO9+k3edQsozt3464KTk/mMB/SIcE1pEJjEdRUc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a7c24c4-603e-46fb-c882-08d6e29b7502
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2019 12:04:23.3846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pramod.kumar_1@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6421
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bHMxMDQ2YWZyd3kgYm9hcmQgaXMgYmFzZWQgb24gbnhwIGxzMTA0NmEgU29DLg0KQm9hcmQgc3Vw
cG9ydCdzIDRHQiBkZHIgbWVtb3J5LCBpMmMsIG1pY3JvU0QgY2FyZCwNCnNlcmlhbCBjb25zb2xl
LHFzcGkgbm9yIGZsYXNoLGlmYyBuYW5kIGZsYXNoLHFzZ21paSBuZXR3b3JrIGludGVyZmFjZSwN
CnVzYiAzLjAgYW5kIHNlcmRlcyBpbnRlcmZhY2UgdG8gc3VwcG9ydCB0d28geDFnZW4zIHBjaWUg
aW50ZXJmYWNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBWYWJoYXYgU2hhcm1hIDx2YWJoYXYuc2hhcm1h
QG54cC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBQcmFtb2QgS3VtYXIgPHByYW1vZC5rdW1hcl8xQG54
cC5jb20+DQotLS0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZSAgICAg
ICAgfCAgIDEgKw0KIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEtZnJ3eS5kdHMg
ICB8IDE1NiArKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDE1NyBpbnNlcnRp
b25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1sczEwNDZhLWZyd3kuZHRzDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9NYWtlZmlsZSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2Vm
aWxlDQppbmRleCAwYmQxMjJmNjA1NDkuLjEyMTE1MzFmNDE3YyAxMDA2NDQNCi0tLSBhL2FyY2gv
YXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlDQorKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQ0KQEAgLTgsNiArOCw3IEBAIGR0Yi0kKENPTkZJR19BUkNI
X0xBWUVSU0NBUEUpICs9IGZzbC1sczEwMjhhLXFkcy5kdGINCiBkdGItJChDT05GSUdfQVJDSF9M
QVlFUlNDQVBFKSArPSBmc2wtbHMxMDI4YS1yZGIuZHRiDQogZHRiLSQoQ09ORklHX0FSQ0hfTEFZ
RVJTQ0FQRSkgKz0gZnNsLWxzMTA0M2EtcWRzLmR0Yg0KIGR0Yi0kKENPTkZJR19BUkNIX0xBWUVS
U0NBUEUpICs9IGZzbC1sczEwNDNhLXJkYi5kdGINCitkdGItJChDT05GSUdfQVJDSF9MQVlFUlND
QVBFKSArPSBmc2wtbHMxMDQ2YS1mcnd5LmR0Yg0KIGR0Yi0kKENPTkZJR19BUkNIX0xBWUVSU0NB
UEUpICs9IGZzbC1sczEwNDZhLXFkcy5kdGINCiBkdGItJChDT05GSUdfQVJDSF9MQVlFUlNDQVBF
KSArPSBmc2wtbHMxMDQ2YS1yZGIuZHRiDQogZHRiLSQoQ09ORklHX0FSQ0hfTEFZRVJTQ0FQRSkg
Kz0gZnNsLWxzMTA4OGEtcWRzLmR0Yg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1sczEwNDZhLWZyd3kuZHRzIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVl
c2NhbGUvZnNsLWxzMTA0NmEtZnJ3eS5kdHMNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAw
MDAwMDAwMDAwMDAuLmNkYTQ5OTg4ZDhiOA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWxzMTA0NmEtZnJ3eS5kdHMNCkBAIC0wLDAgKzEsMTU2
IEBADQorLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wKyBPUiBNSVQpDQorLyoN
CisgKiBEZXZpY2UgVHJlZSBJbmNsdWRlIGZpbGUgZm9yIEZyZWVzY2FsZSBMYXllcnNjYXBlLTEw
NDZBIGZhbWlseSBTb0MuDQorICoNCisgKiBDb3B5cmlnaHQgMjAxOSBOWFAuDQorICoNCisgKi8N
CisNCisvZHRzLXYxLzsNCisNCisjaW5jbHVkZSAiZnNsLWxzMTA0NmEuZHRzaSINCisNCisvIHsN
CisJbW9kZWwgPSAiTFMxMDQ2QSBGUldZIEJvYXJkIjsNCisJY29tcGF0aWJsZSA9ICJmc2wsbHMx
MDQ2YS1mcnd5IiwgImZzbCxsczEwNDZhIjsNCisNCisJYWxpYXNlcyB7DQorCQlzZXJpYWwwID0g
JmR1YXJ0MDsNCisJCXNlcmlhbDEgPSAmZHVhcnQxOw0KKwkJc2VyaWFsMiA9ICZkdWFydDI7DQor
CQlzZXJpYWwzID0gJmR1YXJ0MzsNCisJfTsNCisNCisJY2hvc2VuIHsNCisJCXN0ZG91dC1wYXRo
ID0gInNlcmlhbDA6MTE1MjAwbjgiOw0KKwl9Ow0KKw0KKwlzYl8zdjM6IHJlZ3VsYXRvci1zYjN2
MyB7DQorCQljb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhlZCI7DQorCQlyZWd1bGF0b3ItbmFt
ZSA9ICJMVDg2NDJTRVYtMy4zViI7DQorCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAw
MDAwPjsNCisJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KKwkJcmVndWxh
dG9yLWJvb3Qtb247DQorCQlyZWd1bGF0b3ItYWx3YXlzLW9uOw0KKwl9Ow0KK307DQorDQorJmR1
YXJ0MCB7DQorCXN0YXR1cyA9ICJva2F5IjsNCit9Ow0KKw0KKyZkdWFydDEgew0KKwlzdGF0dXMg
PSAib2theSI7DQorfTsNCisNCismZHVhcnQyIHsNCisJc3RhdHVzID0gIm9rYXkiOw0KK307DQor
DQorJmR1YXJ0MyB7DQorCXN0YXR1cyA9ICJva2F5IjsNCit9Ow0KKw0KKyZpMmMwIHsNCisJc3Rh
dHVzID0gIm9rYXkiOw0KKw0KKwlpMmMtbXV4QDc3IHsNCisJCWNvbXBhdGlibGUgPSAibnhwLHBj
YTk1NDYiOw0KKwkJcmVnID0gPDB4Nzc+Ow0KKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCQkj
c2l6ZS1jZWxscyA9IDwwPjsNCisNCisJCWkyY0AwIHsNCisJCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsNCisJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCisJCQlyZWcgPSA8MD47DQorDQorCQkJcG93ZXIt
bW9uaXRvckA0MCB7DQorCQkJCWNvbXBhdGlibGUgPSAidGksaW5hMjIwIjsNCisJCQkJcmVnID0g
PDB4NDA+Ow0KKwkJCQlzaHVudC1yZXNpc3RvciA9IDwxMDAwPjsNCisJCQl9Ow0KKw0KKw0KKwkJ
CXRlbXBlcmF0dXJlLXNlbnNvckA0YyB7DQorCQkJCWNvbXBhdGlibGUgPSAibnhwLHNhNTYwMDQi
Ow0KKwkJCQlyZWcgPSA8MHg0Yz47DQorCQkJCXZjYy1zdXBwbHkgPSA8JnNiXzN2Mz47DQorCQkJ
fTsNCisNCisJCQlydGNANTEgew0KKwkJCQljb21wYXRpYmxlID0gIm54cCxwY2YyMTI5IjsNCisJ
CQkJcmVnID0gPDB4NTE+Ow0KKwkJCX07DQorDQorCQkJZWVwcm9tQDUyIHsNCisJCQkJY29tcGF0
aWJsZSA9ICJhdG1lbCwyNGM1MTIiOw0KKwkJCQlyZWcgPSA8MHg1Mj47DQorCQkJfTsNCisNCisJ
CQllZXByb21ANTMgew0KKwkJCQljb21wYXRpYmxlID0gImF0bWVsLDI0YzUxMiI7DQorCQkJCXJl
ZyA9IDwweDUzPjsNCisJCQl9Ow0KKw0KKwkJfTsNCisJfTsNCit9Ow0KKw0KKyZpZmMgew0KKwkj
YWRkcmVzcy1jZWxscyA9IDwyPjsNCisJI3NpemUtY2VsbHMgPSA8MT47DQorCS8qIE5BTkQgRmxh
c2ggKi8NCisJcmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4N2U4MDAwMDAgMHgwMDAxMDAwMD47DQor
CXN0YXR1cyA9ICJva2F5IjsNCisNCisJbmFuZEAwLDAgew0KKwkJY29tcGF0aWJsZSA9ICJmc2ws
aWZjLW5hbmQiOw0KKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCQkjc2l6ZS1jZWxscyA9IDwx
PjsNCisJCXJlZyA9IDwweDAgMHgwIDB4MTAwMDA+Ow0KKwl9Ow0KKw0KK307DQorDQorI2luY2x1
ZGUgImZzbC1sczEwNDYtcG9zdC5kdHNpIg0KKw0KKyZmbWFuMCB7DQorCWV0aGVybmV0QGUwMDAw
IHsNCisJCXBoeS1oYW5kbGUgPSA8JnFzZ21paV9waHk0PjsNCisJCXBoeS1jb25uZWN0aW9uLXR5
cGUgPSAicXNnbWlpIjsNCisJfTsNCisNCisJZXRoZXJuZXRAZTgwMDAgew0KKwkJcGh5LWhhbmRs
ZSA9IDwmcXNnbWlpX3BoeTI+Ow0KKwkJcGh5LWNvbm5lY3Rpb24tdHlwZSA9ICJxc2dtaWkiOw0K
Kwl9Ow0KKw0KKwlldGhlcm5ldEBlYTAwMCB7DQorCQlwaHktaGFuZGxlID0gPCZxc2dtaWlfcGh5
MT47DQorCQlwaHktY29ubmVjdGlvbi10eXBlID0gInFzZ21paSI7DQorCX07DQorDQorCWV0aGVy
bmV0QGYyMDAwIHsNCisJCXBoeS1oYW5kbGUgPSA8JnFzZ21paV9waHkzPjsNCisJCXBoeS1jb25u
ZWN0aW9uLXR5cGUgPSAicXNnbWlpIjsNCisJfTsNCisNCisJbWRpb0BmZDAwMCB7DQorCQlxc2dt
aWlfcGh5MTogZXRoZXJuZXQtcGh5QDFjIHsNCisJCQlyZWcgPSA8MHgxYz47DQorCQl9Ow0KKw0K
KwkJcXNnbWlpX3BoeTI6IGV0aGVybmV0LXBoeUAxZCB7DQorCQkJcmVnID0gPDB4MWQ+Ow0KKwkJ
fTsNCisNCisJCXFzZ21paV9waHkzOiBldGhlcm5ldC1waHlAMWUgew0KKwkJCXJlZyA9IDwweDFl
PjsNCisJCX07DQorDQorCQlxc2dtaWlfcGh5NDogZXRoZXJuZXQtcGh5QDFmIHsNCisJCQlyZWcg
PSA8MHgxZj47DQorCQl9Ow0KKwl9Ow0KK307DQotLSANCjIuMTcuMQ0KDQo=
