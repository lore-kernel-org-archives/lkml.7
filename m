Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54DFC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9132720872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 19:32:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfGKTce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 15:32:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:49781 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbfGKTcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 15:32:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 12:32:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="168727080"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga003.jf.intel.com with ESMTP; 11 Jul 2019 12:32:32 -0700
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.206]) by
 FMSMSX108.amr.corp.intel.com ([169.254.9.235]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 12:32:32 -0700
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Topic: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Index: AQHVNzBm8CIMNghqKU6lUG8vwFsPdKbEfMKAgAAES4CAAAOcAIAADhGAgABJpoCAAAV9gIABY9wA
Date:   Thu, 11 Jul 2019 19:32:31 +0000
Message-ID: <a522eb05e65fe5068c519f0c2ce44d894a9526db.camel@intel.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <1562770874.3213.14.camel@HansenPartnership.com>
         <93b8a186f4c8b4dae63845a20bd49ae965893143.camel@tiscali.nl>
         <1562776339.3213.50.camel@HansenPartnership.com>
         <5245d2b3d82f11d2f988a3154814eb42dcb835c5.camel@tiscali.nl>
         <1562780135.3213.58.camel@HansenPartnership.com>
         <a23e93d918f8be5aea4af0b87efbf9c3d143d2fb.camel@tiscali.nl>
         <1562797129.3213.111.camel@HansenPartnership.com>
In-Reply-To: <1562797129.3213.111.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <63A26A140C29274B84ED02677C2B33C3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMgYW5kIFBhdWwNCg0KQ291bGQgeW91IHNoYXJlIGEgZG1lc2cgb3V0cHV0IG9mIHlv
dXIgc3lzdGVtIGFmdGVyIHRoZSBidWcgb2NjdXIgd2l0aA0KdGhpcyBrZXJuZWwgcGFyYW1ldGVy
cyAiZHJtLmRlYnVnPTB4MWUgbG9nX2J1Zl9sZW49NE0iPyBBbHNvIHRoZSBvdXRwdXQNCm9mIC9z
eXMva2VybmVsL2RlYnVnL2RyaS8wL2k5MTVfZWRwX3Bzcl9zdGF0dXMNCg0KVGhhbmtzDQoNCg0K
T24gV2VkLCAyMDE5LTA3LTEwIGF0IDE1OjE4IC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE9uIFdlZCwgMjAxOS0wNy0xMCBhdCAyMzo1OSArMDIwMCwgUGF1bCBCb2xsZSB3cm90ZToN
Cj4gPiBKYW1lcyBCb3R0b21sZXkgc2NocmVlZiBvcCB3byAxMC0wNy0yMDE5IG9tIDEwOjM1IFst
MDcwMF06DQo+ID4gPiBJIGNhbiBnZXQgYmFjayB0byBpdCB0aGlzIGFmdGVybm9vbiwgd2hlbiBJ
J20gZG9uZSB3aXRoIHRoZQ0KPiA+ID4gbWVldGluZw0KPiA+ID4gcmVxdWlyZW1lbnRzIGFuZCBk
b2luZyBvdGhlciBkZXYgc3R1ZmYuDQo+ID4gDQo+ID4gSSd2ZSBzdGFydGVkIGJpc2VjdGluZyB1
c2luZyB5b3VyIHN1Z2dlc3Rpb24gb2YgdGhhdCBkcm0gbWVyZ2U6DQo+ID4gICAgICQgZ2l0IGJp
c2VjdCBsb2cNCj4gPiAgICAgZ2l0IGJpc2VjdCBzdGFydA0KPiA+ICAgICAjIGdvb2Q6IFs4OWMz
YjM3YWY4N2VjMTgzYjY2NmQ4MzQyOGNiMjhjYzQyMTY3MWE2XSBNZXJnZQ0KPiA+IGdpdDovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9kYXZlbS9pZGUNCj4gPiAgICAg
Z2l0IGJpc2VjdCBnb29kIDg5YzNiMzdhZjg3ZWMxODNiNjY2ZDgzNDI4Y2IyOGNjNDIxNjcxYTYN
Cj4gPiAgICAgIyBiYWQ6IFthMmQ2MzVkZWNiZmE5YzFlNGFlMTVjYjA1YjY4YjI1NTlmN2Y4Mjdj
XSBNZXJnZSB0YWcNCj4gPiAnZHJtLQ0KPiA+IG5leHQtMjAxOS0wNS0wOScgb2YgZ2l0Oi8vYW5v
bmdpdC5mcmVlZGVza3RvcC5vcmcvZHJtL2RybQ0KPiA+ICAgICBnaXQgYmlzZWN0IGJhZCBhMmQ2
MzVkZWNiZmE5YzFlNGFlMTVjYjA1YjY4YjI1NTlmN2Y4MjdjDQo+ID4gICAgICMgYmFkOiBbYWQy
YzQ2N2FhOTJlMjgzZTllODAwOWJiOWViMjlhNWM2YTJkMTIxN10gZHJtL2k5MTU6DQo+ID4gVXBk
YXRlIERSSVZFUl9EQVRFIHRvIDIwMTkwNDE3DQo+ID4gICAgIGdpdCBiaXNlY3QgYmFkIGFkMmM0
NjdhYTkyZTI4M2U5ZTgwMDliYjllYjI5YTVjNmEyZDEyMTcNCj4gPiANCj4gPiBHaXQgdG9sZCBt
ZSBJIGhhdmUgbmluZSBzdGVwcyBhZnRlciB0aGlzLiBTbyBhdCB0d28gaG91cnMgcGVyIHN0ZXAN
Cj4gPiBJDQo+ID4gbWlnaHQNCj4gPiBwaW5wb2ludCB0aGUgb2ZmZW5kaW5nIGNvbW1pdCBieSBG
cmlkYXkgdGhlIDEydGguIElmIEknbSBsdWNreS4NCj4gPiAoVGhlcmUgYXJlDQo+ID4gb3RoZXIg
dGhpbmdzIHRvIGRvIHRoYW4gYmlzZWN0aW5nIHRoaXMgaXNzdWUuKQ0KPiA+IA0KPiA+IElmIHlv
dSBmaW5kIHRoYXQgY29tbWl0IGJlZm9yZSBJIGRvLCBJJ2xsIGJlIGFsbCBlYXJzLg0KPiANCj4g
U3VyZSAuLi4gSSdtIGRvaW5nIHRoZSBob2xpc3RpYyB0aGluZyBhbmQgbG9va2luZyBhdCB0aGUg
dHJlZSBpbiB0aGF0DQo+IGJyYW5jaC4gIEl0IHNlZW1zIHRvIGNvbnNpc3Qgb2YgNyBpOTE1IHVw
ZGF0ZXMNCj4gDQo+IGMwOWQzOTE2NmQ4YTNmMzc4ODY4MGIzMmRiYjBhNDBhNzBkZTMyZTIgRFJJ
VkVSX0RBVEUgdG8gMjAxOTAyMDcNCj4gNDdlZDU1YTliYjllMjg0ZDQ2ZDZmMjQ4OWUzMmE1M2I1
OTE1MjgwOSBEUklWRVJfREFURSB0byAyMDE5MDIyMA0KPiBmNGVjYjhhZTcwZGU4NjcxMGU4NTEz
OGNlNDlhZjVjNjg5OTUxOTUzIERSSVZFUl9EQVRFIHRvIDIwMTkwMzExDQo+IDEyODRlYzk4NTU3
MjIzMmFjZTQ4MTc0NzZiYWViMmQ4MmI2MGJlN2EgRFJJVkVSX0RBVEUgdG8gMjAxOTAzMjANCj4g
YTAxYjJjNmY0N2Q4NmM3ZDFhOWZhODIyYjNiOTFlYzIzM2I2MTc4NCBEUklWRVJfREFURSB0byAy
MDE5MDMyOA0KPiAyOGQ2MThlOWFiODZmMjZhMzFhZjBiMjM1Y2VkNTViZWIzZTM0M2M4IERSSVZF
Ul9EQVRFIHRvIDIwMTkwNDA0DQo+IGFkMmM0NjdhYTkyZTI4M2U5ZTgwMDliYjllYjI5YTVjNmEy
ZDEyMTcgRFJJVkVSX0RBVEUgdG8gMjAxOTA0MTcNCj4gDQo+IFNvIEkgZmlndXJlZCBJJ2Qgc2Vl
IGlmIEkgY2FuIGxvY2F0ZSB0aGUgcHJvYmxlbSBieSBiaXNlY3Rpb24gb2YNCj4gdGhvc2UNCj4g
cGx1cyBpbnNwZWN0aW9uLg0KPiANCj4gSmFtZXMNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IEludGVsLWdmeCBtYWlsaW5nIGxpc3QNCj4g
SW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeA0K
