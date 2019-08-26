Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F3FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3075D217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 13:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730886AbfHZNiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 09:38:52 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:49186 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfHZNiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 09:38:51 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id E332867A928;
        Mon, 26 Aug 2019 15:38:48 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 26 Aug
 2019 15:38:48 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 26 Aug 2019 15:38:48 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>
CC:     "vigneshr@ti.com" <vigneshr@ti.com>,
        "richard@nod.at" <richard@nod.at>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>
Subject: Re: [RESEND PATCH v3 14/20] mtd: spi_nor: Add a ->setup() method
Thread-Topic: [RESEND PATCH v3 14/20] mtd: spi_nor: Add a ->setup() method
Thread-Index: AQHVXAeF9JHgldFrG0Cm/K0wg1GidacNPSwAgAAQawA=
Date:   Mon, 26 Aug 2019 13:38:48 +0000
Message-ID: <d44218eb-458a-dd59-b79d-7803de2bdc09@kontron.de>
References: <20190826120821.16351-1-tudor.ambarus@microchip.com>
 <20190826120821.16351-15-tudor.ambarus@microchip.com>
 <20190826144002.479494be@collabora.com>
In-Reply-To: <20190826144002.479494be@collabora.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0F24203E231F740AC3F10735AB72514@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: E332867A928.ADC9A
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

T24gMjYuMDguMTkgMTQ6NDAsIEJvcmlzIEJyZXppbGxvbiB3cm90ZToNCj4gT24gTW9uLCAyNiBB
dWcgMjAxOSAxMjowODo1OCArMDAwMA0KPiA8VHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tPiB3
cm90ZToNCj4gDQo+PiBGcm9tOiBUdWRvciBBbWJhcnVzIDx0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb20+DQo+Pg0KPj4gbm9yLT5wYXJhbXMuc2V0dXAoKSBjb25maWd1cmVzIHRoZSBTUEkgTk9S
IG1lbW9yeS4gVXNlZnVsIGZvciBTUEkgTk9SDQo+PiBmbGFzaGVzIHRoYXQgaGF2ZSBwZWN1bGlh
cml0aWVzIHRvIHRoZSBTUEkgTk9SIHN0YW5kYXJkLCBlLmcuDQo+PiBkaWZmZXJlbnQgb3Bjb2Rl
cywgc3BlY2lmaWMgYWRkcmVzcyBjYWxjdWxhdGlvbiwgcGFnZSBzaXplLCBldGMuDQo+PiBSaWdo
dCBub3cgdGhlIG9ubHkgdXNlciB3aWxsIGJlIHRoZSBTM0FOIGNoaXBzLCBidXQgb3RoZXINCj4+
IG1hbnVmYWN0dXJlcnMgY2FuIGltcGxlbWVudCBpdCBpZiBuZWVkZWQuDQo+Pg0KPj4gTW92ZSBz
cGlfbm9yX3NldHVwKCkgcmVsYXRlZCBjb2RlIGluIG9yZGVyIHRvIGF2b2lkIGEgZm9yd2FyZA0K
Pj4gZGVjbGFyYXRpb24gdG8gc3BpX25vcl9kZWZhdWx0X3NldHVwKCkuDQo+Pg0KPj4gUmV2aWV3
ZWQtYnk6IEJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGNvbGxhYm9yYS5jb20+DQo+
IA0KPiBOaXRwaWNrOiBSLWJzIHNob3VsZCBub3JtYWxseSBiZSBwbGFjZWQgYWZ0ZXIgeW91ciBT
b0IuDQoNCkp1c3QgYSBxdWVzdGlvbiB1bnJlbGF0ZWQgdG8gdGhlIHBhdGNoIGNvbnRlbnQ6DQoN
CkkgbGVhcm5lZCB0byBhZGQgUi1iIHRhZ3MgYWZ0ZXIgbXkgU29CIHdoZW4gc3VibWl0dGluZyBN
VEQgcGF0Y2hlcywgYnV0IA0KcmVjZW50bHkgSSBzdWJtaXR0ZWQgYSBwYXRjaCB0byB0aGUgc2Vy
aWFsIHN1YnN5c3RlbSBhbmQgd2FzIHRvbGQgdG8gcHV0IA0KbXkgU29CIGxhc3QuIElzIHRoZXJl
IGFuICJvZmZpY2lhbCIgcnVsZSBmb3IgdGhpcz8gQW5kIGlmIHNvIHdoZXJlIHRvIA0KZmluZCBp
dD8NCg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IFR1ZG9yIEFtYmFydXMgPHR1ZG9yLmFtYmFydXNA
bWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPiANCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxp
bmcgbGlzdA0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW10ZC8NCj4g
