Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228F4C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D00422175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfEWG4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:56:13 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:34680 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbfEWG4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:56:13 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id F1C4C66117A;
        Thu, 23 May 2019 08:56:10 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 23 May
 2019 08:56:10 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 23 May 2019 08:56:10 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Jeff Kletsky <lede@allycomm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kbuild-all@01.org" <kbuild-all@01.org>
Subject: Re: [PATCH v4 0/3] mtd: spinand: Add support for GigaDevice
 GD5F1GQ4UFxxG
Thread-Topic: [PATCH v4 0/3] mtd: spinand: Add support for GigaDevice
 GD5F1GQ4UFxxG
Thread-Index: AQHVEOqZITkhzQGdUk6QCGzMLzqE8KZ4JdgA
Date:   Thu, 23 May 2019 06:56:10 +0000
Message-ID: <6351c1d6-c284-6bca-3914-3895d847c9c3@kontron.de>
References: <20190522220555.11626-1-lede@allycomm.com>
In-Reply-To: <20190522220555.11626-1-lede@allycomm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A0683E7EA1CEF4893A50D6A09536B99@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: F1C4C66117A.A0D76
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: bbrezillon@kernel.org, computersforpeace@gmail.com,
        dwmw2@infradead.org, kbuild-all@01.org, lede@allycomm.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmVmZiwNCg0KT24gMjMuMDUuMTkgMDA6MDUsIEplZmYgS2xldHNreSB3cm90ZToNCj4gQWRk
