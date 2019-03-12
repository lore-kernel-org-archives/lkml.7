Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3CCFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C602214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 01:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B3YgcI6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfCLBnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:43:42 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:12138
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbfCLBnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 21:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gm7+3MY1W7sLrW4kyrmyd8WUV+hu59NXwmr1iaT47ZU=;
 b=B3YgcI6FsRYA5ANXfpiFzl7vnIjJGf4VBMPYqHnhFHSVcYV33CsyatgF2ZEsaBJVsf5+cKnhQl6RyAUpbnE7HKiaCh3vpdI0HBkS9Z72yOWp8F+qH5aOZHHGgTdMS3Eq2/yr/wCiXpFoZFamvFTkDKE4hvPw0mooPpZADMAvLx0=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3738.eurprd04.prod.outlook.com (52.134.70.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 01:43:34 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::1cb4:3e1c:fc85:7ed7%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 01:43:34 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 1/3] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
Thread-Topic: [PATCH V4 1/3] dt-bindings: memory-controllers: freescale: add
 MMDC binding doc
Thread-Index: AQHUz819CWq3wsojT0+oGW04Z701rqYHGsmAgAAo6oA=
Date:   Tue, 12 Mar 2019 01:43:34 +0000
Message-ID: <DB3PR0402MB3916F5563191799BB34384D7F5490@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1551403185-16314-1-git-send-email-Anson.Huang@nxp.com>
 <20190311225309.GA32334@bogus>
