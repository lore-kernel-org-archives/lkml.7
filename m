Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7035FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426C22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfCYOp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:45:59 -0400
Received: from smtp.eu.citrix.com ([185.25.65.24]:18300 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfCYOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:45:59 -0400
X-IronPort-AV: E=Sophos;i="5.60,269,1549929600"; 
   d="scan'208";a="87814490"
From:   Paul Durrant <Paul.Durrant@citrix.com>
To:     Jennifer Herbert <jennifer.herbert@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [Xen-devel] [PATCH] xen/pv: Add PV specific legacy_pic struct to
 expose legacy IRQs.
Thread-Topic: [Xen-devel] [PATCH] xen/pv: Add PV specific legacy_pic struct to
 expose legacy IRQs.
Thread-Index: AQHU3pAvtqaaN9/e3EqcRGbUDqiNy6YTgvmAgALMEICABg+9AIAAFQ1w
Date:   Mon, 25 Mar 2019 14:40:55 +0000
Message-ID: <6a1834d81d6443c78b88e63f7cc3baaa@AMSPEX02CL02.citrite.net>
References: <1553025739-92245-1-git-send-email-jennifer.herbert@citrix.com>
 <2eb1fdec-6cc0-7f62-3d4f-adc5dba9971e@oracle.com>
 <5C93CEB7.9030701@citrix.com> <5C98E468.1050502@citrix.com>
In-Reply-To: <5C98E468.1050502@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBYZW4tZGV2ZWwgW21haWx0bzp4
ZW4tZGV2ZWwtYm91bmNlc0BsaXN0cy54ZW5wcm9qZWN0Lm9yZ10gT24gQmVoYWxmIE9mIEplbm5p
ZmVyIEhlcmJlcnQNCj4gU2VudDogMjUgTWFyY2ggMjAxOSAxNDoyNA0KPiBUbzogQm9yaXMgT3N0
cm92c2t5IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IHg4NkBrZXJuZWwub3JnOyB4ZW4t
ZGV2ZWxAbGlzdHMueGVucHJvamVjdC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT47IFN0ZWZhbm8gU3RhYmVs
bGluaSA8c3N0YWJlbGxpbmlAa2VybmVsLm9yZz47IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRo
YXQuY29tPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+OyBILiBQZXRlciBBbnZpbiA8
aHBhQHp5dG9yLmNvbT47IFRob21hcyBHbGVpeG5lcg0KPiA8dGdseEBsaW51dHJvbml4LmRlPg0K
PiBTdWJqZWN0OiBSZTogW1hlbi1kZXZlbF0gW1BBVENIXSB4ZW4vcHY6IEFkZCBQViBzcGVjaWZp
YyBsZWdhY3lfcGljIHN0cnVjdCB0byBleHBvc2UgbGVnYWN5IElSUXMuDQo+IA0KPiANCj4gDQo+
IE9uIDIxLzAzLzE5IDE3OjQ5LCBKZW5uaWZlciBIZXJiZXJ0IHdyb3RlOg0KPiA+DQo+ID4NCj4g
PiBPbiAxOS8wMy8xOSAyMzowNiwgQm9yaXMgT3N0cm92c2t5IHdyb3RlOg0KPiA+PiBPbiAzLzE5
LzE5IDQ6MDIgUE0sIEplbm5pZmVyIEhlcmJlcnQgd3JvdGU6DQo+ID4+PiBUaGUgQUNQSSB0YWJs
ZXMgZG9lc24ndCBhbHdheXMgY29udGFpbiBhbGwgSVJRcyBmb3IgbGVnYWN5IGRldmljZXMNCj4g
Pj4+IHN1Y2ggYXMgUlRDLiAgU2luY2Ugbm8gUElDIGNvbnRyb2xsZXIgaXMgdmlzaWJsZSBmb3Ig
YSBQViBsaW51eCBndWVzdCwNCj4gPj4+IHVuZGVyIFhlbiwgbGVnYWN5X3BpYyBjdXJyZW50bHkg
ZGVmYXVsdHMgdG8gdGhlIG51bGxfbGVnYWN5X3BpYyAtIHdpdGgNCj4gPj4+IHJlcG9ydHMgbm8g
bGVnYWN5IElSUXMuICBTaW5jZSB0aGUgY29tbWl0ICJydGM6IGNtb3M6IERvIG5vdCBhc3N1bWUN
Cj4gPj4+IGlycSA4IGZvciBydGMgd2hlbiB0aGVyZSBhcmUgbm8gbGVnYWN5IGlycXMiIGJ5IEhh
bnMgZGUgR29lZGUNCj4gPj4+IChjb21taXQgaWQ6IGExZTIzYTQyZjFiZGMwMGUzMmZjNDg2OWNh
ZWYxMmU0ZTYyNzJmMjYpLCB0aGUgcnRjIG5vdw0KPiA+Pj4gaW5jb3JyZWN0bHkgZGVjaWRlcyBp
dCBoYXMgbm8gaXJxIGl0IGNhbiB1c2UsIGZvciBzb21lIGhhcmR3YXJlLg0KPiA+Pj4NCj4gPj4+
IFRoaXMgcGF0Y2ggcmVjdGlmaWVzIHRoZSBwcm9ibGVtIGJ5IHByb3ZpZGluZyBhIHhlbiBsZWdh
Y3lfcGljDQo+ID4+PiBzdHJ1Y3QsIHdoaWNoIGlzIG11Y2ggbGlrZSB0aGUgbnVsbF9sZWdhY3lf
cGljIGV4Y2VwdCB0aGF0IGl0DQo+ID4+PiByZXBvcnRzIE5SX0lSUVNfTEVHQUNZIGlycXMuDQo+
ID4+IEkgYXNzdW1lIHRoaXMgaXMgZm9yIGRvbTA/DQo+ID4+DQo+ID4+IENvdWxkIHRoZXJlIGJl
IHRoZSBzYW1lIHByb2JsZW0gd2l0aCBQVkggZG9tMD8gKGFuZCBpZiB5ZXMgdGhlbiB0aGlzDQo+
ID4+IHNob3VsZCBwcm9iYWJseSBnbyBpbnRvIGFyY2gveDg2L3hlbi9lbmxpZ2h0ZW4uYykuDQo+
ID4+DQo+ID4+IC1ib3Jpcw0KPiA+Pg0KPiA+DQo+ID4gSSBhbSBkb2luZyB0aGlzIHRvIGZpeCBh
IHByb2JsZW0gd2l0aCBkb20wLiAgRG9tVSBkb2Vzbid0IHNlZW0gdG8gaGF2ZQ0KPiA+IGFuIFJU
QywgYW5kIHNvIGl0IGlzIHVuYWZmZWN0ZWQuDQo+ID4NCj4gPiBJJ20gbm90IGZhbWlsaWFyIHdp
dGggUFZILCBidXQgaGF2ZSBub3cgZG9uZSBzb21lIGV4cGVyaW1lbnRzLiBUaGUgUlRDDQo+ID4g
b24gUFZIIHNlZW1zIGJyb2tlbiAtIGJ1dCBub3QgcXVpdGUgaW4gdGhlIHNhbWUgd2F5IGFzIFBW
LiBNb3JlDQo+ID4gcmVzZWFyY2ggaXMgbmVlZGVkLCBob3dldmVyIHNpbXBseSBkb2luZyB0aGUg
c2FtZSB0cmljayBJIGRpZCB3aXRoIFBWDQo+ID4gd2lsbCBub3QgZml4IHRoZSBpc3N1ZS4NCj4g
Pg0KPiA+IEknbGwgbG9vayBmdXJ0aGVyIGludG8gaXQuDQo+ID4NCj4gDQo+IFRoZSBzYW1lIHBy
b2JsZW0gZG9lcyBleGlzdCB3aXRoIFBWSCAtIGhvd2V2ZXIgaXRzIHdvcnNlIHdpdGggdGhlDQo+
IHByZXNlbmNlIG9mIHRoZSBJTy1BUElDLCBhcyB3aXRoIG15IHBhdGNoIGl0IHRyaWVzIHRvIHNl
dCB1cCB3aXRoIElSUSwNCj4gYW5kIGZhaWxzLiAgSSdtIG5vdCBzdXJlIGhvdyB3b3VsZCBiZSBi
ZXN0IHRvIGRlYWwgd2l0aCB0aGlzLg0KPiBIb3dldmVyLCB0aGUgUlRDIHNlZW1zIGJyb2tlbiBl
dmVuIGZvciBtYWNoaW5lcyB3aXRob3V0IHRoZSBBQ1BJIG9taXNzaW9uLg0KPiBJIGNhbiBzZWUg
Zml4aW5nIGl0IGZvciBqdXN0IFBWIGRvZXNuJ3Qgc2VlbSB0b28gbmljZSwgYnV0IHVuc3VyZSBo
b3cgdG8NCj4gZml4IHRoaXMgZm9yIFBWSC4gIEknbSBvcGVuIHRvIHN1Z2dlc3Rpb25zLCBidXQg
b3RoZXJ3aXNlIEknbGwgcHV0IHRoaXMNCj4gb24gaG9sZC4NCg0KQUZBSUNUIGZyb20gdGhlIGNv
ZGUgaW4gbGlieGxfX2FyY2hfZG9tYWluX3ByZXBhcmVfY29uZmlnKCksIFBWSCBkb21haW5zIGRv
bid0IGdldCBhbiBSVEMsIGp1c3QgYSBsb2NhbCBBUElDLg0KDQogIFBhdWwgDQoNCj4gDQo+IA0K
PiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
DQo+IFhlbi1kZXZlbCBtYWlsaW5nIGxpc3QNCj4gWGVuLWRldmVsQGxpc3RzLnhlbnByb2plY3Qu
b3JnDQo+IGh0dHBzOi8vbGlzdHMueGVucHJvamVjdC5vcmcvbWFpbG1hbi9saXN0aW5mby94ZW4t
ZGV2ZWwNCg==
