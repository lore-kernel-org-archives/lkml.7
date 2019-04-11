Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1975FC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:54:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC90D20850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 05:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="GT7TWiiD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDKFyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 01:54:32 -0400
Received: from mail-eopbgr130083.outbound.protection.outlook.com ([40.107.13.83]:42151
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726686AbfDKFyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 01:54:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51Vzfp04Epz7DGAAxjZY4Szn0Da+XZMAW8XtRTOuccc=;
 b=GT7TWiiDZVzQGbM6Vs8xhf7zgr7EFZPKtw1oxQKysLrC4R+6qjk3fzwgUMaL6Z1G1WzqPiGwK1zcFhgmId6wvv6vzSe6BLXBpSNgzEbSS8Gb0wW4wTveDHQSHmBO4IBd/43viYS3tkoPfLsf+TfZPGVsMHRsceVk5NbfIZfjZB8=
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com (20.178.94.211) by
 AM6PR06MB5365.eurprd06.prod.outlook.com (20.178.90.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.15; Thu, 11 Apr 2019 05:54:14 +0000
Received: from AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476]) by AM6PR06MB5557.eurprd06.prod.outlook.com
 ([fe80::c0b4:b693:fdc7:e476%4]) with mapi id 15.20.1792.009; Thu, 11 Apr 2019
 05:54:14 +0000
