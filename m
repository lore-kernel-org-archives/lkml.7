Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8285CC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A0A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 06:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfEOGvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 02:51:43 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:46536 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOGvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 02:51:43 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 6369967A913;
        Wed, 15 May 2019 08:51:39 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 15 May
 2019 08:51:38 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Wed, 15 May 2019 08:51:38 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Jeff Kletsky <lede@allycomm.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] mtd: spinand: Add #define-s for page-read ops with
 three-byte addresses
Thread-Topic: [PATCH v2 1/3] mtd: spinand: Add #define-s for page-read ops
 with three-byte addresses
Thread-Index: AQHVCp+gSJvETC1sqUWniiGRN7WTKKZrnoMA
Date:   Wed, 15 May 2019 06:51:38 +0000
Message-ID: <e5dfd043-e5a4-4c6c-5af7-51c52873c9d6@kontron.de>
References: <20190514215315.19228-1-lede@allycomm.com>
 <20190514215315.19228-2-lede@allycomm.com>
In-Reply-To: <20190514215315.19228-2-lede@allycomm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CC79ECD7D7CF34CBF4C437EECD620E0@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 6369967A913.ACFA0
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

T24gMTQuMDUuMTkgMjM6NTMsIEplZmYgS2xldHNreSB3cm90ZToNCj4gRnJvbTogSmVmZiBLbGV0
c2t5IDxnaXQtY29tbWl0c0BhbGx5Y29tbS5jb20+DQo+IA0KPiBUaGUgR2lnYURldmljZSBHRDVG
MUdRNFVGeHhHIFNQSSBOQU5EIHV0aWxpemVzIHRocmVlLWJ5dGUgYWRkcmVzc2VzDQo+IGZvciBp
dHMgcGFnZS1yZWFkIG9wcy4NCj4gDQo+IGh0dHA6Ly93d3cuZ2lnYWRldmljZS5jb20vZGF0YXNo
ZWV0L2dkNWYxZ3E0eGZ4eGcvDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKZWZmIEtsZXRza3kgPGdp
dC1jb21taXRzQGFsbHljb21tLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEZyaWVkZXIgU2NocmVtcGYg
PGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCg0KPiAtLS0NCj4gICBpbmNsdWRlL2xpbnV4
L210ZC9zcGluYW5kLmggfCAzMCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAx
IGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvbXRkL3NwaW5hbmQuaCBiL2luY2x1ZGUvbGludXgvbXRkL3NwaW5hbmQuaA0KPiBp
bmRleCBiOTJlMmFhOTU1YjYuLjA1ZmU5OGVlYmUyNyAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9tdGQvc3BpbmFuZC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbXRkL3NwaW5hbmQuaA0K
PiBAQCAtNjgsMzAgKzY4LDYwIEBADQo+ICAgCQkgICBTUElfTUVNX09QX0RVTU1ZKG5kdW1teSwg
MSksCQkJCVwNCj4gICAJCSAgIFNQSV9NRU1fT1BfREFUQV9JTihsZW4sIGJ1ZiwgMSkpDQo+ICAg
DQo+ICsjZGVmaW5lIFNQSU5BTkRfUEFHRV9SRUFEX0ZST01fQ0FDSEVfT1BfM0EoZmFzdCwgYWRk
ciwgbmR1bW15LCBidWYsIGxlbikgXA0KPiArCVNQSV9NRU1fT1AoU1BJX01FTV9PUF9DTUQoZmFz
dCA/IDB4MGIgOiAweDAzLCAxKSwJCVwNCj4gKwkJICAgU1BJX01FTV9PUF9BRERSKDMsIGFkZHIs
IDEpLAkJCQlcDQo+ICsJCSAgIFNQSV9NRU1fT1BfRFVNTVkobmR1bW15LCAxKSwJCQkJXA0KPiAr
CQkgICBTUElfTUVNX09QX0RBVEFfSU4obGVuLCBidWYsIDEpKQ0KPiArDQo+ICAgI2RlZmluZSBT
UElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1gyX09QKGFkZHIsIG5kdW1teSwgYnVmLCBsZW4p
CVwNCj4gICAJU1BJX01FTV9PUChTUElfTUVNX09QX0NNRCgweDNiLCAxKSwJCQkJXA0KPiAgIAkJ
ICAgU1BJX01FTV9PUF9BRERSKDIsIGFkZHIsIDEpLAkJCQlcDQo+ICAgCQkgICBTUElfTUVNX09Q
X0RVTU1ZKG5kdW1teSwgMSksCQkJCVwNCj4gICAJCSAgIFNQSV9NRU1fT1BfREFUQV9JTihsZW4s
IGJ1ZiwgMikpDQo+ICAgDQo+ICsjZGVmaW5lIFNQSU5BTkRfUEFHRV9SRUFEX0ZST01fQ0FDSEVf
WDJfT1BfM0EoYWRkciwgbmR1bW15LCBidWYsIGxlbikJXA0KPiArCVNQSV9NRU1fT1AoU1BJX01F
TV9PUF9DTUQoMHgzYiwgMSksCQkJCVwNCj4gKwkJICAgU1BJX01FTV9PUF9BRERSKDMsIGFkZHIs
IDEpLAkJCQlcDQo+ICsJCSAgIFNQSV9NRU1fT1BfRFVNTVkobmR1bW15LCAxKSwJCQkJXA0KPiAr
CQkgICBTUElfTUVNX09QX0RBVEFfSU4obGVuLCBidWYsIDIpKQ0KPiArDQo+ICAgI2RlZmluZSBT
UElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX1g0X09QKGFkZHIsIG5kdW1teSwgYnVmLCBsZW4p
CVwNCj4gICAJU1BJX01FTV9PUChTUElfTUVNX09QX0NNRCgweDZiLCAxKSwJCQkJXA0KPiAgIAkJ
ICAgU1BJX01FTV9PUF9BRERSKDIsIGFkZHIsIDEpLAkJCQlcDQo+ICAgCQkgICBTUElfTUVNX09Q
X0RVTU1ZKG5kdW1teSwgMSksCQkJCVwNCj4gICAJCSAgIFNQSV9NRU1fT1BfREFUQV9JTihsZW4s
IGJ1ZiwgNCkpDQo+ICAgDQo+ICsjZGVmaW5lIFNQSU5BTkRfUEFHRV9SRUFEX0ZST01fQ0FDSEVf
WDRfT1BfM0EoYWRkciwgbmR1bW15LCBidWYsIGxlbikJXA0KPiArCVNQSV9NRU1fT1AoU1BJX01F
TV9PUF9DTUQoMHg2YiwgMSksCQkJCVwNCj4gKwkJICAgU1BJX01FTV9PUF9BRERSKDMsIGFkZHIs
IDEpLAkJCQlcDQo+ICsJCSAgIFNQSV9NRU1fT1BfRFVNTVkobmR1bW15LCAxKSwJCQkJXA0KPiAr
CQkgICBTUElfTUVNX09QX0RBVEFfSU4obGVuLCBidWYsIDQpKQ0KPiArDQo+ICAgI2RlZmluZSBT
UElOQU5EX1BBR0VfUkVBRF9GUk9NX0NBQ0hFX0RVQUxJT19PUChhZGRyLCBuZHVtbXksIGJ1Ziwg
bGVuKQlcDQo+ICAgCVNQSV9NRU1fT1AoU1BJX01FTV9PUF9DTUQoMHhiYiwgMSksCQkJCVwNCj4g
ICAJCSAgIFNQSV9NRU1fT1BfQUREUigyLCBhZGRyLCAyKSwJCQkJXA0KPiAgIAkJICAgU1BJX01F
TV9PUF9EVU1NWShuZHVtbXksIDIpLAkJCQlcDQo+ICAgCQkgICBTUElfTUVNX09QX0RBVEFfSU4o
bGVuLCBidWYsIDIpKQ0KPiAgIA0KPiArI2RlZmluZSBTUElOQU5EX1BBR0VfUkVBRF9GUk9NX0NB
Q0hFX0RVQUxJT19PUF8zQShhZGRyLCBuZHVtbXksIGJ1ZiwgbGVuKSBcDQo+ICsJU1BJX01FTV9P
UChTUElfTUVNX09QX0NNRCgweGJiLCAxKSwJCQkJXA0KPiArCQkgICBTUElfTUVNX09QX0FERFIo
MywgYWRkciwgMiksCQkJCVwNCj4gKwkJICAgU1BJX01FTV9PUF9EVU1NWShuZHVtbXksIDIpLAkJ
CQlcDQo+ICsJCSAgIFNQSV9NRU1fT1BfREFUQV9JTihsZW4sIGJ1ZiwgMikpDQo+ICsNCj4gICAj
ZGVmaW5lIFNQSU5BTkRfUEFHRV9SRUFEX0ZST01fQ0FDSEVfUVVBRElPX09QKGFkZHIsIG5kdW1t
eSwgYnVmLCBsZW4pCVwNCj4gICAJU1BJX01FTV9PUChTUElfTUVNX09QX0NNRCgweGViLCAxKSwJ
CQkJXA0KPiAgIAkJICAgU1BJX01FTV9PUF9BRERSKDIsIGFkZHIsIDQpLAkJCQlcDQo+ICAgCQkg
ICBTUElfTUVNX09QX0RVTU1ZKG5kdW1teSwgNCksCQkJCVwNCj4gICAJCSAgIFNQSV9NRU1fT1Bf
REFUQV9JTihsZW4sIGJ1ZiwgNCkpDQo+ICAgDQo+ICsjZGVmaW5lIFNQSU5BTkRfUEFHRV9SRUFE
X0ZST01fQ0FDSEVfUVVBRElPX09QXzNBKGFkZHIsIG5kdW1teSwgYnVmLCBsZW4pIFwNCj4gKwlT
UElfTUVNX09QKFNQSV9NRU1fT1BfQ01EKDB4ZWIsIDEpLAkJCQlcDQo+ICsJCSAgIFNQSV9NRU1f
T1BfQUREUigzLCBhZGRyLCA0KSwJCQkJXA0KPiArCQkgICBTUElfTUVNX09QX0RVTU1ZKG5kdW1t
eSwgNCksCQkJCVwNCj4gKwkJICAgU1BJX01FTV9PUF9EQVRBX0lOKGxlbiwgYnVmLCA0KSkNCj4g
Kw0KPiAgICNkZWZpbmUgU1BJTkFORF9QUk9HX0VYRUNfT1AoYWRkcikJCQkJCVwNCj4gICAJU1BJ
X01FTV9PUChTUElfTUVNX09QX0NNRCgweDEwLCAxKSwJCQkJXA0KPiAgIAkJICAgU1BJX01FTV9P
UF9BRERSKDMsIGFkZHIsIDEpLAkJCQlcDQo+IA==
