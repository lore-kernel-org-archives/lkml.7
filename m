Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC26C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14242070D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 06:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfE0GgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 02:36:02 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:37096 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfE0GgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 02:36:01 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 9E8A6661163;
        Mon, 27 May 2019 08:35:59 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 May
 2019 08:35:59 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 27 May 2019 08:35:59 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Jeff Kletsky <lede@allycomm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] mtd: spinand: Add support for GigaDevice
 GD5F1GQ4UFxxG
Thread-Topic: [PATCH v4 3/3] mtd: spinand: Add support for GigaDevice
 GD5F1GQ4UFxxG
Thread-Index: AQHVEOq8ofUdXvC9RUu5vDDV8HwpMaZ4IfUAgAElfICABSIVAA==
Date:   Mon, 27 May 2019 06:35:59 +0000
Message-ID: <34004a59-5643-e405-13ca-3581659fc745@kontron.de>
References: <20190522220555.11626-1-lede@allycomm.com>
 <20190522220555.11626-4-lede@allycomm.com>
 <e438022f-3444-9aae-adac-2dd3dd0071b7@kontron.de>
 <e0682730-b69d-d774-d98f-53858e390d8b@allycomm.com>
In-Reply-To: <e0682730-b69d-d774-d98f-53858e390d8b@allycomm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <66800F9B288E7F4BBCB7C047851E6EE1@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 9E8A6661163.AFE1B
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: lede@allycomm.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmVmZiwNCg0KT24gMjQuMDUuMTkgMDI6MTIsIEplZmYgS2xldHNreSB3cm90ZToNCj4gKHJl
ZHVjZWQgZGlyZWN0IGFkZHJlc3NlZXMsIHRob3VnaCBzdGlsbCBvbiBsaXN0cykNCj4gDQo+IE9u
IDUvMjIvMTkgMTE6NDIgUE0sIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+IA0KPj4gT24gMjMu
MDUuMTkgMDA6MDUsIEplZmYgS2xldHNreSB3cm90ZToNCj4+PiBGcm9tOiBKZWZmIEtsZXRza3kg
PGdpdC1jb21taXRzQGFsbHljb21tLmNvbT4NCj4+Pg0KPj4+IFRoZSBHaWdhRGV2aWNlIEdENUYx
R1E0VUZ4eEcgU1BJIE5BTkQgaXMgaW4gY3VycmVudCBwcm9kdWN0aW9uIGRldmljZXMNCj4+PiBh
bmQsIHdoaWxlIGl0IGhhcyB0aGUgc2FtZSBsb2dpY2FsIGxheW91dCBhcyB0aGUgRS1zZXJpZXMg
ZGV2aWNlcywNCj4+PiBpdCBkaWZmZXJzIGluIHRoZSBTUEkgaW50ZXJmYWNpbmcgaW4gc2lnbmlm
aWNhbnQgd2F5cy4NCj4+Pg0KPj4+IFRoaXMgc3VwcG9ydCBpcyBjb250aW5nZW50IG9uIHByZXZp
b3VzIGNvbW1pdHMgdG86DQo+Pj4NCj4+PiDCoMKgwqAgKiBBZGQgc3VwcG9ydCBmb3IgdHdvLWJ5
dGUgZGV2aWNlIElEcw0KPj4+IMKgwqDCoCAqIERlZmluZSBtYWNyb3MgZm9yIHBhZ2UtcmVhZCBv
cHMgd2l0aCB0aHJlZS1ieXRlIGFkZHJlc3Nlcw0KPj4+DQo+Pj4gaHR0cDovL3d3dy5naWdhZGV2
aWNlLmNvbS9kYXRhc2hlZXQvZ2Q1ZjFncTR4Znh4Zy8NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IEplZmYgS2xldHNreSA8Z2l0LWNvbW1pdHNAYWxseWNvbW0uY29tPg0KPj4gUmV2aWV3ZWQtYnk6
IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+DQo+Pj4g
UmVwb3J0ZWQtYnk6IGtidWlsZCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPj4gSSBkb250
J3QgdGhpbmsgdGhhdCB0aGlzIFJlcG9ydGVkLWJ5IHRhZyBzaG91bGQgYmUgdXNlZCBoZXJlLiBU
aGUgYm90DQo+PiByZXBvcnRlZCBidWlsZCBlcnJvcnMgY2F1c2VkIGJ5IHlvdXIgcGF0Y2ggYW5k
IHlvdSBmaXhlZCBpdCBpbiBhIG5ldw0KPj4gdmVyc2lvbi4gQXMgZmFyIGFzIEkgdW5kZXJzdGFu
ZCB0aGlzIHRhZywgaXQgcmVmZXJlbmNlcyBzb21lb25lIHdobw0KPj4gcmVwb3J0ZWQgYSBmbGF3
L2J1ZyB0aGF0IGxlZCB0byB0aGlzIGNoYW5nZSBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+PiBUaGUg
dmVyc2lvbiBoaXN0b3J5IG9mIHRoZSBjaGFuZ2VzIHdvbid0IGJlIHZpc2libGUgaW4gdGhlIGdp
dCBoaXN0b3J5DQo+PiBsYXRlciwgYnV0IHRoZSB0YWcgd2lsbCBiZSBhbmQgd291bGQgYmUgcmF0
aGVyIGNvbmZ1c2luZy4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRpZW5jZSBhbmQgZXhw
bGFuYXRpb25zLiBJJ3ZlIGJlZW4gYmVpbmcgY29uc2VydmF0aXZlDQo+IGFzIEknbSBub3QgYSAi
c2Vhc29uZWQsIExpbnV4IHByb2Zlc3Npb25hbCIgYW5kIGFtIHN0aWxsIGdldHRpbmcgbXkNCj4g
Z2l0IHNlbmQtZW1haWwgY29uZmlnIC8gY29tbWFuZCBsaW5lIGZvciBMaW51eCBwcm9wZXJseSBz
dHJhaWdodGVuZWQgb3V0Lg0KDQpCZWluZyBjb25zZXJ2YXRpdmUgaW4gc3VjaCBjYXNlcyBpcyBu
b3QgYSBmYXVsdCBhdCBhbGwuIEknbSBub3QgYW4gDQpleHBlcnQgZWl0aGVyLiBJJ20ganVzdCBy
ZWNvbW1lbmRpbmcgd2hhdCBJIHRoaW5rIG1pZ2h0IGJlIHRoZSAiY29ycmVjdCIgDQp3YXkgdG8g
ZG8gaXQuDQoNCj4gU2hvdWxkIEkgc2VuZCBhbm90aGVyIHBhdGNoIHNldCB3aXRoIHRoZSBga2J1
aWxkLi4uYCB0YWcgcmVtb3ZlZCwNCj4gb3Igd291bGQgaXQgYmUgcmVtb3ZlZCBpbiB0aGUgcHJv
Y2VzcyBvZiBhbiBhcHByb3ByaWF0ZSBtZW1iZXINCj4gb2YgdGhlIExpbnV4IE1URCB0ZWFtIGFk
ZGluZyB0aGVpciB0YWcgZm9yIGFwcHJvdmFsLCBpZiBhbmQgd2hlbg0KPiB0aGF0IGhhcHBlbnM/
DQoNCkkgZG9uJ3QgdGhpbmsgdGhhdCdzIG5lY2Vzc2FyeS4gTWlxdcOobCBpcyB0aGUgb25lIHRv
IHBpY2sgdXAgdGhlIHBhdGNoLCANCnNvIGhlIGNvdWxkIHByb2JhYmx5IGRyb3AgdGhlICJSZXBv
cnRlZC1ieToga2J1aWxkIiB3aGVuIGhlIGFwcGxpZXMgaXQuDQoNClJlZ2FyZHMsDQpGcmllZGVy
