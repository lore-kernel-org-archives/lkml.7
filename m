Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87894C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8CB2089E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 08:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DjFM97V/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfDZIFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 04:05:43 -0400
Received: from mail-eopbgr50045.outbound.protection.outlook.com ([40.107.5.45]:7942
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbfDZIFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 04:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gnRKarNhddCU1AORDzZBs5G9ScPkPlar0EDir6cOQZA=;
 b=DjFM97V/9i5/zUijR2drgMyovCpohKg3gzY8G/f97QmVA+spFW87af/VvwVlpsAVZaob1XxSKIc20ivd69yrCZPQ8o3N/3Q0ez5CK5HK2SeDCcZrMn1ZYw4cdlrjEIEUPnqkde2z/ZKoqFMOqEm0F03VbwckT5xaQWSk1pgdSg8=
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com (20.177.55.90) by
 VI1PR04MB6109.eurprd04.prod.outlook.com (20.179.26.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Fri, 26 Apr 2019 08:05:16 +0000
Received: from VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525]) by VI1PR04MB4543.eurprd04.prod.outlook.com
 ([fe80::5d07:911b:18e1:1525%4]) with mapi id 15.20.1835.010; Fri, 26 Apr 2019
 08:05:16 +0000
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
Subject: [PATCH v2 02/15] Revert "ARM: dts: imx6: Use correct SDMA script for
 SPI cores"
Thread-Topic: [PATCH v2 02/15] Revert "ARM: dts: imx6: Use correct SDMA script
 for SPI cores"
