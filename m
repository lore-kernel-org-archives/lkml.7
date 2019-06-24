Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A02C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5062A2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 07:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YdtPy4f7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfFXHor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:44:47 -0400
Received: from mail-eopbgr80048.outbound.protection.outlook.com ([40.107.8.48]:20865
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726453AbfFXHoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNfKOHm0tGukvE4R2zYaYOhGBg0Uh78SvOksqp2+Xuk=;
 b=YdtPy4f7ZYRQW3+4cFhCUzOnUdNyoYFCjwILKDnngd3Oq/rx4RkIdFIGcV87xh7gCOcpR0ZSWp+gmWdz1Tu7JrsvFqjz6lTb19aTxmTru3lngPk5KJ/JHhgLUSWb0Hln2DhwY/zUExleMD1sBX76gkqeUyNe26H8m2zgF497bAY=
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.123.141) by
 VI1PR04MB5360.eurprd04.prod.outlook.com (20.178.120.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 07:44:40 +0000
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3d8f:3ac3:c34e:eb7b]) by VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3d8f:3ac3:c34e:eb7b%5]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 07:44:40 +0000
From:   Robert Chiras <robert.chiras@nxp.com>
To:     "festevam@gmail.com" <festevam@gmail.com>
CC:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sam@ravnborg.org" <sam@ravnborg.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>
Subject: Re: [EXT] Re: [PATCH v3 2/2] drm/panel: Add support for Raydium
 RM67191 panel driver
Thread-Topic: [EXT] Re: [PATCH v3 2/2] drm/panel: Add support for Raydium
 RM67191 panel driver
Thread-Index: AQHVJ2xXDzcS3eCEpkyDS1SMgLl/7qamJDGAgAROTwA=
Date:   Mon, 24 Jun 2019 07:44:39 +0000
Message-ID: <1561362278.9328.83.camel@nxp.com>
References: <1561037428-13855-1-git-send-email-robert.chiras@nxp.com>
         <1561037428-13855-3-git-send-email-robert.chiras@nxp.com>
         <CAOMZO5DS2v15h9E=qKg2vKuFkBSQQwdBHA5Th5mZ+ca6DWgQsw@mail.gmail.com>
