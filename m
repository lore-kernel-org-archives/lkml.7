Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817D4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCF32070B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PHQpvYPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbfCZGxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:53:40 -0400
Received: from mail-eopbgr50089.outbound.protection.outlook.com ([40.107.5.89]:10865
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730575AbfCZGxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H37Uib2Qb/zaje6X7CmddM3uumDVt85UnnkqaNKDFcQ=;
 b=PHQpvYPWvu/hKUrItY1yrRQR6HHfpZtPhTe2ndTwH0Wzdr5Jsm3i5xfd4wYhyLKfcYG+rwSDhw44VDYmZ9EeuGR7RYRgt9h+epBF4U3yAAPX93os7dBZZksUMlFDgO7Z9uGStEYm+9KViRhNat8C2x980jVdEB4oAvmxSCtuvzw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 06:53:33 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::f1b4:a1fb:cfd1:3f08%7]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 06:53:33 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "otavio@ossystems.com.br" <otavio@ossystems.com.br>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "jan.tuerk@emtrion.com" <jan.tuerk@emtrion.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V9 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Topic: [PATCH V9 1/5] dt-bindings: pwm: Add i.MX TPM PWM binding
Thread-Index: AQHU4FFLawhysUr2ckuOKuIEIybWsaYc1aWAgABF1lCAAGTC4A==
Date:   Tue, 26 Mar 2019 06:53:33 +0000
Message-ID: <DB3PR0402MB3916C72A8FE827F965627E91F55F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1553218974-20464-1-git-send-email-Anson.Huang@nxp.com>
 <1553218974-20464-2-git-send-email-Anson.Huang@nxp.com>
 <20190325204137.GA19824@bogus>
 <DB3PR0402MB3916B84081393C46609FD178F55F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B84081393C46609FD178F55F0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd91a49c-5016-4c6f-444e-08d6b1b7c33b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB3675978A3A26503EFF8111B8F55F0@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(396003)(366004)(346002)(13464003)(199004)(189003)(66066001)(486006)(105586002)(186003)(68736007)(11346002)(446003)(33656002)(2906002)(93886005)(44832011)(71190400001)(6436002)(256004)(81166006)(8676002)(81156014)(97736004)(106356001)(476003)(14444005)(53936002)(55016002)(52536014)(71200400001)(26005)(93156006)(9686003)(6246003)(316002)(99286004)(54906003)(305945005)(6116002)(6506007)(25786009)(86362001)(7736002)(74316002)(7696005)(478600001)(76176011)(4326008)(14454004)(229853002)(6916009)(7416002)(5660300002)(102836004)(8936002)(3846002)(2940100002)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iIvzVhVUfLKHm8fo0D5ZwujOo/9zcq3RZCY6AWTrh89Q2NzumI7HzPBlO7T5F8l8aH8jj4Lak+/gthyzNoqrrfFaxO7J0zF+9KcsHc2Dai5CV/A3GDcxkBYQAS1JJ4icRqL2NU6ulQnbAo3zBVUed0eifTSg7adV9RB1/8qXzguFBhCmMwlr8rP8eii5AGWJ3I3O5uY4H4Dg50qwf3Y7Ya6Mp8X+hW2iKwod7VOJdkEVKcAQBf4fTuiq8pQuBxUh3I6Dp/+SG2Iabt4AjYRw4rut0WgXtc145rYJhd/oX4G21Etz22EfMKLYLNZoKrPmbAZ4OJj+nI8rwnVjuoTQ8ilgMQaLd4j9seyGTj/E1i10w2zrIg36Ed+AymAbgEhA2snadhK2yy3eYPfDa2wXe3eUXJGhwOd3nQ2fbql+X2g=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd91a49c-5016-4c6f-444e-08d6b1b7c33b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 06:53:33.0715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFJvYg0KDQpCZXN0IFJlZ2FyZHMhDQpBbnNvbiBIdWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IEFuc29uIEh1YW5nDQo+IFNlbnQ6IDIwMTnE6jPUwjI2yNUg
