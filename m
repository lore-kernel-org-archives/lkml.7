Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E427CC04AA7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C6522084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfEOGtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:49:17 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:47346 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbfEOGtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:49:17 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id A8E1024D8E90;
        Wed, 15 May 2019 08:49:12 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 May
 2019 08:49:12 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Wed, 15 May 2019 08:49:12 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Marek Vasut <marek.vasut@gmail.com>,
        Jeff Kletsky <lede@allycomm.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spinand: Add #define-s for page-read ops with
 three-byte addresses
Thread-Topic: [PATCH v2 1/3] mtd: spinand: Add #define-s for page-read ops
 with three-byte addresses
Thread-Index: AQHVCp+gSJvETC1sqUWniiGRN7WTKKZrlQUAgAAIzoA=
Date:   Wed, 15 May 2019 06:49:12 +0000
Message-ID: <efcbdd61-d60e-a5d1-9f91-f8f747fadecf@kontron.de>
References: <20190514215315.19228-1-lede@allycomm.com>
 <20190514215315.19228-2-lede@allycomm.com>
 <355bcf8d-bce6-1b82-0f57-539c8d9b6cac@gmail.com>
In-Reply-To: <355bcf8d-bce6-1b82-0f57-539c8d9b6cac@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FF76DAAB784ED4D817389ECCA7528A9@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: A8E1024D8E90.ACE6F
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, lede@allycomm.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, marek.vasut@gmail.com,
        miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDUuMTkgMDg6MTcsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBPbiA1LzE0LzE5IDExOjUz
