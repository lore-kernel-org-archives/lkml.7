Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0272CC0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22EF21850
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ECL3zQYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfGEA0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 20:26:43 -0400
Received: from mail-eopbgr30087.outbound.protection.outlook.com ([40.107.3.87]:63185
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727093AbfGEA0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 20:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGziptvsj5NuUVTGH1rzLHrnPaAuypv9P4eX/Pp1EAU=;
 b=ECL3zQYj0FpA3jFhuDSM7N2Y9edrXBKmmQUTWQ6FwJZL1gYfrz4kKCqzKZPiruRZx53yZNDQD+uauZPghxzC+es3kFFohyEEA55uvzQVE7QqHHCo79cBZdDSwxCBMhW9A95nWdEAyyCs2iza4z4mnJ6qAIBzr7617/R8obA5PDs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3755.eurprd04.prod.outlook.com (52.134.71.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Fri, 5 Jul 2019 00:26:38 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::3945:fcda:5bdd:8191%4]) with mapi id 15.20.2052.010; Fri, 5 Jul 2019
 00:26:38 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Thread-Topic: [PATCH V3 1/2] dt-bindings: reset: imx7: Add support for i.MX8MM
Thread-Index: AQHVMk5T8ePkVlGuXEKfzs7Ixfs7tqa6PluAgADs2ZA=
Date:   Fri, 5 Jul 2019 00:26:38 +0000
Message-ID: <DB3PR0402MB39167B9A3CFAE6D8798B3CAEF5F50@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190704094416.4757-1-Anson.Huang@nxp.com>
 <1562235363.6641.10.camel@pengutronix.de>
