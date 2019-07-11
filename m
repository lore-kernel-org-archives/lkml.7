Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C747CC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E9320863
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 20:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfGKUZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 16:25:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:1758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfGKUZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 16:25:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 13:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="168123117"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2019 13:25:20 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jul 2019 13:25:20 -0700
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.206]) by
 FMSMSX154.amr.corp.intel.com ([169.254.6.214]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 13:25:20 -0700
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Topic: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Index: AQHVN8s6u18XhfEo0kuWcj/kjNqW06bGT1sAgAAD6QA=
Date:   Thu, 11 Jul 2019 20:25:19 +0000
Message-ID: <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
In-Reply-To: <1562875878.2840.0.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E314B7807B550846AB0B42284365433D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA3LTExIGF0IDEzOjExIC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE9uIFRodSwgMjAxOS0wNy0xMSBhdCAxMDoyOSArMDEwMCwgQ2hyaXMgV2lsc29uIHdyb3Rl
Og0KPiA+IFF1b3RpbmcgSmFtZXMgQm90dG9tbGV5ICgyMDE5LTA2LTI5IDE5OjU2OjUyKQ0KPiA+
ID4gVGhlIHN5bXB0b21zIGFyZSByZWFsbHkgd2VpcmQ6IHRoZSBzY3JlZW4gaW1hZ2UgaXMgbG9j
a2VkIGluDQo+ID4gPiBwbGFjZS4gIFRoZSBtYWNoaW5lIGlzIHN0aWxsIGZ1bmN0aW9uYWwgYW5k
IGlmIEkgbG9nIGluIG92ZXIgdGhlDQo+ID4gPiBuZXR3b3JrIGNhbiBkbyBhbnl0aGluZyBJIGxp
a2UsIGluY2x1ZGluZyBraWxsaW5nIHRoZSBYIHNlcnZlcg0KPiA+ID4gYW5kDQo+ID4gPiB0aGUg
ZGlzcGxheSB3aWxsIG5ldmVyIGFsdGVyLiAgSXQgYWxzbyBzZWVtcyB0aGF0IHRoZSBzeXN0ZW0g
aXMNCj4gPiA+IGFjY2VwdGluZyBrZXlib2FyZCBpbnB1dCBiZWNhdXNlIHdoZW4gaXQgZnJlZXpl
cyBJIGNhbiBjYXQNCj4gPiA+IGluZm9ybWF0aW9uIHRvIGEgZmlsZSAoaWYgdGhlIG1vdXNlIHdh
cyBvdmVyIGFuIHh0ZXJtKSBhbmQgdmVyaWZ5DQo+ID4gPiBvdmVyIHRoZSBuZXR3b3JrIHRoZSBm
aWxlIGNvbnRlbnRzLiBOb3RoaW5nIHVudXN1YWwgYXBwZWFycyBpbg0KPiA+ID4gZG1lc2cgd2hl
biB0aGUgbG9ja3VwIGhhcHBlbnMuDQo+ID4gPiANCj4gPiA+IFRoZSBsYXN0IGtlcm5lbCBJIGJv
b3RlZCBzdWNjZXNzZnVsbHkgb24gdGhlIHN5c3RlbSB3YXMgNS4wLCBzbw0KPiA+ID4gSSdsbCB0
cnkgY29tcGlsaW5nIDUuMSB0byBuYXJyb3cgZG93biB0aGUgY2hhbmdlcy4NCj4gPiANCj4gPiBJ
dCdzIGxpa2VseSB0aGlzIGlzIHBhbmVsIHNlbGYtcmVmcmVzaCBnb2luZyBoYXl3aXJlLg0KPiA+
IA0KPiA+IGNvbW1pdCA4ZjZlODdkNmQ1NjFmMTBjZmE0OGE2ODczNDU1MTI0MTk4MzliNmQ4DQo+
ID4gQXV0aG9yOiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNvdXphQGludGVsLmNvbT4N
Cj4gPiBEYXRlOiAgIFRodSBNYXIgNyAxNjowMDo1MCAyMDE5IC0wODAwDQo+ID4gDQo+ID4gICAg
IGRybS9pOTE1OiBFbmFibGUgUFNSMiBieSBkZWZhdWx0DQo+ID4gDQo+ID4gICAgIFRoZSBzdXBw
b3J0IGZvciBQU1IyIHdhcyBwb2xpc2hlZCwgSUdUIHRlc3RzIGZvciBQU1IyIHdhcyBhZGRlZA0K
PiA+IGFuZA0KPiA+ICAgICBpdCB3YXMgdGVzdGVkIHBlcmZvcm1pbmcgcmVndWxhciB1c2VyIHdv
cmtsb2FkcyBsaWtlIGJyb3dzaW5nLA0KPiA+ICAgICBlZGl0aW5nIGRvY3VtZW50cyBhbmQgY29t
cGlsaW5nIExpbnV4LCBzbyBpdCBpcyB0aW1lIHRvIGVuYWJsZQ0KPiA+IGl0DQo+ID4gYnkNCj4g
PiAgICAgZGVmYXVsdCBhbmQgZW5qb3kgZXZlbiBtb3JlIHBvd2VyLXNhdmluZ3MuDQo+ID4gDQo+
ID4gVGVtcG9yYXJ5IHdvcmthcm91bmQgd291bGQgYmUgdG8gc2V0IGk5MTUuZW5hYmxlX3Bzcj0w
DQo+IA0KPiBJdCBsb29rcyBwbGF1c2libGUuICBJIGhhdmUgdG8gc2F5IEkgd2FzIGp1c3QgYWJv
dXQgdG8gbWFyayBhIGJpc2VjdA0KPiBjb250YWluaW5nIHRoaXMgYXMgZ29vZCwgYnV0IHRoYXQg
cHJvYmFibHkgcmVmbGVjdHMgbXkgZGlmZmljdWx0eQ0KPiByZXByb2R1Y2luZyB0aGUgaXNzdWUu
DQoNClRha2UgYXQgbG9vayBvZiB3aGF0IFBTUiB2ZXJzaW9uIGlzIHN1cHBvcnRlZCBieSB5b3Vy
IHBhbmVsLCBpdCBsaWtlbHkNCnRoYXQgYSBub3RlYm9vayBzaGlwcGVkIHdpdGggU2t5bGFrZSB3
aWxsIGhhdmUgcGFuZWwgdGhhdCBzdXBwb3J0cyBvbmx5DQpQU1IxIHNvIHRoYXQgcGF0Y2ggaGFz
IG5vIGVmZmVjdCBvbiB5b3VyIG1hY2hpbmUuDQoNCnN1ZG8gbW9yZSAvc3lzL2tlcm5lbC9kZWJ1
Zy9kcmkvMC9pOTE1X2VkcF9wc3Jfc3RhdHVzDQpTaW5rIHN1cHBvcnQ6IHllcyBbMHgwMV0NCg0K
T25seSBpZiB5b3UgaGF2ZSAweDAzIHlvdXIgcGFuZWwgaGF2ZSBzdXBwb3J0IGZvciBQU1IyLg0K
DQpPciBjaGVjayB5b3VyIGRtZXNnOg0KW2RybTppbnRlbF9wc3JfaW5pdF9kcGNkIFtpOTE1XV0g
ZURQIHBhbmVsIHN1cHBvcnRzIFBTUiB2ZXJzaW9uIDENCg0KPiANCj4gSmFtZXMNCj4gDQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IEludGVsLWdm
eCBtYWlsaW5nIGxpc3QNCj4gSW50ZWwtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZw0KPiBodHRw
czovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2ludGVsLWdmeA0K
