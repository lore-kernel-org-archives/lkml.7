Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260F1C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E676926075
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hvysCZpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389191AbfE3FAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 01:00:02 -0400
Received: from mail-eopbgr10074.outbound.protection.outlook.com ([40.107.1.74]:18075
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727621AbfE3DJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHi0c9mDstHF85xZs1iI/uKxKjPrRj7kba7R09Z1Z4o=;
 b=hvysCZplplixTp3nHznyNbWt9/J65jrz4vZnB4oRXeav8c4so0+Y4isxZYYpIpGtCXuMoCZ5qrQPG52miw+Xw0SOMPAx3x04vRQoD/V7a6E5YDjDgzxoLrGnOzONRTpBCh+qa2U8CTwfHBeSp0Gx4Q1F03FJ0C2WUusGR8vaoBs=
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com (52.135.167.33) by
 AM6PR04MB5079.eurprd04.prod.outlook.com (20.177.34.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.20; Thu, 30 May 2019 03:09:30 +0000
Received: from AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::d877:33b5:bfa6:30ce]) by AM6PR04MB4357.eurprd04.prod.outlook.com
 ([fe80::d877:33b5:bfa6:30ce%6]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 03:09:30 +0000
From:   Chuanhua Han <chuanhua.han@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     Leo Li <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ying Zhang <ying.zhang22455@nxp.com>
Subject: RE: [EXT] Re: [PATCH] arm64: dts: ls1028a: fix watchdog device node
Thread-Topic: [EXT] Re: [PATCH] arm64: dts: ls1028a: fix watchdog device node
Thread-Index: AQHVBjWLU5tDmMzveEaz3RlKVqbc5aZupocAgAA6wsCAAQpVgIAFsPwAgAB6roCAAKa7cIAACsWAgANWFYCAAC1XAIAI0QqQ
Date:   Thu, 30 May 2019 03:09:30 +0000
Message-ID: <AM6PR04MB43573B91F0D575EB293B490597180@AM6PR04MB4357.eurprd04.prod.outlook.com>
References: <20190509070657.18281-1-chuanhua.han@nxp.com>
 <20190517023728.GA15856@dragon>
 <AM6PR04MB4357C78FCEBA1B00AA42ED2E970B0@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <AM6PR04MB586341334E62A663EE5E8BD18F0B0@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM6PR04MB435758E1498B6A2BE0C0ACE397070@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <AM6PR04MB58631458E6D851E4D83A77ED8F070@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM6PR04MB435708872A4DBA92561C772597000@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <AM6PR04MB5863FA1CE6D1E40F11B2E5008F000@AM6PR04MB5863.eurprd04.prod.outlook.com>
 <AM6PR04MB4357072E079BDD8D1866595797020@AM6PR04MB4357.eurprd04.prod.outlook.com>
 <CAL_Jsq+evXqKKyXLFbE+9o8X5BA9NWmcjvZ9-Y1Y7-pwcu8nJg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+evXqKKyXLFbE+9o8X5BA9NWmcjvZ9-Y1Y7-pwcu8nJg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chuanhua.han@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64c9abf1-1b8b-4724-bc81-08d6e4ac3bcf
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB5079;
x-ms-traffictypediagnostic: AM6PR04MB5079:
x-microsoft-antispam-prvs: <AM6PR04MB50790D97B91EB82E16FE85C897180@AM6PR04MB5079.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(136003)(39860400002)(13464003)(189003)(199004)(478600001)(44832011)(14454004)(4326008)(66066001)(476003)(99286004)(11346002)(52536014)(53936002)(6506007)(5660300002)(6246003)(53546011)(33656002)(71190400001)(6116002)(3846002)(71200400001)(86362001)(102836004)(81156014)(76176011)(8676002)(8936002)(66946007)(486006)(54906003)(305945005)(7736002)(9686003)(68736007)(74316002)(55016002)(316002)(6436002)(25786009)(81166006)(256004)(26005)(2906002)(66556008)(76116006)(66476007)(229853002)(66446008)(64756008)(73956011)(6916009)(14444005)(186003)(446003)(7696005)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5079;H:AM6PR04MB4357.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 56YYvbg5CLq2c2LMQO6/yGrPeGW6f+CNxlmPokq+JbsHQ9uTxdhQlSaMEVAcuYQ1rD8skZ+LRXTXBqkqtJYHoWvenH6yR+wlMIU0iudrGwlO20GLZIDDlkxPfFn9lcN+nlLjZwhEUDjeNGhO0II+UBAEuOv2ekTsEN8WzNrEJh2Tpbevmjh+wEkmc6ZqqDlj1c2ZwgmCEEUCHp+1by82D0PhJbZRKnGiJSf+ICmeEtueSXLL5VN8BHJy2LPIF67rIBwf4Uq0cX/gslaiWVABuwY6zXDGJfj/DewQ2TTQnnrEQsERrlEn9DwSSsJVjI3MD2OEStfRqA5DjjLXHcTrcTrcml0H7W4CdbKU3zWq2WNqEWCBZUHGz4zqGGvB0dRv5ODcsjOvWvMal+VqUr4vgBeD/u6pmUlXTJJ2pZ2xiig=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c9abf1-1b8b-4724-bc81-08d6e4ac3bcf
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 03:09:30.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chuanhua.han@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOeW5tDXmnIgyNOaXpSAyMDoyOQ0KPiBUbzogQ2h1
YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gQ2M6IExlbyBMaSA8bGVveWFuZy5s
aUBueHAuY29tPjsgU2hhd24gR3VvIDxzaGF3bmd1b0BrZXJuZWwub3JnPjsNCj4gbWFyay5ydXRs
YW5kQGFybS5jb207IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFlp
bmcgWmhhbmcNCj4gPHlpbmcuemhhbmcyMjQ1NUBueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW0VY
VF0gUmU6IFtQQVRDSF0gYXJtNjQ6IGR0czogbHMxMDI4YTogZml4IHdhdGNoZG9nIGRldmljZSBu
b2RlDQo+IA0KPiBDYXV0aW9uOiBFWFQgRW1haWwNCj4gDQo+IE9uIEZyaSwgTWF5IDI0LCAyMDE5
IGF0IDQ6NDggQU0gQ2h1YW5odWEgSGFuIDxjaHVhbmh1YS5oYW5AbnhwLmNvbT4NCj4gd3JvdGU6
DQo+ID4NCj4gPiBIaSwgUm9iIEhlcnJpbmcNCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gPiA+IEZyb206IExlbyBMaQ0KPiA+ID4gU2VudDogMjAxOeW5tDXmnIgyMuaX
pSAxNDo1MA0KPiANCj4gDQo+ID4gPiA+ID4gPiA+ID4gPiA+IC0gICAgICAgICAgICAgd2RvZzA6
IHdhdGNoZG9nQDIzYzAwMDAgew0KPiA+ID4gPiA+ID4gPiA+ID4gPiAtICAgICAgICAgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJmc2wsbHMxMDI4YS13ZHQiLA0KPiA+ID4gPiA+ICJmc2wsaW14
MjEtd2R0IjsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgIHJlZyA9
IDwweDAgMHgyM2MwMDAwIDB4MCAweDEwMDAwPjsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAg
ICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSA1OQ0KPiA+ID4gPiA+ID4gPiBJ
UlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAgICAgICAgICAgICAg
ICAgICAgIGNsb2NrcyA9IDwmY2xvY2tnZW4gNCAxPjsNCj4gPiA+ID4gPiA+ID4gPiA+ID4gLSAg
ICAgICAgICAgICAgICAgICAgIGJpZy1lbmRpYW47DQo+ID4gPiA+ID4gPiA+ID4gPiA+IC0gICAg
ICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ID4gPiA+ID4gPiA+ID4g
PiArICAgICAgICAgICAgIGNsdXN0ZXIxX2NvcmUwX3dhdGNoZG9nOiB3ZHRAYzAwMDAwMCB7DQo+
ID4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4gS2VlcCAnd2F0Y2hkb2cnIGFzIHRo
ZSBub2RlIG5hbWUsDQo+ID4gPiA+ID4gPiA+ID4gVGhhbmtzIGZvciB5b3VyIHJlcGxheQ0KPiA+
ID4gPiA+ID4gPiA+IERvIHlvdSBtZWFuIHJlcGxhY2UgdGhlIOKAmHdkdOKAmSB3aXRoIOKAmHdh
dGNoZG9n4oCZPw0KPiA+ID4gPiA+ID4gPiA+IGFuZCBrZWVwIG5vZGVzIHNvcnQgaW4gdW5pdC1h
ZGRyZXNzLg0KPiA+ID4gPiA+ID4gPiA+IFdoYXQgZG9lcyB0aGlzIG1lYW4/DQo+ID4gPiA+ID4g
PiA+DQo+ID4gPiA+ID4gPiA+IFRoYXQgbWVhbnMgb3JkZXIgdGhlIG5vZGVzIGJ5IHRoZSBhZGRy
ZXNzZXMgKGUuZy4gYzAwMDAwMCwNCj4gPiA+ID4gPiA+ID4gYzAxMDAwMCkNCj4gPiA+ID4gPiA+
IFRoZSBjdXJyZW50IG9yZGVyIGlzIGNvcnJlY3TvvIhUaGUgZmlyc3QgaXMgYzAwMDAwMCwgdGhl
biBjMDAwMDAw77yJLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQnV0IHRoZXkgYXJlIGFkZGVkIGFm
dGVyIGdwaW9AMjMyMDAwMCBhbmQgYmVmb3JlIHNhdGFAMzIwMDAwMC4NCj4gPiA+ID4gSSBjaGFu
Z2VkIGFuZCBtYWRlIHRoZSBzZWNvbmQgdmVyc2lvbiBvZiB0aGUgcGF0Y2gsIGJ1dCBJIGZvdW5k
DQo+ID4gPiA+IHRoZSBmb2xsb3dpbmcgZXJyb3Igd2hlbiBJIGV4ZWN1dGVkIC4vc2NyaXB0cy9j
aGVja3BhdGNoLnBsDQo+ID4gPiA+IHh4eC5wYXRjaCB0byBjaGVjayB0aGUgcGF0Y2g6DQo+ID4g
PiA+DQo+ID4gPiA+IFdBUk5JTkc6IERUIGNvbXBhdGlibGUgc3RyaW5nIHZlbmRvciAiYXJtIiBh
cHBlYXJzIHVuLWRvY3VtZW50ZWQNCj4gPiA+ID4gLS0gY2hlY2sgLi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnR4dA0KPiA+ID4gPiAjNDM6IEZJTEU6
IGFyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1sczEwMjhhLmR0c2k6MzUxOg0KPiA+
ID4gPiArIGNvbXBhdGlibGUgPSAiYXJtLHNwODA1IiwgImFybSxwcmltZWNlbGwiOw0KPiA+ID4g
Pg0KPiA+ID4gPiBIb3dldmVyLCB0aGVyZSBpcyBubyB2ZW5kb3ItcHJlZml4ZXMudHh0IGZpbGUg
aW4gdGhlDQo+ID4gPiA+IC4vRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzLyBkaXJl
Y3RvcnksIG9ubHkgdmVuZG9yLQ0KPiA+ID4gPiBwcmVmaXhlcy55YW1sLg0KPiA+ID4gPiBNb3Jl
b3ZlciwgdGhlcmUgYXJlIOKAmGFybeKAmSB2ZW5kb3JzIGluIHZlbmRvci1wcmVmaXhlcy55YW1s
Lg0KPiA+ID4NCj4gPiA+IEFkZGVkIFJvYiBIZXJyaW5nIHRvIHRoZSB0aHJlYWQuDQo+ID4gPg0K
PiA+ID4gPiBSZXF1ZXN0IGhlbHDvvIx0aGFua3MNCj4gPiBIb3cgY2FuIEkgc29sdmUgdGhpcyBw
YXRjaCBjaGVjayBlcnJvcj8gQXNrIGZvciBoZWxwLCB0aGFuayB5b3UhDQo+IA0KPiBJZ25vcmUg
aXQuIEEgZml4IHRvIGNoZWNrcGF0Y2gucGwgaXMgcGVuZGluZy4NCk9LLCB0aGUgc2Vjb25kIHZl
cnNpb24gaGFzIGJlZW4gc2VudC4gQ2hlY2tpbmcgd2l0aCBjaGVja3BhdGNoLnBsIGlzIG5vIHBy
b2JsZW0uDQo+IA0KPiBSb2INCg==