In-Reply-To: <1562235363.6641.10.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f3ca13b-04a9-4221-ea51-08d700df7201
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3755;
x-ms-traffictypediagnostic: DB3PR0402MB3755:
x-microsoft-antispam-prvs: <DB3PR0402MB37558948A0E7C199FDCA580EF5F50@DB3PR0402MB3755.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 008960E8EC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(199004)(189003)(305945005)(6436002)(7736002)(478600001)(25786009)(53936002)(99286004)(2501003)(7696005)(26005)(446003)(11346002)(186003)(110136005)(486006)(81166006)(66556008)(8676002)(229853002)(81156014)(256004)(316002)(64756008)(66946007)(66476007)(66446008)(76116006)(476003)(73956011)(74316002)(8936002)(44832011)(2906002)(14444005)(76176011)(6246003)(71200400001)(5660300002)(9686003)(86362001)(55016002)(33656002)(6506007)(71190400001)(68736007)(2201001)(52536014)(14454004)(66066001)(3846002)(6116002)(4326008)(102836004)(7416002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3755;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6jZk33i6j0vGIuTyoG10V9qUbvgqy2ipVxr+TYsa2zWEVUFJS97IF4I0rYgf2zg+6FV0XTYOHuhMSSbWZIZtuKq05VBiYW9wn8azb44CXh0Wn/+L19fuKM/mhezWkdkKvcjoQqv1XMww2AjqJ+tX1mDVImHLlfrjaasqVyaxCEV4HN+27Kzukw9QNEce0n3zOxwOtaODvP75uJtj4cxxHHb0qMESolkAWhMjCTTT2rKQRjz31tl1TkxW0HrbYxvWAGuV7dSCtKcVMd4GoRvlUmNILDl3PKs5/Cs2K1gRn6raD7P4pkmCpNOagQLBSL6k2ImntDwRGgbDcSMVHKzKRPaXmoM6xFI0oZvFAPr6eEgds8Fvnv2IQDl5moqxWjIzNJemTjChpTavBJOdNoihga7oWFvKiy+8zCtr4JxFr3c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3ca13b-04a9-4221-ea51-08d700df7201
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2019 00:26:38.5320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3755
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFBoaWxpcHANCg0KPiBPbiBUaHUsIDIwMTktMDctMDQgYXQgMTc6NDQgKzA4MDAsIEFuc29u
Lkh1YW5nQG54cC5jb20gd3JvdGU6DQo+ID4gRnJvbTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5n
QG54cC5jb20+DQo+ID4NCj4gPiBpLk1YOE1NIGNhbiByZXVzZSBpLk1YOE1RJ3MgcmVzZXQgZHJp
dmVyLCB1cGRhdGUgdGhlIGNvbXBhdGlibGUNCj4gPiBwcm9wZXJ0eSBhbmQgcmVsYXRlZCBpbmZv
IHRvIHN1cHBvcnQgaS5NWDhNTS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuc29uIEh1YW5n
IDxBbnNvbi5IdWFuZ0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgc2luY2UgVjI6DQo+
ID4gCS0gQWRkIHNlcGFyYXRlIGxpbmUgZm9yIGkuTVg4TU0gaW4gY2FzZSBhbnl0aGluZyBkaWZm
ZXJlbnQgbGF0ZXIgZm9yDQo+IGkuTVg4TU0uDQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2wsaW14Ny1zcmMudHh0IHwgNiArKysrLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVzZXQv
ZnNsLGlteDctc3JjLnR4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Jlc2V0L2ZzbCxpbXg3LXNyYy50eHQNCj4gPiBpbmRleCAxM2UwOTUxLi5jMjQ4OWU0IDEwMDY0
NA0KPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZXNldC9mc2ws
aW14Ny1zcmMudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Jlc2V0L2ZzbCxpbXg3LXNyYy50eHQNCj4gPiBAQCAtOCw2ICs4LDcgQEAgUmVxdWlyZWQgcHJv
cGVydGllczoNCj4gPiAgLSBjb21wYXRpYmxlOg0KPiA+ICAJLSBGb3IgaS5NWDcgU29DcyBzaG91
bGQgYmUgImZzbCxpbXg3ZC1zcmMiLCAic3lzY29uIg0KPiA+ICAJLSBGb3IgaS5NWDhNUSBTb0Nz
IHNob3VsZCBiZSAiZnNsLGlteDhtcS1zcmMiLCAic3lzY29uIg0KPiA+ICsJLSBGb3IgaS5NWDhN
TSBTb0NzIHNob3VsZCBiZSAiZnNsLGlteDhtbS1zcmMiLCAiZnNsLGlteDhtcS1zcmMiLA0KPiAi
c3lzY29uIg0KPiA+ICAtIHJlZzogc2hvdWxkIGJlIHJlZ2lzdGVyIGJhc2UgYW5kIGxlbmd0aCBh
cyBkb2N1bWVudGVkIGluIHRoZQ0KPiA+ICAgIGRhdGFzaGVldA0KPiA+ICAtIGludGVycnVwdHM6
IFNob3VsZCBjb250YWluIFNSQyBpbnRlcnJ1cHQgQEAgLTQ2LDUgKzQ3LDYgQEAgRXhhbXBsZToN
Cj4gPg0KPiA+DQo+ID4gIEZvciBsaXN0IG9mIGFsbCB2YWxpZCByZXNldCBpbmRpY2VzIHNlZQ0K
PiA+IC08ZHQtYmluZGluZ3MvcmVzZXQvaW14Ny1yZXNldC5oPiBmb3IgaS5NWDcgYW5kDQo+ID4g
LTxkdC1iaW5kaW5ncy9yZXNldC9pbXg4bXEtcmVzZXQuaD4gZm9yIGkuTVg4TVENCj4gPiArPGR0
LWJpbmRpbmdzL3Jlc2V0L2lteDctcmVzZXQuaD4gZm9yIGkuTVg3LA0KPiA+ICs8ZHQtYmluZGlu
Z3MvcmVzZXQvaW14OG1xLXJlc2V0Lmg+IGZvciBpLk1YOE1RIGFuZA0KPiA+ICs8ZHQtYmluZGlu
Z3MvcmVzZXQvaW14OG1xLXJlc2V0Lmg+IGZvciBpLk1YOE1NDQo+IA0KPiBUaGUgbGFzdCBsaW5l
IGlzIG1pc2xlYWRpbmcsIGFzIHRoYXQgZmlsZSBjb250YWlucyByZXNldCBpbmRpY2VzIHRoYXQg
YXJlIGludmFsaWQNCj4gZm9yIGkuTVg4TU0uDQoNCldoYXQgaXMgeW91ciBzdWdnZXN0aW9uIGFi
b3V0IHRoaXMgbGluZT8gSnVzdCBOT1QgY2hhbmdlIGl0PyBPciBhZGRpbmcgYSBuZXcgZmlsZQ0K
aW14OG1tLXJlc2V0LmggYnV0IHN0aWxsIHVzZSB0aGUgSU1YOE1RX1JFU0VUXyBhcyBwcmVmaXgg
PyBPciBrZWVwIHdoYXQgSSBjaGFuZ2VkLCBidXQNCmFkZGluZyBzb21lIGNvbW1lbnRzIGluIHRo
b3NlIG1hY3JvcyB0aGF0IGkuTVg4TU0gZG9lcyBOT1Qgc3VwcG9ydD8NCg0KVGhhbmtzLA0KQW5z
b24uDQoNCj4gDQo+IHJlZ2FyZHMNCj4gUGhpbGlwcA0K
