Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF6DCA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC3021D81
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 13:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfKDNON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 08:14:13 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:46230 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfKDNON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 08:14:13 -0500
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 267E560C23B;
        Mon,  4 Nov 2019 14:14:09 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 14:14:08 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 4 Nov 2019 14:14:08 +0100
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
Thread-Index: AQHVj/bnGF5WcKYgcUiKBHtcAgBib6d6ln2AgAAGP4CAADWxgIAAGHqAgAAH4YA=
Date:   Mon, 4 Nov 2019 13:14:08 +0000
Message-ID: <54e7efb9-bf18-f513-569b-817ff2e403f6@kontron.de>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-10-frieder.schrempf@kontron.de>
 <20191104074346.GT24620@dragon>
 <626ad87a-eb1d-4dca-7cd3-8c5f38025aec@kontron.de>
 <7da30a17-d16c-3cde-12a8-430ff3eec692@kontron.de>
 <20191104124553.GY24620@dragon>
In-Reply-To: <20191104124553.GY24620@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB1A34C6DAD8AA4C91F7F040A25CE28B@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 267E560C23B.AF403
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

T24gMDQuMTEuMTkgMTM6NDUsIFNoYXduIEd1byB3cm90ZToNCj4gT24gTW9uLCBOb3YgMDQsIDIw
MTkgYXQgMTE6MTg6MTlBTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IE9uIDA0
LjExLjE5IDA5OjA2LCBGcmllZGVyIFNjaHJlbXBmIHdyb3RlOg0KPj4+IEhpIFNoYXduLA0KPj4+
DQo+Pj4gT24gMDQuMTEuMTkgMDg6NDMsIFNoYXduIEd1byB3cm90ZToNCj4+Pj4gT24gVGh1LCBP
Y3QgMzEsIDIwMTkgYXQgMDI6MjQ6MjdQTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToN
Cj4+Pj4+IEZyb206IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5k
ZT4NCj4+Pj4+DQo+Pj4+PiBUaGUgc252cy1wb3dlcm9mZiBkcml2ZXIgY2FuIHBvd2VyIG9mZiB0
aGUgc3lzdGVtIGJ5IHB1bGxpbmcgdGhlDQo+Pj4+PiBQTUlDX09OX1JFUSBzaWduYWwgbG93LCB0
byBsZXQgdGhlIFBNSUMgZGlzYWJsZSB0aGUgcG93ZXIuDQo+Pj4+PiBUaGUgS29udHJvbiBTb01z
IGRvIG5vdCBoYXZlIHRoaXMgc2lnbmFsIGNvbm5lY3RlZCwgc28gbGV0J3MgcmVtb3ZlDQo+Pj4+
PiB0aGUgbm9kZS4NCj4+Pj4+DQo+Pj4+PiBUaGlzIHNlZW1zIHRvIGZpeCBhIHJlYWwgaXNzdWUg
d2hlbiB0aGUgc2lnbmFsIGlzIGFzc2VydGVkIGF0DQo+Pj4+PiBwb3dlcm9mZiwgYnV0IG5vdCBh
Y3R1YWxseSBjYXVzaW5nIHRoZSBwb3dlciB0byB0dXJuIG9mZi4gSXQgd2FzDQo+Pj4+PiBvYnNl
cnZlZCwgdGhhdCBpbiB0aGlzIGNhc2UgdGhlIHN5c3RlbSB3b3VsZCBub3Qgc2h1dCBkb3duIHBy
b3Blcmx5Lg0KPj4+Pg0KPj4+PiBJIGRvIG5vdCBxdWl0ZSBmb2xsb3cgb24gdGhpcy7CoCBIb3cg
ZG9lcyBkaXNhYmxpbmcgc252c19wb3dlcm9mZiBmaXggdGhlDQo+Pj4+IGlzc3VlP8KgIFRoZSBy
b290IGNhdXNlIG9mIHN5c3RlbSBub3Qgc2h1dCBkb3duIHByb3Blcmx5IHNlZW1zIHRvIGJlIHRo
YXQNCj4+Pj4gUE1JQyBkb2Vzbid0IHNodXQgZG93biBwb3dlci7CoCBUaGlzIGxvb2tzIGxpa2Ug
YSBjbGVhbi11cCByYXRoZXIgdGhhbg0KPj4+PiBidWcgZml4Lg0KPj4+DQo+Pj4gSSBkb24ndCBr
bm93IHRoZSBleGFjdCByZWFzb25zLCBidXQgd2UgaGFkIGlzc3VlcyBvbiB0aGVzZSBib2FyZHMg
d2hlbg0KPj4+IGRvaW5nIGEgInBvd2Vyb2ZmIi4gVGhlIGtlcm5lbCB3b3VsZCBwcmludCBzb21l
dGhpbmcgbGlrZSB0aGUgbG9nIGJlbG93Lg0KPj4+IERpc2FibGluZyB0aGUgc252cy1wb3dlcm9m
ZiBzb2x2ZWQgdGhpcy4NCj4+Pg0KPj4+IEJ1dCBub3RlIHRoYXQgdGhpcyBoYXMgbGFzdCBiZWVu
IHJlcHJvZHVjZWQgb24gdjQuMTQuIFNvIEknbSBub3Qgc3VyZSBpZg0KPj4+IHRoaXMgaXMgc3Rp
bGwgYSBwcm9ibGVtIHdpdGggdGhlIGN1cnJlbnQga2VybmVsLg0KPj4+DQo+Pj4gIyMjIyMjIw0K
Pj4+IHJlYm9vdDogUG93ZXIgZG93bg0KPj4+IFVuYWJsZSB0byBwb3dlcm9mZiBzeXN0ZW0NCj4+
Pg0KPj4+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4+IFdBUk5JTkc6
IGhhbHQvNjc1IHN0aWxsIGhhcyBsb2NrcyBoZWxkIQ0KPj4+IDQuMTQuMTA0LWV4Y2VldCAjMSBO
b3QgdGFpbnRlZA0KPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+
IDEgbG9jayBoZWxkIGJ5IGhhbHQvNjc1Og0KPj4+ICAgwqAjMDrCoCAocmVib290X211dGV4KXsr
LisufSwgYXQ6IFs8YzAxNDVhOTg+XSBTeVNfcmVib290KzB4MTRjLzB4MWRjDQo+Pj4gIyMjIyMj
Iw0KPj4+DQo+Pj4+DQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1w
ZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRlPg0KPj4+Pj4gRml4ZXM6IDFlYTRiNzZjZGZk
ZSAoIkFSTTogZHRzOiBpbXg2dWwta29udHJvbi1uNjMxMDogQWRkIEtvbnRyb24NCj4+Pj4+IGku
TVg2VUwgTjYzMTAgU29NIGFuZCBib2FyZHMiKQ0KPj4+Pg0KPj4+PiBJZiB5b3UgdGhpbmsgdGhp
cyBpcyByZWFsbHkgYSBidWcgZml4LCBpdCBzaG91bGQgYmUgYXBwbGllZCB0byB0aGUgZmlsZQ0K
Pj4+PiBiZWZvcmUgcmVuYW1pbmcgcmF0aGVyIHRoYW4gdGhlIG9uZSBhZnRlciByZW5hbWluZy4N
Cj4+Pg0KPj4+IEkgd2lsbCB0cnkgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSB3aXRoIHRoZSBjdXJy
ZW50IGtlcm5lbCBhbmQgZGVwZW5kaW5nDQo+Pj4gb24gdGhlIHJlc3VsdHMgZWl0aGVyIGRyb3Ag
dGhlIEZpeGVzIHRhZyBvciBtb3ZlIHRoZSBwYXRjaCBiZWZvcmUgdGhlDQo+Pj4gcmVuYW1pbmcu
DQo+Pg0KPj4gSSBqdXN0IHRyaWVkIHRoaXMgd2l0aCA1LjQtcmM1IGFuZCB0aGUgaXNzdWUgcGVy
c2lzdHMuIFdoZW4NCj4+IHNudnMtcG93ZXJvZmYgaXMgZW5hYmxlZCB3aXRob3V0IHRoZSBoYXJk
d2FyZSBhY3R1YWxseSBiZWluZyBhYmxlIHRvDQo+PiBwb3dlciBkb3duIHZpYSBQTUlDIEkgZ2V0
IGEgbG9ja2luZyBXQVJOSU5HIGZyb20gdGhlIGtlcm5lbC4gUHJvYmFibHkNCj4+IGJlY2F1c2Ug
dGhlIHN5c3RlbSBpcyBzdGlsbCBydW5uaW5nLCB3aGVuIGl0J3MgYWxyZWFkeSBzdXBwb3NlZCB0
byBiZQ0KPj4gc2h1dCBkb3duIGJ5IHRoZSBQTUlDLg0KPiANCj4gSSBzdGlsbCBkbyBub3QgZ2V0
IGl0LiAgQXJlIHlvdSBzYXlpbmcgdGhhdCB3aXRoIHNudnMtcG93ZXJvZmYgYmVpbmcNCj4gZGlz
YWJsZWQsIHlvdXIgc3lzdGVtIGlzIG5vdyBhYmxlIHRvIGJlIHNodXQgZG93biBwcm9wZXJseSBi
eSBQTUlDPw0KDQpTb3JyeSBmb3IgdGhlIGNvbmZ1c2lvbi4gVGhlIGJvYXJkIGRvZXMgbm90IGhh
dmUgYSBQTUlDIGFuZCB0aGUgDQpQTUlDX09OX1JFUSBzaWduYWwgaXMgbm90IGNvbm5lY3RlZC4g
U28gdGhlIHNudnMtcG93ZXJvZmYgZHJpdmVyIHNob3VsZCANCmRlZmluaXRlbHkgYmUgZGlzYWJs
ZWQgYmVjYXVzZSB0aGVyZSBpcyBubyByZWFzb24gZm9yIGl0IHRvIGJlIGVuYWJsZWQuDQoNCkJ1
dCBpbmRlZWQsIHdpdGggc252cy1wb3dlcm9mZiBkaXNhYmxlZCB0aGUgYm9hcmQgZG9lcyBub3cg
YXQgbGVhc3QgaGFsdCANCmNvcnJlY3RseSAoaXQgaXMgc3RpbGwgcG93ZXJlZCBvZiBjb3Vyc2Up
Lg0KDQpGb3Igc29tZSByZWFzb24sIHByb2JhYmx5IGJ5IHNvbWUgY29weSBhbmQgcGFzdGUgbWlz
dGFrZSwgdGhlIA0Kc252cy1wb3dlcm9mZiBkcml2ZXIgaXMgZW5hYmxlZCBpbiB0aGUgZHRzIHdo
aWNoIGNhdXNlcyB0aGUgaXNzdWUgDQpkZXNjcmliZWQgYWJvdmUgd2hlbiB0cnlpbmcgdG8gaGFs
dC9zaHV0ZG93biB0aGUgc3lzdGVtLiBQbGVhc2UgYWxzbyBzZWUgDQp0aGUgbG9ncyBiZWxvdyBm
b3IgY29tcGFyaXNvbiBvZiBib3RoIGNhc2VzLg0KDQpXaXRoIHNudnMtcG93ZXJvZmYgZW5hYmxl
ZDoNCg0KIyMjIyMjIyMjIyMjDQp+IyBwb3dlcm9mZg0KVGhlIHN5c3RlbSBpcyBnb2luZyBkb3du
IGZvciBzeXN0ZW0gaGFsdCBOT1cheW14YzMpIChUaHUgT2N0IDMxIDE4OjU3OjU1IA0KMjAxOQ0K
Wy4uLl0NCnJlYm9vdDogUG93ZXIgZG93bg0KVW5hYmxlIHRvIHBvd2Vyb2ZmIHN5c3RlbQ0KDQo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCldBUk5JTkc6IGhhbHQvODY5IHN0
aWxsIGhhcyBsb2NrcyBoZWxkIQ0KNS40LjAtcmM1LWt0biAjMSBOb3QgdGFpbnRlZA0KLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoxIGxvY2sgaGVsZCBieSBoYWx0Lzg2OToN
CiAgIzA6IGMxMTEzOGY4IChzeXN0ZW1fdHJhbnNpdGlvbl9tdXRleCl7Ky4rLn0sIGF0OiANCl9f
ZG9fc3lzX3JlYm9vdCsweDE3NC8weDIwYw0KDQpzdGFjayBiYWNrdHJhY2U6DQpDUFU6IDAgUElE
OiA4NjkgQ29tbTogaGFsdCBOb3QgdGFpbnRlZCA1LjQuMC1yYzUta3RuICMxDQpIYXJkd2FyZSBu
YW1lOiBGcmVlc2NhbGUgaS5NWDYgVWx0cmFsaXRlIChEZXZpY2UgVHJlZSkNCls8YzAxMTJiYjg+
XSAodW53aW5kX2JhY2t0cmFjZSkgZnJvbSBbPGMwMTBjZTE0Pl0gKHNob3dfc3RhY2srMHgxMC8w
eDE0KQ0KWzxjMDEwY2UxND5dIChzaG93X3N0YWNrKSBmcm9tIFs8YzBhZTE4ZGM+XSAoZHVtcF9z
dGFjaysweGQ4LzB4MTEwKQ0KWzxjMGFlMThkYz5dIChkdW1wX3N0YWNrKSBmcm9tIFs8YzAxMmE1
YzA+XSAoZG9fZXhpdCsweDdhNC8weGI5NCkNCls8YzAxMmE1YzA+XSAoZG9fZXhpdCkgZnJvbSBb
PGMwMTRmZTY0Pl0gKF9fZG9fc3lzX3JlYm9vdCsweDE4MC8weDIwYykNCls8YzAxNGZlNjQ+XSAo
X19kb19zeXNfcmVib290KSBmcm9tIFs8YzAxMDEwMDA+XSAocmV0X2Zhc3Rfc3lzY2FsbCsweDAv
MHgyOCkNCkV4Y2VwdGlvbiBzdGFjaygweGQ5ZTE1ZmE4IHRvIDB4ZDllMTVmZjApDQo1ZmEwOiAg
ICAgICAgICAgICAgICAgICBiZWQ1M2UxNCAwMDAwMDAwNSBmZWUxZGVhZCAyODEyMTk2OSA0MzIx
ZmVkYyANCmZmZmZmZmY2DQo1ZmMwOiBiZWQ1M2UxNCAwMDAwMDAwNSAwMDQwY2YwNCAwMDAwMDA1
OCAwMDQxZGVmOCAwMDAwMDAwMCAwMDAwMDAwMSANCjAwMDAwMDAwDQo1ZmUwOiAwMDAwMDA1OCBi
ZWQ1M2M3NCBiNmYwM2FkNSBiNmU4OWM0Ng0KIyMjIyMjIyMjIyMjDQoNCldpdGggc252cy1wb3dl
cm9mZiBkaXNhYmxlZDoNCg0KIyMjIyMjIyMjIyMjDQpUaGUgc3lzdGVtIGlzIGdvaW5nIGRvd24g
Zm9yIHN5c3RlbSBoYWx0IE5PVyF5bXhjMykgKFRodSBPY3QgMzEgMTg6NTY6MzMgDQoyMDE5DQpb
Li4uXQ0KcmVib290OiBTeXN0ZW0gaGFsdGVkDQojIyMjIyMjIyMjIyMNCg0KPiANCj4gU2hhd24N
Cj4gDQo+Pg0KPj4gU28gdGhpcyBmaXhlcyBhIHJlYWwgcHJvYmxlbSBhbmQgdGhlcmVmb3JlIEkg
d2lsbCBrZWVwIHRoZSBGaXhlcyB0YWcgYW5kDQo+PiBtb3ZlIHRoZSBwYXRjaCB0byB0aGUgcHJv
cGVyIHBsYWNlIGluIHRoaXMgc2VyaWVzLg==
