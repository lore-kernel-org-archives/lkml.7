Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E0CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9647421E6F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 11:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfKDLSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 06:18:32 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:41304 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbfKDLSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 06:18:31 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 783EF6279E4;
        Mon,  4 Nov 2019 12:18:20 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 12:18:19 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 4 Nov 2019 12:18:19 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 09/11] ARM: dts: imx6ul-kontron-n6x1x-s: Disable the
 snvs-poweroff driver
Thread-Topic: [PATCH v3 09/11] ARM: dts: imx6ul-kontron-n6x1x-s: Disable the
 snvs-poweroff driver
Thread-Index: AQHVj/bnGF5WcKYgcUiKBHtcAgBib6d6ln2AgAAGP4CAADWxgA==
Date:   Mon, 4 Nov 2019 11:18:19 +0000
Message-ID: <7da30a17-d16c-3cde-12a8-430ff3eec692@kontron.de>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-10-frieder.schrempf@kontron.de>
 <20191104074346.GT24620@dragon>
 <626ad87a-eb1d-4dca-7cd3-8c5f38025aec@kontron.de>
In-Reply-To: <626ad87a-eb1d-4dca-7cd3-8c5f38025aec@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <183E16540FE8D144885902D56D2599EA@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 783EF6279E4.A0907
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

