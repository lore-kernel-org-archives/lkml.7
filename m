Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50054C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C2321019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 08:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfEUI6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 04:58:45 -0400
Received: from mail-oln040092065044.outbound.protection.outlook.com ([40.92.65.44]:1607
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726347AbfEUI6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 04:58:44 -0400
Received: from DB5EUR01FT032.eop-EUR01.prod.protection.outlook.com
 (10.152.4.51) by DB5EUR01HT177.eop-EUR01.prod.protection.outlook.com
 (10.152.5.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1900.16; Tue, 21 May
 2019 08:58:41 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com (10.152.4.52) by
 DB5EUR01FT032.mail.protection.outlook.com (10.152.4.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1900.16 via Frontend Transport; Tue, 21 May 2019 08:58:41 +0000
Received: from VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3]) by VI1PR07MB4432.eurprd07.prod.outlook.com
 ([fe80::91f:b1bb:a60a:fdc3%7]) with mapi id 15.20.1922.013; Tue, 21 May 2019
 08:58:41 +0000
From:   Philippe Mazenauer <philippe.mazenauer@outlook.de>
CC:     Philippe Mazenauer <philippe.mazenauer@outlook.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: armada-xp: Remove unused variables
Thread-Topic: [PATCH] clk: armada-xp: Remove unused variables
Thread-Index: AQHVD7Nie9KlF+wqrEWpZHuBCAHDLg==
Date:   Tue, 21 May 2019 08:58:41 +0000
Message-ID: <VI1PR07MB4432F4F275BC445289FF3D9CFD070@VI1PR07MB4432.eurprd07.prod.outlook.com>
Accept-Language: de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:300:115::34) To VI1PR07MB4432.eurprd07.prod.outlook.com
 (2603:10a6:802:67::17)
