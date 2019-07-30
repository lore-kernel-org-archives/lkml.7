Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A896C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A2420651
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfG3I1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:27:19 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:57654 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbfG3I1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:27:19 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 262BF67A918;
        Tue, 30 Jul 2019 10:27:15 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 30 Jul
 2019 10:27:14 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 30 Jul 2019 10:27:14 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/2] ARM: dts: imx6ul-kontron-n6310: Add Kontron
 i.MX6UL N6310 SoM and boards
Thread-Topic: [PATCH v3 2/2] ARM: dts: imx6ul-kontron-n6310: Add Kontron
 i.MX6UL N6310 SoM and boards
Thread-Index: AQHVRjH02WMnvqVtME2ER52FoUT5GKbis0MA
Date:   Tue, 30 Jul 2019 08:27:14 +0000
Message-ID: <f33dfd63-23c2-0316-fad9-e59b96bd5814@kontron.de>
References: <20190729172007.3275-1-krzk@kernel.org>
 <20190729172007.3275-2-krzk@kernel.org>
In-Reply-To: <20190729172007.3275-2-krzk@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D6D7FF85AE64B41808BCE3C3F611E61@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 262BF67A918.AE303
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkuMDcuMTkgMTk6MjAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEFkZCBzdXBw
b3J0IGZvciBpLk1YNlVMIG1vZHVsZXMgZnJvbSBLb250cm9uIEVsZWN0cm9uaWNzIEdtYkggKGJl
Zm9yZQ0KPiBhY3F1aXNpdGlvbjogRXhjZWV0IEVsZWN0cm9uaWNzKSBhbmQgZXZhbGtpdCBib2Fy
ZHMgYmFzZWQgb24gaXQ6DQo+IA0KPiAxLiBONjMxMCBTT006IGkuTVg2IFVMIFN5c3RlbS1vbi1N
b2R1bGUsIGEgMjV4MjUgbW0gc29sZGVyYWJsZSBtb2R1bGUNCj4gICAgIChMR0EgcGFkcyBhbmQg
cGluIGNhc3RlbGxhdGlvbnMpIHdpdGggMjU2IE1CIFJBTSwgMSBNQiBOT1ItRmxhc2gsDQo+ICAg
ICAyNTYgTUIgTkFORCBhbmQgb3RoZXIgaW50ZXJmYWNlcywNCj4gMi4gTjYzMTAgUzogZXZhbGtp
dCwgdy93byBlTU1DLCB3aXRob3V0IGRpc3BsYXksDQo+IDMuIE42MzEwIFMgNDM6IGV2YWxraXQg
d2l0aCA0LjMiIGRpc3BsYXksDQo+IDQuIE42MzEwIFMgNTA6IGV2YWxraXQgd2l0aCA1LjAiIGRp
c3BsYXkuDQo+IA0KPiBUaGlzIGluY2x1ZGVzIGRldmljZSBub2RlcyBmb3IgdW5zdXBwb3J0ZWQg
ZGlzcGxheXMgKEFkbWF0ZWMNCj4gVDA0M0MwMDQ4MDAyNzJUMkEgYW5kIFQwNzBQMTMzVDBTMzAx
KS4NCj4gDQo+IFRoZSB3b3JrIGlzIGJhc2VkIG9uIEV4Y2VldC9Lb250cm9uIHNvdXJjZSBjb2Rl
IChHUEx2Mikgd2l0aCBudW1lcm91cw0KPiBjaGFuZ2VzOg0KPiAxLiBSZW9yZ2FuaXplIGZpbGVz
LA0KPiAyLiBSZW5hbWUgRXhjZWV0IC0+IEtvbnRyb24sDQo+IDMuIFJlbmFtZSBtb2RlbHMvY29t
cGF0aWJsZXMgdG8gbWF0Y2ggbmV3ZXN0IEtvbnRyb24gcHJvZHVjdCBuYW1pbmcsDQo+IDQuIEZp
eCBjb2Rpbmcgc3R5bGUgZXJyb3JzIGFuZCBhZGp1c3QgdG8gZGV2aWNlIHRyZWUgY29kaW5nIGd1
aWRlbGluZXMsDQo+IDUuIEZpeCBEVEMgd2FybmluZ3MsDQo+IDYuIEV4dGVuZCBjb21wYXRpYmxl
cyBzbyBldmFsIGJvYXJkcyBpbmhlcml0IHRoZSBTb00gY29tcGF0aWJsZSwNCj4gNy4gVXNlIGRl
ZmluZXMgaW5zdGVhZCBvZiBHUElPIGFuZCBpbnRlcnJ1cHQgZmxhZyB2YWx1ZXMsDQo+IDguIFVz
ZSBwcm9wZXIgdmVuZG9yIGNvbXBhdGlibGUgZm9yIE1hY3Jvbml4IFNQSSBOT1IsDQo+IDkuIFNv
cnQgbm9kZXMgYWxwaGFiZXRpY2FsbHkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2Yg
S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IA0KPiAtLS0NCj4gDQo+IENoYW5nZXMgc2lu
Y2UgdjIsIGFmdGVyIEZhYmlvJ3MgcmV2aWV3Og0KPiAxLiBBZGQgImlteDZ1bCIgY29tcGF0aWJs
ZSB0byBib2FyZCBuYW1lICh0aGF0J3Mgd2hhdCBJIHVuZGVyc3Rvb2QgZnJvbQ0KPiAgICAgcmV2
aWV3KSwNCj4gMi4gQWRkIHZlbmRvci9kZXZpY2UgcHJlZml4IHRvIGVlcHJvbSBhbmQgZG9jdW1l
bnQgdGhlIGNvbXBhdGlibGUsDQo+IDMuIFVzZSAiYWRtYXRlY2RlIiBhcyB2ZW5kb3IgY29tcGF0
aWJsZSB0byBhdm9pZCBjb25mdXNpb24gd2l0aCBBZG1hdGVjDQo+ICAgICBBRyBpbiBTd2l0emVy
bGFuZCAoYWxzbyBtYWtpbmcgTENEIHBhbmVscyksDQo+IDQuIFVzZSBnZW5lcmljIG5hbWVzIGZv
ciBub2RlcywNCj4gNS4gVXNlIElSUV9UWVBFX0xFVkVMX0xPVywNCj4gNi4gTW92ZSBpb211eCB0
byB0aGUgZW5kIG9mIGZpbGVzLA0KPiA3LiBSZW1vdmUgcmVndWxhdG9ycyBub2RlIChpbmNsdWRl
IHJlZ3VsYXRvcnMgaW4gdG9wIGxldmVsKSwNCj4gOC4gUmVtb3ZlIGNwdSBjbG9jay1mcmVxdWVu
Y3ksDQo+IDkuIE90aGVyIG1pbm9yIGZpeGVzIHBvaW50ZWQgYnkgRmFiaW8uDQo+IA0KPiBDaGFu
Z2VzIHNpbmNlIHYxLCBhZnRlciBGcmllZGVyJ3MgcmV2aWV3Og0KPiAxLiBSZW1vdmUgdW5uZWVk
ZWQgbGljZW5zZSBub3RlcywNCj4gMi4gQWRkIEtvbnRyb24gY29weXJpZ2h0ICgyMDE4KSwNCj4g
My4gUmVuYW1lIHRoZSBmaWxlcy9tb2RlbHMvY29tcGF0aWJsZXMgdG8gbmV3IG5hbWluZyAtIE42
MzEwLA0KPiA0LiBSZW1vdmUgdW5uZWVkZWQgQ1BVIG9wZXJhdGluZyBwb2ludHMgb3ZlcnJpZGUs
DQo+IDUuIFN3aXRjaCByZWd1bGF0b3Igbm9kZXMgaW50byBzaW1wbGUgY2hpbGRyZW4gbm9kZXMg
d2l0aG91dCBhZGRyZXNzZXMNCj4gICAgIChzbyBub3Qgc2ltcGxlIGJ1cyksDQo+IDYuIFVzZSBw
cm9wZXIgdmVuZG9yIGNvbXBhdGlibGUgZm9yIE1hY3Jvbml4IFNQSSBOT1IuDQo+IC0tLQ0KPiAg
IC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9mc2wueWFtbCAgICAgICAgICB8ICAgNCArDQo+
ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvZWVwcm9tL2F0MjUudHh0ICAgICAgIHwgICAxICsN
Cj4gICBhcmNoL2FybS9ib290L2R0cy9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgfCAgIDMg
Kw0KPiAgIC4uLi9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNjMxMC1zLTQzLmR0cyAgICB8IDEx
OSArKysrKw0KPiAgIC4uLi9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNjMxMC1zLTUwLmR0cyAg
ICB8IDExOSArKysrKw0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42MzEw
LXMuZHRzICB8IDQyMCArKysrKysrKysrKysrKysrKysNCj4gICAuLi4vYm9vdC9kdHMvaW14NnVs
LWtvbnRyb24tbjYzMTAtc29tLmR0c2kgICAgfCAxMzQgKysrKysrDQo+ICAgNyBmaWxlcyBjaGFu
Z2VkLCA4MDAgaW5zZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9i
b290L2R0cy9pbXg2dWwta29udHJvbi1uNjMxMC1zLTQzLmR0cw0KPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNjMxMC1zLTUwLmR0cw0KPiAg
IGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNjMx
MC1zLmR0cw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwt
a29udHJvbi1uNjMxMC1zb20uZHRzaQ0KDQpSZXZpZXdlZC1ieTogRnJpZWRlciBTY2hyZW1wZiA8
ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg==