T24gMDQuMTEuMTkgMDk6MDYsIEZyaWVkZXIgU2NocmVtcGYgd3JvdGU6DQo+IEhpIFNoYXduLA0K
PiANCj4gT24gMDQuMTEuMTkgMDg6NDMsIFNoYXduIEd1byB3cm90ZToNCj4+IE9uIFRodSwgT2N0
IDMxLCAyMDE5IGF0IDAyOjI0OjI3UE0gKzAwMDAsIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+
Pj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0K
Pj4+DQo+Pj4gVGhlIHNudnMtcG93ZXJvZmYgZHJpdmVyIGNhbiBwb3dlciBvZmYgdGhlIHN5c3Rl
bSBieSBwdWxsaW5nIHRoZQ0KPj4+IFBNSUNfT05fUkVRIHNpZ25hbCBsb3csIHRvIGxldCB0aGUg
UE1JQyBkaXNhYmxlIHRoZSBwb3dlci4NCj4+PiBUaGUgS29udHJvbiBTb01zIGRvIG5vdCBoYXZl
IHRoaXMgc2lnbmFsIGNvbm5lY3RlZCwgc28gbGV0J3MgcmVtb3ZlDQo+Pj4gdGhlIG5vZGUuDQo+
Pj4NCj4+PiBUaGlzIHNlZW1zIHRvIGZpeCBhIHJlYWwgaXNzdWUgd2hlbiB0aGUgc2lnbmFsIGlz
IGFzc2VydGVkIGF0DQo+Pj4gcG93ZXJvZmYsIGJ1dCBub3QgYWN0dWFsbHkgY2F1c2luZyB0aGUg
cG93ZXIgdG8gdHVybiBvZmYuIEl0IHdhcw0KPj4+IG9ic2VydmVkLCB0aGF0IGluIHRoaXMgY2Fz
ZSB0aGUgc3lzdGVtIHdvdWxkIG5vdCBzaHV0IGRvd24gcHJvcGVybHkuDQo+Pg0KPj4gSSBkbyBu
b3QgcXVpdGUgZm9sbG93IG9uIHRoaXMuwqAgSG93IGRvZXMgZGlzYWJsaW5nIHNudnNfcG93ZXJv
ZmYgZml4IHRoZQ0KPj4gaXNzdWU/wqAgVGhlIHJvb3QgY2F1c2Ugb2Ygc3lzdGVtIG5vdCBzaHV0
IGRvd24gcHJvcGVybHkgc2VlbXMgdG8gYmUgdGhhdA0KPj4gUE1JQyBkb2Vzbid0IHNodXQgZG93
biBwb3dlci7CoCBUaGlzIGxvb2tzIGxpa2UgYSBjbGVhbi11cCByYXRoZXIgdGhhbg0KPj4gYnVn
IGZpeC4NCj4gDQo+IEkgZG9uJ3Qga25vdyB0aGUgZXhhY3QgcmVhc29ucywgYnV0IHdlIGhhZCBp
c3N1ZXMgb24gdGhlc2UgYm9hcmRzIHdoZW4gDQo+IGRvaW5nIGEgInBvd2Vyb2ZmIi4gVGhlIGtl
cm5lbCB3b3VsZCBwcmludCBzb21ldGhpbmcgbGlrZSB0aGUgbG9nIGJlbG93Lg0KPiBEaXNhYmxp
bmcgdGhlIHNudnMtcG93ZXJvZmYgc29sdmVkIHRoaXMuDQo+IA0KPiBCdXQgbm90ZSB0aGF0IHRo
aXMgaGFzIGxhc3QgYmVlbiByZXByb2R1Y2VkIG9uIHY0LjE0LiBTbyBJJ20gbm90IHN1cmUgaWYg
DQo+IHRoaXMgaXMgc3RpbGwgYSBwcm9ibGVtIHdpdGggdGhlIGN1cnJlbnQga2VybmVsLg0KPiAN
Cj4gIyMjIyMjIw0KPiByZWJvb3Q6IFBvd2VyIGRvd24NCj4gVW5hYmxlIHRvIHBvd2Vyb2ZmIHN5
c3RlbQ0KPiANCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+IFdBUk5J
Tkc6IGhhbHQvNjc1IHN0aWxsIGhhcyBsb2NrcyBoZWxkIQ0KPiA0LjE0LjEwNC1leGNlZXQgIzEg
Tm90IHRhaW50ZWQNCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IDEg
bG9jayBoZWxkIGJ5IGhhbHQvNjc1Og0KPiAgwqAjMDrCoCAocmVib290X211dGV4KXsrLisufSwg
YXQ6IFs8YzAxNDVhOTg+XSBTeVNfcmVib290KzB4MTRjLzB4MWRjDQo+ICMjIyMjIyMNCj4gDQo+
Pg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hy
ZW1wZkBrb250cm9uLmRlPg0KPj4+IEZpeGVzOiAxZWE0Yjc2Y2RmZGUgKCJBUk06IGR0czogaW14
NnVsLWtvbnRyb24tbjYzMTA6IEFkZCBLb250cm9uIA0KPj4+IGkuTVg2VUwgTjYzMTAgU29NIGFu
ZCBib2FyZHMiKQ0KPj4NCj4+IElmIHlvdSB0aGluayB0aGlzIGlzIHJlYWxseSBhIGJ1ZyBmaXgs
IGl0IHNob3VsZCBiZSBhcHBsaWVkIHRvIHRoZSBmaWxlDQo+PiBiZWZvcmUgcmVuYW1pbmcgcmF0
aGVyIHRoYW4gdGhlIG9uZSBhZnRlciByZW5hbWluZy4NCj4gDQo+IEkgd2lsbCB0cnkgdG8gcmVw
cm9kdWNlIHRoZSBpc3N1ZSB3aXRoIHRoZSBjdXJyZW50IGtlcm5lbCBhbmQgZGVwZW5kaW5nIA0K
PiBvbiB0aGUgcmVzdWx0cyBlaXRoZXIgZHJvcCB0aGUgRml4ZXMgdGFnIG9yIG1vdmUgdGhlIHBh
dGNoIGJlZm9yZSB0aGUgDQo+IHJlbmFtaW5nLg0KDQpJIGp1c3QgdHJpZWQgdGhpcyB3aXRoIDUu
NC1yYzUgYW5kIHRoZSBpc3N1ZSBwZXJzaXN0cy4gV2hlbiANCnNudnMtcG93ZXJvZmYgaXMgZW5h
YmxlZCB3aXRob3V0IHRoZSBoYXJkd2FyZSBhY3R1YWxseSBiZWluZyBhYmxlIHRvIA0KcG93ZXIg
ZG93biB2aWEgUE1JQyBJIGdldCBhIGxvY2tpbmcgV0FSTklORyBmcm9tIHRoZSBrZXJuZWwuIFBy
b2JhYmx5IA0KYmVjYXVzZSB0aGUgc3lzdGVtIGlzIHN0aWxsIHJ1bm5pbmcsIHdoZW4gaXQncyBh
bHJlYWR5IHN1cHBvc2VkIHRvIGJlIA0Kc2h1dCBkb3duIGJ5IHRoZSBQTUlDLg0KDQpTbyB0aGlz
IGZpeGVzIGEgcmVhbCBwcm9ibGVtIGFuZCB0aGVyZWZvcmUgSSB3aWxsIGtlZXAgdGhlIEZpeGVz
IHRhZyBhbmQgDQptb3ZlIHRoZSBwYXRjaCB0byB0aGUgcHJvcGVyIHBsYWNlIGluIHRoaXMgc2Vy
aWVzLg0KDQo+IA0KPiBUaGFua3MgZm9yIHJldmlld2luZywNCj4gRnJpZWRlcg0KPiANCj4+DQo+
PiBTaGF3bg0KPj4NCj4+PiAtLS0NCj4+PiDCoCBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29u
dHJvbi1uNngxeC1zLmR0c2kgfCA0IC0tLS0NCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBkZWxl
dGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwt
a29udHJvbi1uNngxeC1zLmR0c2kgDQo+Pj4gYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29u
dHJvbi1uNngxeC1zLmR0c2kNCj4+PiBpbmRleCBlMThhOGJkMjM5YmUuLjQ2ODJhNzlmNWIyMyAx
MDA2NDQNCj4+PiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNngxeC1z
LmR0c2kNCj4+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNngxeC1z
LmR0c2kNCj4+PiBAQCAtMTU4LDEwICsxNTgsNiBAQA0KPj4+IMKgwqDCoMKgwqAgc3RhdHVzID0g
Im9rYXkiOw0KPj4+IMKgIH07DQo+Pj4gLSZzbnZzX3Bvd2Vyb2ZmIHsNCj4+PiAtwqDCoMKgIHN0
YXR1cyA9ICJva2F5IjsNCj4+PiAtfTsNCj4+PiAtDQo+Pj4gwqAgJnVhcnQxIHsNCj4+PiDCoMKg
wqDCoMKgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+Pj4gwqDCoMKgwqDCoCBwaW5jdHJs
LTAgPSA8JnBpbmN0cmxfdWFydDE+Ow0KPj4+IC0tIA0KPj4+IDIuMTcuMQ==
