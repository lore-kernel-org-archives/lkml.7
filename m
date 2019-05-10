Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A08C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349D921479
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 13:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="srWXc6SV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbfEJNA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 09:00:26 -0400
Received: from mail-eopbgr150045.outbound.protection.outlook.com ([40.107.15.45]:33461
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727819AbfEJNAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 09:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nXGTsfK8kPy9o65RDbYgSMufyodGvQAlB88bQfwOaBs=;
 b=srWXc6SVX6U2+CffdhjqUL094FZMeOtopszHo+mwl4fB99Z3D7erJbti9LzFM/ldiQghzmN79VO8wpN4/r8Oivfq+/xwzDIXruqTJVNgn9kEoZ0/Q+zNi16GnOiCuJTMXH4ZuDiSpR1pIPtJWPY47Y+TQ/sVK3/nRzDocUX6x7Q=
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com (20.177.34.92) by
 AM6PR04MB6229.eurprd04.prod.outlook.com (20.179.7.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Fri, 10 May 2019 13:00:21 +0000
Received: from AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda]) by AM6PR04MB5032.eurprd04.prod.outlook.com
 ([fe80::15c1:586e:553c:3cda%6]) with mapi id 15.20.1856.016; Fri, 10 May 2019
 13:00:21 +0000
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
Subject: [PATCH v2 2/3] arm64: dts: nxp: add ls1046a-frwy board support
Thread-Topic: [PATCH v2 2/3] arm64: dts: nxp: add ls1046a-frwy board support
Thread-Index: AQHVBzBTKlCYQU+P6USHvschCL9MIQ==
Date:   Fri, 10 May 2019 13:00:20 +0000
Message-ID: <20190510130207.14330-3-pramod.kumar_1@nxp.com>
References: <20190510130207.14330-1-pramod.kumar_1@nxp.com>
In-Reply-To: <20190510130207.14330-1-pramod.kumar_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR04CA0183.apcprd04.prod.outlook.com
 (2603:1096:4:14::21) To AM6PR04MB5032.eurprd04.prod.outlook.com
 (2603:10a6:20b:9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pramod.kumar_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.120.1.70]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c911007-8975-48ab-751d-08d6d547754c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6229;