x-incomingtopheadermarker: OriginalChecksum:1A525005303F667F3D35DA1E30BBD83622B3654A128FCB34F680D2433E1C6F31;UpperCasedChecksum:9B30A8A8DC83C1A3351497F91C24328BDEBB288FB13FA084AC8DB3F01C1DBD74;SizeAsReceived:7574;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-tmn:  [zKprlb9CT/BjvWHAmUhQAynNjvh/9fzn]
x-microsoft-original-message-id: <20190521085813.4399-1-philippe.mazenauer@outlook.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR01HT177;
x-ms-traffictypediagnostic: DB5EUR01HT177:
x-microsoft-antispam-message-info: Mw0q8NWWDrNWJMjPHyqi8mFXmMQEPhVRmkfWvwKqsmfzQVRk+PHQyQumHhVa9i+zBP8WMmU7oukRN72xmQwNmkUXmlAmaEkdOd7T4AxOPYlzT+KErEBjkf2pBO4RyRMBVH5ImrDrGJ3QmfwS/19vx3n8nBGffh1+xOohAlp157IlxOcGVrwvfY36z/u9wHSG
Content-Type: text/plain; charset="utf-8"
Content-ID: <E271F5C32003734582199585E9CFAEC7@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b20b9785-8699-4620-3d35-08d6ddca8511
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 08:58:41.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR01HT177
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VmFyaWFibGVzICdtdjk4ZHgzMjM2X2dhdGluZ19kZXNjJyBhbmQgJ212OThkeDMyMzZfY29yZWNs
a3MnIGFyZQ0KZGVjbGFyZWQgc3RhdGljIGFuZCBpbml0aWFsaXplZCwgYnV0IGFyZSBub3QgdXNl
ZCBpbiB0aGUgZmlsZS4NCg0KLi4vZHJpdmVycy9jbGsvbXZlYnUvYXJtYWRhLXhwLmM6MjEzOjQx
OiB3YXJuaW5nOiDigJhtdjk4ZHgzMjM2X2dhdGluZ19kZXNj4oCZIGRlZmluZWQgYnV0IG5vdCB1
c2VkIFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dDQogc3RhdGljIGNvbnN0IHN0cnVjdCBjbGtf
Z2F0aW5nX3NvY19kZXNjIG12OThkeDMyMzZfZ2F0aW5nX2Rlc2NbXSBfX2luaXRjb25zdCA9IHsN
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fg0KLi4vZHJpdmVycy9jbGsvbXZlYnUvYXJtYWRhLXhwLmM6MTcxOjM4OiB3YXJuaW5n
OiDigJhtdjk4ZHgzMjM2X2NvcmVjbGtz4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFstV3VudXNl
ZC1jb25zdC12YXJpYWJsZT1dDQogc3RhdGljIGNvbnN0IHN0cnVjdCBjb3JlY2xrX3NvY19kZXNj
IG12OThkeDMyMzZfY29yZWNsa3MgPSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn4NCg0KU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF6
ZW5hdWVyIDxwaGlsaXBwZS5tYXplbmF1ZXJAb3V0bG9vay5kZT4NCi0tLQ0KIGRyaXZlcnMvY2xr
L212ZWJ1L2FybWFkYS14cC5jIHwgMTQgLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwg
MTQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tdmVidS9hcm1hZGEt
eHAuYyBiL2RyaXZlcnMvY2xrL212ZWJ1L2FybWFkYS14cC5jDQppbmRleCBmYTE1NjgyNzljMjMu
LjJhZTI0YTVkZWJkMCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvY2xrL212ZWJ1L2FybWFkYS14cC5j
DQorKysgYi9kcml2ZXJzL2Nsay9tdmVidS9hcm1hZGEteHAuYw0KQEAgLTE2OCwxMSArMTY4LDYg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBjb3JlY2xrX3NvY19kZXNjIGF4cF9jb3JlY2xrcyA9IHsN
CiAJLm51bV9yYXRpb3MgPSBBUlJBWV9TSVpFKGF4cF9jb3JlY2xrX3JhdGlvcyksDQogfTsNCiAN
Ci1zdGF0aWMgY29uc3Qgc3RydWN0IGNvcmVjbGtfc29jX2Rlc2MgbXY5OGR4MzIzNl9jb3JlY2xr
cyA9IHsNCi0JLmdldF90Y2xrX2ZyZXEgPSBtdjk4ZHgzMjM2X2dldF90Y2xrX2ZyZXEsDQotCS5n
ZXRfY3B1X2ZyZXEgPSBtdjk4ZHgzMjM2X2dldF9jcHVfZnJlcSwNCi19Ow0KLQ0KIC8qDQogICog
Q2xvY2sgR2F0aW5nIENvbnRyb2wNCiAgKi8NCkBAIC0yMTAsMTUgKzIwNSw2IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgY2xrX2dhdGluZ19zb2NfZGVzYyBheHBfZ2F0aW5nX2Rlc2NbXSBfX2luaXRj
b25zdCA9IHsNCiAJeyB9DQogfTsNCiANCi1zdGF0aWMgY29uc3Qgc3RydWN0IGNsa19nYXRpbmdf
c29jX2Rlc2MgbXY5OGR4MzIzNl9nYXRpbmdfZGVzY1tdIF9faW5pdGNvbnN0ID0gew0KLQl7ICJn
ZTEiLCBOVUxMLCAzLCAwIH0sDQotCXsgImdlMCIsIE5VTEwsIDQsIDAgfSwNCi0JeyAicGV4MDAi
LCBOVUxMLCA1LCAwIH0sDQotCXsgInNkaW8iLCBOVUxMLCAxNywgMCB9LA0KLQl7ICJ4b3IwIiwg
TlVMTCwgMjIsIDAgfSwNCi0JeyB9DQotfTsNCi0NCiBzdGF0aWMgdm9pZCBfX2luaXQgYXhwX2Ns
a19pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApDQogew0KIAlzdHJ1Y3QgZGV2aWNlX25vZGUg
KmNnbnAgPQ0KLS0gDQoyLjE3LjENCg0K
