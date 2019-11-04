Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E483DCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C495421744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 08:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfKDIGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 03:06:12 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:51168 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfKDIGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 03:06:12 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id ECF1B60C223;
        Mon,  4 Nov 2019 09:06:09 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 09:06:09 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 4 Nov 2019 09:06:09 +0100
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
Thread-Index: AQHVj/bnGF5WcKYgcUiKBHtcAgBib6d6ln2AgAAGP4A=
Date:   Mon, 4 Nov 2019 08:06:09 +0000
Message-ID: <626ad87a-eb1d-4dca-7cd3-8c5f38025aec@kontron.de>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-10-frieder.schrempf@kontron.de>
 <20191104074346.GT24620@dragon>
In-Reply-To: <20191104074346.GT24620@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8B15234843B51418DD790C4DE2879E7@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: ECF1B60C223.A27C5
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

SGkgU2hhd24sDQoNCk9uIDA0LjExLjE5IDA4OjQzLCBTaGF3biBHdW8gd3JvdGU6DQo+IE9uIFRo
dSwgT2N0IDMxLCAyMDE5IGF0IDAyOjI0OjI3UE0gKzAwMDAsIFNjaHJlbXBmIEZyaWVkZXIgd3Jv
dGU6DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24u
ZGU+DQo+Pg0KPj4gVGhlIHNudnMtcG93ZXJvZmYgZHJpdmVyIGNhbiBwb3dlciBvZmYgdGhlIHN5
c3RlbSBieSBwdWxsaW5nIHRoZQ0KPj4gUE1JQ19PTl9SRVEgc2lnbmFsIGxvdywgdG8gbGV0IHRo
ZSBQTUlDIGRpc2FibGUgdGhlIHBvd2VyLg0KPj4gVGhlIEtvbnRyb24gU29NcyBkbyBub3QgaGF2
ZSB0aGlzIHNpZ25hbCBjb25uZWN0ZWQsIHNvIGxldCdzIHJlbW92ZQ0KPj4gdGhlIG5vZGUuDQo+
Pg0KPj4gVGhpcyBzZWVtcyB0byBmaXggYSByZWFsIGlzc3VlIHdoZW4gdGhlIHNpZ25hbCBpcyBh
c3NlcnRlZCBhdA0KPj4gcG93ZXJvZmYsIGJ1dCBub3QgYWN0dWFsbHkgY2F1c2luZyB0aGUgcG93
ZXIgdG8gdHVybiBvZmYuIEl0IHdhcw0KPj4gb2JzZXJ2ZWQsIHRoYXQgaW4gdGhpcyBjYXNlIHRo
ZSBzeXN0ZW0gd291bGQgbm90IHNodXQgZG93biBwcm9wZXJseS4NCj4gDQo+IEkgZG8gbm90IHF1
aXRlIGZvbGxvdyBvbiB0aGlzLiAgSG93IGRvZXMgZGlzYWJsaW5nIHNudnNfcG93ZXJvZmYgZml4
IHRoZQ0KPiBpc3N1ZT8gIFRoZSByb290IGNhdXNlIG9mIHN5c3RlbSBub3Qgc2h1dCBkb3duIHBy
b3Blcmx5IHNlZW1zIHRvIGJlIHRoYXQNCj4gUE1JQyBkb2Vzbid0IHNodXQgZG93biBwb3dlci4g
IFRoaXMgbG9va3MgbGlrZSBhIGNsZWFuLXVwIHJhdGhlciB0aGFuDQo+IGJ1ZyBmaXguDQoNCkkg
ZG9uJ3Qga25vdyB0aGUgZXhhY3QgcmVhc29ucywgYnV0IHdlIGhhZCBpc3N1ZXMgb24gdGhlc2Ug
Ym9hcmRzIHdoZW4gDQpkb2luZyBhICJwb3dlcm9mZiIuIFRoZSBrZXJuZWwgd291bGQgcHJpbnQg
c29tZXRoaW5nIGxpa2UgdGhlIGxvZyBiZWxvdy4NCkRpc2FibGluZyB0aGUgc252cy1wb3dlcm9m
ZiBzb2x2ZWQgdGhpcy4NCg0KQnV0IG5vdGUgdGhhdCB0aGlzIGhhcyBsYXN0IGJlZW4gcmVwcm9k
dWNlZCBvbiB2NC4xNC4gU28gSSdtIG5vdCBzdXJlIGlmIA0KdGhpcyBpcyBzdGlsbCBhIHByb2Js
ZW0gd2l0aCB0aGUgY3VycmVudCBrZXJuZWwuDQoNCiMjIyMjIyMNCnJlYm9vdDogUG93ZXIgZG93
bg0KVW5hYmxlIHRvIHBvd2Vyb2ZmIHN5c3RlbQ0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT0NCldBUk5JTkc6IGhhbHQvNjc1IHN0aWxsIGhhcyBsb2NrcyBoZWxkIQ0KNC4x
NC4xMDQtZXhjZWV0ICMxIE5vdCB0YWludGVkDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCjEgbG9jayBoZWxkIGJ5IGhhbHQvNjc1Og0KICAjMDogIChyZWJvb3RfbXV0ZXgp
eysuKy59LCBhdDogWzxjMDE0NWE5OD5dIFN5U19yZWJvb3QrMHgxNGMvMHgxZGMNCiMjIyMjIyMN
Cg0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNj
aHJlbXBmQGtvbnRyb24uZGU+DQo+PiBGaXhlczogMWVhNGI3NmNkZmRlICgiQVJNOiBkdHM6IGlt
eDZ1bC1rb250cm9uLW42MzEwOiBBZGQgS29udHJvbiBpLk1YNlVMIE42MzEwIFNvTSBhbmQgYm9h
cmRzIikNCj4gDQo+IElmIHlvdSB0aGluayB0aGlzIGlzIHJlYWxseSBhIGJ1ZyBmaXgsIGl0IHNo
b3VsZCBiZSBhcHBsaWVkIHRvIHRoZSBmaWxlDQo+IGJlZm9yZSByZW5hbWluZyByYXRoZXIgdGhh
biB0aGUgb25lIGFmdGVyIHJlbmFtaW5nLg0KDQpJIHdpbGwgdHJ5IHRvIHJlcHJvZHVjZSB0aGUg
aXNzdWUgd2l0aCB0aGUgY3VycmVudCBrZXJuZWwgYW5kIGRlcGVuZGluZyANCm9uIHRoZSByZXN1
bHRzIGVpdGhlciBkcm9wIHRoZSBGaXhlcyB0YWcgb3IgbW92ZSB0aGUgcGF0Y2ggYmVmb3JlIHRo
ZSANCnJlbmFtaW5nLg0KDQpUaGFua3MgZm9yIHJldmlld2luZywNCkZyaWVkZXINCg0KPiANCj4g
U2hhd24NCj4gDQo+PiAtLS0NCj4+ICAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24t
bjZ4MXgtcy5kdHNpIHwgNCAtLS0tDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygt
KQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1u
NngxeC1zLmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNngxeC1zLmR0
c2kNCj4+IGluZGV4IGUxOGE4YmQyMzliZS4uNDY4MmE3OWY1YjIzIDEwMDY0NA0KPj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjZ4MXgtcy5kdHNpDQo+PiArKysgYi9h
cmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNngxeC1zLmR0c2kNCj4+IEBAIC0xNTgs
MTAgKzE1OCw2IEBADQo+PiAgIAlzdGF0dXMgPSAib2theSI7DQo+PiAgIH07DQo+PiAgIA0KPj4g
LSZzbnZzX3Bvd2Vyb2ZmIHsNCj4+IC0Jc3RhdHVzID0gIm9rYXkiOw0KPj4gLX07DQo+PiAtDQo+
PiAgICZ1YXJ0MSB7DQo+PiAgIAlwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPj4gICAJcGlu
Y3RybC0wID0gPCZwaW5jdHJsX3VhcnQxPjsNCj4+IC0tIA0KPj4gMi4xNy4x
