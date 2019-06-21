Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2108FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB5120679
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 14:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtAgQkpT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfFUORM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 10:17:12 -0400
Received: from mail-eopbgr40087.outbound.protection.outlook.com ([40.107.4.87]:60902
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725975AbfFUORM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 10:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq/Z2rq1N2NySK5wO/nneFl43iIw00N+AmZgMnaFNnE=;
 b=AtAgQkpT9b63dDsrLm8KUqeJydRyTBqpO+hYHbREISFl1Qxi/DfQT/iXifgZZAQfgnOTw6D/9xxdgf9Kf+2OALS/k4BO4/B9vhU6ULg+ztRhdl3ESTGqEfyXhdZGPS1NKmOaEIFWuayBr3CBfDbERvivV1DoHXFeU3SkqxwUpSY=
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com (20.178.123.141) by
 VI1PR04MB4317.eurprd04.prod.outlook.com (52.134.31.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Fri, 21 Jun 2019 14:16:28 +0000
Received: from VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7]) by VI1PR04MB5967.eurprd04.prod.outlook.com
 ([fe80::3dd4:5031:dc06:1fd7%7]) with mapi id 15.20.1987.014; Fri, 21 Jun 2019
 14:16:28 +0000
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
Subject: Re: [EXT] Re: [PATCH v3 1/2] dt-bindings: display: panel: Add support
 for Raydium RM67191 panel
Thread-Topic: [EXT] Re: [PATCH v3 1/2] dt-bindings: display: panel: Add
 support for Raydium RM67191 panel
Thread-Index: AQHVJ2xX1b/vfXFflkiTFJeIvUdOWqamJJQAgAAEZ4A=
Date:   Fri, 21 Jun 2019 14:16:28 +0000
Message-ID: <1561126587.9328.76.camel@nxp.com>
References: <1561037428-13855-1-git-send-email-robert.chiras@nxp.com>
         <1561037428-13855-2-git-send-email-robert.chiras@nxp.com>
         <CAOMZO5DunK3+ovBd0c0X4NTf-zkW1Tjz6KgXFMaRQKMk2SBMiw@mail.gmail.com>
