Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E558C43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525A7204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 11:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F0kfZLB2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfFWLau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 07:30:50 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:19943
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726350AbfFWLau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 07:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2RVCvfy+Hm5NCOLI8l4YvVF000LKUlGCMnroEDwY9+c=;
 b=F0kfZLB2ZaIaXIOON5sYATJxgvmvJ45QuE6fHijI+n8FV9avQoP3rx/laHp/eQW3jICQlfitvnydXztzWIrFfLlY698AM56A/Kyy9sj9QOspGRTRztd7u/RKmGoSFE4RH1N4iK+MxK7V4V89Ryx4X1v7cDxLZKQvV8aeAduR96M=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3787.eurprd04.prod.outlook.com (52.134.73.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.15; Sun, 23 Jun 2019 11:30:06 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2008.014; Sun, 23 Jun 2019
 11:30:06 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Martin Kepplinger <martink@posteo.de>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH 3/3] arm64: dts: imx8mq: Add system counter node
Thread-Topic: [PATCH 3/3] arm64: dts: imx8mq: Add system counter node
Thread-Index: AQHVKAsXvjXZswp9YUaGUA/T/OvzKqanug2AgAFhPQCAAAFk8A==
Date:   Sun, 23 Jun 2019 11:30:06 +0000
Message-ID: <DB3PR0402MB3916E2E26F96AED711182C64F5E10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190621082838.12630-1-Anson.Huang@nxp.com>
 <20190621082838.12630-3-Anson.Huang@nxp.com>
 <6c632476-9ecd-d6cc-b543-a28576c06a0c@posteo.de>
 <8a887fee-54e7-16ac-6373-a693ec7ad944@posteo.de>