x-ms-traffictypediagnostic: AM6PR04MB6229:
x-microsoft-antispam-prvs: <AM6PR04MB622955D743C9CEAF14107BA7F60C0@AM6PR04MB6229.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-forefront-prvs: 0033AAD26D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(366004)(199004)(189003)(11346002)(2501003)(476003)(446003)(73956011)(66556008)(2906002)(66946007)(66476007)(64756008)(25786009)(50226002)(2616005)(486006)(14454004)(8936002)(478600001)(68736007)(66446008)(186003)(52116002)(76176011)(99286004)(5660300002)(6636002)(26005)(102836004)(386003)(6506007)(6486002)(6436002)(4326008)(3846002)(6116002)(2201001)(305945005)(66066001)(256004)(6512007)(71190400001)(53936002)(71200400001)(110136005)(86362001)(54906003)(36756003)(7736002)(316002)(81156014)(8676002)(81166006)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6229;H:AM6PR04MB5032.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cNQsFaVf69CeGs+fiv5s6IBggUvfzDkdjEQJkbWgOLnswLbz78QzTVW5SqYLB6mH9YZtGNZwS1XnUNuuBSl7MWKJbr5CXK0JHP/s/nD/llZOY8pCqYJO/s9F8UioBL2t9zbKM/LY7OmlvlHGMsHLYdMVCuVtkFCKmoMW13V7ZcnG3nhbS72kB4mTHZ4EC4AM0ldmZAFIMFZJFfA7AKUAX0VnV58lgEi7ayT+ozO7e2DMqx64beNgYOjMAGzgAzOFr0kSsWZveiP0EtfM4XOh1DgZIPnoKWGhRYAINPEVHm/RE6CRkNeSETUzmEuD0M+AgoxTXF9cXtyxYArnzj3U4qNC0sTTNSyBO0NAeVfwxxPdX9g45hEhFtJBjhCtmkftaKnnpC+614naZWrA2zb5WQ86iQirlYpr3GsdMQhhAW8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c911007-8975-48ab-751d-08d6d547754c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2019 13:00:20.9855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6229
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
aWxlDQppbmRleCAxMzYwNGU1NThkYzEuLjg0ZmY2OTk1YjQxZSAxMDA2NDQNCi0tLSBhL2FyY2gv
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
MDAwMDAwMDAwMDAuLmRlMGQxOWMwMjk0NA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvYXJjaC9hcm02
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
c2l6ZS1jZWxscyA9IDwwPjsNCisJCWkyYy1tdXgtbmV2ZXItZGlzYWJsZTsNCisNCisJCWkyY0Aw
IHsNCisJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCisJCQkjc2l6ZS1jZWxscyA9IDwwPjsNCisJ
CQlyZWcgPSA8MD47DQorDQorCQkJZWVwcm9tQDUyIHsNCisJCQkJY29tcGF0aWJsZSA9ICJhdG1l
bCwyNGM1MTIiOw0KKwkJCQlyZWcgPSA8MHg1Mj47DQorCQkJfTsNCisNCisJCQllZXByb21ANTMg
ew0KKwkJCQljb21wYXRpYmxlID0gImF0bWVsLDI0YzUxMiI7DQorCQkJCXJlZyA9IDwweDUzPjsN
CisJCQl9Ow0KKw0KKwkJCXBvd2VyLW1vbml0b3JANDAgew0KKwkJCQljb21wYXRpYmxlID0gInRp
LGluYTIyMCI7DQorCQkJCXJlZyA9IDwweDQwPjsNCisJCQkJc2h1bnQtcmVzaXN0b3IgPSA8MTAw
MD47DQorCQkJfTsNCisNCisJCQlydGNANTEgew0KKwkJCQljb21wYXRpYmxlID0gIm54cCxwY2Yy
MTI5IjsNCisJCQkJcmVnID0gPDB4NTE+Ow0KKwkJCX07DQorDQorCQkJdGVtcGVyYXR1cmUtc2Vu
c29yQDRjIHsNCisJCQkJY29tcGF0aWJsZSA9ICJueHAsc2E1NjAwNCI7DQorCQkJCXJlZyA9IDww
eDRjPjsNCisJCQkJdmNjLXN1cHBseSA9IDwmc2JfM3YzPjsNCisJCQl9Ow0KKw0KKwkJfTsNCisJ
fTsNCit9Ow0KKw0KKyZpZmMgew0KKwkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCisJI3NpemUtY2Vs
bHMgPSA8MT47DQorCS8qIE5BTkQgRmxhc2ggKi8NCisJcmFuZ2VzID0gPDB4MCAweDAgMHgwIDB4
N2U4MDAwMDAgMHgwMDAxMDAwMD47DQorCXN0YXR1cyA9ICJva2F5IjsNCisNCisJbmFuZEAwLDAg
ew0KKwkJY29tcGF0aWJsZSA9ICJmc2wsaWZjLW5hbmQiOw0KKwkJI2FkZHJlc3MtY2VsbHMgPSA8
MT47DQorCQkjc2l6ZS1jZWxscyA9IDwxPjsNCisJCXJlZyA9IDwweDAgMHgwIDB4MTAwMDA+Ow0K
Kwl9Ow0KKw0KK307DQorDQorI2luY2x1ZGUgImZzbC1sczEwNDYtcG9zdC5kdHNpIg0KKw0KKyZm
bWFuMCB7DQorCWV0aGVybmV0QGUwMDAwIHsNCisJCXBoeS1oYW5kbGUgPSA8JnFzZ21paV9waHk0
PjsNCisJCXBoeS1jb25uZWN0aW9uLXR5cGUgPSAicXNnbWlpIjsNCisJfTsNCisNCisJZXRoZXJu
ZXRAZTgwMDAgew0KKwkJcGh5LWhhbmRsZSA9IDwmcXNnbWlpX3BoeTI+Ow0KKwkJcGh5LWNvbm5l
Y3Rpb24tdHlwZSA9ICJxc2dtaWkiOw0KKwl9Ow0KKw0KKwlldGhlcm5ldEBlYTAwMCB7DQorCQlw
aHktaGFuZGxlID0gPCZxc2dtaWlfcGh5MT47DQorCQlwaHktY29ubmVjdGlvbi10eXBlID0gInFz
Z21paSI7DQorCX07DQorDQorCWV0aGVybmV0QGYyMDAwIHsNCisJCXBoeS1oYW5kbGUgPSA8JnFz
Z21paV9waHkzPjsNCisJCXBoeS1jb25uZWN0aW9uLXR5cGUgPSAicXNnbWlpIjsNCisJfTsNCisN
CisJbWRpb0BmZDAwMCB7DQorCQlxc2dtaWlfcGh5MTogZXRoZXJuZXQtcGh5QDFjIHsNCisJCQly
ZWcgPSA8MHgxYz47DQorCQl9Ow0KKw0KKwkJcXNnbWlpX3BoeTI6IGV0aGVybmV0LXBoeUAxZCB7
DQorCQkJcmVnID0gPDB4MWQ+Ow0KKwkJfTsNCisNCisJCXFzZ21paV9waHkzOiBldGhlcm5ldC1w
aHlAMWUgew0KKwkJCXJlZyA9IDwweDFlPjsNCisJCX07DQorDQorCQlxc2dtaWlfcGh5NDogZXRo
ZXJuZXQtcGh5QDFmIHsNCisJCQlyZWcgPSA8MHgxZj47DQorCQl9Ow0KKwl9Ow0KK307DQotLSAN
CjIuMTcuMQ0KDQo=
