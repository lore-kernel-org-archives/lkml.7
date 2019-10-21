Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D20ACA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7958F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 12:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbfJUMob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 08:44:31 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:60036 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfJUMob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 08:44:31 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 071276272E0;
        Mon, 21 Oct 2019 14:44:29 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 21 Oct
 2019 14:44:28 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 21 Oct 2019 14:44:28 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "krzk@kernel.org" <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] ARM: dts: imx6ul-kontron-n6310-s: Move common nodes
 to a separate file
Thread-Topic: [PATCH 03/10] ARM: dts: imx6ul-kontron-n6310-s: Move common
 nodes to a separate file
Thread-Index: AQHVhDNridwU/x73F0y3lESzDZ9q0qdkzUwAgAAjUoA=
Date:   Mon, 21 Oct 2019 12:44:28 +0000
Message-ID: <cb88a237-3d5b-a7b2-8ff9-51d192b5d0d7@kontron.de>
References: <20191016150622.21753-1-frieder.schrempf@kontron.de>
 <20191016150622.21753-4-frieder.schrempf@kontron.de>
 <20191021103802.GC1934@pi3>
In-Reply-To: <20191021103802.GC1934@pi3>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE7C61A8E785454F8AF7F0B5D380FEC3@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 071276272E0.A1A22
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

SGkgS3J6eXN6dG9mLA0KDQpPbiAyMS4xMC4xOSAxMjozOCwga3J6a0BrZXJuZWwub3JnIHdyb3Rl
Og0KPiBPbiBXZWQsIE9jdCAxNiwgMjAxOSBhdCAwMzowNzoyNVBNICswMDAwLCBTY2hyZW1wZiBG
cmllZGVyIHdyb3RlOg0KPj4gRnJvbTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1w
ZkBrb250cm9uLmRlPg0KPj4NCj4+IFRoZSBiYXNlYm9hcmQgZm9yIHRoZSBLb250cm9uIE42MzEw
IFNvTSBpcyBhbHNvIHVzZWQgZm9yIG90aGVyIFNvTXMNCj4+IHN1Y2ggYXMgTjYzMTEgYW5kIE42
NDExLiBJbiBvcmRlciB0byBzaGFyZSB0aGUgY29kZSwgd2UgbW92ZSB0aGUNCj4+IGRlZmluaXRp
b25zIG9mIHRoZSBiYXNlYm9hcmQgdG8gYSBzZXBhcmF0ZSBkdHNpIGZpbGUuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1wZkBrb250cm9uLmRl
Pg0KPj4gLS0tDQo+PiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42MzEwLXMu
ZHRzICB8IDQwNSArLS0tLS0tLS0tLS0tLS0tLQ0KPj4gICBhcmNoL2FybS9ib290L2R0cy9pbXg2
dWwta29udHJvbi1uNngxeC1zLmR0c2kgfCA0MTIgKysrKysrKysrKysrKysrKysrDQo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNDEzIGluc2VydGlvbnMoKyksIDQwNCBkZWxldGlvbnMoLSkNCj4+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42eDF4
LXMuZHRzaQ0KPj4NClsuLi5dDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14
NnVsLWtvbnRyb24tbjZ4MXgtcy5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRy
b24tbjZ4MXgtcy5kdHNpDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAw
MDAwMDAwLi4wOGEzMjZjZTJjYmUNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42eDF4LXMuZHRzaQ0KPj4gQEAgLTAsMCArMSw0MTIg
QEANCj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gKy8qDQo+PiAr
ICogQ29weXJpZ2h0IChDKSAyMDE3IGV4Y2VldCBlbGVjdHJvbmljcyBHbWJIDQo+PiArICogQ29w
eXJpZ2h0IChDKSAyMDE4IEtvbnRyb24gRWxlY3Ryb25pY3MgR21iSA0KPj4gKyAqIENvcHlyaWdo
dCAoYykgMjAxOSBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+PiArICov
DQo+PiArDQo+IA0KPiBUaGlzIGZpbGUgZG9lcyBub3QgaW5jbHVkZSBhbnl0aGluZyBlbHNlIGJ1
dCB1c2VzIGRlZmluZXMgKEdQSU8gZmxhZ3MsDQo+IGNsb2NrcywgcGlucykuIFVzdWFsbHkgc291
cmNlcyBzaG91bGQgbm90IHJlbHkgb24gaW5jbHVzaW9ucyBjb21pbmcgZnJvbQ0KPiB1bnJlbGF0
ZWQgZmlsZXMgc28gaGVyZSB5b3Ugc2hvdWxkIGluY2x1ZGUgbmVjZXNzYXJ5IGhlYWRlcnMuIElu
IGNhc2Ugb2YNCj4gZnV0dXJlIHJlZmFjdG9yaW5ncyBvciByZXVzZSBvbmUgbWlnaHQgbm90IGtu
b3cgd2hpY2ggZGVmaW5lcyB5b3Ugd2FudGVkDQo+IHRvIHVzZSAoaW4gb3RoZXIgcGxhdGZvcm1z
IGZvciBleGFtcGxlIHRoZXJlIG1pZ2h0IGJlIG11bHRpcGxlIGRlZmluZXMNCj4gaW4gbXVsdGlw
bGUgaGVhZGVyIGZpbGVzIHdpdGggc2FtZSBuYW1lKS4NCg0KUmlnaHQsIEkgbmVlZCB0byBpbmNs
dWRlIHRoZSBwcm9wZXIgaGVhZGVycyBoZXJlLiBJIHdpbGwgYWxzbyBjaGVjayB0aGUgDQpvdGhl
ciBmaWxlcy4NCg0KVGhhbmtzIGZvciByZXZpZXdpbmchDQpGcmllZGVy
