Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32249CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D48D2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 21:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbfJ3ViN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 17:38:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:64858 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbfJ3ViN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 17:38:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2019 14:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,248,1569308400"; 
   d="scan'208";a="194103599"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga008.jf.intel.com with ESMTP; 30 Oct 2019 14:38:12 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 14:38:11 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 fmsmsx117.amr.corp.intel.com ([169.254.3.136]) with mapi id 14.03.0439.000;
 Wed, 30 Oct 2019 14:38:11 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "cai@lca.pw" <cai@lca.pw>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v2] nvdimm/btt: fix variable 'rc' set but not used
Thread-Topic: [PATCH v2] nvdimm/btt: fix variable 'rc' set but not used
Thread-Index: AQHVj2j5N04bKZ3YrkGatkzY9Yk1Sad0KywA
Date:   Wed, 30 Oct 2019 21:38:10 +0000
Message-ID: <03cacc16f2fcd7cc74cf15c57070c78e73206e68.camel@intel.com>
References: <1572470889-28754-1-git-send-email-cai@lca.pw>
In-Reply-To: <1572470889-28754-1-git-send-email-cai@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <26DA713DD43F4744895098BA3049F01E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMTktMTAtMzAgYXQgMTc6MjggLTA0MDAsIFFpYW4gQ2FpIHdyb3RlOg0KPiBk
cml2ZXJzL252ZGltbS9idHQuYzogSW4gZnVuY3Rpb24gJ2J0dF9yZWFkX3BnJzoNCj4gZHJpdmVy
cy9udmRpbW0vYnR0LmM6MTI2NDo4OiB3YXJuaW5nOiB2YXJpYWJsZSAncmMnIHNldCBidXQgbm90
IHVzZWQNCj4gWy1XdW51c2VkLWJ1dC1zZXQtdmFyaWFibGVdDQo+ICAgICBpbnQgcmM7DQo+ICAg
ICAgICAgXn4NCj4gDQo+IEFkZCBhIHJhdGVsaW1pdGVkIG1lc3NhZ2UgaW4gY2FzZSBhIHN0b3Jt
IG9mIGVycm9ycyBpcyBlbmNvdW50ZXJlZC4NCj4gDQo+IEZpeGVzOiBkOWI4M2M3NTY5NTMgKCJs
aWJudmRpbW0sIGJ0dDogcmV3b3JrIGVycm9yIGNsZWFyaW5nIikNCj4gU2lnbmVkLW9mZi1ieTog
UWlhbiBDYWkgPGNhaUBsY2EucHc+DQo+IC0tLQ0KPiANCj4gdjI6IGluY2x1ZGUgdGhlIGJsb2Nr
IGFkZHJlc3MgdGhhdCBpcyByZXR1cm5pbmcgYW4gZXJyb3IgcGVyIERhbi4NCj4gDQo+ICBkcml2
ZXJzL252ZGltbS9idHQuYyB8IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0vYnR0LmMgYi9kcml2ZXJz
L252ZGltbS9idHQuYw0KPiBpbmRleCAzZTlmNDVhZWM4ZDEuLjEwMzEzYmU3ODIyMSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9udmRpbW0vYnR0LmMNCj4gKysrIGIvZHJpdmVycy9udmRpbW0vYnR0
LmMNCj4gQEAgLTEyNjYsNiArMTI2NiwxMiBAQCBzdGF0aWMgaW50IGJ0dF9yZWFkX3BnKHN0cnVj
dCBidHQgKmJ0dCwgc3RydWN0IGJpb19pbnRlZ3JpdHlfcGF5bG9hZCAqYmlwLA0KPiAgCQkJLyog
TWVkaWEgZXJyb3IgLSBzZXQgdGhlIGVfZmxhZyAqLw0KPiAgCQkJcmMgPSBidHRfbWFwX3dyaXRl
KGFyZW5hLCBwcmVtYXAsIHBvc3RtYXAsIDAsIDEsDQo+ICAJCQkJTlZESU1NX0lPX0FUT01JQyk7
DQo+ICsNCj4gKwkJCWlmIChyYykNCj4gKwkJCQlkZXZfd2Fybl9yYXRlbGltaXRlZCh0b19kZXYo
YXJlbmEpLA0KPiArCQkJCQkiRXJyb3IgcGVyc2lzdGVudGx5IHRyYWNraW5nIGJhZCBibG9ja3Mg
YXQgJSN4XG4iLA0KPiArCQkJCQlwcmVtYXApOw0KPiArDQo+ICAJCQlnb3RvIG91dF9ydHQ7DQo+
ICAJCX0NCg0KR29vZCBmaW5kISBTaW5jZSB3ZSdyZSBub3QgcmVhbGx5IHVzaW5nIHJjIGxhdGVy
LCB3ZSBzaG91bGQganVzdA0Kc2ltcGxpZnkgdGhpcyB0bzoNCg0KCWlmIChidHRfbWFwX3dyaXRl
KC4uLikpDQoJCWRldl93YXJuX3JhdGVsaW1pdGVkKC4uLikNCglnb3RvIG91dF9ydHQ7DQoNCg0K
