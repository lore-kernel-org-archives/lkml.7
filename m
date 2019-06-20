Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFACC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761DA206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 08:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HGaWtBZy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfFTIcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 04:32:23 -0400
Received: from mail-eopbgr150085.outbound.protection.outlook.com ([40.107.15.85]:19424
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725875AbfFTIcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 04:32:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RGLb8f/ednR1jDgMRpqjY9nBPvf7lM5acESYZvLLcx0=;
 b=HGaWtBZydNxMVpB886DVhlxJpMgOZKHnOHAy6e8pg1iEhPwDOrnijfrRwcwZ4fT56dw0TTuTuuFVBNSxx5r1PlAO4hXU5v1i+CiWH0xtRF6xvnjS/mL2/Gqm/rQlCj57ZMhaTiaY8YRP64UsYRuDiiOOEsA0pajmHd/77JykVQo=
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.123.141) by
 VI1PR04MB3008.eurprd04.prod.outlook.com (10.170.228.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Thu, 20 Jun 2019 08:30:38 +0000
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7]) by VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7%7]) with mapi id 15.20.1987.014; Thu, 20 Jun 2019
 08:30:38 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     "sam@ravnborg.org" <sam@ravnborg.org>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [EXT] Re: [PATCH v2 2/2] drm/panel: Add support for Raydium
 RM67191 panel driver
Thread-Topic: [EXT] Re: [PATCH v2 2/2] drm/panel: Add support for Raydium
 RM67191 panel driver
Thread-Index: AQHVJdoL5NWVS2lKwkmkyRwSLkxJKqai+UwAgAE/3IA=
Date:   Thu, 20 Jun 2019 08:30:38 +0000
Message-ID: <1561019435.9328.67.camel@nxp.com>
References: <1560864646-1468-1-git-send-email-robert.chiras@nxp.com>
         <1560864646-1468-3-git-send-email-robert.chiras@nxp.com>
         <20190619132546.GB31903@ravnborg.org>
