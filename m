Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5F5C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 227EE260AF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 01:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfEaBRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 21:17:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:31605 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbfEaBRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 21:17:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 May 2019 18:17:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,533,1549958400"; 
   d="scan'208";a="180146968"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga002.fm.intel.com with ESMTP; 30 May 2019 18:17:47 -0700
Received: from orsmsx106.amr.corp.intel.com ([169.254.1.191]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.182]) with mapi id 14.03.0415.000;
 Thu, 30 May 2019 18:17:47 -0700
From:   "Yu, Fenghua" <fenghua.yu@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v3 3/5] x86/umwait: Add sysfs interface to control
 umwait C0.2 state
Thread-Topic: [PATCH v3 3/5] x86/umwait: Add sysfs interface to control
 umwait C0.2 state
Thread-Index: AQHVEo2OKXbABb0TWkq6YN3OCk9vEqaEqHgA///HhbA=
Date:   Fri, 31 May 2019 01:17:46 +0000
Message-ID: <3E5A0FA7E9CA944F9D5414FEC6C712209D8E5C5A@ORSMSX106.amr.corp.intel.com>
References: <1558742162-73402-1-git-send-email-fenghua.yu@intel.com>
 <1558742162-73402-4-git-send-email-fenghua.yu@intel.com>
 <CALCETrUByHERw5ZB7q-3ka71a_4uxVi-uthTjf7JtDPEgLPjRg@mail.gmail.com>