IFBNLCBKZWZmIEtsZXRza3kgd3JvdGU6DQo+PiBGcm9tOiBKZWZmIEtsZXRza3kgPGdpdC1jb21t
aXRzQGFsbHljb21tLmNvbT4NCj4gDQo+IFRoYXQgI2RlZmluZSBpbiAkc3ViamVjdCBpcyBjYWxs
ZWQgYSBtYWNyby4NCj4gDQo+IFNlZW1zIHRoaXMgcGF0Y2ggYWRkcyBhIGxvdCBvZiBhbG1vc3Qg
ZHVwbGljYXRlIGNvZGUsIGNhbiBpdCBiZSBzb21laG93DQo+IGRlLWR1cGxpY2F0ZWQgPw0KDQpX
ZSBjb3VsZCBhZGQgYW5vdGhlciBwYXJhbWV0ZXIgbmFkZHIgb3IgYWRkcmxlbiB0byB0aGUgDQpT
UElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1hYX09QcyBhbmQgcGFzcyB0aGUgdmFsdWUgMiBm
b3IgYWxsIA0KZXhpc3RpbmcgY2hpcHMgZXhjZXB0IGZvciBHRDVGMUdRNFVGeHhHIHdoaWNoIG5l
ZWRzIDMgYnl0ZXMgYWRkcmVzcyBsZW5ndGguDQoNClRoaXMgd291bGQgY2F1c2Ugb25lIG1vcmUg
YXJndW1lbnQgdG8gZWFjaCBvZiB0aGUgbWFjcm8gY2FsbHMgaW4gYWxsIA0KY2hpcCBkcml2ZXJz
LiBBcyBsb25nIGFzIHRoZXJlIGFyZSBvbmx5IHR3byBmbGF2b3JzICgyIGFuZCAzIGJ5dGVzKSBJ
J20gDQpub3Qgc3VyZSBpZiB0aGlzIHJlYWxseSB3b3VsZCBtYWtlIHRoaW5ncyBlYXNpZXIgYW5k
IGFsc28gdGhpcyBpcyAib25seSIgDQpwcmVwcm9jZXNzb3IgY29kZS4NCg0KU28gYW55d2F5cywg
SSB3b3VsZCBiZSBmaW5lIHdpdGggYm90aCBhcHByb2FjaGVzLCBKZWZmJ3MgY3VycmVudCBvbmUg
b3IgDQpvbmUgd2l0aCBhbm90aGVyIHBhcmFtZXRlciBmb3IgdGhlIGFkZHJlc3MgbGVuZ3RoLg0K
DQpCeSB0aGUgd2F5OiBKZWZmLCB5b3UgZGlkbid0IGNhcnJ5IG15IFJldmlld2VkLWJ5IHRhZyB0
byB2Mi4gU28gSSB3aWxsIA0KanVzdCByZXBseSBhZ2FpbiB0byBhZGQgdGhlIHRhZ3MuDQoNCj4g
DQo+PiBUaGUgR2lnYURldmljZSBHRDVGMUdRNFVGeHhHIFNQSSBOQU5EIHV0aWxpemVzIHRocmVl
LWJ5dGUgYWRkcmVzc2VzDQo+PiBmb3IgaXRzIHBhZ2UtcmVhZCBvcHMuDQo+Pg0KPj4gaHR0cDov
L3d3dy5naWdhZGV2aWNlLmNvbS9kYXRhc2hlZXQvZ2Q1ZjFncTR4Znh4Zy8NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBKZWZmIEtsZXRza3kgPGdpdC1jb21taXRzQGFsbHljb21tLmNvbT4NCj4+IC0t
LQ0KPj4gICBpbmNsdWRlL2xpbnV4L210ZC9zcGluYW5kLmggfCAzMCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tdGQvc3BpbmFuZC5oIGIvaW5jbHVkZS9s
aW51eC9tdGQvc3BpbmFuZC5oDQo+PiBpbmRleCBiOTJlMmFhOTU1YjYuLjA1ZmU5OGVlYmUyNyAx
MDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvbGludXgvbXRkL3NwaW5hbmQuaA0KPj4gKysrIGIvaW5j
bHVkZS9saW51eC9tdGQvc3BpbmFuZC5oDQo+PiBAQCAtNjgsMzAgKzY4LDYwIEBADQo+PiAgIAkJ
ICAgU1BJX01FTV9PUF9EVU1NWShuZHVtbXksIDEpLAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9P
UF9EQVRBX0lOKGxlbiwgYnVmLCAxKSkNCj4+ICAgDQo+PiArI2RlZmluZSBTUElOQU5EX1BBR0Vf
UkVBRF9GUk9NX0NBQ0hFX09QXzNBKGZhc3QsIGFkZHIsIG5kdW1teSwgYnVmLCBsZW4pIFwNCj4+
ICsJU1BJX01FTV9PUChTUElfTUVNX09QX0NNRChmYXN0ID8gMHgwYiA6IDB4MDMsIDEpLAkJXA0K
Pj4gKwkJICAgU1BJX01FTV9PUF9BRERSKDMsIGFkZHIsIDEpLAkJCQlcDQo+PiArCQkgICBTUElf
TUVNX09QX0RVTU1ZKG5kdW1teSwgMSksCQkJCVwNCj4+ICsJCSAgIFNQSV9NRU1fT1BfREFUQV9J
TihsZW4sIGJ1ZiwgMSkpDQo+PiArDQo+PiAgICNkZWZpbmUgU1BJTkFORF9QQUdFX1JFQURfRlJP
TV9DQUNIRV9YMl9PUChhZGRyLCBuZHVtbXksIGJ1ZiwgbGVuKQlcDQo+PiAgIAlTUElfTUVNX09Q
KFNQSV9NRU1fT1BfQ01EKDB4M2IsIDEpLAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9PUF9BRERS
KDIsIGFkZHIsIDEpLAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9PUF9EVU1NWShuZHVtbXksIDEp
LAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9PUF9EQVRBX0lOKGxlbiwgYnVmLCAyKSkNCj4+ICAg
DQo+PiArI2RlZmluZSBTUElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1gyX09QXzNBKGFkZHIs
IG5kdW1teSwgYnVmLCBsZW4pCVwNCj4+ICsJU1BJX01FTV9PUChTUElfTUVNX09QX0NNRCgweDNi
LCAxKSwJCQkJXA0KPj4gKwkJICAgU1BJX01FTV9PUF9BRERSKDMsIGFkZHIsIDEpLAkJCQlcDQo+
PiArCQkgICBTUElfTUVNX09QX0RVTU1ZKG5kdW1teSwgMSksCQkJCVwNCj4+ICsJCSAgIFNQSV9N
RU1fT1BfREFUQV9JTihsZW4sIGJ1ZiwgMikpDQo+PiArDQo+PiAgICNkZWZpbmUgU1BJTkFORF9Q
QUdFX1JFQURfRlJPTV9DQUNIRV9YNF9PUChhZGRyLCBuZHVtbXksIGJ1ZiwgbGVuKQlcDQo+PiAg
IAlTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKDB4NmIsIDEpLAkJCQlcDQo+PiAgIAkJICAgU1BJ
X01FTV9PUF9BRERSKDIsIGFkZHIsIDEpLAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9PUF9EVU1N
WShuZHVtbXksIDEpLAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9PUF9EQVRBX0lOKGxlbiwgYnVm
LCA0KSkNCj4+ICAgDQo+PiArI2RlZmluZSBTUElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1g0
X09QXzNBKGFkZHIsIG5kdW1teSwgYnVmLCBsZW4pCVwNCj4+ICsJU1BJX01FTV9PUChTUElfTUVN
X09QX0NNRCgweDZiLCAxKSwJCQkJXA0KPj4gKwkJICAgU1BJX01FTV9PUF9BRERSKDMsIGFkZHIs
IDEpLAkJCQlcDQo+PiArCQkgICBTUElfTUVNX09QX0RVTU1ZKG5kdW1teSwgMSksCQkJCVwNCj4+
ICsJCSAgIFNQSV9NRU1fT1BfREFUQV9JTihsZW4sIGJ1ZiwgNCkpDQo+PiArDQo+PiAgICNkZWZp
bmUgU1BJTkFORF9QQUdFX1JFQURfRlJPTV9DQUNIRV9EVUFMSU9fT1AoYWRkciwgbmR1bW15LCBi
dWYsIGxlbikJXA0KPj4gICAJU1BJX01FTV9PUChTUElfTUVNX09QX0NNRCgweGJiLCAxKSwJCQkJ
XA0KPj4gICAJCSAgIFNQSV9NRU1fT1BfQUREUigyLCBhZGRyLCAyKSwJCQkJXA0KPj4gICAJCSAg
IFNQSV9NRU1fT1BfRFVNTVkobmR1bW15LCAyKSwJCQkJXA0KPj4gICAJCSAgIFNQSV9NRU1fT1Bf
REFUQV9JTihsZW4sIGJ1ZiwgMikpDQo+PiAgIA0KPj4gKyNkZWZpbmUgU1BJTkFORF9QQUdFX1JF
QURfRlJPTV9DQUNIRV9EVUFMSU9fT1BfM0EoYWRkciwgbmR1bW15LCBidWYsIGxlbikgXA0KPj4g
KwlTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKDB4YmIsIDEpLAkJCQlcDQo+PiArCQkgICBTUElf
TUVNX09QX0FERFIoMywgYWRkciwgMiksCQkJCVwNCj4+ICsJCSAgIFNQSV9NRU1fT1BfRFVNTVko
bmR1bW15LCAyKSwJCQkJXA0KPj4gKwkJICAgU1BJX01FTV9PUF9EQVRBX0lOKGxlbiwgYnVmLCAy
KSkNCj4+ICsNCj4+ICAgI2RlZmluZSBTUElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1FVQURJ
T19PUChhZGRyLCBuZHVtbXksIGJ1ZiwgbGVuKQlcDQo+PiAgIAlTUElfTUVNX09QKFNQSV9NRU1f
T1BfQ01EKDB4ZWIsIDEpLAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9PUF9BRERSKDIsIGFkZHIs
IDQpLAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9PUF9EVU1NWShuZHVtbXksIDQpLAkJCQlcDQo+
PiAgIAkJICAgU1BJX01FTV9PUF9EQVRBX0lOKGxlbiwgYnVmLCA0KSkNCj4+ICAgDQo+PiArI2Rl
ZmluZSBTUElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1FVQURJT19PUF8zQShhZGRyLCBuZHVt
bXksIGJ1ZiwgbGVuKSBcDQo+PiArCVNQSV9NRU1fT1AoU1BJX01FTV9PUF9DTUQoMHhlYiwgMSks
CQkJCVwNCj4+ICsJCSAgIFNQSV9NRU1fT1BfQUREUigzLCBhZGRyLCA0KSwJCQkJXA0KPj4gKwkJ
ICAgU1BJX01FTV9PUF9EVU1NWShuZHVtbXksIDQpLAkJCQlcDQo+PiArCQkgICBTUElfTUVNX09Q
X0RBVEFfSU4obGVuLCBidWYsIDQpKQ0KPj4gKw0KPj4gICAjZGVmaW5lIFNQSU5BTkRfUFJPR19F
WEVDX09QKGFkZHIpCQkJCQlcDQo+PiAgIAlTUElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKDB4MTAs
IDEpLAkJCQlcDQo+PiAgIAkJICAgU1BJX01FTV9PUF9BRERSKDMsIGFkZHIsIDEpLAkJCQlcDQo+
Pg0KPiANCj4g
