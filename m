Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D03C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE25206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nmXjpJns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfDQMqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:46:36 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:42638
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729898AbfDQMqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Unxz3qhy6j02VZm8kU/DMHeV8z8xKhfQiWUHRYPmGk=;
 b=nmXjpJns2lsCfEkgmXdJ2fNHkHymxqorkP7I9STsw/uFrEAPkcYzjBIlCnarn+QmNhxK363A1SGLsAXt/4vkY+AYxOS3bZygLrdH8zOrKQEi2uugPwDpbosJUvdAaovU6B/Cvp61d8lHNv/4QXlLHByjx02MFjP2jyYpN3ZAbvQ=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3737.eurprd04.prod.outlook.com (52.134.66.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Wed, 17 Apr 2019 12:46:29 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::e8ca:4f6b:e43:c170%3]) with mapi id 15.20.1813.011; Wed, 17 Apr 2019
 12:46:29 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "edubezval@gmail.com" <edubezval@gmail.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "agross@kernel.org" <agross@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V12 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Topic: [PATCH V12 1/5] dt-bindings: fsl: scu: add thermal binding
Thread-Index: AQHU9AOTUGgOS08iR0aOB0ANqNq0mqY/s5cwgACbbSA=
Date:   Wed, 17 Apr 2019 12:46:29 +0000
Message-ID: <DB3PR0402MB3916541587F0F7E4FF099CB0F5250@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1555384609-7030-1-git-send-email-Anson.Huang@nxp.com>
 <AM0PR04MB42118E59E441BE043A3BE54F80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB42118E59E441BE043A3BE54F80250@AM0PR04MB4211.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.69]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d3de21f-2c7a-4c04-595c-08d6c332b668
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600140)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3737;
x-ms-traffictypediagnostic: DB3PR0402MB3737:
x-microsoft-antispam-prvs: <DB3PR0402MB373757428D694747AC8B708DF5250@DB3PR0402MB3737.eurprd04.prod.outlook.com>
x-forefront-prvs: 0010D93EFE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(346002)(366004)(376002)(199004)(189003)(13464003)(478600001)(9686003)(55016002)(76176011)(53936002)(14454004)(6246003)(2201001)(4326008)(229853002)(6436002)(25786009)(68736007)(66066001)(256004)(71200400001)(446003)(71190400001)(486006)(7696005)(86362001)(11346002)(476003)(44832011)(99286004)(186003)(26005)(2906002)(8936002)(74316002)(7416002)(52536014)(6506007)(6116002)(3846002)(53546011)(316002)(102836004)(110136005)(81166006)(305945005)(7736002)(81156014)(8676002)(33656002)(5660300002)(2501003)(97736004)(105586002)(106356001)(21314003)(921003)(1121003)(15866825006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3737;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: j0g0A0JiX0SNLkCxWLEOJDMz52UrRMNm5+r0X6CpW2IytNyGohO2q0taj/c+ySSaqJjyPvJnQpGkZSg0q4rWLxMtobANshDjulSqRfB6NWZYiCsI3k13efla97psRXeM3Sb3LPk2JUL82yaJqiGiTtHqCU40YcJ8UIpXbjgLx4wbjQxRTma1k4f+Z+o/P3VKW2Tm6q155cQM/toXComEesKisQZmQgZfgybt0E5kIUsgn6hJt8ZyFMhfxtbPuYQmfauCjY2x5gyzzjHInr/gB+Msv8pMBW9L69leXnamH5FAcTdasEtKv9rs1s1umQ9iJrw2tmJEqrEEXs8dR12ijYeMghJUA3AGE23UFn+SAttvUow8VxmbY4sFHaeoB0Q+W865KWwfAbV4Kvt/dwEA+nSyjbb56lX+/VeCpBZZiGA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d3de21f-2c7a-4c04-595c-08d6c332b668
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2019 12:46:29.4015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3737
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkJlc3QgUmVnYXJkcyENCkFuc29uIEh1YW5nDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gRnJvbTogQWlzaGVuZyBEb25nDQo+IFNlbnQ6IFdlZG5lc2RheSwgQXByaWwgMTcs
IDIwMTkgMTE6MzIgQU0NCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPjsg
cm9iaCtkdEBrZXJuZWwub3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRl
OyBmZXN0ZXZhbUBnbWFpbC5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRl
YWNvbkBhcm0uY29tOyBydWkuemhhbmdAaW50ZWwuY29tOyBlZHViZXp2YWxAZ21haWwuY29tOw0K
PiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyB1bGYuaGFuc3NvbkBsaW5hcm8ub3JnOyBEYW5p
ZWwgQmFsdXRhDQo+IDxkYW5pZWwuYmFsdXRhQG54cC5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT47DQo+IGhlaWtvQHNudGVjaC5kZTsgaG9ybXMrcmVuZXNhc0B2ZXJnZS5uZXQuYXU7
IGFncm9zc0BrZXJuZWwub3JnOw0KPiBvbG9mQGxpeG9tLm5ldDsgYmpvcm4uYW5kZXJzc29uQGxp
bmFyby5vcmc7IGphZ2FuQGFtYXJ1bGFzb2x1dGlvbnMuY29tOw0KPiBlbnJpYy5iYWxsZXRib0Bj
b2xsYWJvcmEuY29tOyBtYXJjLncuZ29uemFsZXpAZnJlZS5mcjsNCj4gZGV2aWNldHJlZUB2Z2Vy
Lmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4g
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRD
SCBWMTIgMS81XSBkdC1iaW5kaW5nczogZnNsOiBzY3U6IGFkZCB0aGVybWFsIGJpbmRpbmcNCj4g
DQo+ID4gRnJvbTogQW5zb24gSHVhbmcNCj4gPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAxNiwgMjAx
OSAxMToyMiBBTQ0KPiA+DQo+ID4gTlhQIGkuTVg4UVhQIGlzIGFuIEFSTXY4IFNvQyB3aXRoIGEg
Q29ydGV4LU00IGNvcmUgaW5zaWRlIGFzIHN5c3RlbQ0KPiA+IGNvbnRyb2xsZXIsIHRoZSBzeXN0
ZW0gY29udHJvbGxlciBpcyBpbiBjaGFyZ2Ugb2Ygc3lzdGVtIHBvd2VyLCBjbG9jaw0KPiA+IGFu
ZCB0aGVybWFsIHNlbnNvcnMgZXRjLiBtYW5hZ2VtZW50LCBMaW51eCBrZXJuZWwgaGFzIHRvIGNv
bW11bmljYXRlDQo+ID4gd2l0aCBzeXN0ZW0gY29udHJvbGxlciB2aWEgTVUgKG1lc3NhZ2UgdW5p
dCkgSVBDIHRvIGdldCB0ZW1wZXJhdHVyZQ0KPiA+IGZyb20gdGhlcm1hbCBzZW5zb3JzLCB0aGlz
IHBhdGNoIGFkZHMgYmluZGluZyBkb2MgZm9yIGkuTVggc3lzdGVtDQo+IGNvbnRyb2xsZXIgdGhl
cm1hbCBkcml2ZXIuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24u
SHVhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiBObyBjaGFuZ2VzLg0KPiA+IC0tLQ0KPiA+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0ICAgICAgICB8
IDE2DQo+ID4gKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTYgaW5zZXJ0
aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9mcmVlc2NhbGUvZnNsLHNjdS50eHQNCj4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+ID4gaW5k
ZXggNWQ3ZGJhYi4uZjRmYjZkNSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvYXJtL2ZyZWVzY2FsZS9mc2wsc2N1LnR4dA0KPiA+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vZnJlZXNjYWxlL2ZzbCxzY3UudHh0DQo+
ID4gQEAgLTEzMyw2ICsxMzMsMTcgQEAgUlRDIGJpbmRpbmdzIGJhc2VkIG9uIFNDVSBNZXNzYWdl
IFByb3RvY29sDQo+ID4gUmVxdWlyZWQgcHJvcGVydGllczoNCj4gPiAgLSBjb21wYXRpYmxlOiBz
aG91bGQgYmUgImZzbCxpbXg4cXhwLXNjLXJ0YyI7DQo+ID4NCj4gPiArVGhlcm1hbCBiaW5kaW5n
cyBiYXNlZCBvbiBTQ1UgTWVzc2FnZSBQcm90b2NvbA0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArDQo+ID4gK1Jl
cXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0aWJsZToJCQlTaG91bGQgYmUgOg0KPiA+
ICsJCQkJICAiZnNsLGlteDhxeHAtc2MtdGhlcm1hbCINCj4gPiArCQkJCWZvbGxvd2VkIGJ5ICJm
c2wsaW14LXNjLXRoZXJtYWwiOw0KPiA+ICsNCj4gPiArLSAjdGhlcm1hbC1zZW5zb3ItY2VsbHM6
CVNlZQ0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy90aGVybWFsL3RoZXJt
YWwudHh0DQo+ID4gKwkJCQlmb3IgYSBkZXNjcmlwdGlvbi4NCj4gDQo+IEJldHRlciB0byBoYXZl
IGFuIGV4cGxpY2l0IHZhbHVlIGhlcmUuDQo+IGUuZy4NCj4gTXVzdCBiZSAxLiBTZWUgeHh4IGZv
ciBhIGRlc2NyaXB0aW9uLg0KDQpPSywgd2lsbCBhZGQgaXQgaW4gbmV4dCB2ZXJzaW9uLg0KDQpB
bnNvbi4NCg0KPiANCj4gT3RoZXJ3aXNlOg0KPiBSZXZpZXdlZC1ieTogRG9uZyBBaXNoZW5nIDxh
aXNoZW5nLmRvbmdAbnhwLmNvbT4NCj4gDQo+IFJlZ2FyZHMNCj4gRG9uZyBBaXNoZW5nDQo=