cmVzc2VzIGNoYW5nZXMgaW4gbWFjcm9zIGFuZCByZWxhdGVkIGRhdGEgc3RydWN0dXJlcyBpbnRy
b2R1Y2VkIGJ5DQo+ICAgIGNvbW1pdCAzNzdlNTE3YjVmYTUNCj4gICAgICAgIG10ZDogbmFuZDog
QWRkIG1heF9iYWRfZXJhc2VibG9ja3NfcGVyX2x1biBpbmZvIHRvIG1lbW9yZw0KPiANCj4gUmVz
b2x2ZXMgaXNzdWUgZGV0ZWN0ZWQgYnkga2J1aWxkIHRlc3Qgcm9ib3QNCj4gICAgVHVlLCAyMSBN
YXkgMjAxOSAxNzoyODowOSArMDgwMA0KPiAgICBUdWUsIDIxIE1heSAyMDE5IDE4OjE3OjI4ICsw
ODAwDQo+IA0KPiBHRDVGMUdRNFVGeHhHIGRhdGEgc2hlZXQgb24gcGFnZSAzNCBvZiBnZDVmMWdx
NHhmeHhnX3YyLjRfMjAxOTAzMjIucGRmDQo+IGluZGljYXRlcyAiTWludW11bSBudW1iZXIgb2Yg
dmFsaWQgYmxvY2tzIChOdmIpIiAxMDA0IG91dCBvZiAxMDI0IHRvdGFsLg0KPiANCj4gTmV3bHkg
aW50cm9kdWNlZCAibWF4IGJhZCBibG9ja3MiIHBhcmFtZXRlciBzZXQgdG8gMjAgKDEwMjQtMTAy
MCkuDQo+IA0KPiBSZWJhc2VkIG9uIHY1LjItcmMxIGFuZCBjb25maXJtZWQgcGF0Y2ggYXBwbGll
cyBvbiBtYXN0ZXIuDQo+IA0KPiANCj4gUGF0Y2hlcyAxLzMgYW5kIDIvMyBhcmUgdGhlIHNhbWUg
YXMgaW4gdGhlIHByZXZpb3VzIHNlcmllcy4NCj4gDQo+IFBhdGNoIDMvMywgbXRkOiBzcGluYW5k
OiBBZGQgc3VwcG9ydCBmb3IgR2lnYURldmljZSBHRDVGMUdRNFVGeHhHLA0KPiBpbmNsdWRlcyB0
aGUgYWRkaXRpb25hbCBwYXJhbWV0ZXIgKGNvbXBhcmVkIGhlcmUgdG8gdjMgb2YgdGhlIHNlcmll
cyk6DQo+IA0KPiAgICAgIFNQSU5BTkRfSU5GTygiR0Q1RjFHUTRVRnh4RyIsIDB4YjE0OCwNCj4g
ICAgICAtICAgICAgICAgICAgICAgICAgICBOQU5EX01FTU9SRygxLCAyMDQ4LCAxMjgsIDY0LCAx
MDI0LCAxLCAxLCAxKSwNCj4gICAgICArICAgICAgICAgICAgICAgICAgICBOQU5EX01FTU9SRygx
LCAyMDQ4LCAxMjgsIDY0LCAxMDI0LCAyMCwgMSwgMSwgMSksDQo+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTkFORF9FQ0NSRVEoOCwgNTEyKSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICBTUElOQU5EX0lORk9fT1BfVkFSSUFOVFMoJnJlYWRfY2FjaGVfdmFyaWFudHNfZiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAmd3JpdGVfY2FjaGVfdmFyaWFudHMsDQo+IA0KPiBSLWIg
b2YgRnJpZWRlciBTY2hyZW1wZiByZW1vdmVkIGZyb20gWzMvM10gYXMgYSByZXN1bHQgdGhpcyBj
aGFuZ2UuDQoNCkFzIHRvIHdoYXQgSSBrbm93LCB0aGlzIHdvdWxkIG5vdCBoYXZlIGJlZW4gbmVj
ZXNzYXJ5IGluIHRoaXMgY2FzZS4gSSANCm1pc3NlZCB0aGUgbWlzc2luZyBwYXJhbWV0ZXIgd2hp
bGUgcmV2aWV3aW5nIGFuZCB5b3UgZml4ZWQgaXQgd2l0aCB0aGlzIA0KbmV3IHZlcnNpb24sIHNv
IHlvdSBvYnZpb3VzbHkgaW1wcm92ZWQgdGhlIHBhdGNoIHdpdGggYSBtaW5vciBjaGFuZ2UgYW5k
IA0KaXQgd291bGRuJ3QgYmUgd29ya2luZyB3aXRob3V0IHRoaXMgYW55d2F5LiBTbyBJIHRoaW5r
IGluIHN1Y2ggY2FzZXMgeW91IA0Kd291bGQgdHlwaWNhbGx5IGtlZXAgdGhlIFItYiB0YWdzLg0K
DQpBbHNvIGlmIHlvdSBkcm9wIHRoZSBSLWIgdGFnIGZyb20gb25lIG9mIHRoZSBwYXRjaGVzIGlu
IHlvdXIgc2V0LCB5b3UgDQpzaG91bGQgaW5zdGVhZCBDQyB0aGUgcmV2aWV3ZXIgZm9yIHRoZSB3
aG9sZSBzZXQuIE90aGVyd2lzZSANCmdldF9tYWludGFpbmVyIHdpbGwgb25seSBDQyB0aGUgcmV2
aWV3ZXIgZm9yIHRob3NlIHBhdGNoZXMgdGhhdCBjb250YWluIA0KaGlzIHRhZy4gSW4gdGhpcyBj
YXNlIEkgd2Fzbid0IENDZWQgZm9yIHBhdGNoIDMvMy4NCg0KVGhhbmtzLA0KRnJpZWRlcg0KDQo+
IA0KPiBTdXBlcnNlZGVzIHNlcmllczoNCj4gDQo+IG10ZDogc3BpbmFuZDogQWRkIHN1cHBvcnQg
Zm9yIEdpZ2FEZXZpY2UgR0Q1RjFHUTRVRnh4Rw0KPiBodHRwczovL3BhdGNod29yay5vemxhYnMu
b3JnL3Byb2plY3QvbGludXgtbXRkL2xpc3QvP3Nlcmllcz0xMDg4NjgNCj4gDQo+IA0KPiANCj4g
SmVmZg0KPiANCj4gDQo+IA0KPiBDYzogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290
bGluLmNvbT4NCj4gQ2M6IFNjaHJlbXBmIEZyaWVkZXIgPGZyaWVkZXIuc2NocmVtcGZAa29udHJv
bi5kZT4NCj4gQ2M6IEJvcmlzIEJyZXppbGxvbiA8YmJyZXppbGxvbkBrZXJuZWwub3JnPg0KPiBD
YzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4NCj4gQ2M6IERhdmlkIFdvb2Ro
b3VzZSA8ZHdtdzJAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IEJyaWFuIE5vcnJpcyA8Y29tcHV0ZXJz
Zm9ycGVhY2VAZ21haWwuY29tPg0KPiBDYzogTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0QGdtYWls
LmNvbT4NCj4gQ2M6IGxpbnV4LW10ZEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IENjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBrYnVpbGQtYWxsQDAxLm9yZw0KPiANCj4gDQo+
IA==
