Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB0CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1F220863
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 16:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbfENQLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 12:11:33 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:47864 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbfENQLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 12:11:33 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 58C216000B7;
        Tue, 14 May 2019 18:11:29 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 14 May
 2019 18:11:28 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 14 May 2019 18:11:28 +0200
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
Subject: Re: [PATCH] mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG
Thread-Topic: [PATCH] mtd: spinand: Add support for GigaDevice GD5F1GQ4UFxxG
Thread-Index: AQHVBypxyGCaW3KLokGl7ivY8UUpB6Zo92KAgAGv7YCAAAg0AA==
Date:   Tue, 14 May 2019 16:11:28 +0000
Message-ID: <e53a0569-6eca-4385-007d-baffc3f5c7ea@kontron.de>
References: <20190510121727.29834-1-lede@allycomm.com>
 <3cb32209-f246-e562-2aee-fdf566a60b30@kontron.de>
 <1023ba21-b188-1dcc-3ecc-c563d4cb8a67@allycomm.com>
In-Reply-To: <1023ba21-b188-1dcc-3ecc-c563d4cb8a67@allycomm.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <69EEC9F891FDAF4C9BBF3481A0F38A3B@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 58C216000B7.AD04F
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

SGkgSmVmZiwNCg0KT24gMTQuMDUuMTkgMTc6NDIsIEplZmYgS2xldHNreSB3cm90ZToNCj4gT24g
NS8xMy8xOSA2OjU2IEFNLCBTY2hyZW1wZiBGcmllZGVyIHdyb3RlOg0KPiANCj4+IEhpIEplZmYs
DQo+Pg0KPj4gSSBqdXN0IG5vdGljZWQgSSBoaXQgdGhlIHdyb25nIGJ1dHRvbiBhbmQgbXkgcHJl
dmlvdXMgcmVwbHkgd2FzIG9ubHkNCj4+IHNlbnQgdG8gdGhlIE1URCBsaXN0LCBzbyBJJ20gcmVz
ZW5kaW5nIHdpdGggZml4ZWQgcmVjaXBpZW50cy4uLg0KPj4NCj4+IE9uIDEwLjA1LjE5IDE0OjE3
LGxlZGVAYWxseWNvbW0uY29tICB3cm90ZToNCj4+PiBGcm9tOiBKZWZmIEtsZXRza3k8Z2l0LWNv
bW1pdHNAYWxseWNvbW0uY29tPg0KPj4+DQo+Pj4gVGhlIEdpZ2FEZXZpY2UgR0Q1RjFHUTRVRnh4
RyBTUEkgTkFORCBpcyBpbiBjdXJyZW50IHByb2R1Y3Rpb24gZGV2aWNlcw0KPj4+IGFuZCwgd2hp
bGUgaXQgaGFzIHRoZSBzYW1lIGxvZ2ljYWwgbGF5b3V0IGFzIHRoZSBFLXNlcmllcyBkZXZpY2Vz
LA0KPj4+IGl0IGRpZmZlcnMgaW4gdGhlIFNQSSBpbnRlcmZhY2luZyBpbiBzaWduaWZpY2FudCB3
YXlzLg0KPj4+DQo+Pj4gVG8gYWNjb21tb2RhdGUgdGhlc2UgY2hhbmdlcywgdGhpcyBwYXRjaCBh
bHNvOg0KPj4+DQo+Pj4gICAgICogQWRkcyBzdXBwb3J0IGZvciB0d28tYnl0ZSBtYW51ZmFjdHVy
ZXIgSURzDQo+Pj4gICAgICogQWRkcyAjZGVmaW5lLXMgZm9yIHRocmVlLWJ5dGUgYWRkcmVzc2lu
ZyBmb3IgcmVhZCBvcHMNCj4+Pg0KPj4+IGh0dHA6Ly93d3cuZ2lnYWRldmljZS5jb20vZGF0YXNo
ZWV0L2dkNWYxZ3E0eGZ4eGcvDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBKZWZmIEtsZXRza3k8
Z2l0LWNvbW1pdHNAYWxseWNvbW0uY29tPg0KPj4gTWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRv
IHNwbGl0IHRoaXMgcGF0Y2ggaW50byB0aHJlZSBwYXJ0czoNCj4+ICogQWRkIHN1cHBvcnQgZm9y
IHR3by1ieXRlIGRldmljZSBJRHMNCj4+ICogQWRkICNkZWZpbmUtcyBmb3IgdGhyZWUtYnl0ZSBh
ZGRyZXNzaW5nIGZvciByZWFkIG9wcw0KPj4gKiBBZGQgc3VwcG9ydCBmb3IgR0Q1RjFHUTRVRnh4
Rw0KPj4NCj4+IEFueXdheSB0aGUgY29udGVudCBsb29rcyBnb29kIHRvIG1lLCBzbzoNCj4+DQo+
PiBSZXZpZXdlZC1ieTogRnJpZWRlciBTY2hyZW1wZjxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24u
ZGU+DQo+Pg0KPj4gWy4uLl0NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHRpbWUgaW4gcmV2aWV3IGFu
ZCBnb29kIHdvcmRzIQ0KDQpZb3UncmUgd2VsY29tZSENCg0KPiBNeSBhcG9sb2dpZXMgZm9yIGFu
IGluY29tcGxldGUgZ2l0LXNlbmQtZW1haWwgY29uZmlnIHRoYXQgbGVmdA0KPiBtZSBuYW1lbGVz
cyBpbiB0aGUgaGVhZGVycy4NCg0KTm8gcHJvYmxlbSwgSSBndWVzc2VkIHlvdXIgbmFtZSBmcm9t
IHRoZSBTaWduZWQtb2ZmLWJ5IHRhZyA7KQ0KDQo+IEkgd2Fzbid0IHN1cmUgaWYgdGhhdCB3YXMg
ZGlyZWN0aW9uIHRvIHN1Ym1pdCBhcyB0aHJlZSBwYXRjaGVzDQo+IGF0IHRoaXMgdGltZSwgYnV0
IHdvdWxkIGJlIGhhcHB5IHRvIGRvIHNvIGlmIHRoZSBjb25zZW5zdXMgaXMNCj4gdGhhdCBpdCB0
aGUgZGlyZWN0aW9uIHRvIGZvbGxvdy4NCg0KSSB0aGluayBpdCdzIGNvbW1vbiB0byBzZXBhcmF0
ZSBsb2dpY2FsIGRpZmZlcmVudCBjaGFuZ2VzLiBUaGlzIG1ha2VzIGl0IA0KZWFzaWVyIHRvIHJl
YWQuDQpBbHNvIHRoZSBwcmVwYXJhdGlvbiBjaGFuZ2VzIG9ubHkgdG91Y2ggdGhlIFNQSSBOQU5E
IGNvcmUuIEkgZ3Vlc3MgDQp0aGF0J3MgYW5vdGhlciByZWFzb24gd2h5IHRoZXkgc2hvdWxkIGJl
IHNlcGFyYXRlZCBmcm9tIHRoZSANCmNoaXAtc3BlY2lmaWMgY2hhbmdlcy4NCg0KPiBBdCBsZWFz
dCBmb3IgbWUsIEkgZmVlbCB0aGF0IHRoZSBvdGhlciB0d28gZG9uJ3QgcmVhbGx5IHN0YW5kDQo+
IG9uIHRoZWlyIG93biB3aXRob3V0IHRoZSBjb250ZXh0IGZvciB0aGVpciBuZWVkLg0KDQpJIGRv
bid0IHRoaW5rIHRoYXQncyBhIHByb2JsZW0uIEp1c3QgYWRkIGEgbm90ZSB0byB0aGUgY29tbWl0
IG1lc3NhZ2UgDQp0aGF0IHRoZXNlIGNvcmUgY2hhbmdlcyBhcmUgbmVlZGVkIHRvIHByZXBhcmUg
Zm9yIHRoZSBHRDVGMUdRNFVGeHhHIHN1cHBvcnQuDQoNClRoYW5rcywNCkZyaWVkZXI=
