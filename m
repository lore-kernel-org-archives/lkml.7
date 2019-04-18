Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03541C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C26214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 03:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="h734a1Bc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbfDRDm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 23:42:29 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:50107
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387442AbfDRDm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 23:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdAiI0A1RB9j71Ek46AlVCou0vgROKLKo5+VjTL5cmM=;
 b=h734a1BcyljkraGQ9Rtu90wY8TXd2VlY9GidcncHHoaXcFyEU690oH+UOiHhejyQE73NacdHRKBcUv5d5l7w06l+DreUKxUh8THJbODJ1uRUEAwi2cFVQ7NuXLWH1xcC6WJqqw0mSypEdQrpeh9guzvqhP3qusFwpF0kZIwBPlI=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2739.eurprd04.prod.outlook.com (10.175.40.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Thu, 18 Apr 2019 03:42:25 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::dd22:eb7e:4dd8:e247]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::dd22:eb7e:4dd8:e247%4]) with mapi id 15.20.1813.011; Thu, 18 Apr 2019
 03:42:25 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] arm64: dts: lx2160a: add cpu idle support
Thread-Topic: [PATCH] arm64: dts: lx2160a: add cpu idle support
Thread-Index: AQHU9Zi8cngNa+O1oU2NiJ6tfBC9CA==
Date:   Thu, 18 Apr 2019 03:42:25 +0000
Message-ID: <20190418034401.26480-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e3d0dc1-479d-406d-c934-08d6c3afdf25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM5PR0402MB2739;
x-ms-traffictypediagnostic: AM5PR0402MB2739:
x-microsoft-antispam-prvs: <AM5PR0402MB27395A1367C044F7DCBB8D73F1260@AM5PR0402MB2739.eurprd04.prod.outlook.com>
x-forefront-prvs: 0011612A55
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(366004)(396003)(39850400004)(189003)(199004)(305945005)(99286004)(486006)(81156014)(386003)(6116002)(54906003)(2616005)(86362001)(102836004)(6506007)(52116002)(3846002)(97736004)(8676002)(81166006)(1076003)(25786009)(6436002)(4326008)(6486002)(26005)(68736007)(256004)(478600001)(66066001)(36756003)(316002)(7736002)(53936002)(14444005)(5660300002)(50226002)(186003)(14454004)(71200400001)(71190400001)(2906002)(8936002)(476003)(6916009)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2739;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XkjPJbUkIRU5uUAMzelxUJW6vF1+eWcCtZRnRIjt4AfsvzqkAaopb1UCa3/1Nm8+u7YjTMW5CAw/EIAq/krxML9gDyZyg1YVayUiCkezfqhx9+/mnaeWXqqQwqQvpP2OqGiNtcLcskPaDwlNFRx5MDIb6D69Y2sYbiQyVi/KD1Lr4Maf3l5cL7aq/nazfr4K4dEzX1bxRw0aH4WHzjYMmcxtjEHGKsa8xYkn/E9mzKVaP6ka68kIRjW2cLgpmZu5UwtT61Xd0gKo3y4Iij4/m+BEcoKYu0dQh69w3k1rvi0wGrxb9SpOcqEMTzltjmUW6eFVwMmAWhmwBONi5elhvpdkvhZGhTJKKlE0CXDbljuU4RATfvaTBOnFXZR/18zTiSALPmdpS9ZmPGYyqlCIxCT02r5WnDsCqqDrbQtrpKc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3d0dc1-479d-406d-c934-08d6c3afdf25
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2019 03:42:25.2764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2739
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bHgyMTYwYSBzdXBwb3J0cyBwdzIwIHdoaWNoIGNvdWxkIGhlbHAgc2F2ZSBtb3JlIHBvd2VyIGR1
cmluZyBjcHUgaXMNCmRpbGUuIEl0IG5lZWRzIHN5c3RlbSBmaXJtd2FyZSBzdXBwb3J0IHZpYSBQ
U0NJLg0KDQpTaWduZWQtb2ZmLWJ5OiBSYW4gV2FuZyA8cmFuLndhbmdfMUBueHAuY29tPg0KLS0t
DQogYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSB8ICAgMjUg
KysrKysrKysrKysrKysrKysrKysrKysrDQogMSBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25z
KCspLCAwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjBhLmR0c2kNCmluZGV4IGZlODcyMDQuLjFlMDcxNTUgMTAwNjQ0DQotLS0gYS9h
cmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQorKysgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS5kdHNpDQpAQCAtMzMsNiArMzMs
NyBAQA0KIAkJCWktY2FjaGUtbGluZS1zaXplID0gPDY0PjsNCiAJCQlpLWNhY2hlLXNldHMgPSA8
MTkyPjsNCiAJCQluZXh0LWxldmVsLWNhY2hlID0gPCZjbHVzdGVyMF9sMj47DQorCQkJY3B1LWlk
bGUtc3RhdGVzID0gPCZjcHVfcHcyMD47DQogCQl9Ow0KIA0KIAkJY3B1QDEgew0KQEAgLTQ4LDYg
KzQ5LDcgQEANCiAJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQogCQkJaS1jYWNoZS1zZXRz
ID0gPDE5Mj47DQogCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmY2x1c3RlcjBfbDI+Ow0KKwkJCWNw
dS1pZGxlLXN0YXRlcyA9IDwmY3B1X3B3MjA+Ow0KIAkJfTsNCiANCiAJCWNwdUAxMDAgew0KQEAg
LTYzLDYgKzY1LDcgQEANCiAJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQogCQkJaS1jYWNo
ZS1zZXRzID0gPDE5Mj47DQogCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmY2x1c3RlcjFfbDI+Ow0K
KwkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmY3B1X3B3MjA+Ow0KIAkJfTsNCiANCiAJCWNwdUAxMDEg
ew0KQEAgLTc4LDYgKzgxLDcgQEANCiAJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQogCQkJ
aS1jYWNoZS1zZXRzID0gPDE5Mj47DQogCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmY2x1c3RlcjFf
bDI+Ow0KKwkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmY3B1X3B3MjA+Ow0KIAkJfTsNCiANCiAJCWNw
dUAyMDAgew0KQEAgLTkzLDYgKzk3LDcgQEANCiAJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47
DQogCQkJaS1jYWNoZS1zZXRzID0gPDE5Mj47DQogCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmY2x1
c3RlcjJfbDI+Ow0KKwkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmY3B1X3B3MjA+Ow0KIAkJfTsNCiAN
CiAJCWNwdUAyMDEgew0KQEAgLTEwOCw2ICsxMTMsNyBAQA0KIAkJCWktY2FjaGUtbGluZS1zaXpl
ID0gPDY0PjsNCiAJCQlpLWNhY2hlLXNldHMgPSA8MTkyPjsNCiAJCQluZXh0LWxldmVsLWNhY2hl
ID0gPCZjbHVzdGVyMl9sMj47DQorCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZjcHVfcHcyMD47DQog
CQl9Ow0KIA0KIAkJY3B1QDMwMCB7DQpAQCAtMTIzLDYgKzEyOSw3IEBADQogCQkJaS1jYWNoZS1s
aW5lLXNpemUgPSA8NjQ+Ow0KIAkJCWktY2FjaGUtc2V0cyA9IDwxOTI+Ow0KIAkJCW5leHQtbGV2
ZWwtY2FjaGUgPSA8JmNsdXN0ZXIzX2wyPjsNCisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JmNwdV9w
dzIwPjsNCiAJCX07DQogDQogCQljcHVAMzAxIHsNCkBAIC0xMzgsNiArMTQ1LDcgQEANCiAJCQlp
LWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQogCQkJaS1jYWNoZS1zZXRzID0gPDE5Mj47DQogCQkJ
bmV4dC1sZXZlbC1jYWNoZSA9IDwmY2x1c3RlcjNfbDI+Ow0KKwkJCWNwdS1pZGxlLXN0YXRlcyA9
IDwmY3B1X3B3MjA+Ow0KIAkJfTsNCiANCiAJCWNwdUA0MDAgew0KQEAgLTE1Myw2ICsxNjEsNyBA
QA0KIAkJCWktY2FjaGUtbGluZS1zaXplID0gPDY0PjsNCiAJCQlpLWNhY2hlLXNldHMgPSA8MTky
PjsNCiAJCQluZXh0LWxldmVsLWNhY2hlID0gPCZjbHVzdGVyNF9sMj47DQorCQkJY3B1LWlkbGUt
c3RhdGVzID0gPCZjcHVfcHcyMD47DQogCQl9Ow0KIA0KIAkJY3B1QDQwMSB7DQpAQCAtMTY4LDYg
KzE3Nyw3IEBADQogCQkJaS1jYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0KIAkJCWktY2FjaGUtc2V0
cyA9IDwxOTI+Ow0KIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JmNsdXN0ZXI0X2wyPjsNCisJCQlj
cHUtaWRsZS1zdGF0ZXMgPSA8JmNwdV9wdzIwPjsNCiAJCX07DQogDQogCQljcHVANTAwIHsNCkBA
IC0xODMsNiArMTkzLDcgQEANCiAJCQlpLWNhY2hlLWxpbmUtc2l6ZSA9IDw2ND47DQogCQkJaS1j
YWNoZS1zZXRzID0gPDE5Mj47DQogCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmY2x1c3RlcjVfbDI+
Ow0KKwkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmY3B1X3B3MjA+Ow0KIAkJfTsNCiANCiAJCWNwdUA1
MDEgew0KQEAgLTE5OCw2ICsyMDksNyBAQA0KIAkJCWktY2FjaGUtbGluZS1zaXplID0gPDY0PjsN
CiAJCQlpLWNhY2hlLXNldHMgPSA8MTkyPjsNCiAJCQluZXh0LWxldmVsLWNhY2hlID0gPCZjbHVz
dGVyNV9sMj47DQorCQkJY3B1LWlkbGUtc3RhdGVzID0gPCZjcHVfcHcyMD47DQogCQl9Ow0KIA0K
IAkJY3B1QDYwMCB7DQpAQCAtMjEzLDYgKzIyNSw3IEBADQogCQkJaS1jYWNoZS1saW5lLXNpemUg
PSA8NjQ+Ow0KIAkJCWktY2FjaGUtc2V0cyA9IDwxOTI+Ow0KIAkJCW5leHQtbGV2ZWwtY2FjaGUg
PSA8JmNsdXN0ZXI2X2wyPjsNCisJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JmNwdV9wdzIwPjsNCiAJ
CX07DQogDQogCQljcHVANjAxIHsNCkBAIC0yMjgsNiArMjQxLDcgQEANCiAJCQlpLWNhY2hlLWxp
bmUtc2l6ZSA9IDw2ND47DQogCQkJaS1jYWNoZS1zZXRzID0gPDE5Mj47DQogCQkJbmV4dC1sZXZl
bC1jYWNoZSA9IDwmY2x1c3RlcjZfbDI+Ow0KKwkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmY3B1X3B3
MjA+Ow0KIAkJfTsNCiANCiAJCWNwdUA3MDAgew0KQEAgLTI0Myw2ICsyNTcsNyBAQA0KIAkJCWkt
Y2FjaGUtbGluZS1zaXplID0gPDY0PjsNCiAJCQlpLWNhY2hlLXNldHMgPSA8MTkyPjsNCiAJCQlu
ZXh0LWxldmVsLWNhY2hlID0gPCZjbHVzdGVyN19sMj47DQorCQkJY3B1LWlkbGUtc3RhdGVzID0g
PCZjcHVfcHcyMD47DQogCQl9Ow0KIA0KIAkJY3B1QDcwMSB7DQpAQCAtMjU4LDYgKzI3Myw3IEBA
DQogCQkJaS1jYWNoZS1saW5lLXNpemUgPSA8NjQ+Ow0KIAkJCWktY2FjaGUtc2V0cyA9IDwxOTI+
Ow0KIAkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JmNsdXN0ZXI3X2wyPjsNCisJCQljcHUtaWRsZS1z
dGF0ZXMgPSA8JmNwdV9wdzIwPjsNCiAJCX07DQogDQogCQljbHVzdGVyMF9sMjogbDItY2FjaGUw
IHsNCkBAIC0zMjMsNiArMzM5LDE1IEBADQogCQkJY2FjaGUtc2V0cyA9IDwxMDI0PjsNCiAJCQlj
YWNoZS1sZXZlbCA9IDwyPjsNCiAJCX07DQorDQorCQljcHVfcHcyMDogY3B1LXB3MjAgew0KKwkJ
CWNvbXBhdGlibGUgPSAiYXJtLGlkbGUtc3RhdGUiOw0KKwkJCWlkbGUtc3RhdGUtbmFtZSA9ICJQ
VzIwIjsNCisJCQlhcm0scHNjaS1zdXNwZW5kLXBhcmFtID0gPDB4MD47DQorCQkJZW50cnktbGF0
ZW5jeS11cyA9IDwyMDAwPjsNCisJCQlleGl0LWxhdGVuY3ktdXMgPSA8MjAwMD47DQorCQkJbWlu
LXJlc2lkZW5jeS11cyA9IDw2MDAwPjsNCisJCSAgfTsNCiAJfTsNCiANCiAJZ2ljOiBpbnRlcnJ1
cHQtY29udHJvbGxlckA2MDAwMDAwIHsNCi0tIA0KMS43LjENCg0K