In-Reply-To: <20190311225309.GA32334@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caf9866a-d898-4552-326f-08d6a68c2409
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3738;
x-ms-traffictypediagnostic: DB3PR0402MB3738:
x-microsoft-exchange-diagnostics: =?gb2312?B?MTtEQjNQUjA0MDJNQjM3Mzg7MjM6Ujh5NjdXQjFLeXVVa3M1M1loTlhmZzBx?=
 =?gb2312?B?WWlncmZPYmVqYkZ3Ymg3cXlTZUF0Q1FLOVJlVVBDcXMrTVFUbFNqTWNJd0RW?=
 =?gb2312?B?UG1LazFGSEtWWkxXTWQzZWlnVi9aMVdBRWxPVXBhMUlhRDVUdlpXMS9IVTZh?=
 =?gb2312?B?NTNGZlh6WEcvN3pzYWNlUE1aSVVLK2VmUWtEV3hIcDV2YWJoUDRhNUpIT0sx?=
 =?gb2312?B?S3NjVGppTTIvMFJLSXdqdzNXRm1obktWV1FLRzZ1UmM1TTN1akxrdy9mUG9P?=
 =?gb2312?B?U1ZRTUFidDQvL1JDRFAwVHdrdEl1aEhNMlh1UVo5WDBpVGV0ZjFieWNzM1BF?=
 =?gb2312?B?YmUyRXZCaDR5dW5jRFFyWm83Q2VXYkR0bFpPNzdvNmFjVEtjRWRxYUUvUy9T?=
 =?gb2312?B?Uml3TjBuZk5TN2w3T1ZVVE4xZUZjYXFHZTZuQkc3OU1sSCthN1ovdWpqN2th?=
 =?gb2312?B?ZXNCZ3YvMTVxV1FNTHJGazZNalduSXVFMUFiem83RU1Ga1ppa2dXcDM1enFG?=
 =?gb2312?B?T3hrMjE1eEhLSndJQTZqYlZiZUhmT2ROU2ZMNzR5WHE4ZVVadXI2THlFemRk?=
 =?gb2312?B?T2VYK3Q2RXRqWnJsVzNwMytHK2xkOFpNdzFWOWRLUXVWOVpUbnlrdTFEYmtE?=
 =?gb2312?B?NytVSjljUnh0YWdENEVrS0NHYXpQZ3R4MFllV2doRVJWUTRUTkQ3UjhaNWV4?=
 =?gb2312?B?Q1dtRGJSTnNtME9pMURhV25zTmNpZk9jZUZZampraUd1VEZIMTRGMm8wWXBK?=
 =?gb2312?B?Y2dMVkkwc1dFREtJK3dsaWI1U3VsdnRXRXlRdEVVUEN5Q01zek42S2dnR0Jk?=
 =?gb2312?B?Zy81ZDJ1TjBPVVZxVlV0MUZESDlUcytVZHdEOUxVcWVJMlV4WVR3U3FlbTds?=
 =?gb2312?B?THlKMVB0aVkrWDNTL2t3VVJ3U2ZES0NPNklGcWtMN2JkMCs1NitlcUZzSHBy?=
 =?gb2312?B?ZmZrMmlFcjczSXZiYmttWWIzWHJja0dJelk1Uk1hN0oyTGZqYXdWcEcvcFFC?=
 =?gb2312?B?YWdpTnRwOWl5WFhGbjV0NEdRdlI0UzNBTGpUZXJLZXdnNjlhY1dFYkhEOW02?=
 =?gb2312?B?dCtCSkk2Mlg5SXIwdlZVMElwNnFxSHZUWkcrUVhYL3pybkhJdUxZdTQvVTha?=
 =?gb2312?B?Z2dCN2NyR3h0ZzA0T3JHT2VlYUVtN2hnYTRjbmF3YWVFMTI1RjUvc3BxS3Bx?=
 =?gb2312?B?STlmWFJQaS90bHd4bndmTTQ5L3g3dFJZN0o0dUUrQkF1NFpkN3RCTnBFekNh?=
 =?gb2312?B?bXQ3MkdCL2ZtYWpETzM5VElycDg2bHg5TlVuSGVTRHFVbGo2YlZPS3o5QlU4?=
 =?gb2312?B?czFuOU44Smc2bDFuUXVNbHhCUUd1SUkzR1hZZDdJZkQwMzNnejd2RUY2VE9M?=
 =?gb2312?B?WUMvQW45STkybStNMHcyM1pUMzJ3blBSZHk4aUViRVhHajFuWEJPcDdyS056?=
 =?gb2312?B?RFh3cFowTGVqNGN4dG90NSs3YUY4KzJ3OE15YTZUSFIzQVJrNURXUWZQOEQz?=
 =?gb2312?B?VUM2RFhMeWl6Q25sZEEvWEVGRFhlVndBL21DbUhBQ2pJZG5UQitLdW9KNENk?=
 =?gb2312?B?Z3Z2aGljVkdHVmJEaFRTTFZrT0J3MFZXVjF5SWkzTkhjNU5hcmZsZFJwekhT?=
 =?gb2312?B?UHlBVDVmQjVYVDd0YU1Wc3dpSE5HMysyc2VHUmF1cVI0V25kRkt3MU1xeGsv?=
 =?gb2312?B?ZUt6a1BtWFYvOUV6SzVTT2pwYldkbm1sV05ISmxRWmFVN3Rsc1FZZ0ZKZ284?=
 =?gb2312?B?WTFYOWlXMHJrUG8ybndqMm5BPT0=?=
