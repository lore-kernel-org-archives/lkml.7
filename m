Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB51C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 00:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92194214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 00:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfCMAKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 20:10:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:26407 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726280AbfCMAKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 20:10:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 17:10:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,472,1544515200"; 
   d="scan'208";a="151147834"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 12 Mar 2019 17:10:42 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 12 Mar 2019 17:10:44 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.56]) by
 FMSMSX114.amr.corp.intel.com ([10.18.116.8]) with mapi id 14.03.0415.000;
 Tue, 12 Mar 2019 17:10:43 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi/nfit: Always dump _DSM output payload
Thread-Topic: [PATCH] acpi/nfit: Always dump _DSM output payload
Thread-Index: AQHU2R2myvooYryHh0ycVhPwQ26eQqYJJYCA
Date:   Wed, 13 Mar 2019 00:10:42 +0000
Message-ID: <7b33acb9a5741f06bbac7dae307a74a300a5422f.camel@intel.com>
References: <155242666957.581839.11006696811038518218.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155242666957.581839.11006696811038518218.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2362C3AD847C34FB36B5A1260D4BFF0@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTAzLTEyIGF0IDE0OjM3IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFRoZSBkeW5hbWljLWRlYnVnIHN0YXRlbWVudHMgZm9yIGNvbW1hbmQgcGF5bG9hZCBvdXRwdXQg
b25seSBnZXQNCj4gZW1pdHRlZA0KPiB3aGVuIHRoZSBjb21tYW5kIGlzIG5vdCBORF9DTURfQ0FM
TC4gTW92ZSB0aGUgb3V0cHV0IHBheWxvYWQgZHVtcGluZw0KPiBhaGVhZCBvZiB0aGUgZWFybHkg
cmV0dXJuIHBhdGggZm9yIE5EX0NNRF9DQUxMLg0KPiANCj4gRml4ZXM6IDMxZWNhNzZiYTJmYzkg
KCIuLi53aGl0ZWxpc3RlZCBkaW1tIGNvbW1hbmQgbWFyc2hhbGluZw0KPiBtZWNoYW5pc20iKQ0K
PiBSZXBvcnRlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQo+
IFNpZ25lZC1vZmYtYnk6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0K
PiAtLS0NCj4gIGRyaXZlcnMvYWNwaS9uZml0L2NvcmUuYyB8ICAgMTIgKysrKysrLS0tLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPiANCg0K
TG9va3MgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZl
cm1hQGludGVsLmNvbT4NCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL25maXQvY29yZS5j
IGIvZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+IGluZGV4IGEyMmUyZjJiYmI3NS4uYzkzNjdl
Nzg1MjFiIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2FjcGkvbmZpdC9jb3JlLmMNCj4gKysrIGIv
ZHJpdmVycy9hY3BpL25maXQvY29yZS5jDQo+IEBAIC01NDYsNiArNTQ2LDEyIEBAIGludCBhY3Bp
X25maXRfY3RsKHN0cnVjdCBudmRpbW1fYnVzX2Rlc2NyaXB0b3INCj4gKm5kX2Rlc2MsIHN0cnVj
dCBudmRpbW0gKm52ZGltbSwNCj4gIAkJZ290byBvdXQ7DQo+ICAJfQ0KPiAgDQo+ICsJZGV2X2Ri
ZyhkZXYsICIlcyBjbWQ6ICVzIG91dHB1dCBsZW5ndGg6ICVkXG4iLCBkaW1tX25hbWUsDQo+ICsJ
CQljbWRfbmFtZSwgb3V0X29iai0+YnVmZmVyLmxlbmd0aCk7DQo+ICsJcHJpbnRfaGV4X2R1bXBf
ZGVidWcoY21kX25hbWUsIERVTVBfUFJFRklYX09GRlNFVCwgNCwgNCwNCj4gKwkJCW91dF9vYmot
PmJ1ZmZlci5wb2ludGVyLA0KPiArCQkJbWluX3QodTMyLCAxMjgsIG91dF9vYmotPmJ1ZmZlci5s
ZW5ndGgpLCB0cnVlKTsNCj4gKw0KPiAgCWlmIChjYWxsX3BrZykgew0KPiAgCQljYWxsX3BrZy0+
bmRfZndfc2l6ZSA9IG91dF9vYmotPmJ1ZmZlci5sZW5ndGg7DQo+ICAJCW1lbWNweShjYWxsX3Br
Zy0+bmRfcGF5bG9hZCArIGNhbGxfcGtnLT5uZF9zaXplX2luLA0KPiBAQCAtNTY0LDEyICs1NzAs
NiBAQCBpbnQgYWNwaV9uZml0X2N0bChzdHJ1Y3QgbnZkaW1tX2J1c19kZXNjcmlwdG9yDQo+ICpu
ZF9kZXNjLCBzdHJ1Y3QgbnZkaW1tICpudmRpbW0sDQo+ICAJCXJldHVybiAwOw0KPiAgCX0NCj4g
IA0KPiAtCWRldl9kYmcoZGV2LCAiJXMgY21kOiAlcyBvdXRwdXQgbGVuZ3RoOiAlZFxuIiwgZGlt
bV9uYW1lLA0KPiAtCQkJY21kX25hbWUsIG91dF9vYmotPmJ1ZmZlci5sZW5ndGgpOw0KPiAtCXBy
aW50X2hleF9kdW1wX2RlYnVnKGNtZF9uYW1lLCBEVU1QX1BSRUZJWF9PRkZTRVQsIDQsIDQsDQo+
IC0JCQlvdXRfb2JqLT5idWZmZXIucG9pbnRlciwNCj4gLQkJCW1pbl90KHUzMiwgMTI4LCBvdXRf
b2JqLT5idWZmZXIubGVuZ3RoKSwgdHJ1ZSk7DQo+IC0NCj4gIAlmb3IgKGkgPSAwLCBvZmZzZXQg
PSAwOyBpIDwgZGVzYy0+b3V0X251bTsgaSsrKSB7DQo+ICAJCXUzMiBvdXRfc2l6ZSA9IG5kX2Nt
ZF9vdXRfc2l6ZShudmRpbW0sIGNtZCwgZGVzYywgaSwNCj4gYnVmLA0KPiAgCQkJCSh1MzIgKikg
b3V0X29iai0+YnVmZmVyLnBvaW50ZXIsDQo+IA0KDQo=