In-Reply-To: <CAOMZO5DunK3+ovBd0c0X4NTf-zkW1Tjz6KgXFMaRQKMk2SBMiw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.18.5.2-0ubuntu3.2 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=robert.chiras@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10cc73a1-d7b7-417a-eb2e-08d6f6530d38
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB4317;
x-ms-traffictypediagnostic: VI1PR04MB4317:
x-microsoft-antispam-prvs: <VI1PR04MB4317A15721CDE1EB8C33447BE3E70@VI1PR04MB4317.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0075CB064E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(136003)(366004)(396003)(39860400002)(189003)(199004)(76116006)(103116003)(66476007)(486006)(86362001)(6436002)(5640700003)(305945005)(54906003)(2501003)(73956011)(1361003)(6486002)(8676002)(66066001)(71200400001)(99286004)(5660300002)(229853002)(25786009)(316002)(36756003)(2906002)(4326008)(6246003)(1411001)(6512007)(44832011)(186003)(6916009)(1730700003)(7416002)(446003)(476003)(8936002)(53936002)(71190400001)(66556008)(256004)(50226002)(81156014)(102836004)(6506007)(64756008)(3846002)(2351001)(66946007)(66446008)(11346002)(81166006)(7736002)(478600001)(6116002)(53546011)(26005)(76176011)(2616005)(68736007)(14454004)(99106002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4317;H:VI1PR04MB5967.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HpN0ykw6GU26lNgmuHBKNqrA4MByGFXB2AabWpPDUUe2xACzs8tIKsg9XYJ2uYB9SVGGsU3e+Pcrn5wSsZcqfwEN6v2f0lUdT1mwOy6XK2M3VL46fhseB/xTkdzOmtCMKyMrLSscVK3Y+etkUsBpnVPzJ2AaUc+i4EmyPCQ2OxSRLmc4PDhXRzP93OzzarCULcketo4Vk0p5yfN83mdliGHCJjbN2Yio17j16FrGMMdSopuWwK2mZVXbuu+n3VX1NTFXt9zQgDxi8MreUp7F6fX45eg8wYcpxnOdkzZJwfcQzZXcDBGfQyoAEeuvcu6QtMhIg+CcMvO9T/sqL2jZFTUt+PvE/UdU5FjYyVUmu42ZuNLniMP9nzHOjomUuSWnGNAjMS9jeNnMOKbe1jj1czvdMa6KbteYHU6mOqKXFGE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EF40643811A1D4193F3D91D3C679BD7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10cc73a1-d7b7-417a-eb2e-08d6f6530d38
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2019 14:16:28.3256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: robert.chiras@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmFiaW8sDQoNCk9uIFZpLCAyMDE5LTA2LTIxIGF0IDExOjAwIC0wMzAwLCBGYWJpbyBFc3Rl
dmFtIHdyb3RlOg0KPiBIaSBSb2JlcnQsDQo+IA0KPiBPbiBUaHUsIEp1biAyMCwgMjAxOSBhdCAx
MDozMiBBTSBSb2JlcnQgQ2hpcmFzIDxyb2JlcnQuY2hpcmFzQG54cC5jb20NCj4gPiB3cm90ZToN
Cj4gPiANCj4gPiANCj4gPiBBZGQgZHQtYmluZGluZ3MgZG9jdW1lbnRhdGlvbiBmb3IgUmF5ZGl1
bSBSTTY3MTkxIERTSSBwYW5lbC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSb2JlcnQgQ2hp
cmFzIDxyb2JlcnQuY2hpcmFzQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFNhbSBSYXZuYm9y
ZyA8c2FtQHJhdm5ib3JnLm9yZz4NCj4gPiAtLS0NCj4gPiDCoC4uLi9iaW5kaW5ncy9kaXNwbGF5
L3BhbmVsL3JheWRpdW0scm02NzE5MS50eHTCoMKgwqDCoMKgfCAzOQ0KPiA+ICsrKysrKysrKysr
KysrKysrKysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspDQo+ID4g
wqBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvZGlzcGxheS9wYW5lbC9yYXlkaXVtLHJtNjcxOTEudHh0DQo+ID4gDQo+ID4gZGlmZiAtLWdp
dA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwv
cmF5ZGl1bSxybTY3MTkxLnQNCj4gPiB4dA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2Rpc3BsYXkvcGFuZWwvcmF5ZGl1bSxybTY3MTkxLnQNCj4gPiB4dA0KPiA+IG5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5kZXggMDAwMDAwMC4uNTJhZjI3Mg0KPiA+IC0tLSAv
ZGV2L251bGwNCj4gPiArKysNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9kaXNwbGF5L3BhbmVsL3JheWRpdW0scm02NzE5MS50DQo+ID4geHQNCj4gPiBAQCAtMCwwICsx
LDM5IEBADQo+ID4gK1JheWRpdW0gUk02NzE3MSBPTEVEIExDRCBwYW5lbCB3aXRoIE1JUEktRFNJ
IHByb3RvY29sDQo+ID4gKw0KPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICstIGNvbXBh
dGlibGU6wqDCoMKgwqDCoMKgwqDCoMKgwqAicmF5ZGl1bSxybTY3MTkxIg0KPiA+ICstIHJlZzrC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdmlydHVhbCBjaGFubmVsIGZvciBNSVBJ
LURTSSBwcm90b2NvbA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgbXVzdCBiZSA8MD4NCj4gPiArLSBkc2ktbGFuZXM6wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoG51bWJlciBvZiBEU0kgbGFuZXMgdG8gYmUgdXNlZA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXVzdCBiZSA8Mz4gb3IgPDQ+DQo+ID4gKy0g
cG9ydDrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlucHV0IHBvcnQgbm9kZSB3aXRo
IGVuZHBvaW50IGRlZmluaXRpb24gYXMNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGRlZmluZWQgaW4NCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvZ3JhcGgudHh0Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgdGhlIGlucHV0IHBvcnQgc2hvdWxkIGJlIGNvbm5lY3RlZCB0byBh
DQo+ID4gTUlQSS1EU0kgZGV2aWNlDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBkcml2ZXINCj4gPiArDQo+ID4gK09wdGlvbmFsIHByb3BlcnRpZXM6
DQo+ID4gKy0gcmVzZXQtZ3Bpb3M6wqDCoMKgwqDCoMKgwqDCoMKgYSBHUElPIHNwZWMgZm9yIHRo
ZSBSU1RfQiBHUElPIHBpbg0KPiA+ICstIHdpZHRoLW1tOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHNlZSBwYW5lbC1jb21tb24udHh0DQo+ID4gKy0gaGVpZ2h0LW1tOsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBzZWUgcGFuZWwtY29tbW9uLnR4dA0KPiA+ICstIHZpZGVvLW1vZGU6wqDCoMKgwqDCoMKg
wqDCoMKgwqAwIC0gYnVyc3QtbW9kZQ0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgMSAtIG5vbi1idXJzdCB3aXRoIHN5bmMgZXZlbnQNCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDIgLSBub24tYnVyc3Qg
d2l0aCBzeW5jIHBvIHVsc2UNCj4gTm8gcG93ZXItc3VwcGx5IHByb3BlcnR5Pw0KRnJvbSB3aGF0
IEkndmUgc2VlbiBpbiB0aGUgc2NoZW1hdGljcywgdGhlIHBvd2VyIGxpbmVzIG9uIHRoZSBEU0kg
cG9ydA0Kb24gYWxsIHRoZSBpLk1YOCBjb3JlcyBhcmUgY29taW5nIGZyb20gYSBQTUlDIHByb3Zp
ZGluZyBwb3dlciBmb3IgYWxsDQp0aGUgcGVyaXBoZXJhbHMuIFNpbmNlIEkgZGlkbid0IGZpbmQg
YSB3YXkgdG8gY3V0IHRoZSBwb3dlciBvbiBhIHNpbmdsZQ0KcGVyaXBoZXJhbCAobGlrZSBEU0ks
IGZvciBleGFtcGxlKSBpdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgZm9yIHBvd2VyLQ0Kc3VwcGx5IHBy
b3BlcnR5LiBGb3Igbm93LCBhdCBsZWFzdC4=
