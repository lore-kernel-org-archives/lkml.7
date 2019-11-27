Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AF1C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925292053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 11:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfK0Lw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 06:52:26 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:57258 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfK0Lw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 06:52:26 -0500
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 6CF6F67A903;
        Wed, 27 Nov 2019 12:52:18 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 27 Nov
 2019 12:52:17 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Wed, 27 Nov 2019 12:52:17 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     "Togorean, Bogdan" <Bogdan.Togorean@analog.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "sam@ravnborg.org" <sam@ravnborg.org>
CC:     "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "matt.redfearn@thinci.com" <matt.redfearn@thinci.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: Re: [PATCH v2 2/2] drm: bridge: adv7511: Add support for ADV7535
Thread-Topic: Re: [PATCH v2 2/2] drm: bridge: adv7511: Add support for ADV7535
Thread-Index: AQHVpRke93eDKSsyK0u0m5zFvr+lWQ==
Date:   Wed, 27 Nov 2019 11:52:17 +0000
Message-ID: <4c60f287-eb6b-d5b3-8d40-89172755887d@kontron.de>
References: <20190809141611.9927-1-bogdan.togorean@analog.com>
 <20190809141611.9927-3-bogdan.togorean@analog.com>
 <20190809152510.GA23265@ravnborg.org>
 <c99cfbd3dc45bb02618e7653c33022f3553e1cce.camel@analog.com>
 <20190819104616.GA15890@ravnborg.org>
 <20190820085329.GC11147@phenom.ffwll.local>
 <ccba9a66c6d5db8a295353b16084c6a1199f31dc.camel@analog.com>
In-Reply-To: <ccba9a66c6d5db8a295353b16084c6a1199f31dc.camel@analog.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <65B7112A5BC3804EA5F6AAD9C877BF3B@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 6CF6F67A903.A1496
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: a.hajda@samsung.com, airlied@linux.ie,
        allison@lohutok.net, bogdan.togorean@analog.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        laurent.pinchart@ideasonboard.com, linux-kernel@vger.kernel.org,
        matt.redfearn@thinci.com, robh+dt@kernel.org, sam@ravnborg.org,
        tglx@linutronix.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQm9nZGFuLA0KDQpPbiAyMS4wOC4xOSAwNzozNCwgVG9nb3JlYW4sIEJvZ2RhbiB3cm90ZToN
Cj4gT24gVHVlLCAyMDE5LTA4LTIwIGF0IDEwOjUzICswMjAwLCBEYW5pZWwgVmV0dGVyIHdyb3Rl
Og0KPj4gW0V4dGVybmFsXQ0KPj4NCj4+IE9uIE1vbiwgQXVnIDE5LCAyMDE5IGF0IDEyOjQ2OjE2
UE0gKzAyMDAsIFNhbSBSYXZuYm9yZyB3cm90ZToNCj4+PiBIaSBCb2dkYW4uDQo+Pj4NCj4+Pj4+
PiAgIAkJYWR2NzUzM19kZXRhY2hfZHNpKGFkdjc1MTEpOw0KPj4+Pj4+ICAgCWkyY191bnJlZ2lz
dGVyX2RldmljZShhZHY3NTExLT5pMmNfY2VjKTsNCj4+Pj4+PiAgIAlpZiAoYWR2NzUxMS0+Y2Vj
X2NsaykNCj4+Pj4+PiBAQCAtMTI2Niw4ICsxMjc4LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
MmNfZGV2aWNlX2lkDQo+Pj4+Pj4gYWR2NzUxMV9pMmNfaWRzW10gPSB7DQo+Pj4+Pj4gICAJeyAi
YWR2NzUxMSIsIEFEVjc1MTEgfSwNCj4+Pj4+PiAgIAl7ICJhZHY3NTExdyIsIEFEVjc1MTEgfSwN
Cj4+Pj4+PiAgIAl7ICJhZHY3NTEzIiwgQURWNzUxMSB9LA0KPj4+Pj4+IC0jaWZkZWYgQ09ORklH
X0RSTV9JMkNfQURWNzUzMw0KPj4+Pj4+ICsjaWZkZWYgQ09ORklHX0RSTV9JMkNfQURWNzUzeA0K
Pj4+Pj4+ICAgCXsgImFkdjc1MzMiLCBBRFY3NTMzIH0sDQo+Pj4+Pj4gKwl7ICJhZHY3NTM1Iiwg
QURWNzUzNSB9LA0KPj4+Pj4+ICAgI2VuZGlmDQo+Pj4+Pg0KPj4+Pj4gVGhpcyBpZmRlZiBtYXkg
bm90IGJlIG5lZWRlZD8/DQo+Pj4+PiBJZiB3ZSBkaWQgbm90IGdldCB0aGlzIHR5cGUgd2Ugd2ls
bCBub3QgbG9vayBpdCB1cC4NCj4+Pj4gQnV0IGlmIHdlIGhhdmUgZGVmaW5lZCBpbiBEVCBhZHY3
NTMzLzUgZGV2aWNlIGJ1dA0KPj4+PiBDT05GSUdfRFJNX0kyQ19BRFY3NTN4IG5vdCBzZWxlY3Rl
ZCBwcm9iZSB3aWxsIGZhaWwgd2l0aCBFTk9ERVYuDQo+Pj4+IFRoYXQNCj4+Pj4gd291bGQgYmUg
b2s/DQo+Pj4NCj4+PiBXaGF0IGRvIHdlIGdhaW4gZnJvbSB0aGlzIGNvbXBsZXhpdHkgaW4gdGhl
IGVuZC4NCj4+PiBXaHkgbm90IGxldCB0aGUgZHJpdmVyIGFsd2F5cyBzdXBwb3J0IGFsbCB2YXJp
YW50cy4NCj4+Pg0KPj4+IElmIHRoaXMgcmVzdWx0IGluIGEgc2ltcGxlciBkcml2ZXIsIGFuZCBs
ZXNzIGNob2ljZXMgaW4gS2NvbmZpZw0KPj4+IHRoZW4gaXQgaXMgYSB3aW4td2luLg0KPj4NCj4+
IFllYWggaW4gZ2VuZXJhbCB3ZSBkb24ndCBLY29uZmlnIHdpdGhpbiBkcml2ZXJzIGluIGRybSB0
byBkaXNhYmxlDQo+PiBzcGVjaWZpYw0KPj4gY29kZS1wYXRocy4gSXQncyBub3Qgd29ydGggdGhl
IHBhaW4uDQogPg0KPiBBY2ssDQo+IFRoYW5rIHlvdSBmb3IgY2xhcmlmaWNhdGlvbi4gV2lsbCBy
ZW1vdmUgaW4gVjMuDQoNCkFyZSB5b3Ugc3RpbGwgd29ya2luZyBvbiB0aGlzPyBEbyB5b3UgcGxh
biB0byBzZW5kIGEgdjM/DQpJIHdpbGwgc29vbiBsYXkgbXkgaGFuZHMgb24gYSBib2FyZCB3aXRo
IHRoZSBBRFY3NTM1IGFuZCB3b3VsZCBsaWtlIHRvIA0Kc2VlIHRoaXMgbWVyZ2VkLg0KQWxzbyBm
b3IgcGF0Y2ggMS8yLCBpdCBzZWVtcyB5b3UgYWxyZWFkeSBoYXZlIGEgUi1iIGZvciB2MSBmcm9t
IExhdXJlbnQsIA0KYnV0IHlvdSBkaWRuJ3QgY2FycnkgdGhlIHRhZyB0byB2Mi4NCg0KVGhhbmtz
LA0KRnJpZWRlcg==