In-Reply-To: <CAOMZO5DS2v15h9E=qKg2vKuFkBSQQwdBHA5Th5mZ+ca6DWgQsw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06659a48-b610-4772-1fff-08d6f877d065
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5360;
x-ms-traffictypediagnostic: VI1PR04MB5360:
x-microsoft-antispam-prvs: <VI1PR04MB5360D80793F9F3A6C3E71763E3E00@VI1PR04MB5360.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(366004)(199004)(189003)(50226002)(229853002)(11346002)(66946007)(446003)(73956011)(256004)(14444005)(5024004)(486006)(44832011)(54906003)(2351001)(2501003)(66556008)(66476007)(186003)(5660300002)(476003)(2616005)(66446008)(6916009)(76116006)(7416002)(86362001)(71190400001)(26005)(1411001)(71200400001)(1730700003)(8676002)(5640700003)(6246003)(99286004)(81156014)(81166006)(6486002)(8936002)(1361003)(66066001)(76176011)(36756003)(478600001)(6506007)(7736002)(305945005)(6116002)(53546011)(64756008)(3846002)(6512007)(68736007)(53936002)(6436002)(316002)(4326008)(25786009)(14454004)(103116003)(2906002)(102836004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5360;H:VI1PR04MB5967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zLoWA1sm7naGIEj8NEyEaS3uYGeyvo1qW6yiXp9SniwjV3BTzyE3MO0bb0lfUWnw5ajc6Nv6ZW3Z8CRcN++PB/KhMlEu3TlSNOfjpEhHdugNQYQPSung+Q3A8ZzX9cg54UOHfGqYvsBno6sh2gbBEsQ7Z4DXDtm8zx8FzFoh3iKepKYPjC87QojYjZOswDmQT3vHiNkofMeJ3HTmwVq7qS/5JB8iZuEBGu2k1aq+LzN1yIZ3Dm0okMRYdFNHYUv0xk3lraylwS0kfdBpI5EAKGJUw+Hyc4Av0XvZbRztZ/GoK6K5szONi8a6XfNKSqmlLi3MDtVM2Xg/1+kfvNfVvlnGS7mbx3THv61pLW3y33fJpAkv7S3bU2rrqfhg3/LpZ8rIseOuDG19RB+B2pYGjjrGRYlkVEkV6MHXSdF9xEY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1796AEB207541D4E834DA85DD569493F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06659a48-b610-4772-1fff-08d6f877d065
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 07:44:39.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: robert.chiras@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5360
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNClRoYW5rcyBmb3IgeW91ciBmZWVkYmFjay4gSSB3aWxsIGhhbmRsZSB0aGVt
IGFsbCwgYnV0IGZvciB0aGUgcG1fb3BzIEkNCmhhdmUgc29tZSBjb21tZW50cy4gU2VlIGlubGlu
ZS4NCg0KT24gVmksIDIwMTktMDYtMjEgYXQgMTA6NTkgLTAzMDAsIEZhYmlvIEVzdGV2YW0gd3Jv
dGU6DQo+IEhpIFJvYmVydCwNCj4gDQo+IE9uIFRodSwgSnVuIDIwLCAyMDE5IGF0IDEwOjMxIEFN
IFJvYmVydCBDaGlyYXMgPHJvYmVydC5jaGlyYXNAbnhwLmNvbQ0KPiA+IHdyb3RlOg0KPiANCj4g
PiANCj4gPiArZmFpbDoNCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAocmFkLT5yZXNldCkNCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKHJh
ZC0+cmVzZXQsIDEpOw0KPiBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAoKSBjYW4gaGFuZGxlIE5V
TEwsIHNvIG5vIG5lZWQgZm9yIHRoZSBpZigpDQo+IGNoZWNrLg0KPiANCj4gPiANCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBkaXNwbGF5X3RpbWluZyByYWRfZGVmYXVsdF90aW1pbmcgPSB7DQo+
ID4gK8KgwqDCoMKgwqDCoMKgLnBpeGVsY2xvY2sgPSB7IDEzMjAwMDAwMCwgMTMyMDAwMDAwLCAx
MzIwMDAwMDAgfSwNCj4gSGF2aW5nIHRoZSBzYW1lIGluZm9ybWF0aW9uIGxpc3RlZCB0aHJlZSB0
aW1lcyBkb2VzIG5vdCBzZWVtIHVzZWZ1bC4NCj4gDQo+IFlvdSBjb3VsZCB1c2UgYSBkcm1fZGlz
cGxheV9tb2RlIHN0cnVjdHVyZSB3aXRoIGEgc2luZ2xlIGVudHJ5DQo+IGluc3RlYWQuDQo+IA0K
PiA+IA0KPiA+ICvCoMKgwqDCoMKgwqDCoHZpZGVvbW9kZV9mcm9tX3RpbWluZygmcmFkX2RlZmF1
bHRfdGltaW5nLCAmcGFuZWwtPnZtKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgb2ZfcHJv
cGVydHlfcmVhZF91MzIobnAsICJ3aWR0aC1tbSIsICZwYW5lbC0+d2lkdGhfbW0pOw0KPiA+ICvC
oMKgwqDCoMKgwqDCoG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAiaGVpZ2h0LW1tIiwgJnBhbmVs
LT5oZWlnaHRfbW0pOw0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBwYW5lbC0+cmVzZXQgPSBk
ZXZtX2dwaW9kX2dldChkZXYsICJyZXNldCIsIEdQSU9EX09VVF9MT1cpOw0KPiBTaW5jZSB0aGlz
IGlzIG9wdGlvbmFsIGl0IHdvdWxkIGJlIGJldHRlciB0byB1c2UNCj4gZGV2bV9ncGlvZF9nZXRf
b3B0aW9uYWwoKSBpbnN0ZWFkLg0KPiANCj4gDQo+ID4gDQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKg
wqDCoGlmIChJU19FUlIocGFuZWwtPnJlc2V0KSkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcGFuZWwtPnJlc2V0ID0gTlVMTDsNCj4gPiArwqDCoMKgwqDCoMKgwqBlbHNlDQo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdwaW9kX3NldF92YWx1ZV9jYW5zbGVl
cChwYW5lbC0+cmVzZXQsIDEpOw0KPiBUaGlzIGlzIG5vdCBoYW5kbGluZyBkZWZlciBwcm9iaW5n
LCBzbyBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gZG8gbGlrZQ0KPiB0aGlzOg0KPiANCj4gcGFuZWwt
PnJlc2V0ID0gZGV2bV9ncGlvZF9nZXRfb3B0aW9uYWwoZGV2LCAicmVzZXQiLCBHUElPRF9PVVRf
TE9XKTsNCj4gaWYgKElTX0VSUihwYW5lbC0+cmVzZXQpKQ0KPiDCoMKgwqDCoMKgwqByZXR1cm7C
oMKgUFRSX0VSUihwYW5lbC0+cmVzZXQpOw0KPiANCj4gPiANCj4gPiArwqDCoMKgwqDCoMKgwqBt
ZW1zZXQoJmJsX3Byb3BzLCAwLCBzaXplb2YoYmxfcHJvcHMpKTsNCj4gPiArwqDCoMKgwqDCoMKg
wqBibF9wcm9wcy50eXBlID0gQkFDS0xJR0hUX1JBVzsNCj4gPiArwqDCoMKgwqDCoMKgwqBibF9w
cm9wcy5icmlnaHRuZXNzID0gMjU1Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGJsX3Byb3BzLm1heF9i
cmlnaHRuZXNzID0gMjU1Ow0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBwYW5lbC0+YmFja2xp
Z2h0ID0gZGV2bV9iYWNrbGlnaHRfZGV2aWNlX3JlZ2lzdGVyKGRldiwNCj4gPiBkZXZfbmFtZShk
ZXYpLA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqBkZXYsIGRzaSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgJnJhZF9ibF9vDQo+ID4gcHMsDQo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCZibF9w
cm9wcw0KPiA+ICk7DQo+IENvdWxkIHlvdSBwdXQgbW9yZSBwYXJhbWV0ZXJzIGludG8gdGhlIHNh
bWUgbGluZT8NCj4gDQo+IFVzaW5nIDQgbGluZXMgc2VlbXMgZXhjZXNzaXZlLg0KPiANCj4gPiAN
Cj4gPiArwqDCoMKgwqDCoMKgwqBpZiAoSVNfRVJSKHBhbmVsLT5iYWNrbGlnaHQpKSB7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IFBUUl9FUlIocGFuZWwtPmJhY2ts
aWdodCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoZGV2LCAi
RmFpbGVkIHRvIHJlZ2lzdGVyIGJhY2tsaWdodCAoJWQpXG4iLA0KPiA+IHJldCk7DQo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo+ID4gK8KgwqDCoMKgwqDC
oMKgfQ0KPiA+ICsNCj4gPiArwqDCoMKgwqDCoMKgwqBkcm1fcGFuZWxfaW5pdCgmcGFuZWwtPnBh
bmVsKTsNCj4gPiArwqDCoMKgwqDCoMKgwqBwYW5lbC0+cGFuZWwuZnVuY3MgPSAmcmFkX3BhbmVs
X2Z1bmNzOw0KPiA+ICvCoMKgwqDCoMKgwqDCoHBhbmVsLT5wYW5lbC5kZXYgPSBkZXY7DQo+ID4g
K8KgwqDCoMKgwqDCoMKgZGV2X3NldF9kcnZkYXRhKGRldiwgcGFuZWwpOw0KPiA+ICsNCj4gPiAr
wqDCoMKgwqDCoMKgwqByZXQgPSBkcm1fcGFuZWxfYWRkKCZwYW5lbC0+cGFuZWwpOw0KPiA+ICsN
Cj4gVW5uZWVkZWQgYmxhbmsgbGluZQ0KPiANCj4gPiANCj4gPiArwqDCoMKgwqDCoMKgwqBpZiAo
cmV0IDwgMCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHJldDsN
Cj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0ID0gbWlwaV9kc2lfYXR0YWNoKGRzaSk7DQo+
ID4gK8KgwqDCoMKgwqDCoMKgaWYgKHJldCA8IDApDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGRybV9wYW5lbF9yZW1vdmUoJnBhbmVsLT5wYW5lbCk7DQo+ID4gKw0KPiA+ICvC
oMKgwqDCoMKgwqDCoHJldHVybiByZXQ7DQo+IFlvdSBkaWQgbm90IGhhbmRsZSB0aGUgInBvd2Vy
IiByZWd1bGF0b3IuDQpUaGVyZSBpcyBubyBuZWVkIGZvciBhIHBvd2VyIHJlZ3VsYXRvci4NCj4g
DQo+ID4gDQo+ID4gK3N0YXRpYyBpbnQgX19tYXliZV91bnVzZWQgcmFkX3BhbmVsX3N1c3BlbmQo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJh
ZF9wYW5lbCAqcmFkID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICvCoMKgwqDC
oMKgwqDCoGlmICghcmFkLT5yZXNldCkNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0dXJuIDA7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoGRldm1fZ3Bpb2RfcHV0KGRl
diwgcmFkLT5yZXNldCk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmFkLT5yZXNldCA9IE5VTEw7DQo+
ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtz
dGF0aWMgaW50IF9fbWF5YmVfdW51c2VkIHJhZF9wYW5lbF9yZXN1bWUoc3RydWN0IGRldmljZSAq
ZGV2KQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoMKgc3RydWN0IHJhZF9wYW5lbCAqcmFkID0g
ZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKw0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChyYWQt
PnJlc2V0KQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsNCj4g
PiArDQo+ID4gK8KgwqDCoMKgwqDCoMKgcmFkLT5yZXNldCA9IGRldm1fZ3Bpb2RfZ2V0KGRldiwg
InJlc2V0IiwgR1BJT0RfT1VUX0xPVyk7DQo+IFdoeSBkbyB5b3UgY2FsbCBkZXZtX2dwaW9kX2dl
dCgpIG9uY2UgYWdhaW4/DQo+IA0KPiBJIGFtIGhhdmluZyBhIGhhcmQgdGltZSB0byB1bmRlcnN0
YW5kIHRoZSBuZWVkIGZvciB0aGlzDQo+IHN1c3BlbmQvcmVzdW1lIGhvb2tzLg0KPiANCj4gQ2Fu
J3QgeW91IHNpbXBseSByZW1vdmUgdGhlbT8NClRoZSByZXNldCBncGlvIHBpbiBpcyBzaGFyZWQg
YmV0d2VlbiB0aGUgRFNJIGRpc3BsYXkgY29udHJvbGxlciBhbmQNCnRvdWNoIGNvbnRyb2xsZXIs
IGJvdGggZm91bmQgb24gdGhlIHNhbWUgcGFuZWwuIFNpbmNlLCB0aGUgdG91Y2ggZHJpdmVyDQph
bHNvIGFjY2VzZXMgdGhpcyBncGlvIHBpbiwgaW4gc29tZSBjYXNlcyB0aGUgZGlzcGxheSBjYW4g
YmUgcHV0IHRvDQpzbGVlcCwgYnV0IHRoZSB0b3VjaCBpcyBzdGlsbCBhY3RpdmUuIFRoaXMgaXMg
d2h5LCBkdXJpbmcgc3VzcGVuZCBJDQpyZWxlYXNlIHRoZSBncGlvIHJlc291cmNlLCBhbmQgSSBo
YXZlIHRvIHRha2UgaXQgYmFjayBpbiByZXN1bWUuDQpXaXRob3V0IHRoaXMgcmVsZWFzZS9hY3F1
aXJlIG1lY2hhbmlzbSBkdXJpbmcgc3VzcGVuZC9yZXN1bWUsIHN0cmVzcy0NCnRlc3RzIHNob3dl
ZCBzb21lIGZhaWx1cmVzOiB0aGUgcmVzdW1lIGZyZWV6ZXMgY29tcGxldGx5Lg==