In-Reply-To: <CALCETrUByHERw5ZB7q-3ka71a_4uxVi-uthTjf7JtDPEgLPjRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: request-justification,no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUaHVyc2RheSwgTWF5IDMwLCAyMDE5IDI6MTEgUE0gQW5keSBMdXRvbWlyc2tpIFttYWls
dG86bHV0b0BrZXJuZWwub3JnXSB3cm90ZToNCj4gT24gRnJpLCBNYXkgMjQsIDIwMTkgYXQgNTow
NSBQTSBGZW5naHVhIFl1IDxmZW5naHVhLnl1QGludGVsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBD
MC4yIHN0YXRlIGluIHVtd2FpdCBhbmQgdHBhdXNlIGluc3RydWN0aW9ucyBjYW4gYmUgZW5hYmxl
ZCBvcg0KPiA+IGRpc2FibGVkIG9uIGEgcHJvY2Vzc29yIHRocm91Z2ggSUEzMl9VTVdBSVRfQ09O
VFJPTCBNU1IgcmVnaXN0ZXIuDQo+ID4NCj4gPiBCeSBkZWZhdWx0LCBDMC4yIGlzIGVuYWJsZWQg
YW5kIHRoZSB1c2VyIHdhaXQgaW5zdHJ1Y3Rpb25zIHJlc3VsdCBpbg0KPiA+IGxvd2VyIHBvd2Vy
IGNvbnN1bXB0aW9uIHdpdGggc2xvd2VyIHdha2V1cCB0aW1lLg0KPiA+DQo+ID4gQnV0IGluIHJl
YWwgdGltZSBzeXN0ZW1zIHdoaWNoIHJlcXVyaWUgZmFzdGVyIHdha2V1cCB0aW1lIGFsdGhvdWdo
DQo+ID4gcG93ZXIgc2F2aW5ncyBjb3VsZCBiZSBzbWFsbGVyLCB0aGUgYWRtaW5pc3RyYXRvciBu
ZWVkcyB0byBkaXNhYmxlDQo+ID4gQzAuMiBhbmQgYWxsDQo+ID4gQzAuMiByZXF1ZXN0cyBmcm9t
IHVzZXIgYXBwbGljYXRpb25zIHJldmVydCB0byBDMC4xLg0KPiA+DQo+ID4gQSBzeXNmcyBpbnRl
cmZhY2UgIi9zeXMvZGV2aWNlcy9zeXN0ZW0vY3B1L3Vtd2FpdF9jb250cm9sL2VuYWJsZV9jMF8y
Ig0KPiA+IGlzIGNyZWF0ZWQgdG8gYWxsb3cgdGhlIGFkbWluaXN0cmF0b3IgdG8gY29udHJvbCBD
MC4yIHN0YXRlIGR1cmluZyBydW4gdGltZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZlbmdo
dWEgWXUgPGZlbmdodWEueXVAaW50ZWwuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBBc2hvayBSYWog
PGFzaG9rLnJhakBpbnRlbC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFRvbnkgTHVjayA8dG9ueS5s
dWNrQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC94ODYvcG93ZXIvdW13YWl0LmMgfCA3
NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L3Bvd2VyL3Vtd2FpdC5jIGIvYXJjaC94ODYvcG93ZXIvdW13
YWl0LmMgaW5kZXgNCj4gPiA4MGNjNTNhOWMyZDAuLmNmNWRlN2UxY2MyNCAxMDA2NDQNCj4gPiAt
LS0gYS9hcmNoL3g4Ni9wb3dlci91bXdhaXQuYw0KPiA+ICsrKyBiL2FyY2gveDg2L3Bvd2VyL3Vt
d2FpdC5jDQo+ID4gQEAgLTcsNiArNyw3IEBADQo+ID4gIHN0YXRpYyBib29sIHVtd2FpdF9jMF8y
X2VuYWJsZWQgPSB0cnVlOw0KPiA+ICAvKiBVbXdhaXQgbWF4IHRpbWUgaXMgaW4gVFNDLXF1YW50
YS4gQml0c1sxOjBdIGFyZSB6ZXJvLiAqLyAgc3RhdGljDQo+ID4gdTMyIHVtd2FpdF9tYXhfdGlt
ZSA9IDEwMDAwMDsNCj4gPiArc3RhdGljIERFRklORV9NVVRFWCh1bXdhaXRfbG9jayk7DQo+ID4N
Cj4gPiAgLyogUmV0dXJuIHZhbHVlIHRoYXQgd2lsbCBiZSB1c2VkIHRvIHNldCBJQTMyX1VNV0FJ
VF9DT05UUk9MIE1TUiAqLw0KPiA+IHN0YXRpYyB1MzIgdW13YWl0X2NvbXB1dGVfbXNyX3ZhbHVl
KHZvaWQpIEBAIC0yMiw3ICsyMyw3IEBAIHN0YXRpYw0KPiB1MzINCj4gPiB1bXdhaXRfY29tcHV0
ZV9tc3JfdmFsdWUodm9pZCkNCj4gPiAgICAgICAgICAgICAgICAodW13YWl0X21heF90aW1lICYg
TVNSX0lBMzJfVU1XQUlUX0NPTlRST0xfTUFYX1RJTUUpOw0KPiA+ICB9DQo+ID4NCj4gPiAtc3Rh
dGljIHZvaWQgdW13YWl0X2NvbnRyb2xfbXNyX3VwZGF0ZSh2b2lkKQ0KPiA+ICtzdGF0aWMgdm9p
ZCB1bXdhaXRfY29udHJvbF9tc3JfdXBkYXRlKHZvaWQgKnVudXNlZCkNCj4gPiAgew0KPiA+ICAg
ICAgICAgdTMyIG1zcl92YWw7DQo+ID4NCj4gPiBAQCAtMzMsNyArMzQsOSBAQCBzdGF0aWMgdm9p
ZCB1bXdhaXRfY29udHJvbF9tc3JfdXBkYXRlKHZvaWQpDQo+ID4gIC8qIFNldCB1cCBJQTMyX1VN
V0FJVF9DT05UUk9MIE1TUiBvbiBDUFUgdXNpbmcgdGhlIGN1cnJlbnQgZ2xvYmFsDQo+ID4gc2V0
dGluZy4gKi8gIHN0YXRpYyBpbnQgdW13YWl0X2NwdV9vbmxpbmUodW5zaWduZWQgaW50IGNwdSkg
IHsNCj4gPiAtICAgICAgIHVtd2FpdF9jb250cm9sX21zcl91cGRhdGUoKTsNCj4gPiArICAgICAg
IG11dGV4X2xvY2soJnVtd2FpdF9sb2NrKTsNCj4gPiArICAgICAgIHVtd2FpdF9jb250cm9sX21z
cl91cGRhdGUoTlVMTCk7DQo+ID4gKyAgICAgICBtdXRleF91bmxvY2soJnVtd2FpdF9sb2NrKTsN
Cj4gDQo+IFdoYXQncyB0aGUgbXV0ZXggZm9yPyAgQ2FuJ3QgeW91IGp1c3QgdXNlIFJFQURfT05D
RT8NCg0KdW13YWl0X2NvbnRyb2xfbXNyX3VwZGF0ZSgpIHdpbGwgd3JpdGUgYm90aCB1bXdhaXRf
YzBfMl9lbmFibGVkIGFuZCB1bXdhaXRfbWF4X3RpbWUgKHdoaWNoIGFsc28gY2FuIGJlDQpjaGFu
Z2VkIHRocm91Z2ggc3lzZnMgaW4gdGhlIG5leHQgcGF0Y2gpIHRvIHRoZSBURVNUX0NUUkwgTVNS
Lg0KDQpKdXN0IHVzaW5nIFJFQURfT05DRSgpIGZvciB0aGUgdHdvIHZhcmlhYmxlcyBjYW5ub3Qg
Z3VhcmFudGVlIGFsbCBDUFVzIGhhdmUgdGhlIHNhbWUgc2V0dGluZyBvZiBDMC4yIGFuZCBtYXgg
dGltZS4NClJFQURfT05DRSgpIGFuZCBXUklURV9PTkNFKCkgY2FuIG9ubHkgZ3VhcmFudGVlIGF0
b21pY2l0eSBmb3IgcmVhZGluZyBhbmQgd3JpdG5nIHRoZSBzYW1lIHZhcmlhYmxlLg0KDQpGb3Ig
ZS5nLiB3aXRob3V0IG11dGV4IHByb3RlY3Rpb246DQoNCmluaXRpYWwgdmFsdWVzOiB1bXdhaXRf
YzBfMl9lbmFibGVkPTEgYW5kIHVtd2FpdF9tYXhfdGltZT0xMDAwMDANCg0KMS4gdW13YWl0X2Nw
dV9vbmxpbmUoWCk6IHJlYWQgdW13YWl0X2MwXzJfZW5hYmxlZCBhcyAxDQoyLiBlbmFibGVfYzBf
Ml9zdG9yZSgpOiB1bXdhaXRfYzBfMl9lbmFibGVkID0gMCBhbmQgdXBkYXRlIGFsbCBvbmxpbmUg
Q1BVcyBhcyBDMC4yIGRpc2FibGVkLg0KMy4gdW13YWl0X2NwdV9vbmxpbmUoWCk6IHJlYWQgdW13
YWl0X21heF90aW1lPTEwMDAwMA0KNC4gdW13YWl0X2NwdV9vbmxpbmUoWSk6IHJlYWQgdW13YWl0
X2MwXzJfZW5hYmxlZCBhcyAwDQo1LiB1bXdhaXRfbWF4X3RpbWVfc3RvcmUoKTogdW13YWl0X21h
eF90aW1lPTUwMCBhbmQgdXBkYXRlIGFsbCBvbmxpbmUgQ1BVcyBhcyBtYXggdGltZSA9IDUwMCBj
eWNsZXMuDQo2LiB1bXdhaXRfY3B1X29ubGluZShZKTogcmVhZCB1bXdhaXRfbWF4X3RpbWUgYXMg
NTAwDQo3LiB1bXdhdGlfY3B1X29ubGluZShYKTogd3Jtc3IoKSBlbmFibGVzIEMwLjIgYW5kIHNl
dHMgbWF4IHRpbWUgMTAwMDAwIG9uIENQVSBYDQo4LiB1bXdhaXRfY3B1X29ubGluZShZKTogZGlz
YWJsZXMgQzAuMiBhbmQgc2V0cyAgbWF4IHRpbWUgNTAwIG9uIENQVSBZDQoNCldpdGggdGhlIG11
dGV4IHRvIHByb3RlY3QgdGhlIHR3byB2YXJpYWJsZXMgYW5kIHdybXNyKCksIGVhY2ggQ1BVIHdp
bGwgaGF2ZSB0aGUgc2FtZSBzZXR0aW5nIG9mIEMwLjIgYW5kIG1heCB0aW1lLg0KDQo+IA0KPiA+
ICtzdGF0aWMgdm9pZCB1bXdhaXRfY29udHJvbF9tc3JfdXBkYXRlX2FsbF9jcHVzKHZvaWQpDQo+
ID4gK3sNCj4gPiArICAgICAgIHUzMiBtc3JfdmFsOw0KPiA+ICsNCj4gPiArICAgICAgIG1zcl92
YWwgPSB1bXdhaXRfY29tcHV0ZV9tc3JfdmFsdWUoKTsNCj4gPiArICAgICAgIC8qIEFsbCBDUFVz
IGhhdmUgc2FtZSB1bXdhaXQgY29udHJvbCBzZXR0aW5nICovDQo+ID4gKyAgICAgICBvbl9lYWNo
X2NwdSh1bXdhaXRfY29udHJvbF9tc3JfdXBkYXRlLCBOVUxMLCAxKTsNCj4gDQo+IFdoeSBhcmUg
eW91IGNhbGxpbmcgdW13YWl0X2NvbXB1dGVfbXNyX3ZhbHVlKCk/DQoNClVtd2FpdF9jb21wdXRl
X21zcl92YWx1ZSgpIGNvbXB1dGVzIHRoZSBURVNUX0NUTCB2YWx1ZSBmcm9tIHR3byB2YXJpYWJs
ZXMgdW13YWl0X2MwXzJfZW5hYmxlZCBhbmQgdW13YWl0X21heF90aW1lLg0KQW55IG9mIHRoZSB0
d28gdmFyaWFibGVzIG1heSBiZSBjaGFuZ2VkIHdoZW4gIHVtd2FpdF9jb250cm9sX21zcl91cGRh
dGVfYWxsX2NwdXMoKSBpcyBjYWxsZWQuIFNvIG5lZWQgdG8gcmUtY2FsY3VsYXRlIHRoZQ0KTVNS
IHZhbHVlIHRoZW4gd3JpdGUgdGhlIHZhbHVlIHRvIE1TUiBvbiBhbGwgQ1BVcy4NCg0KVGhhbmtz
Lg0KDQotRmVuZ2h1YQ0K