In-Reply-To: <8a887fee-54e7-16ac-6373-a693ec7ad944@posteo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0f5198a-9e52-4f78-1ed6-08d6f7ce2469
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3787;
x-ms-traffictypediagnostic: DB3PR0402MB3787:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB37871B6C26E691B844F6D638F5E10@DB3PR0402MB3787.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 00770C4423
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(136003)(366004)(376002)(396003)(13464003)(189003)(199004)(8936002)(3846002)(55016002)(102836004)(53936002)(7696005)(8676002)(966005)(6506007)(81166006)(81156014)(316002)(99286004)(6246003)(26005)(33656002)(110136005)(476003)(2501003)(44832011)(11346002)(446003)(486006)(7416002)(2906002)(186003)(256004)(9686003)(305945005)(7736002)(66946007)(229853002)(45080400002)(74316002)(86362001)(53546011)(14454004)(76176011)(6116002)(478600001)(71200400001)(5660300002)(2201001)(66066001)(25786009)(52536014)(68736007)(6306002)(66556008)(71190400001)(4326008)(64756008)(66476007)(76116006)(73956011)(66446008)(6436002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3787;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: g0FaKivABOVGBhwr1h+KBauQlEc/LoZbw1cuGSzTc7v5C9Z0pMkB8GV1LFxql+BDJGeGw57PblpAqkcOjdMEzMDxf+QsysAY68TfiYNyNcq6ot5Aumdx6TXHSffBy2l32gt4gYCCSpk4lrkOHJKtLhvzjHxUUk7S6fseUOyH2OxvJsQt1UlBv+RnUOxFVGowrs7D23kDnjUFEJSdg1bPxF5FvkbAw2Yf8gSght6za+XZYzbceenL6zf9PlL09t30SG4KKVOqNAcdtTQjJZgdxb4m4dwb95OY8Hs0hbtpFNNgzWA1aBHPljaddcvBuV9hjM8nOwqdMj4d3f38E4D5fMkUXchCLRycqVSCaxMCJE7Ohys08+zdAlfHHhjS0HYsv4VgYvW3wlIvhleO5oZ/Dle1rHOE1cZimhxS21oWFs4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f5198a-9e52-4f78-1ed6-08d6f7ce2469
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 11:30:06.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3787
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFydGluIEtlcHBsaW5n
ZXIgPG1hcnRpbmtAcG9zdGVvLmRlPg0KPiBTZW50OiBTdW5kYXksIEp1bmUgMjMsIDIwMTkgNzoy
MSBQTQ0KPiBUbzogQW5zb24gSHVhbmcgPGFuc29uLmh1YW5nQG54cC5jb20+OyBkYW5pZWwubGV6
Y2Fub0BsaW5hcm8ub3JnOw0KPiB0Z2x4QGxpbnV0cm9uaXguZGU7IHJvYmgrZHRAa2VybmVsLm9y
ZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJA
cGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsNCj4gZmVzdGV2YW1AZ21haWwu
Y29tOyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOyBBYmVsIFZlc2ENCj4gPGFiZWwudmVzYUBueHAu
Y29tPjsgY2NhaW9uZUBiYXlsaWJyZS5jb207IGFuZ3VzQGFra2VhLmNhOw0KPiBhbmRyZXcuc21p
cm5vdkBnbWFpbC5jb207IGFneEBzaWd4Y3B1Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gYXJtNjQ6IGR0czogaW14OG1xOiBBZGQg
c3lzdGVtIGNvdW50ZXIgbm9kZQ0KPiANCj4gT24gMjIuMDYuMTkgMTY6MTYsIE1hcnRpbiBLZXBw
bGluZ2VyIHdyb3RlOg0KPiA+IE9uIDIxLjA2LjE5IDEwOjI4LCBBbnNvbi5IdWFuZ0BueHAuY29t
IHdyb3RlOg0KPiA+PiBGcm9tOiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4g
Pj4NCj4gPj4gQWRkIGkuTVg4TVEgc3lzdGVtIGNvdW50ZXIgbm9kZSB0byBlbmFibGUgdGltZXIt
aW14LXN5c2N0ciBicm9hZGNhc3QNCj4gPj4gdGltZXIgZHJpdmVyLg0KPiA+DQo+ID4gd2l0aCB0
aGVzZSBjaGFuZ2VzIGFuZCBUSU1FUl9JTVhfU1lTX0NUUiBzZWxlY3RlZCwgSSBkb24ndCBzZWUg
Y3B1aWRsZQ0KPiA+IHdvcmtpbmcgeWV0ICh3aGljaCBpcyB3aGF0IEkgd2FudCB0byBhY2hpZXZl
IG9uIGlteDhtcSkuIE1pZ2h0IHRoZXJlDQo+ID4gYmUgYSBzeXN0ZW0gY291bnRlciBjbG9jayBk
ZWZpbml0aW9uIG9yIGFueXRoaW5nIGVsc2UgbWlzc2luZz8NCj4gPg0KPiANCj4gVG8gYmUgY2xl
YXIgYWJvdXQgd2hhdCBJIHRyaWVkIHJ1bm5pbmc6IEFiZWwncyB3YWtldXAtd29ya2Fyb3VuZCAo
d2l0aCB0aGUNCj4gY29ycmVzcG9uZGluZyBBVEYgY2hhbmdlcyk6DQo+IGh0dHBzOi8vZXVyMDEu
c2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxrbWwu
bw0KPiByZyUyRmxrbWwlMkYyMDE5JTJGNiUyRjEwJTJGMzUwJmFtcDtkYXRhPTAyJTdDMDElN0NB
bnNvbi5IdWFuDQo+IGclNDBueHAuY29tJTdDNDQ1NjkwNzQzMTg3NDIyYTJkMmIwOGQ2ZjdjY2Q2
NjUlN0M2ODZlYTFkM2JjMmI0DQo+IGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzNjk2
ODg1NjQ3NzE4NTAxMiZhbXA7c2RhdGE9azFBag0KPiBDSjVTR1VZUUU3Vm56Y2lpaFJUS2dmMXlp
NGJEYUJxQ0N2OUR6cFUlM0QmYW1wO3Jlc2VydmVkPTAgcGx1cw0KPiB5b3VyIHBhdGNoZXMgaGVy
ZSAoYWx0aG91Z2ggeW91IGRvbid0IGRlZmluZSBhIHN5c3RlbSBjb3VudGVyIGNsb2NrLCBsaWtl
IHlvdQ0KPiBkbyBpbiB5b3VyIGlteDhtbSBwYXRjaGVzKS4NCj4gDQo+IEluIGFueSBjYXNlLCBJ
IG1pZ2h0IHRyeSB0byBlbmFibGUgY3B1aWRsZSB0b3RhbGx5IHdyb25nIHN0aWxsIDopIGFuZCBJ
J2QgYmUgaGFwcHkNCj4gZm9yIGhpbnRzIGFuZCB0ZXN0IHlvdXIgY2hhbmdlcyAobm8gbWF0dGVy
IGhvdyBmaXQgdGhleSBhcmUgdG8gYmUgbWVyZ2VkDQo+IHJpZ2h0IG5vdykuDQoNCkNvdWxkIGJl
IHNvbWV0aGluZyBlbHNlIHRoYW4gdGhpcyBwYXRjaCBzZXJpZXMsIGkuTVg4TVEgdXNlcyBwbGF0
Zm9ybSBkcml2ZXIgbW9kZWwNCmZvciBjbG9jayBkcml2ZXIsIHRvIGVuYWJsZSBzeXN0ZW0gY291
bnRlciBkcml2ZXIsIHNvbWV0aGluZyBuZWVkcyB0byBiZSBjaGFuZ2VkIGluDQpzeXN0ZW0gY291
bnRlciBkcml2ZXIsIGFuZCBubyBuZWVkIHRvIGhhdmUgc3lzdGVtIGNvdW50ZXIgY2xvY2sgZGVm
aW5pdGlvbiBpbiBpLk1YOE1RDQpjbG9jayB0cmVlLCB3aGlsZSBpLk1YOE1NIHVzZXMgT0ZfQ0xL
IGFzIGNsb2NrIGRyaXZlciBpbml0aWFsaXphdGlvbiwgc28gd2UgbmVlZCBzeXN0ZW0NCmNvdW50
ZXIgY2xvY2sgZGVmaW5pdGlvbi4NCg0KTXkgdW5kZXJzdGFuZGluZyBpcywgZXZlbiB3aXRob3V0
IHRoaXMgcGF0Y2ggc2VyaWVzLCBjcHUtaWRsZSBzaG91bGQgYmUgYWJsZSB0byB3b3JrLCBidXQN
ClRoZSBsYXN0IENQVSBjb3VsZCBiZSBhbHdheXMgcG93ZXJlZCBPTiB0byBhY2sgYXMgYnJvYWRj
YXN0IHRpbWVyLCBpZiB3aXRoIHN5c3RlbSBjb3VudGVyDQplbmFibGVkLCBhbGwgQ1BVcyBjYW4g
YmUgcG93ZXJlZCBPRkYgd2hlbiBlbnRlcmluZyBzdGF0ZSAjMSBpZGxlIGluZGVwZW5kZW50bHks
IGFzIHN5c3RlbQ0KY291bnRlciBjYW4gYmUgYnJvYWRjYXN0IHRpbWVyLiBDb3JyZWN0IG1lIGlm
IGFueXRoaW5nIHdyb25nLCBtYXliZSBsYXRlc3QgdXBzdHJlYW0ga2VybmVsDQpoYXMgc29tZXRo
aW5nIGRpZmZlcmVudCBhYm91dCB0aGlzIHBhcnQuIA0KDQpUaGFua3MsDQpBbnNvbi4NCg0KPiAN
Cj4gdGhhbmtzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFydGlu
DQoNCg==
