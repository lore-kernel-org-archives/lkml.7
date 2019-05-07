Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA749C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF3520C01
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 06:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qLQnx9/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfEGGeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 02:34:50 -0400
Received: from mail-eopbgr150088.outbound.protection.outlook.com ([40.107.15.88]:37091
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbfEGGeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 02:34:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIqFKo67j1OLxemIF4EVaarhth6Ewg64aY1XCv684qM=;
 b=qLQnx9/GemTcvcQ5HlvMYxe9/NUOwHyppcdnIZ9fN+gCCQX70E0yZy05W6KWIvf6yRQHyvOXZX3zj4ZEeYR1VvlsGk/Ec0C+Rh0MQUqi87SnTkzTLJBsrKASijN3VU4s3lR2AlZeWMuWwvplqQUe6ybMeZMGmz9RIDvYaZYVyt0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3771.eurprd04.prod.outlook.com (52.134.67.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Tue, 7 May 2019 06:34:37 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1856.012; Tue, 7 May 2019
 06:34:37 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 5/5] ARM: dts: imx6sx-sdb: Assign corresponding power supply
 for LDOs
Thread-Topic: [PATCH 5/5] ARM: dts: imx6sx-sdb: Assign corresponding power
 supply for LDOs
Thread-Index: AQHVBJ7x3Esw4lVUTkihnrtILND7+A==
Date:   Tue, 7 May 2019 06:34:37 +0000
Message-ID: <1557210565-4457-5-git-send-email-Anson.Huang@nxp.com>
References: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1557210565-4457-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0014.apcprd03.prod.outlook.com
 (2603:1096:202::24) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec7518c3-9aad-44f7-9d74-08d6d2b6139d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3771;
x-ms-traffictypediagnostic: DB3PR0402MB3771:
x-microsoft-antispam-prvs: <DB3PR0402MB3771DD4275776C817075EEB4F5310@DB3PR0402MB3771.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0030839EEE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39860400002)(376002)(346002)(136003)(189003)(199004)(6486002)(66066001)(68736007)(26005)(386003)(6506007)(186003)(102836004)(86362001)(11346002)(2616005)(446003)(76176011)(110136005)(14454004)(316002)(2201001)(52116002)(2501003)(5660300002)(99286004)(6116002)(2906002)(3846002)(4326008)(6512007)(6436002)(476003)(486006)(25786009)(36756003)(256004)(53936002)(305945005)(66476007)(66556008)(64756008)(66446008)(50226002)(478600001)(81156014)(81166006)(8676002)(8936002)(71190400001)(7736002)(73956011)(66946007)(71200400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3771;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B5UCuCV/Szp/u3iRvgm8rZhX6jHLVMdlCarDfKrAqdAqxYQW8RAeQpCPPcDu1faz1QQcrCy8/KlD7C+HDJQ/bsaR99A7l/fxhIqh4JnMMBshzOYYYqjZ3KVGVIVRgb5ZnkHieNC7Dd/AWrC75hz6TVEXpmVyj2cDpdwap+ONWOG2RFgOs78aXBKD2rLlXvqfMDYE7GD+iywKsUVYcKPX9YIcJFcoQzsiTB7DXhQkTXhi/fUCbFyAmbNiQsv1yY46YebdN1VinU07KA8fkzz36cN6WM11OjRrat4nUxREdljQojtFoh3F87QcajksyLYhdJ4LTfLY66GsPrZKa0vRFBZzwaGSne+SP75IJWB+bkgjZTnMIWQ2oLZyxRxYtBlcjexUo8klW6HQjNJDe9qUYOZDH2IpxOy7vpMZg+YjTJ4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7518c3-9aad-44f7-9d74-08d6d2b6139d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2019 06:34:37.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3771
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gaS5NWDZTWCBTREIgYm9hcmQsIHZnZW42IHN1cHBsaWVzIHZkZDFwMS92ZGQycDUgTERPIGFu
ZA0Kc3cyIHN1cHBsaWVzIHZkZDNwMCBMRE8sIHRoaXMgcGF0Y2ggYXNzaWducyBjb3JyZXNwb25k
aW5nIHBvd2VyDQpzdXBwbHkgZm9yIHZkZDFwMS92ZGQycDUvdmRkM3AwIHRvIGF2b2lkIGNvbmZ1
c2lvbiBieSBiZWxvdyBsb2c6DQoNCnZkZDFwMTogc3VwcGxpZWQgYnkgcmVndWxhdG9yLWR1bW15
DQp2ZGQzcDA6IHN1cHBsaWVkIGJ5IHJlZ3VsYXRvci1kdW1teQ0KdmRkMnA1OiBzdXBwbGllZCBi
eSByZWd1bGF0b3ItZHVtbXkNCg0KV2l0aCB0aGlzIHBhdGNoLCB0aGUgcG93ZXIgc3VwcGx5IGlz
IG1vcmUgYWNjdXJhdGU6DQoNCnZkZDFwMTogc3VwcGxpZWQgYnkgVkdFTjYNCnZkZDNwMDogc3Vw
cGxpZWQgYnkgU1cyDQp2ZGQycDU6IHN1cHBsaWVkIGJ5IFZHRU42DQoNClNpZ25lZC1vZmYtYnk6
IEFuc29uIEh1YW5nIDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KLS0tDQogYXJjaC9hcm0vYm9vdC9k
dHMvaW14NnN4LXNkYi1yZXZhLmR0cyB8IDEyICsrKysrKysrKysrKw0KIGFyY2gvYXJtL2Jvb3Qv
ZHRzL2lteDZzeC1zZGIuZHRzICAgICAgfCAxMiArKysrKysrKysrKysNCiBhcmNoL2FybS9ib290
L2R0cy9pbXg2c3guZHRzaSAgICAgICAgIHwgIDYgKysrLS0tDQogMyBmaWxlcyBjaGFuZ2VkLCAy
NyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvaW14NnN4LXNkYi1yZXZhLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC1z
ZGItcmV2YS5kdHMNCmluZGV4IDAwYzQ4NTQuLjViM2Q2YzEwIDEwMDY0NA0KLS0tIGEvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnN4LXNkYi1yZXZhLmR0cw0KKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnN4LXNkYi1yZXZhLmR0cw0KQEAgLTE1NCwzICsxNTQsMTUgQEANCiAJZW5hYmxlLWFjdGl2
ZS1oaWdoOw0KIAl2aW4tc3VwcGx5ID0gPCZyZWdfY2FuX2VuPjsNCiB9Ow0KKw0KKyZyZWdfdmRk
MXAxIHsNCisJdmluLXN1cHBseSA9IDwmdmdlbjZfcmVnPjsNCit9Ow0KKw0KKyZyZWdfdmRkM3Aw
IHsNCisJdmluLXN1cHBseSA9IDwmc3cyX3JlZz47DQorfTsNCisNCismcmVnX3ZkZDJwNSB7DQor
CXZpbi1zdXBwbHkgPSA8JnZnZW42X3JlZz47DQorfTsNCmRpZmYgLS1naXQgYS9hcmNoL2FybS9i
b290L2R0cy9pbXg2c3gtc2RiLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC1zZGIuZHRz
DQppbmRleCA5OThlM2UxLi4xMGY2ZGE4IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMv
aW14NnN4LXNkYi5kdHMNCisrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZzeC1zZGIuZHRzDQpA
QCAtMTM3LDYgKzEzNywxOCBAQA0KIAl2aW4tc3VwcGx5ID0gPCZzdzFhX3JlZz47DQogfTsNCiAN
CismcmVnX3ZkZDFwMSB7DQorCXZpbi1zdXBwbHkgPSA8JnZnZW42X3JlZz47DQorfTsNCisNCism
cmVnX3ZkZDNwMCB7DQorCXZpbi1zdXBwbHkgPSA8JnN3Ml9yZWc+Ow0KK307DQorDQorJnJlZ192
ZGQycDUgew0KKwl2aW4tc3VwcGx5ID0gPCZ2Z2VuNl9yZWc+Ow0KK307DQorDQogJnJlZ19jYW5f
c3RieSB7DQogCS8qIFRyYW5zY2VpdmVyIEVOL1NUQlkgaXMgYWN0aXZlIGxvdyBvbiBSZXZCIGJv
YXJkICovDQogCWdwaW8gPSA8JmdwaW80IDI3IEdQSU9fQUNUSVZFX0xPVz47DQpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnN4LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2
c3guZHRzaQ0KaW5kZXggYjE2YTEyMy4uYmJkZmRkOCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2lteDZzeC5kdHNpDQorKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2c3guZHRzaQ0K
QEAgLTYwMCw3ICs2MDAsNyBAQA0KIAkJCQkJICAgICA8R0lDX1NQSSA1NCBJUlFfVFlQRV9MRVZF
TF9ISUdIPiwNCiAJCQkJCSAgICAgPEdJQ19TUEkgMTI3IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0K
IA0KLQkJCQlyZWd1bGF0b3ItMXAxIHsNCisJCQkJcmVnX3ZkZDFwMTogcmVndWxhdG9yLTFwMSB7
DQogCQkJCQljb21wYXRpYmxlID0gImZzbCxhbmF0b3AtcmVndWxhdG9yIjsNCiAJCQkJCXJlZ3Vs
YXRvci1uYW1lID0gInZkZDFwMSI7DQogCQkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwx
MDAwMDAwPjsNCkBAIC02MTUsNyArNjE1LDcgQEANCiAJCQkJCWFuYXRvcC1lbmFibGUtYml0ID0g
PDA+Ow0KIAkJCQl9Ow0KIA0KLQkJCQlyZWd1bGF0b3ItM3AwIHsNCisJCQkJcmVnX3ZkZDNwMDog
cmVndWxhdG9yLTNwMCB7DQogCQkJCQljb21wYXRpYmxlID0gImZzbCxhbmF0b3AtcmVndWxhdG9y
IjsNCiAJCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZDNwMCI7DQogCQkJCQlyZWd1bGF0b3ItbWlu
LW1pY3Jvdm9sdCA9IDwyODAwMDAwPjsNCkBAIC02MzAsNyArNjMwLDcgQEANCiAJCQkJCWFuYXRv
cC1lbmFibGUtYml0ID0gPDA+Ow0KIAkJCQl9Ow0KIA0KLQkJCQlyZWd1bGF0b3ItMnA1IHsNCisJ
CQkJcmVnX3ZkZDJwNTogcmVndWxhdG9yLTJwNSB7DQogCQkJCQljb21wYXRpYmxlID0gImZzbCxh
bmF0b3AtcmVndWxhdG9yIjsNCiAJCQkJCXJlZ3VsYXRvci1uYW1lID0gInZkZDJwNSI7DQogCQkJ
CQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwyMjUwMDAwPjsNCi0tIA0KMi43LjQNCg0K
