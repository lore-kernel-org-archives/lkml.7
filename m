Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B10AC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 02:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDE172086D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 02:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HYRuW4/g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfFKCG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 22:06:29 -0400
Received: from mail-eopbgr50075.outbound.protection.outlook.com ([40.107.5.75]:40261
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728685AbfFKCG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 22:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dl3ekszaQfZzI5NRoWgR3VZKIKIISkyZ6KSzujafmCg=;
 b=HYRuW4/gmPubF5K5ImMy5jNok1AQXcr8mmvR5H0KYBcdrpF/R5UdhHw4lOBRVTTHQ8btxSd8jnd9KU3KF2eftAYeJaXkl51+cHM0/2lypCzUoYv9mHY9azlRiA3ab+yjsA97ve0mK/Ntjv4iifxJdwwl0Ccvm1BwL/0ov24yo/E=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3785.eurprd04.prod.outlook.com (52.134.71.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Tue, 11 Jun 2019 02:06:22 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::5835:e874:bd94:fec%5]) with mapi id 15.20.1965.017; Tue, 11 Jun 2019
 02:06:22 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix .de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
Thread-Topic: [PATCH V3 3/4] clk: imx: Add support for i.MX8MN clock driver
Thread-Index: AQHVGnjztvJ1Vzt1002Z3uISz7VXoaaO1AeAgACJypCAASMQAIABCS1ggAN/YICAALOT4A==
Date:   Tue, 11 Jun 2019 02:06:22 +0000
Message-ID: <DB3PR0402MB3916F7F7D7CA801F5C0D0610F5ED0@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <20190604015928.23157-1-Anson.Huang@nxp.com>
 <20190604015928.23157-3-Anson.Huang@nxp.com>
 <20190606162543.EFFB820645@mail.kernel.org>
 <DB3PR0402MB391625A0B3D838CE88C53E33F5100@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190607180039.611C7208C0@mail.kernel.org>
 <DB3PR0402MB391678C245944942EA2A7F62F5110@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20190610151425.D8139207E0@mail.kernel.org>
