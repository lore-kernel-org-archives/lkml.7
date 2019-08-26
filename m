Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CE9C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4380920874
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732554AbfHZOht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:37:49 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:56202 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfHZOhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:37:48 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id AE07867A6E4;
        Mon, 26 Aug 2019 16:37:46 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 26 Aug
 2019 16:37:46 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 26 Aug 2019 16:37:46 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
Subject: Re: [RESEND PATCH v3 14/20] mtd: spi_nor: Add a ->setup() method
Thread-Topic: [RESEND PATCH v3 14/20] mtd: spi_nor: Add a ->setup() method
Thread-Index: AQHVXAeF9JHgldFrG0Cm/K0wg1GidacNPSwAgAAQawCAAAa/gIAACbmA
Date:   Mon, 26 Aug 2019 14:37:46 +0000
Message-ID: <799c9166-428a-9c5b-67cd-c60d31170dc0@kontron.de>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-15-tudor.ambarus@microchip.com>
 <20190826144002.479494be@collabora.com>
 <d44218eb-458a-dd59-b79d-7803de2bdc09@kontron.de>
 <20190826160257.17b46962@collabora.com>
In-Reply-To: <20190826160257.17b46962@collabora.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <01ED29AFA9DA7449A68863D0DF4D86C9@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: AE07867A6E4.AE1FE
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: boris.brezillon@collabora.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        marek.vasut@gmail.com, miquel.raynal@bootlin.com, richard@nod.at,
        tudor.ambarus@microchip.com, vigneshr@ti.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDguMTkgMTY6MDIsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gTW9uLCAyNiBB
dWcgMjAxOSAxMzozODo0OCArMDAwMA0KPiBTY2hyZW1wZiBGcmllZGVyIDxmcmllZGVyLnNjaHJl
bXBmQGtvbnRyb24uZGU+IHdyb3RlOg0KPiANCj4+IE9uIDI2LjA4LjE5IDE0OjQwLCBCb3JpcyBC
cmV6aWxsb24gd3JvdGU6DQo+Pj4gT24gTW9uLCAyNiBBdWcgMjAxOSAxMjowODo1OCArMDAwMA0K
Pj4+IDxUdWRvci5BbWJhcnVzQG1pY3JvY2hpcC5jb20+IHdyb3RlOg0KPj4+ICAgIA0KPj4+PiBG
cm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hpcC5jb20+DQo+Pj4+DQo+
Pj4+IG5vci0+cGFyYW1zLnNldHVwKCkgY29uZmlndXJlcyB0aGUgU1BJIE5PUiBtZW1vcnkuIFVz
ZWZ1bCBmb3IgU1BJIE5PUg0KPj4+PiBmbGFzaGVzIHRoYXQgaGF2ZSBwZWN1bGlhcml0aWVzIHRv
IHRoZSBTUEkgTk9SIHN0YW5kYXJkLCBlLmcuDQo+Pj4+IGRpZmZlcmVudCBvcGNvZGVzLCBzcGVj
aWZpYyBhZGRyZXNzIGNhbGN1bGF0aW9uLCBwYWdlIHNpemUsIGV0Yy4NCj4+Pj4gUmlnaHQgbm93
IHRoZSBvbmx5IHVzZXIgd2lsbCBiZSB0aGUgUzNBTiBjaGlwcywgYnV0IG90aGVyDQo+Pj4+IG1h
bnVmYWN0dXJlcnMgY2FuIGltcGxlbWVudCBpdCBpZiBuZWVkZWQuDQo+Pj4+DQo+Pj4+IE1vdmUg
c3BpX25vcl9zZXR1cCgpIHJlbGF0ZWQgY29kZSBpbiBvcmRlciB0byBhdm9pZCBhIGZvcndhcmQN
Cj4+Pj4gZGVjbGFyYXRpb24gdG8gc3BpX25vcl9kZWZhdWx0X3NldHVwKCkuDQo+Pj4+DQo+Pj4+
IFJldmlld2VkLWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBjb2xsYWJvcmEu
Y29tPg0KPj4+DQo+Pj4gTml0cGljazogUi1icyBzaG91bGQgbm9ybWFsbHkgYmUgcGxhY2VkIGFm
dGVyIHlvdXIgU29CLg0KPj4NCj4+IEp1c3QgYSBxdWVzdGlvbiB1bnJlbGF0ZWQgdG8gdGhlIHBh
dGNoIGNvbnRlbnQ6DQo+Pg0KPj4gSSBsZWFybmVkIHRvIGFkZCBSLWIgdGFncyBhZnRlciBteSBT
b0Igd2hlbiBzdWJtaXR0aW5nIE1URCBwYXRjaGVzLCBidXQNCj4+IHJlY2VudGx5IEkgc3VibWl0
dGVkIGEgcGF0Y2ggdG8gdGhlIHNlcmlhbCBzdWJzeXN0ZW0gYW5kIHdhcyB0b2xkIHRvIHB1dA0K
Pj4gbXkgU29CIGxhc3QuIElzIHRoZXJlIGFuICJvZmZpY2lhbCIgcnVsZSBmb3IgdGhpcz8gQW5k
IGlmIHNvIHdoZXJlIHRvDQo+PiBmaW5kIGl0Pw0KPiANCj4gU2hvdWxkIG1hdGNoIHRoZSBvcmRl
ciBvZiBhZGRpdGlvbjogaWYgeW91IHBpY2tlZCBhbiBleGlzdGluZyBwYXRjaCB0aGF0DQo+IGhh
ZCBhbHJlYWR5IHJlY2VpdmVkIFItYi9BLWIgdGFncyBhbmQgYXBwbGllZCBpdCB0byB5b3VyIHRy
ZWUgeW91DQo+IHNob3VsZCBhZGQgeW91ciBTb0IgYXQgdGhlIGVuZC4gQnV0IGlmIHlvdSBhcmUg
dGhlIGF1dGhvciwgeW91ciBTb0INCj4gc2hvdWxkIGNvbWUgZmlyc3QuIEF0IGxlYXN0IHRoYXQn
cyB0aGUgcnVsZSBJIGZvbGxvdyA6LSkuDQoNCk9rLCB0aGFua3MgZm9yIGNsYXJpZnlpbmcuIEkg
d2FzIHRoZSBhdXRob3Igb2Ygc2FpZCBwYXRjaCBhbmQgd2FzIGFkZGluZyANCmFuIFItYiBqdXN0
IGxpa2UgaW4gdGhpcyBjYXNlIGhlcmUsIHNvIHRoZSBwZW9wbGUgaW4gdGhlIHNlcmlhbCANCnN1
YnN5c3RlbSBzZWVtIHRvIGFwcGx5IGRpZmZlcmVudCBydWxlcyA7KQ==
