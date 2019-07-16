Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36898C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F3221721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730676AbfGPICf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:02:35 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:45102 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfGPICe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:02:34 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 215CF67AB4D;
        Tue, 16 Jul 2019 10:02:23 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 16 Jul
 2019 10:02:22 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 16 Jul 2019 10:02:22 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6ul-kontron-ul2: Add Exceet/Kontron iMX6-UL2
 SoM
Thread-Topic: [PATCH] ARM: dts: imx6ul-kontron-ul2: Add Exceet/Kontron
 iMX6-UL2 SoM
Thread-Index: AQHVOL1dBqnDgiFo/UyQBjMEMaNniabG+AIAgAXLSACAAANMAA==
Date:   Tue, 16 Jul 2019 08:02:22 +0000
Message-ID: <74823caa-ace4-7f24-98f3-7da6f2a4e5c2@kontron.de>
References: <20190712141242.4915-1-krzk@kernel.org>
 <5cbd8bb2-6ecb-7e55-1580-e580e2c340dd@kontron.de>
 <CAJKOXPdq5e1OPmxamicAVf4ZDoSAuD=yvfOgZD04aQD9PtnCEQ@mail.gmail.com>
In-Reply-To: <CAJKOXPdq5e1OPmxamicAVf4ZDoSAuD=yvfOgZD04aQD9PtnCEQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <8338E8458D9FB44BA707B7261589B984@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 215CF67AB4D.AEE78
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDcuMTkgMDk6NTAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIEZyaSwg
MTIgSnVsIDIwMTkgYXQgMTc6MjEsIFNjaHJlbXBmIEZyaWVkZXINCj4gPGZyaWVkZXIuc2NocmVt
cGZAa29udHJvbi5kZT4gd3JvdGU6DQo+Pg0KPj4gSGkgS3J6eXN6dG9mLA0KPj4NCj4+IE9uIDEy
LjA3LjE5IDE2OjEyLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IEFkZCBzdXBwb3J0
IGZvciBpTVg2LVVMMiBtb2R1bGVzIGZyb20gS29udHJvbiBFbGVjdHJvbmljcyBHbWJIIChiZWZv
cmUNCj4+PiBhY3F1aXNpdGlvbjogRXhjZWV0IEVsZWN0cm9uaWNzKSBhbmQgZXZhbGtpdCBib2Fy
ZHMgYmFzZWQgb24gaXQ6DQo+Pj4NCj4+PiAxLiBpLk1YNiBVTCBTeXN0ZW0tb24tTW9kdWxlLCBh
IDI1eDI1IG1tIHNvbGRlcmFibGUgbW9kdWxlIChMR0EgcGFkcyBhbmQNCj4+PiAgICAgIHBpbiBj
YXN0ZWxsYXRpb25zKSB3aXRoIDI1NiBNQiBSQU0sIDEgTUIgTk9SLUZsYXNoLCAyNTYgTUIgTkFO
RCBhbmQNCj4+PiAgICAgIG90aGVyIGludGVyZmFjZXMsDQo+Pj4gMS4gVUwyIGV2YWxraXQsIHcv
d28gZU1NQywgd2l0aG91dCBkaXNwbGF5LA0KPj4+IDIuIFVMMiBldmFsa2l0IHdpdGggNC4zIiBk
aXNwbGF5LA0KPj4+IDMuIFVMMiBldmFsa2l0IHdpdGggNS4wIiBkaXNwbGF5Lg0KPj4+DQo+Pj4g
VGhpcyBpbmNsdWRlcyBkZXZpY2Ugbm9kZXMgZm9yIHVuc3VwcG9ydGVkIGRpc3BsYXlzIChBZG1h
dGVjDQo+Pj4gVDA0M0MwMDQ4MDAyNzJUMkEgYW5kIFQwNzBQMTMzVDBTMzAxKS4NCj4+Pg0KPj4+
IFRoZSB3b3JrIGlzIGJhc2VkIG9uIEV4Y2VldCBzb3VyY2UgY29kZSAoR1BMdjIpIHdpdGggbnVt
ZXJvdXMgY2hhbmdlczoNCj4+PiAxLiBSZW9yZ2FuaXplIGZpbGVzLA0KPj4+IDIuIFJlbmFtZSBF
eGNlZXQgLT4gS29udHJvbiwNCj4+PiAzLiBGaXggY29kaW5nIHN0eWxlIGVycm9ycywNCj4+PiA0
LiBGaXggRFRDIHdhcm5pbmdzLA0KPj4+IDUuIEV4dGVuZCBjb21wYXRpYmxlcyBzbyBldmFsIGJv
YXJkcyBpbmhlcml0IHRoZSBTb00gY29tcGF0aWJsZSwNCj4+PiA2LiBVc2UgZGVmaW5lcyBpbnN0
ZWFkIG9mIEdQSU8gZmxhZyB2YWx1ZXMsDQo+Pj4gNy4gQWRqdXN0IG9wZXJhdGluZyBwb2ludHMg
b2YgQ1BVMCwNCj4+PiA4LiBTb3J0IG5vZGVzIGFscGhhYmV0aWNhbGx5Lg0KPj4+DQo+Pj4gSW4g
ZG93bnN0cmVhbSBCU1AgdGhlIEV4Y2VldCBuYW1lIHN0aWxsIGFwcGVhcnMgaW4gbXVsdGlwbGUg
cGxhY2VzDQo+Pj4gdGhlcmVmb3JlIEkgbGVmdCBpdCBpbiB0aGUgbW9kZWwgbmFtZXMuDQo+Pg0K
Pj4gRmlyc3QsIHRoYW5rcyBmb3IgeW91ciB3b3JrLiBJIHBsYW5uZWQgdG8gdXBzdHJlYW0gdGhl
c2UgYm9hcmRzIG15c2VsZg0KPj4gYWZ0ZXIgdGhlIEZTTCBRU1BJIHNwaS1tZW0gZHJpdmVyIHdh
cyBtZXJnZWQgaW4gNS4xLCBidXQgZGlkbid0IGhhdmUNCj4+IHRpbWUgdG8gZmluYWxpemUgYW5k
IHNlbmQgdGhlIHBhdGNoZXMuDQo+Pg0KPj4gTWVhbndoaWxlIHdlIGNhbWUgdXAgd2l0aCBhIG5l
dyBuYW1pbmcgc2NoZW1lIGZvciBvdXIgYm9hcmRzLCB0aGF0DQo+PiBoYXNuJ3QgYmVlbiBpbXBs
ZW1lbnRlZCB5ZXQuIEJ1dCBJIHdvdWxkIGxpa2UgdG8gdGFrZSB0aGlzIGNoYW5jZSB0bw0KPj4g
aW1wbGVtZW50IHRoZSBuZXcgc2NoZW1lLg0KPiANCj4gU3VyZSwgSSBzZWUgbm8gcHJvYmxlbSBp
biB1c2luZyBkaWZmZXJlbnQgbmFtZXMsIG1hdGNoaW5nIGRvd25zdHJlYW0NCj4ga2VybmVsLiBK
dXN0IHBvaW50IG1lIHRvIHByb3BlciBuYW1lcy4NCj4gDQo+PiBBbHNvIHRoZXJlIGFyZSBzb21l
IG1vcmUgZmxhdm9ycyBvZiB0aGUgU29NICh3aXRoIGkuTVg2VUxMIGluc3RlYWQgb2YNCj4+IGku
TVg2VUwsIHdpdGggNTEyTWlCIGluc3RlYWQgb2YgMjU2TWlCIGZsYXNoL1JBTSksIHRoYXQgSSB3
b3VsZCBsaWtlIHRvDQo+PiBhZGQgYW5kIGZvciB3aGljaCBjb21tb24gcGFydHMgb2YgdGhlIFNv
TSBkdHNpIHdvdWxkIG5lZWQgdG8gYmUgZmFjdG9yZWQNCj4+IG91dCB0byBhIHNlcGFyYXRlIGZp
bGUuDQo+IA0KPiBJIGhhdmUgb25seSB0aGlzIG9uZSBwYXJ0aWN1bGFyIGZsYXZvciBzbyBJIHdv
dWxkIHByZWZlciB0byB1cHN0cmVhbQ0KPiBvbmx5IHRoaXMgb25lLiBJIGRvIG5vdCBrbm93IGFs
bCB0aGUgcG9zc2libGUgY29tYmluYXRpb25zIG9yIGZvcg0KPiBleGFtcGxlIHRoZSBtb3N0IGlu
dGVyZXN0aW5nIG9uZXMuIEkgdGhpbmsgYWZ0ZXIgdGhpcyBwYXRjaHNldCB3ZSBjYW4NCj4gcmVm
YWN0b3IgdGhlIERUUyB3aGVuZXZlciBpdHMgbmVlZGVkIC0gc3BsaXQgY29tbW9uIHBhcnRzLCBh
ZGQgbmV3DQo+IGZpbGVzLg0KPiANCj4+IEkgd291bGQgcHJlZmVyIHRvIGF0IGxlYXN0IGFwcGx5
IHRoZSBuYW1pbmcgY2hhbmdlcyBiZWZvcmUgbWVyZ2luZy4gVGhlDQo+PiBhZGRpdGlvbmFsIGJv
YXJkIGZsYXZvcnMgY291bGQgYmUgYWRkZWQgYmVmb3JlIG1lcmdpbmcgb3IgSSBjb3VsZCBzZW5k
DQo+PiB0aGVtIGFzIGZvbGxvdy11cCBwYXRjaGVzLiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gDQo+
IExldCdzIGNoYW5nZSB0aGUgbmFtaW5nIGFuZCBhZGQgbmV3IGZsYXZvcnMgYXMgZm9sbG93IHVw
cz8NCg0KT2ssIGxldCdzIGRvIGl0IGxpa2UgdGhpcy4gSSB3aWxsIHNvb24gc2VuZCBhbm90aGVy
IHJlcGx5IHRvIHRoZSANCm9yaWdpbmFsIHBhdGNoIHdpdGggdGhlIHByb3Bvc2VkIG5hbWluZyBj
aGFuZ2VzLg0KDQpUaGFua3MsDQpGcmllZGVy