ODo1Ng0KPiBUbzogJ1JvYiBIZXJyaW5nJyA8cm9iaEBrZXJuZWwub3JnPg0KPiBDYzogdGhpZXJy
eS5yZWRpbmdAZ21haWwuY29tOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gc2hhd25ndW9Aa2Vy
bmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0K
PiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgc3RlZmFuQGFnbmVy
LmNoOw0KPiBvdGF2aW9Ab3NzeXN0ZW1zLmNvbS5icjsgTGVvbmFyZCBDcmVzdGV6IDxsZW9uYXJk
LmNyZXN0ZXpAbnhwLmNvbT47DQo+IFJvYmluIEdvbmcgPHlpYmluLmdvbmdAbnhwLmNvbT47IGph
bi50dWVya0BlbXRyaW9uLmNvbTsgbGludXgtDQo+IHB3bUB2Z2VyLmtlcm5lbC5vcmc7IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyB1LmtsZWluZS0NCj4ga29lbmln
QHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPg0KPiBTdWJq
ZWN0OiBSRTogW1BBVENIIFY5IDEvNV0gZHQtYmluZGluZ3M6IHB3bTogQWRkIGkuTVggVFBNIFBX
TSBiaW5kaW5nDQo+IA0KPiBIaSwgUm9iDQo+IA0KPiBCZXN0IFJlZ2FyZHMhDQo+IEFuc29uIEh1
YW5nDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogUm9iIEhl
cnJpbmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQo+ID4gU2VudDogMjAxOcTqM9TCMjbI1SA0
OjQyDQo+ID4gVG86IEFuc29uIEh1YW5nIDxhbnNvbi5odWFuZ0BueHAuY29tPg0KPiA+IENjOiB0
aGllcnJ5LnJlZGluZ0BnbWFpbC5jb207IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiA+IHNoYXdu
Z3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGtlcm5lbEBwZW5ndXRyb25p
eC5kZTsNCj4gPiBmZXN0ZXZhbUBnbWFpbC5jb207IGxpbnV4QGFybWxpbnV4Lm9yZy51azsgc3Rl
ZmFuQGFnbmVyLmNoOw0KPiA+IG90YXZpb0Bvc3N5c3RlbXMuY29tLmJyOyBMZW9uYXJkIENyZXN0
ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPjsNCj4gPiBSb2JpbiBHb25nIDx5aWJpbi5nb25n
QG54cC5jb20+OyBqYW4udHVlcmtAZW10cmlvbi5jb207IGxpbnV4LQ0KPiA+IHB3bUB2Z2VyLmtl
cm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+ID4ga2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHUu
a2xlaW5lLQ0KPiA+IGtvZW5pZ0BwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1p
bXhAbnhwLmNvbT4NCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIFY5IDEvNV0gZHQtYmluZGluZ3M6
IHB3bTogQWRkIGkuTVggVFBNIFBXTSBiaW5kaW5nDQo+ID4NCj4gPiBPbiBGcmksIE1hciAyMiwg
MjAxOSBhdCAwMTo0ODowNUFNICswMDAwLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gPiA+IEFkZCBp
Lk1YIFRQTShMb3cgUG93ZXIgVGltZXIvUHVsc2UgV2lkdGggTW9kdWxhdGlvbiBNb2R1bGUpIFBX
TQ0KPiA+IGJpbmRpbmcuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQW5zb24gSHVhbmcg
PEFuc29uLkh1YW5nQG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IE5vIGNoYW5nZXMuDQo+ID4N
Cj4gPiB2OT8gSSBkb24ndCByZWNhbGwgc2VlaW5nIGFueSBwcmV2aW91cyB2ZXJzaW9ucy4NCj4g
DQo+IEkgY2hlY2tlZCBteSBtYWlsYm94LCB5b3UgYXJlIGluIHRoZSAidG8iIGxpc3QgaW4gZXZl
cnkgdmVyc2lvbi4gVGhlIGZpcnN0DQo+IHZlcnNpb24ncyBzdWJqZWN0IGlzOg0KPiBbUEFUQ0gg
MS81XSBkdC1iaW5kaW5nczogcHdtOiBBZGQgaS5NWCBUUE0gUFdNIGJpbmRpbmcuLi4NCj4gDQo+
ID4NCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgtdHBt
LXB3bS50eHQgICAgICAgIHwgMjINCj4gPiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQNCj4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1w
d20udHh0DQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wd20vaW14LXRwbS1wd20udHh0DQo+ID4gPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiA+ID4gaW5kZXggMDAwMDAwMC4uOTRmMWFkNQ0KPiA+ID4gLS0tIC9kZXYvbnVs
bA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9pbXgt
dHBtLXB3bS50eHQNCj4gPiA+IEBAIC0wLDAgKzEsMjIgQEANCj4gPiA+ICtGcmVlc2NhbGUgaS5N
WCBUUE0gUFdNIGNvbnRyb2xsZXINCj4gPiA+ICsNCj4gPiA+ICtSZXF1aXJlZCBwcm9wZXJ0aWVz
Og0KPiA+ID4gKy0gY29tcGF0aWJsZSA6IFNob3VsZCBiZSAiZnNsLGlteC10cG0iLg0KPiA+DQo+
ID4gTmVlZHMgdG8gYmUgU29DIHNwZWNpZmljLg0KPiANCj4gT0ssIHdpbGwgY2hhbmdlIGl0IHRv
ICJmc2wsaW14N3VscC10cG0iIGluIG5leHQgdmVyc29uLg0KDQpBcyAiIGZzbCxpbXg3dWxwLXRw
bSAiIGlzIGFscmVhZHkgdXNlZCBmb3IgdGltZXIsIFRQTSBjYW4gd29yayBhcyBhIHRpbWVyDQpv
ciBQV00sIHNvIEkgaGF2ZSB0byB1c2UgIiBmc2wsaW14N3VscC1wd20iIGluIHRoZSBWMTAgcGF0
Y2ggSSBqdXN0IHNlbnQuDQoNCkFuc29uLg0KDQo+IA0KPiA+DQo+ID4gPiArLSByZWc6IFBoeXNp
Y2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBjb250cm9sbGVyJ3MgcmVnaXN0ZXJz
Lg0KPiA+ID4gKy0gI3B3bS1jZWxsczogU2hvdWxkIGJlIDMuIFNlZSBwd20udHh0IGluIHRoaXMg
ZGlyZWN0b3J5IGZvciBhDQo+ID4gPiArZGVzY3JpcHRpb24NCj4gPiBvZiB0aGUgY2VsbHMgZm9y
bWF0Lg0KPiA+ID4gKy0gY2xvY2tzIDogVGhlIGNsb2NrIHByb3ZpZGVkIGJ5IHRoZSBTb0MgdG8g
ZHJpdmUgdGhlIFBXTS4NCj4gPiA+ICstIGludGVycnVwdHM6IFRoZSBpbnRlcnJ1cHQgZm9yIHRo
ZSBQV00gY29udHJvbGxlci4NCj4gPiA+ICsNCj4gPiA+ICtOb3RlOiBUaGUgVFBNIGNvdW50ZXIg
YW5kIHBlcmlvZCBjb3VudGVyIGFyZSBzaGFyZWQgYmV0d2Vlbg0KPiA+ID4gK211bHRpcGxlIGNo
YW5uZWxzLCBzbyBhbGwgY2hhbm5lbHMgc2hvdWxkIHVzZSBzYW1lIHBlcmlvZCBzZXR0aW5nLg0K
PiA+ID4gKw0KPiA+ID4gK0V4YW1wbGU6DQo+ID4gPiArDQo+ID4gPiArcHdtMDogdHBtQDQwMjUw
MDAwIHsNCj4gPg0KPiA+IHB3bUAuLi4NCj4gDQo+IEkgZm9yZ290IHRvIHVwZGF0ZSB0aGUgZXhh
bXBsZSBpbiBEVCBiaW5kaW5nLCBzb3JyeSBmb3IgdGhhdCwgd2lsbCB1cGRhdGUgaXQNCj4gYWNj
b3JkaW5nIHRvIGJlbG93IGR0cyBub2RlOg0KPiANCj4gICAgICAgICAgICAgICAgICBwd20wOiBw
d21ANDAyNTAwMDAgew0KPiANCj4gQW5zb24uDQo=