In-Reply-To: <20190619132546.GB31903@ravnborg.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c51f02a0-8cda-46a0-1b10-08d6f55992bb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB3008;
x-ms-traffictypediagnostic: VI1PR04MB3008:
x-microsoft-antispam-prvs: <VI1PR04MB30082EDD3955FDDBD531F265E3E40@VI1PR04MB3008.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0074BBE012
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(136003)(346002)(396003)(366004)(54534003)(199004)(189003)(5640700003)(66066001)(71200400001)(5660300002)(229853002)(6512007)(7736002)(76116006)(11346002)(6916009)(14444005)(71190400001)(99286004)(64756008)(102836004)(14454004)(66446008)(256004)(305945005)(6436002)(66476007)(68736007)(66556008)(476003)(1730700003)(44832011)(53936002)(2906002)(2501003)(26005)(76176011)(66946007)(4326008)(6506007)(73956011)(3846002)(478600001)(6486002)(36756003)(446003)(86362001)(2616005)(316002)(486006)(6116002)(103116003)(2351001)(186003)(81156014)(25786009)(54906003)(8936002)(6246003)(81166006)(50226002)(8676002)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3008;H:VI1PR04MB5967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dHb4FiAxZSg5tk/bKyMFIXWXIrG/pM/MisfMZvHdRa4zP9YxcVDwCLyi5uuLJSpfOMy2VnkF+f4hYVzD1t08lJNzy6MmB9qwdb5cMlhqOrIXE8wpxqrRpZIVfJr+vlLmRpwFCoKIphtWjvjT+wyn54tFJN2JfhRBtw+zSbHkA08JbG3sirk4oBBlW++Bs8N7n5gR2YHPMLxa3nq7NCk0PiOrZRB8i3pEmUqVq6nMV6NpiqqWNoAxpw2bm+eqGzzwGUUp6B4JvAoudZueC7P80amehn0otZoJ+HC6xQl3douOIdaR0DQLiK/YLuDZzd11KXNk4kkJksaAp5knxeakm9tKQt19V90fvgnwWU3viJCjp19hI1ABNSyLjoyVaATZ+3DsoW8VyS4jrQFDQ+o3U1B6U00VSZ3+qxn2N9cWgzo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68BB8F25AE896742824CC602151CD559@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51f02a0-8cda-46a0-1b10-08d6f55992bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2019 08:30:38.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: robert.chiras@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2FtLA0KDQpPbiBNaSwgMjAxOS0wNi0xOSBhdCAxNToyNSArMDIwMCwgU2FtIFJhdm5ib3Jn
IHdyb3RlOg0KPiBPbiBUdWUsIEp1biAxOCwgMjAxOSBhdCAwNDozMDo0NlBNICswMzAwLCBSb2Jl
cnQgQ2hpcmFzIHdyb3RlOg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2ggYWRkcyBSYXlkaXVtIFJNNjcx
OTEgVEZUIExDRCBwYW5lbCBkcml2ZXIgKE1JUEktRFNJDQo+ID4gcHJvdG9jb2wpLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBDaGlyYXMgPHJvYmVydC5jaGlyYXNAbnhwLmNvbT4N
Cj4gUGxlYXNlIGluY2x1ZGUgaW4gdGhlIGNoYW5nZWxvZyBhIGxpc3Qgb2Ygd2hhdCB3YXMgdXBk
YXRlZCAtIGxpa2UNCj4gdGhpczoNCj4gDQo+IHYyOg0KPiAtIGFkZGVkIGtjb25pZiBzeW1ib2wg
c29ydGVkIChzYW0pDQo+IC0gYW5vdGhlciBuaXRwaWNrIChmb28pDQo+IC0gZXRjDQo+IA0KPiBJ
biBnZW5lcmFsIHRyeSB0byBuYW1tZSB3aG8gZ2F2ZSBmZWVkYmFjayB0byBnaXZlIHRoZW0gc29t
ZSBjcmVkaXQuDQpUaGFua3MuIEkgd2lsbCBrZWVwIHRoaXMgaW4gbWluZCwgbmV4dCB0aW1lDQo+
IA0KPiBXaG8gaXMgbWFpbnRhaW5lciBmb3IgdGhpcyBvbndhcmRzPw0KSSBjYW4gb2ZmZXIgbXlz
ZWxmIHRvIG1haW50YWluIHRoaXMuDQo+IA0KPiA+IA0KPiA+IC0tLQ0KPiA+IMKgZHJpdmVycy9n
cHUvZHJtL3BhbmVsL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfMKg
wqDCoDkgKw0KPiA+IMKgZHJpdmVycy9ncHUvZHJtL3BhbmVsL01ha2VmaWxlwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB8wqDCoMKgMSArDQo+ID4gwqBkcml2ZXJzL2dwdS9kcm0vcGFu
ZWwvcGFuZWwtcmF5ZGl1bS1ybTY3MTkxLmMgfCA3MDkNCj4gPiArKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+IMKgMyBmaWxlcyBjaGFuZ2VkLCA3MTkgaW5zZXJ0aW9ucygrKQ0KPiA+IMKg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1yYXlkaXVtLXJt
NjcxOTEuYw0KPiA+IA0KPiA+ICtzdGF0aWMgaW50IHJhZF9wYW5lbF9wcmVwYXJlKHN0cnVjdCBk
cm1fcGFuZWwgKnBhbmVsKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqBzdHJ1Y3QgcmFkX3BhbmVs
ICpyYWQgPSB0b19yYWRfcGFuZWwocGFuZWwpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoGlmIChy
YWQtPnByZXBhcmVkKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0K
PiA+ICsNCj4gPiArwqDCoMKgwqDCoGlmIChyYWQtPnJlc2V0KSB7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJhZC0+cmVzZXQsIDEpOw0K
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHVzbGVlcF9yYW5nZSgzMDAwLCA1MDAwKTsN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAo
cmFkLT5yZXNldCwgMCk7DQo+IFNvIHdyaXRpbmcgYSAwIHdpbGwgcmVsZWFzZSByZXNldC4NCj4g
PiANCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1c2xlZXBfcmFuZ2UoMTgwMDAsIDIw
MDAwKTsNCj4gPiArwqDCoMKgwqDCoH0NCj4gPiArDQo+ID4gK8KgwqDCoMKgwqByYWQtPnByZXBh
cmVkID0gdHJ1ZTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqByZXR1cm4gMDsNCj4gPiArfQ0KPiA+
ICsNCj4gPiArc3RhdGljIGludCByYWRfcGFuZWxfdW5wcmVwYXJlKHN0cnVjdCBkcm1fcGFuZWwg
KnBhbmVsKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqBzdHJ1Y3QgcmFkX3BhbmVsICpyYWQgPSB0
b19yYWRfcGFuZWwocGFuZWwpOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoGlmICghcmFkLT5wcmVw
YXJlZCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4gPiArDQo+
ID4gK8KgwqDCoMKgwqBpZiAocmFkLT5yZXNldCkgew0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChyYWQtPnJlc2V0LCAxKTsNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1c2xlZXBfcmFuZ2UoMTUwMDAsIDE3MDAwKTsNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocmFkLT5y
ZXNldCwgMCk7DQo+IExvb2tzIHN0cmFuZ2UgdGhhdCByZXNldCBpcyByZWxlYXNlZCBpbiB1bnBy
ZXBhcmUuDQo+IEkgd291bGQgZXhwZWN0IGl0IHRvIHN0YXkgcmVzZXQgdG8gbWluaW1pemUgcG93
ZXIgZXRjLg0KWWVzLCBpdCBsb29rcyBzdHJhbmdlIGluZGVlZC4gVGhlIHJlYXNvbiBoZXJlIGlz
IGNvbWluZyBmcm9tIHRoZSBmYWN0DQp0aGF0IHRoaXMgcGFuZWwgYWxzbyBoYXMgdG91Y2gtc2Ny
ZWVuIHRoYXQgc2hhcmVzIHRoaXMgcmVzZXQgcGluIHdpdGgNCnRoZSBPTEVEIGRpc3BsYXkuIFdo
aWxlIHRoZSBkaXNwbGF5IG1heSBiZSB0dXJuZWQgb2ZmLCB0aGUgdG91Y2ggZHJpdmVyDQptYXkg
bmVlZCB0byBrZWVwIHRoZSBjb25uZWN0aW9uIGFjdGl2ZSB3aXRoIHRoZSB0b3VjaCBjb250cm9s
bGVyIGZyb20NCnRoaXMgcGFuZWwuIFRoaXMgaXMgdGhlIHJlYXNvbiBmb3IgcmVsZWFzaW5nIHRo
ZSByZXNldCBwaW4gaW4NCnVucHJlcGFyZS4gSSB3aWxsIGFkZCB0aGlzIGluIGEgY29tbWVudCBp
biB0aGUgY29kZSwgdG8gZWxpbWluYXRlIHRoZQ0KY29uZnVzaW9uLg0KPiANCj4gPiANCj4gPiAr
DQo+ID4gK8KgwqDCoMKgwqByZXQgPSBkcm1fZGlzcGxheV9pbmZvX3NldF9idXNfZm9ybWF0cygm
Y29ubmVjdG9yLQ0KPiA+ID5kaXNwbGF5X2luZm8sDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByYWRfYnVzX2Zvcm1hdHMsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBBUlJBWV9TSVpFKHJhZF9idXNfZm9yDQo+ID4gbWF0cykpOw0KPiBPdGhlciBkcml2
ZXJzIGhhcyB0aGlzIGFzIHRoZSBsYXN0IHN0ZW1lbnQgaW4gdGhlaXIgZW5hYmxlIGZ1bmN0aW9u
Lg0KPiBJIGRpZCBub3QgY2hlY2sgd2h5LCBidXQgbWF5YmUgc29tZXRoaW5nIHRvIGludmVzdCBh
IGZldyBtaW51dGVzDQo+IGludG8uDQo+IEJlIGRpZmZlcmVudCBvbmx5IGlmIHRoZXJlIGlzIGEg
cmVhc29uIHRvIGRvIHNvLg0KT2ssIEkgd2lsbCBtb3ZlIHRoaXMgYXMgdGhlIGxhc3Qgc3RhdGVt
ZW50LiBJIGFsc28gbm90aWNlZCB0aGF0IHRoZQ0Kb3RoZXIgcGFuZWwgZHJpdmVycyBkbyBub3Qg
Y2hlY2sgdGhlIHJldHVybiBvZiB0aGlzIGNhbGwsIGxpa2UgSSBkbw0KaGVyZSwgc28gSSB3aWxs
IGFsc28gcmVtb3ZlIHRoaXMgdG9vLg0KPiANCj4gPiANCj4gPiArwqDCoMKgwqDCoGlmIChyZXQp
DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsNCj4gPiArDQo+ID4g
K8KgwqDCoMKgwqBkcm1fbW9kZV9wcm9iZWRfYWRkKHBhbmVsLT5jb25uZWN0b3IsIG1vZGUpOw0K
PiA+ICsNCj4gPiArwqDCoMKgwqDCoHJldHVybiAxOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICsNCj4g
PiArI2lmZGVmIENPTkZJR19QTQ0KPiA+ICtzdGF0aWMgaW50IHJhZF9wYW5lbF9zdXNwZW5kKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgc3RydWN0IHJhZF9wYW5l
bCAqcmFkID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgaWYg
KCFyYWQtPnJlc2V0KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0K
PiA+ICsNCj4gPiArwqDCoMKgwqDCoGRldm1fZ3Bpb2RfcHV0KGRldiwgcmFkLT5yZXNldCk7DQo+
ID4gK8KgwqDCoMKgwqByYWQtPnJlc2V0ID0gTlVMTDsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqBy
ZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCByYWRfcGFuZWxfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICvCoMKgwqDCoMKgc3RydWN0IHJhZF9w
YW5lbCAqcmFkID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKg
aWYgKHJhZC0+cmVzZXQpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7
DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgcmFkLT5yZXNldCA9IGRldm1fZ3Bpb2RfZ2V0KGRldiwg
InJlc2V0IiwgR1BJT0RfT1VUX0xPVyk7DQo+ID4gK8KgwqDCoMKgwqBpZiAoSVNfRVJSKHJhZC0+
cmVzZXQpKQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJhZC0+cmVzZXQgPSBOVUxM
Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoHJldHVybiBQVFJfRVJSX09SX1pFUk8ocmFkLT5yZXNl
dCk7DQo+ID4gK30NCj4gPiArDQo+ID4gKyNlbmRpZg0KPiBVc2UgX19tYXliZV91bnVzZWQgZm9y
IHRoZSB0dyBmdW5jdGlvbnMgYWJvdmUuDQo+IEFuZCBsb29zZSB0aGUgaWZkZWYuLi4NClRoYW5r
cy4gV2lsbCBhcHBseS4NCj4gDQo+ID4gDQo+ID4gKw0KPiA+ICtzdGF0aWMgY29uc3Qgc3RydWN0
IGRldl9wbV9vcHMgcmFkX3BtX29wcyA9IHsNCj4gPiArwqDCoMKgwqDCoFNFVF9SVU5USU1FX1BN
X09QUyhyYWRfcGFuZWxfc3VzcGVuZCwgcmFkX3BhbmVsX3Jlc3VtZSwgTlVMTCkNCj4gPiArwqDC
oMKgwqDCoFNFVF9TWVNURU1fU0xFRVBfUE1fT1BTKHJhZF9wYW5lbF9zdXNwZW5kLCByYWRfcGFu
ZWxfcmVzdW1lKQ0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9k
ZXZpY2VfaWQgcmFkX29mX21hdGNoW10gPSB7DQo+ID4gK8KgwqDCoMKgwqB7IC5jb21wYXRpYmxl
ID0gInJheWRpdW0scm02NzE5MSIsIH0sDQo+ID4gK8KgwqDCoMKgwqB7IH0NCj4gV2Ugb2Z0ZW4s
IGJ1dCBub3QgYWx3YXlzLCB3cml0ZSB0aGlzIGFzIHsgLyogc2VudGluYWwgKi8gfSwNClRoYW5r
cy4gV2lsbCBhcHBseS4NCj4gDQo+ID4gDQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFC
TEUob2YsIHJhZF9vZl9tYXRjaCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgc3RydWN0IG1pcGlfZHNp
X2RyaXZlciByYWRfcGFuZWxfZHJpdmVyID0gew0KPiA+ICvCoMKgwqDCoMKgLmRyaXZlciA9IHsN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubmFtZSA9ICJwYW5lbC1yYXlkaXVtLXJt
NjcxOTEiLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5vZl9tYXRjaF90YWJsZSA9
IHJhZF9vZl9tYXRjaCwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAucG3CoMKgwqDC
oMKgPSAmcmFkX3BtX29wcywNCj4gPiArwqDCoMKgwqDCoH0sDQo+ID4gK8KgwqDCoMKgwqAucHJv
YmUgPSByYWRfcGFuZWxfcHJvYmUsDQo+ID4gK8KgwqDCoMKgwqAucmVtb3ZlID0gcmFkX3BhbmVs
X3JlbW92ZSwNCj4gPiArwqDCoMKgwqDCoC5zaHV0ZG93biA9IHJhZF9wYW5lbF9zaHV0ZG93biwN
Cj4gPiArfTsNCj4gPiArbW9kdWxlX21pcGlfZHNpX2RyaXZlcihyYWRfcGFuZWxfZHJpdmVyKTsN
Cj4gPiArDQo+ID4gK01PRFVMRV9BVVRIT1IoIlJvYmVydCBDaGlyYXMgPHJvYmVydC5jaGlyYXNA
bnhwLmNvbT4iKTsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJEUk0gRHJpdmVyIGZvciBSYXlk
aXVtIFJNNjcxOTEgTUlQSSBEU0kNCj4gPiBwYW5lbCIpOw0KPiA+ICtNT0RVTEVfTElDRU5TRSgi
R1BMIHYyIik7DQo+IFdpdGggdGhlIGFib3ZlIHRyaXZpYWxpdGllcyBjb25zaWRlcmVkL2ZpeGVk
Og0KPiBSZXZpZXdlZC1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJvcmcub3JnPg0KPiANCj4g
wqDCoMKgwqDCoMKgwqDCoFNhbQ==