x-microsoft-antispam-prvs: <DB3PR0402MB37382909E28B7ABBE8CB7744F5490@DB3PR0402MB3738.eurprd04.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(376002)(39860400002)(396003)(366004)(189003)(199004)(13464003)(33656002)(76176011)(26005)(186003)(102836004)(7696005)(316002)(25786009)(99286004)(4326008)(97736004)(6916009)(478600001)(3846002)(6116002)(53546011)(14454004)(105586002)(68736007)(6506007)(106356001)(11346002)(74316002)(55016002)(81156014)(81166006)(446003)(9686003)(8676002)(476003)(6246003)(305945005)(8936002)(53936002)(54906003)(44832011)(7736002)(486006)(66066001)(229853002)(5660300002)(6436002)(52536013)(71190400001)(86362001)(256004)(71200400001)(2906002)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3738;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kFL/Rut0b1HR4HoZfsykMScG0Uq1SVnCA0/rmAWsJM4LfFgpC+DYSyMay4JoXZ0PQ1GXekttK0+3QryRUbXaeBwtny5gTV6ywAbWrq3ClwDT+VcL1FFyQRdqIssJC3HJ0w3mXI0MKifJJx0e5Ys5pj3deXVSnwdTapn3+PFbIHRfKSAlyNrFFNCvSmWhRG2+1yVUCB2oTtlpqjt/V5RnAzhcSZYlUL1vXlFuTy8TOVvS5YRKW8AF/J4qHhmzXOoP3hYTof+gWgikogQ8deLH3ve7kALADgeuHi+C7HCr5M/jY6Dzzr0bBTLsdgYeC+3uRJcZekqmByH0pQl5Qt1VJNT/J6BYBubyhoolDeDOLI2BJeZ1S/eYMqiJssNwYezEeRTLQNHC2V2BgWoEp+vg7WZ32v4wtOk/kNDpa9VI/h8=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf9866a-d898-4552-326f-08d6a68c2409
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 01:43:34.8737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3738
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFJvYiBIZXJyaW5nIFttYWlsdG86cm9iaEBrZXJuZWwub3Jn
XQ0KPiBTZW50OiAyMDE5xOoz1MIxMsjVIDY6NTMNCj4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5o
dWFuZ0BueHAuY29tPg0KPiBDYzogbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5l
bC5vcmc7DQo+IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZmVzdGV2YW1AZ21haWwuY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBWNCAxLzNdIGR0LWJpbmRpbmdzOiBtZW1vcnktY29udHJvbGxlcnM6IGZyZWVzY2Fs
ZTogYWRkDQo+IE1NREMgYmluZGluZyBkb2MNCj4gDQo+IE9uIEZyaSwgTWFyIDAxLCAyMDE5IGF0
IDAxOjI0OjE4QU0gKzAwMDAsIEFuc29uIEh1YW5nIHdyb3RlOg0KPiA+IEZyZWVzY2FsZSBNTURD
IChNdWx0aSBNb2RlIEREUiBDb250cm9sbGVyKSBkcml2ZXIgaXMgc3VwcG9ydGVkIHNpbmNlDQo+
ID4gaS5NWDZRLCBidXQgbm90IHlldCBkb2N1bWVudGVkLCB0aGlzIHBhdGNoIGFkZHMgYmluZGlu
ZyBkb2MgZm9yIE1NREMNCj4gPiBtb2R1bGUgZHJpdmVyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1i
eTogQW5zb24gSHVhbmcgPEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdl
cyBzaW5jZSBWMzoNCj4gPiAJLSBhZGQgaS5NWDZRUCBjb21wYXRpYmxlIG5hbWUuDQo+ID4gLS0t
DQo+ID4gIC4uLi9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvZnNsL21tZGMudHh0ICAgICAg
IHwgMzMNCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzMg
aW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWVtb3J5LWNvbnRyb2xsZXJzL2ZzbC9tbWRjLnR4dA0KPiA+
DQo+ID4gZGlmZiAtLWdpdA0KPiA+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21lbW9yeS1jb250cm9sbGVycy9mc2wvbW1kYy50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tZW1vcnktY29udHJvbGxlcnMvZnNsL21tZGMudHh0DQo+ID4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi5lNGUwYjUwDQo+ID4gLS0tIC9k
ZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZW1v
cnktDQo+IGNvbnRyb2xsZXJzL2ZzbC9tbWRjLnR4DQo+ID4gKysrIHQNCj4gPiBAQCAtMCwwICsx
LDMzIEBADQo+ID4gK0ZyZWVzY2FsZSBNdWx0aSBNb2RlIEREUiBjb250cm9sbGVyIChNTURDKQ0K
PiA+ICsNCj4gPiArUmVxdWlyZWQgcHJvcGVydGllcyA6DQo+ID4gKy0gY29tcGF0aWJsZSA6IHNo
b3VsZCBiZSBvbmUgb2YgZm9sbG93aW5nOg0KPiA+ICsJZm9yIGkuTVg2US9pLk1YNkRMOg0KPiA+
ICsJLSAiZnNsLGlteDZxLW1tZGMiOw0KPiA+ICsJZm9yIGkuTVg2UVA6DQo+ID4gKwktICJmc2ws
aW14NnFwLW1tZGMiLCAiZnNsLGlteDZxLW1tZGMiOw0KPiA+ICsJZm9yIGkuTVg2U0w6DQo+ID4g
KwktICJmc2wsaW14NnNsLW1tZGMiLCAiZnNsLGlteDZxLW1tZGMiOw0KPiA+ICsJZm9yIGkuTVg2
U0xMOg0KPiA+ICsJLSAiZnNsLGlteDZzbGwtbW1kYyIsICJmc2wsaW14NnEtbW1kYyI7DQo+ID4g
Kwlmb3IgaS5NWDZTWDoNCj4gPiArCS0gImZzbCxpbXg2c3gtbW1kYyIsICJmc2wsaW14NnEtbW1k
YyI7DQo+ID4gKwlmb3IgaS5NWDZVTC9pLk1YNlVMTC9pLk1YNlVMWjoNCj4gPiArCS0gImZzbCxp
bXg2dWwtbW1kYyIsICJmc2wsaW14NnEtbW1kYyI7DQo+ID4gKwlmb3IgaS5NWDdVTFA6DQo+ID4g
KwktICJmc2wsaW14N3VscC1tbWRjIiwgImZzbCxpbXg2cS1tbWRjIjsNCj4gPiArLSByZWcgOiBh
ZGRyZXNzIGFuZCBzaXplIG9mIE1NREMgRERSIGNvbnRyb2xsZXIgcmVnaXN0ZXJzDQo+ID4gKw0K
PiA+ICtPcHRpb25hbCBwcm9wZXJ0aWVzIDoNCj4gPiArLSBjbG9ja3MgOiB0aGUgY2xvY2sgcHJv
dmlkZWQgYnkgdGhlIFNvQyB0byBhY2Nlc3MgdGhlIE1NREMgcmVnaXN0ZXJzDQo+ID4gKw0KPiA+
ICtFeGFtcGxlIDoNCj4gPiArCW1tZGMwOiBtZW1vcnktY29udHJvbGxlckAyMWIwMDAwIHsgLyog
TU1EQzAgKi8NCj4gPiArCQljb21wYXRpYmxlID0gImZzbCxpbXg2cS1tbWRjIjsNCj4gPiArCQly
ZWcgPSA8MHgwMjFiMDAwMCAweDQwMDA+Ow0KPiA+ICsJCWNsb2NrcyA9IDwmY2xrcyBJTVg2UURM
X0NMS19NTURDX1AwX0lQRz47DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJbW1kYzE6IG1lbW9yeS1j
b250cm9sbGVyQDIxYjQwMDAgeyAvKiBNTURDMSAqLw0KPiA+ICsJCXJlZyA9IDwweDAyMWI0MDAw
IDB4NDAwMD47DQo+IA0KPiBXaGF0IGlzIHRoaXMgbm9kZT8gTm8gY29tcGF0aWJsZSBoZXJlIHNo
b3VsZCBiZSBjb25zaWRlcmVkIGludmFsaWQuDQo+IA0KPiBTZWVtcyBsaWtlIG1heWJlIHRoZSAx
c3Qgbm9kZSBzaG91bGQgaGF2ZSAyIHJlZ2lzdGVyIHJhbmdlcyBpZiB5b3Ugd2FudCBhDQo+IHNp
bmdsZSBkZXZpY2UuDQoNCkkgdGhpbmsgbW1kYzEncyBjb21wYXRpYmxlIGlzIG1pc3NlZCBmcm9t
IGJlZ2lubmluZywgSSB3aWxsIGFkZCBhIHNlcGFyYXRlIHBhdGNoIGZvciBpdA0KYW5kIG1ha2Ug
aXRzIHN0YXR1cyBhcyBkaXNhYmxlZCBieSBkZWZhdWx0LCBzaW5jZSBtb3N0IG9mIGkuTVg2IHBs
YXRmb3JtcyBPTkxZIHVzZXMNCm1tZGMwLCBPTkxZIHZlcnkgZmV3IHNwZWNpYWwgcGxhdGZvcm1z
IHVzZSBkdWFsIGNoYW5uZWxzLg0KDQpUaGFua3MsDQpBbnNvbi4NCg0KPiANCj4gUm9iDQo=