From:   Han Nandor <nandor.han@vaisala.com>
To:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Han Nandor <nandor.han@vaisala.com>
Subject: [PATCH v2 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Thread-Topic: [PATCH v2 2/2] dt-bindings: power: reset: add document for NVMEM
 based reboot-mode
Thread-Index: AQHU8Cr+iJj0KCHfwkqXp/XOBkTwEQ==
Date:   Thu, 11 Apr 2019 05:54:14 +0000
Message-ID: <20190411055341.9263-3-nandor.han@vaisala.com>
References: <20190411055341.9263-1-nandor.han@vaisala.com>
In-Reply-To: <20190411055341.9263-1-nandor.han@vaisala.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0160.eurprd05.prod.outlook.com
 (2603:10a6:7:28::47) To AM6PR06MB5557.eurprd06.prod.outlook.com
 (2603:10a6:20b:9c::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nandor.han@vaisala.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.2
x-originating-ip: [193.143.230.131]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2333f9a6-bb38-41d6-3f9d-08d6be421deb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:AM6PR06MB5365;
x-ms-traffictypediagnostic: AM6PR06MB5365:
x-tenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
x-microsoft-antispam-prvs: <AM6PR06MB536537836721CA6063F8EBF8852F0@AM6PR06MB5365.eurprd06.prod.outlook.com>
x-forefront-prvs: 00046D390F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39850400004)(346002)(376002)(199004)(189003)(2616005)(186003)(6436002)(105586002)(6512007)(6116002)(7736002)(25786009)(3846002)(81156014)(446003)(305945005)(486006)(11346002)(8936002)(53936002)(5660300002)(81166006)(2906002)(71190400001)(71200400001)(50226002)(8676002)(76176011)(66066001)(256004)(99286004)(110136005)(6486002)(107886003)(36756003)(476003)(52116002)(4326008)(106356001)(386003)(97736004)(316002)(102836004)(2201001)(14454004)(6506007)(478600001)(26005)(2501003)(68736007)(1076003)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR06MB5365;H:AM6PR06MB5557.eurprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vaisala.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: w1epZkiE84DMb7kH1370DWydONQrtlSYd5zf0WNDYeKD56K6Hqhs+OIsLFbhb23MknC0KkXiAxowoxdtErBpAszyQhHjxABhY5qldwmuFXnMl82ejb8OQZhil/NZ/NJenpNuWBbaUHEIhUkXo28tc8RKIGgeV3kIKeIlBGvguGPMSXAlJ57+4RaaGa6miBDELY5ZV7sk1XNq7yHiAhMCkJjweTLU7mzqpmcGIDfeOwrLGK9EmaqS+lAqFPekKjNg7qZTg1Rxt+kkPgpa+JkSvxVMqOJCSsV5PFsroZ0IqGvEaGoorM9g5BfkiFfmRqmQXj3pGRqQ4+HU7gHRW/RmYTJ4uYQH1vrr7+4l2Z7xrtg1zCaRcAZdiPoSCoHfTwozgdM7jIwgp6SkrYReUqV2z44dw6+UYM/9pS2NhUcJwAU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2333f9a6-bb38-41d6-3f9d-08d6be421deb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2019 05:54:14.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR06MB5365
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWRkIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5ncyBkb2N1bWVudCBmb3IgdGhlIE5WTUVNIGJhc2Vk
IHJlYm9vdC1tb2RlDQpkcml2ZXIuDQoNClNpZ25lZC1vZmYtYnk6IE5hbmRvciBIYW4gPG5hbmRv
ci5oYW5AdmFpc2FsYS5jb20+DQotLS0NCiAuLi4vcG93ZXIvcmVzZXQvbnZtZW0tcmVib290LW1v
ZGUudHh0ICAgICAgICAgfCAzMiArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQs
IDMyIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1tb2RlLnR4dA0KDQpkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252
bWVtLXJlYm9vdC1tb2RlLnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
b3dlci9yZXNldC9udm1lbS1yZWJvb3QtbW9kZS50eHQNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQpp
bmRleCAwMDAwMDAwMDAwMDAuLjJlMWI4NmMzMWNiMw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1t
b2RlLnR4dA0KQEAgLTAsMCArMSwzMiBAQA0KK05WTUVNIHJlYm9vdCBtb2RlIGRyaXZlcg0KKw0K
K1RoaXMgZHJpdmVyIGdldHMgcmVib290IG1vZGUgbWFnaWMgdmFsdWUgZnJvbSByZWJvb3QtbW9k
ZSBkcml2ZXINCithbmQgc3RvcmVzIGl0IGluIGEgTlZNRU0gY2VsbCBuYW1lZCAicmVib290LW1v
ZGUiLiBUaGVuIHRoZSBib290bG9hZGVyDQorY2FuIHJlYWQgaXQgYW5kIHRha2UgZGlmZmVyZW50
IGFjdGlvbiBhY2NvcmRpbmcgdG8gdGhlIG1hZ2ljDQordmFsdWUgc3RvcmVkLg0KKw0KK1RoaXMg
RFQgbm9kZSBzaG91bGQgYmUgcmVwcmVzZW50ZWQgYXMgYSBzdWItbm9kZSBvZiBhICJzaW1wbGUt
bWZkIg0KK25vZGUuDQorDQorUmVxdWlyZWQgcHJvcGVydGllczoNCistIGNvbXBhdGlibGU6IHNo
b3VsZCBiZSAibnZtZW0tcmVib290LW1vZGUiLg0KKy0gbnZtZW0tY2VsbHM6IEEgcGhhbmRsZSB0
byB0aGUgcmVib290IG1vZGUgcHJvdmlkZWQgYnkgYSBudm1lbSBkZXZpY2UuDQorLSBudm1lbS1j
ZWxsLW5hbWVzOiBTaG91bGQgYmUgInJlYm9vdC1tb2RlIi4NCisNCitUaGUgcmVzdCBvZiB0aGUg
cHJvcGVydGllcyBzaG91bGQgZm9sbG93IHRoZSBnZW5lcmljIHJlYm9vdC1tb2RlIGRlc2NyaXB0
aW9uDQorZm91bmQgaW4gcmVib290LW1vZGUudHh0DQorDQorRXhhbXBsZToNCisJcmVib290LW1v
ZGUtbnZtZW1AMCB7DQorCQljb21wYXRpYmxlID0gInNpbXBsZS1tZmQiOw0KKwkJcmVib290LW1v
ZGUgew0KKwkJCWNvbXBhdGlibGUgPSAibnZtZW0tcmVib290LW1vZGUiOw0KKwkJCW52bWVtLWNl
bGxzID0gPCZyZWJvb3RfbW9kZT47DQorCQkJbnZtZW0tY2VsbC1uYW1lcyA9ICJyZWJvb3QtbW9k
ZSI7DQorDQorCQkJbW9kZS1ub3JtYWwgICAgID0gPDB4QUFBQTU1MDE+Ow0KKwkJCW1vZGUtYm9v
dGxvYWRlciA9IDwweEJCQkI1NTAwPjsNCisJCQltb2RlLXJlY292ZXJ5ICAgPSA8MHhDQ0NDNTUw
Mj47DQorCQkJbW9kZS10ZXN0ICAgICAgID0gPDB4RERERDU1MDM+Ow0KKwkJfTsNCisJfTsNCi0t
IA0KMi4xNy4yDQoNCg==