In-Reply-To: <20190610151425.D8139207E0@mail.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8d19663-d653-4edc-4b52-08d6ee116706
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3785;
x-ms-traffictypediagnostic: DB3PR0402MB3785:
x-microsoft-antispam-prvs: <DB3PR0402MB37857DEE6789ED940D83EC38F5ED0@DB3PR0402MB3785.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 006546F32A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(376002)(396003)(39860400002)(346002)(189003)(199004)(13464003)(7736002)(44832011)(8676002)(305945005)(53936002)(81156014)(81166006)(7416002)(66066001)(486006)(476003)(8936002)(256004)(14444005)(33656002)(11346002)(446003)(2501003)(6246003)(74316002)(52536014)(186003)(76116006)(14454004)(73956011)(102836004)(26005)(55016002)(25786009)(68736007)(5660300002)(9686003)(316002)(478600001)(2906002)(229853002)(66446008)(64756008)(66556008)(66946007)(66476007)(6636002)(99286004)(71190400001)(71200400001)(110136005)(2201001)(86362001)(7696005)(53546011)(4326008)(6436002)(76176011)(6506007)(3846002)(6116002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3785;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eGWjbRIUEekwg2Vw0bO3G47VjXw86Rb2Sd4k/zMyBneLSQzwDTJFVEvAtguBhUbhZ+i5cjHwT8+58FXA8r72j82Ytq5ZCeWZ9TP/9RPD77fb/gIUnYY7k0VucQv2rcp22fyZ+9q7bpiLfzIyO2JQ7oZO3QTmhFvieK8hhwB1zkrqwdm105Wh9PwudDbcH8yqXqidJhQ2+xEL1jLOi0Ai8cQxAwFGeoPgetw/Yv7yxkC8yb8pxN2RmP9nVDMFBZjBGTdM4Fl30CTOcMekU9lnnjIUGV9h2Lg+Xxzb/Lv6Iq8Aq37dvId6fgaQUyGg9X2tbKz1S90elGy3yWHTsooQrjrWlPMm1Ima5FyAptFq04c+uAAIhZjmppDySwUJmlBNDcLb/r0yDy/IbLAyFbkL+5JNXrEW2kGyKXQCEuXdGK8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d19663-d653-4edc-4b52-08d6ee116706
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2019 02:06:22.8894
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: anson.huang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3785
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN0ZXBoZW4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdGVw
aGVuIEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IE1vbmRheSwgSnVuZSAxMCwgMjAx
OSAxMToxNCBQTQ0KPiBUbzogYmpvcm4uYW5kZXJzc29uQGxpbmFyby5vcmc7IGNhdGFsaW4ubWFy
aW5hc0Bhcm0uY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZGluZ3V5ZW5Aa2Vy
bmVsLm9yZzsNCj4gZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbTsgZmVzdGV2YW1AZ21haWwu
Y29tOw0KPiBob3JtcytyZW5lc2FzQHZlcmdlLm5ldC5hdTsgamFnYW5AYW1hcnVsYXNvbHV0aW9u
cy5jb207DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsg
bGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgtY2xrQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IG1hcmsucnV0bGFu
ZEBhcm0uY29tOw0KPiBtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tOyBtdHVycXVldHRlQGJheWxp
YnJlLmNvbTsgb2xvZkBsaXhvbS5uZXQ7DQo+IHJvYmgrZHRAa2VybmVsLm9yZzsgcy5oYXVlckBw
ZW5ndXRyb25peCAuZGUgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+Ow0KPiBzaGF3bmd1b0BrZXJu
ZWwub3JnOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBBYmVsIFZlc2ENCj4gPGFiZWwudmVzYUBueHAu
Y29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFuc29uDQo+IEh1YW5n
IDxhbnNvbi5odWFuZ0BueHAuY29tPjsgSmFja3kgQmFpIDxwaW5nLmJhaUBueHAuY29tPjsgTGVv
bmFyZA0KPiBDcmVzdGV6IDxsZW9uYXJkLmNyZXN0ZXpAbnhwLmNvbT4NCj4gQ2M6IGRsLWxpbnV4
LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggVjMgMy80XSBj
bGs6IGlteDogQWRkIHN1cHBvcnQgZm9yIGkuTVg4TU4gY2xvY2sgZHJpdmVyDQo+IA0KPiBRdW90
aW5nIEFuc29uIEh1YW5nICgyMDE5LTA2LTA4IDAyOjU4OjE4KQ0KPiA+IEhpLCBTdGVwaGVuDQo+
ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBTdGVwaGVu
IEJveWQgPHNib3lkQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiBTYXR1cmRheSwgSnVuZSA4LCAy
MDE5IDI6MDEgQU0NCj4gPiA+IFRvOiBiam9ybi5hbmRlcnNzb25AbGluYXJvLm9yZzsgY2F0YWxp
bi5tYXJpbmFzQGFybS5jb207DQo+ID4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgZGlu
Z3V5ZW5Aa2VybmVsLm9yZzsNCj4gPiA+IGVucmljLmJhbGxldGJvQGNvbGxhYm9yYS5jb207IGZl
c3RldmFtQGdtYWlsLmNvbTsNCj4gPiA+IGhvcm1zK3JlbmVzYXNAdmVyZ2UubmV0LmF1OyBqYWdh
bkBhbWFydWxhc29sdXRpb25zLmNvbTsNCj4gPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgbC5z
dGFjaEBwZW5ndXRyb25peC5kZTsgbGludXgtYXJtLQ0KPiA+ID4ga2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiA+ID4ga2VybmVs
QHZnZXIua2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+ID4gPiBtYXhpbWUucmlw
YXJkQGJvb3RsaW4uY29tOyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsgb2xvZkBsaXhvbS5uZXQ7
DQo+ID4gPiByb2JoK2R0QGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXggLmRlDQo+ID4g
PiByb2JoKzxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPjsNCj4gPiA+IHNoYXduZ3VvQGtlcm5lbC5v
cmc7IHdpbGwuZGVhY29uQGFybS5jb207IEFiZWwgVmVzYQ0KPiA+ID4gPGFiZWwudmVzYUBueHAu
Y29tPjsgQWlzaGVuZyBEb25nIDxhaXNoZW5nLmRvbmdAbnhwLmNvbT47IEFuc29uDQo+ID4gPiBI
dWFuZyA8YW5zb24uaHVhbmdAbnhwLmNvbT47IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT47
DQo+IExlb25hcmQNCj4gPiA+IENyZXN0ZXogPGxlb25hcmQuY3Jlc3RlekBueHAuY29tPg0KPiA+
ID4gQ2M6IGRsLWxpbnV4LWlteCA8bGludXgtaW14QG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBS
RTogW1BBVENIIFYzIDMvNF0gY2xrOiBpbXg6IEFkZCBzdXBwb3J0IGZvciBpLk1YOE1OIGNsb2Nr
DQo+ID4gPiBkcml2ZXINCj4gPiA+DQo+ID4gPiBRdW90aW5nIEFuc29uIEh1YW5nICgyMDE5LTA2
LTA2IDE3OjUwOjI4KQ0KPiA+ID4gPg0KPiA+ID4gPiBJIHdpbGwgdXNlIGRldm1fcGxhdGZvcm1f
aW9yZW1hcF9yZXNvdXJjZSgpIGluc3RlYWQgb2YgaW9yZW1hcCgpLA0KPiA+ID4gPiBhbmQgY2Fu
IHlvdSBiZSBtb3JlIHNwZWNpZmljIGFib3V0IGRldm1pZmllZCBjbGsgcmVnaXN0cmF0aW9uPw0K
PiA+ID4gPg0KPiA+ID4NCj4gPiA+IEkgbWVhbiB1c2luZyB0aGluZ3MgbGlrZSBkZXZtX2Nsa19o
d19yZWdpc3RlcigpLg0KPiA+DQo+ID4gU29ycnksIEkgYW0gc3RpbGwgYSBsaXR0bGUgY29uZnVz
ZWQsIGFsbCB0aGUgY2xvY2sNCj4gPiByZWdpc3RlcihjbGtfcmVnaXN0ZXIoKSkgYXJlIHZpYSBl
YWNoIGRpZmZlcmVudCBjbG9jayB0eXBlcyBsaWtlDQo+ID4gaW14X2Nsa19nYXRlNC9pbXhfY2xr
X3BsbDE0eHgsIGlmIHVzaW5nIGNsa19od19yZWdpc3RlciwgbWVhbnMgd2UgbmVlZA0KPiA+IHRv
IHJlLXdyaXRlIHRoZSBjbG9jayBkcml2ZXIgdXNpbmcgZGlmZmVyZW50IGNsayByZWdpc3RlciBt
ZXRob2QsIHRoYXQNCj4gPiB3aWxsIG1ha2UgdGhlIGRyaXZlciBjb21wbGV0ZWx5IGRpZmZlcmVu
dCBmcm9tIGkubXg4bXEvaS5teDhtbSwgdGhleQ0KPiA+IGFyZSBhY3R1YWxseSBzYW1lIHNlcmll
cyBvZiBTb0MgYXMgaS5teDhtbiwgaXQgd2lsbCBpbnRyb2R1Y2UgbWFueQ0KPiBjb25mdXNpb24s
IGlzIG15IHVuZGVyc3RhbmRpbmcgY29ycmVjdD8gQW5kIGlzIGl0IE9LIHRvIGp1c3Qga2VlcCB3
aGF0IGl0IGlzDQo+IGFuZCBtYWtlIHRoZW0gYWxsIGFsaWduZWQ/DQo+ID4NCj4gDQo+IE9rLCB0
aGUgcHJvYmxlbSBJJ20gdHJ5aW5nIHRvIHBvaW50IG91dCBpcyB0aGF0IGNsayByZWdpc3RyYXRp
b25zIG5lZWQgdG8gYmUNCj4gdW5kb25lLCBpLmUuIGNsa191bnJlZ2lzdGVyKCkgbmVlZHMgdG8g
YmUgY2FsbGVkLCB3aGVuIHRoZSBkcml2ZXIgZmFpbHMgdG8NCj4gcHJvYmUuIGRldm1fKigpIGlz
IG9uZSB3YXkgdG8gZG8gdGhpcywgYnV0IGlmIHlvdSBoYXZlIG90aGVyIHdheXMgb2YNCj4gcmVt
b3ZpbmcgYWxsIHRoZSByZWdpc3RlcmVkIGNsa3MgdGhlbiB0aGF0IHdvcmtzIHRvby4gTWFrZXMg
c2Vuc2U/DQoNClllcywgaXQgbWFrZXMgc2Vuc2UuIERvIHlvdSB0aGluayBpdCBpcyBPSyB0byBh
ZGQgYW4gaW14X3VucmVnaXN0ZXJfY2xvY2tzKCkgQVBJLCB0aGVuDQpjYWxsIGl0IGluIGV2ZXJ5
IHBsYWNlIG9mIHJldHVybmluZyBmYWlsdXJlIGluIC5wcm9iZSBmdW5jdGlvbj8gSWYgeWVzLCBJ
IHdpbGwgYWRkIGl0IGFuZCBhbHNvDQpmaXggaXQgaW4gaS5NWDhNUSBkcml2ZXIgd2hpY2ggdXNl
cyBwbGF0Zm9ybSBkcml2ZXIgbW9kZWwgYnV0IGRvZXMgTk9UIGhhbmRsZSB0aGlzIGNhc2UuIA0K
DQogICAgICAgIGJhc2UgPSBkZXZtX3BsYXRmb3JtX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgMCk7
DQotICAgICAgIGlmIChXQVJOX09OKElTX0VSUihiYXNlKSkpDQotICAgICAgICAgICAgICAgcmV0
dXJuIFBUUl9FUlIoYmFzZSk7DQorICAgICAgIGlmIChXQVJOX09OKElTX0VSUihiYXNlKSkpIHsN
CisgICAgICAgICAgICAgICByZXQgPSBQVFJfRVJSKGJhc2UpOw0KKyAgICAgICAgICAgICAgIGdv
dG8gdW5yZWdpc3Rlcl9jbGtzOw0KKyAgICAgICB9DQoNCiAgICAgICAgICAgICAgICBwcl9lcnIo
ImZhaWxlZCB0byByZWdpc3RlciBjbGtzIGZvciBpLk1YOE1OXG4iKTsNCi0gICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCisgICAgICAgICAgICAgICBnb3RvIHVucmVnaXN0ZXJfY2xrczsN
CiAgICAgICAgfQ0KDQogICAgICAgIHJldHVybiAwOw0KKw0KK3VucmVnaXN0ZXJfY2xrczoNCisg
ICAgICAgaW14X3VucmVnaXN0ZXJfY2xvY2tzKGNsa3MsIEFSUkFZX1NJWkUoY2xrcykpOw0KKw0K
KyAgICAgICByZXR1cm4gcmV0Ow0KDQordm9pZCBpbXhfdW5yZWdpc3Rlcl9jbG9ja3Moc3RydWN0
IGNsayAqY2xrc1tdLCB1bnNpZ25lZCBpbnQgY291bnQpDQorew0KKyAgICAgICB1bnNpZ25lZCBp
Ow0KKw0KKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgY291bnQ7IGkrKykNCisgICAgICAgICAgICAg
ICBjbGtfdW5yZWdpc3RlcihjbGtzW2ldKTsNCit9DQorDQoNClRoYW5rcywNCkFuc29uLg0K