Thread-Index: AQHU/AbI2t/VYbMnRUOBzhzbVAbAYQ==
Date:   Fri, 26 Apr 2019 08:05:16 +0000
Message-ID: <1556265512-9130-3-git-send-email-yibin.gong@nxp.com>
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
x-ms-office365-filtering-correlation-id: 962ed4a7-ba07-42f4-00d3-08d6ca1deae7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB6109;
x-ms-traffictypediagnostic: VI1PR04MB6109:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <VI1PR04MB6109C654899E7E3CE1874975893E0@VI1PR04MB6109.eurprd04.prod.outlook.com>
x-forefront-prvs: 001968DD50
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(366004)(376002)(39860400002)(189003)(199004)(68736007)(478600001)(110136005)(99286004)(186003)(53936002)(102836004)(76176011)(25786009)(386003)(6506007)(2501003)(4326008)(6306002)(52116002)(446003)(11346002)(6512007)(97736004)(26005)(486006)(316002)(2616005)(476003)(7736002)(54906003)(71190400001)(305945005)(71200400001)(14444005)(256004)(14454004)(2906002)(7416002)(8676002)(81156014)(81166006)(36756003)(6486002)(8936002)(50226002)(66946007)(66476007)(66556008)(64756008)(66066001)(66446008)(2201001)(6436002)(86362001)(6116002)(5660300002)(3846002)(73956011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6109;H:VI1PR04MB4543.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rbwBZ1ei+C0gKH+zCsZfIukIb5N1VAQwYZDoahifuwTf6m5H+QIro4S7oxDsJ3A5URO4jUgPfvXTQ7m2OcJ+IHMenWMp6hWrnSpL3vGZMmmonhZNu0A/jTHCC1JESmknv+0iBNyRHfkq7iZsPCZ0QACP0+jfrFMPtrM9ecJoMV7sx1qAMi/erdHmCGYhq+hzh6RW9Kj/RQuXqKK7EoNIEfZdBuoR1VkL742G3RfWZe7grWJL2E7RyrNuQ1UWwsD13oj5IK7NsHuo0HBujOX9RcKqDZxhHVNeaQuqCLxTmhUkCkoYZP4txgPI2QhOIIW59Q20tsqkRk/B278S/CoCL1YXGiLxdSY5vgdK0fBfPPSAcjLmJ1gFnna9Kba+ljAkHzs/nJw8OFBt+qkxPSRb3842Y2Af9uhbWGu//L8WUN4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962ed4a7-ba07-42f4-00d3-08d6ca1deae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2019 08:05:16.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ICBUaGVyZSBhcmUgdHdvIHdheXMgZm9yIFNETUEgYWNjZXNzaW5nIFNQQkEgZGV2aWNlczogb25l
IGlzIFNETUEtPkFJUFMNCi0+U1BCQShtYXN0ZXJBIHBvcnQpLCBhbm90aGVyIGlzIFNETUEtPlNQ
QkEobWFzdGVyQyBwb3J0KS4gUGxlYXNlIHJlZmVyDQp0byB0aGUgJ0ZpZ3VyZSA1OC0xLiBpLk1Y
IDZEdWFsLzZRdWFkIFNQQkEgY29ubmVjdGl2aXR5JyBvZiBpLm14NkRRDQpSZWZlcmVuY2UgTWFu
dWFsLiBTRE1BIHByb3ZpZGUgdGhlIGNvcnJlc3BvbmRpbmcgYXBwXzJfbWN1L21jdV8yX2FwcCBh
bmQNCnNocF8yX21jdS9tY3VfMl9zaHAgc2NyaXB0IGZvciBzdWNoIHR3byBvcHRpb25zLiBTbyBi
b3RoIEFJUFMgYW5kIFNQQkENCnNjcmlwdHMgc2hvdWxkIGtlZXAgdGhlIHNhbWUgYmVoYXZpb3Vy
LCB0aGUgaXNzdWUgb25seSBjYXVnaHQgaW4gQUlQUw0Kc2NyaXB0IHNvdW5kcyBub3Qgc29saWRl
Lg0KICBUaGUgaXNzdWUgaXMgbW9yZSBsaWtlbHkgYXMgdGhlIGVjc3BpIGVycmF0YQ0KRVJSMDA5
MTY1KGh0dHA6Ly93d3cubnhwLmNvbS9kb2NzL2VuL2VycmF0YS9JTVg2RFFDRS5wZGYpOg0KZUNT
UEk6IFRYRklGTyBlbXB0eSBmbGFnIGdsaXRjaCBjYW4gY2F1c2UgdGhlIGN1cnJlbnQgRklGTyB0
cmFuc2ZlciB0bw0KICAgICAgICAgICBiZSBzZW50IHR3aWNlDQpTbyByZXZlcnQgY29tbWl0ICdk
ZDRiNDg3YjMyYTMnIGZpcnN0bHkuDQoNClNpZ25lZC1vZmYtYnk6IFJvYmluIEdvbmcgPHlpYmlu
LmdvbmdAbnhwLmNvbT4NCi0tLQ0KIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZxZGwuZHRzaSB8IDgg
KysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpIGIvYXJjaC9h
cm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQppbmRleCBiM2E3N2JjLi5hOTBmMjE3IDEwMDY0NA0K
LS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFkbC5kdHNpDQorKysgYi9hcmNoL2FybS9ib290
L2R0cy9pbXg2cWRsLmR0c2kNCkBAIC0zMzksNyArMzM5LDcgQEANCiAJCQkJCWNsb2NrcyA9IDwm
Y2xrcyBJTVg2UURMX0NMS19FQ1NQSTE+LA0KIAkJCQkJCSA8JmNsa3MgSU1YNlFETF9DTEtfRUNT
UEkxPjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJwZXIiOw0KLQkJCQkJZG1hcyA9IDwm
c2RtYSAzIDggMT4sIDwmc2RtYSA0IDggMj47DQorCQkJCQlkbWFzID0gPCZzZG1hIDMgNyAxPiwg
PCZzZG1hIDQgNyAyPjsNCiAJCQkJCWRtYS1uYW1lcyA9ICJyeCIsICJ0eCI7DQogCQkJCQlzdGF0
dXMgPSAiZGlzYWJsZWQiOw0KIAkJCQl9Ow0KQEAgLTM1Myw3ICszNTMsNyBAQA0KIAkJCQkJY2xv
Y2tzID0gPCZjbGtzIElNWDZRRExfQ0xLX0VDU1BJMj4sDQogCQkJCQkJIDwmY2xrcyBJTVg2UURM
X0NMS19FQ1NQSTI+Ow0KIAkJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgInBlciI7DQotCQkJCQlk
bWFzID0gPCZzZG1hIDUgOCAxPiwgPCZzZG1hIDYgOCAyPjsNCisJCQkJCWRtYXMgPSA8JnNkbWEg
NSA3IDE+LCA8JnNkbWEgNiA3IDI+Ow0KIAkJCQkJZG1hLW5hbWVzID0gInJ4IiwgInR4IjsNCiAJ
CQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJCX07DQpAQCAtMzY3LDcgKzM2Nyw3IEBADQog
CQkJCQljbG9ja3MgPSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEkzPiwNCiAJCQkJCQkgPCZjbGtz
IElNWDZRRExfQ0xLX0VDU1BJMz47DQogCQkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAicGVyIjsN
Ci0JCQkJCWRtYXMgPSA8JnNkbWEgNyA4IDE+LCA8JnNkbWEgOCA4IDI+Ow0KKwkJCQkJZG1hcyA9
IDwmc2RtYSA3IDcgMT4sIDwmc2RtYSA4IDcgMj47DQogCQkJCQlkbWEtbmFtZXMgPSAicngiLCAi
dHgiOw0KIAkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCQkJfTsNCkBAIC0zODEsNyArMzgx
LDcgQEANCiAJCQkJCWNsb2NrcyA9IDwmY2xrcyBJTVg2UURMX0NMS19FQ1NQSTQ+LA0KIAkJCQkJ
CSA8JmNsa3MgSU1YNlFETF9DTEtfRUNTUEk0PjsNCiAJCQkJCWNsb2NrLW5hbWVzID0gImlwZyIs
ICJwZXIiOw0KLQkJCQkJZG1hcyA9IDwmc2RtYSA5IDggMT4sIDwmc2RtYSAxMCA4IDI+Ow0KKwkJ
CQkJZG1hcyA9IDwmc2RtYSA5IDcgMT4sIDwmc2RtYSAxMCA3IDI+Ow0KIAkJCQkJZG1hLW5hbWVz
ID0gInJ4IiwgInR4IjsNCiAJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQogCQkJCX07DQotLSAN
CjIuNy40DQoNCg==
