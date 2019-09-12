Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D54C49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8CC2084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 03:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbfILDxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 23:53:21 -0400
Received: from mga06.intel.com ([134.134.136.31]:13411 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729310AbfILDxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 23:53:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 20:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,492,1559545200"; 
   d="scan'208";a="268958277"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga001.jf.intel.com with ESMTP; 11 Sep 2019 20:53:20 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Sep 2019 20:52:50 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.68]) by
 fmsmsx117.amr.corp.intel.com ([169.254.3.133]) with mapi id 14.03.0439.000;
 Wed, 11 Sep 2019 20:52:50 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "joe@perches.com" <joe@perches.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 11/13] nvdimm: Use more common logic testing styles and
 bare ; positions
Thread-Topic: [PATCH 11/13] nvdimm: Use more common logic testing styles and
 bare ; positions
Thread-Index: AQHVaRWKbif/DxojQEGXHgNOmHirzacn3kSA
Date:   Thu, 12 Sep 2019 03:52:49 +0000
Message-ID: <706f6af6a6571a3bb2d35ec332fa572a990cbc48.camel@intel.com>
References: <cover.1568256705.git.joe@perches.com>
         <d6aa5b66936f2e0f132e893e10494aae6b74e886.1568256708.git.joe@perches.com>
In-Reply-To: <d6aa5b66936f2e0f132e893e10494aae6b74e886.1568256708.git.joe@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.254.21.217]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B343DDA310A65479EFFA2A81A767489@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA5LTExIGF0IDE5OjU0IC0wNzAwLCBKb2UgUGVyY2hlcyB3cm90ZToNCj4g
QXZvaWQgdXNpbmcgdW5jb21tb24gbG9naWMgdGVzdGluZyBzdHlsZXMgdG8gbWFrZSB0aGUgY29k
ZSBhDQo+IGJpdCBtb3JlIGxpa2Ugb3RoZXIga2VybmVsIGNvZGUuDQo+IA0KPiBlLmcuOg0KPiAJ
aWYgKGZvbykgew0KPiAJCTsNCj4gCX0gZWxzZSB7DQo+IAkJPGNvZGU+DQo+IAl9DQo+IA0KPiBp
cyB0eXBpY2FsbHkgd3JpdHRlbg0KPiANCj4gCWlmICghZm9vKSB7DQo+IAkJPGNvZGU+DQo+IAl9
DQo+IA0KDQpBIGxvdCBvZiB0aW1lcyB0aGUgZXhjZXNzaXZlIGludmVyc2lvbnMgc2VlbSB0byBy
ZXN1bHQgaW4gYSBuZXQgbG9zcyBvZg0KcmVhZGFiaWxpdHkgLSBlLmcuOg0KDQo8c25pcD4NCg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0KPiBiL2RyaXZlcnMv
bnZkaW1tL3JlZ2lvbl9kZXZzLmMNCj4gaW5kZXggNjVkZjA3NDgxOTA5Li42ODYxZTA5OTdkMjEg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZkaW1tL3JlZ2lvbl9kZXZzLmMNCj4gKysrIGIvZHJp
dmVycy9udmRpbW0vcmVnaW9uX2RldnMuYw0KPiBAQCAtMzIwLDkgKzMyMCw3IEBAIHN0YXRpYyBz
c2l6ZV90IHNldF9jb29raWVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAJc3RydWN0IG5k
X2ludGVybGVhdmVfc2V0ICpuZF9zZXQgPSBuZF9yZWdpb24tPm5kX3NldDsNCj4gIAlzc2l6ZV90
IHJjID0gMDsNCj4gIA0KPiAtCWlmIChpc19tZW1vcnkoZGV2KSAmJiBuZF9zZXQpDQo+IC0JCS8q
IHBhc3MsIHNob3VsZCBiZSBwcmVjbHVkZWQgYnkgcmVnaW9uX3Zpc2libGUgKi87DQoNCkZvciBv
bmUsIHRoZSBjb21tZW50IGlzIGxvc3QNCg0KPiAtCWVsc2UNCj4gKwlpZiAoIShpc19tZW1vcnko
ZGV2KSAmJiBuZF9zZXQpKQ0KDQpBbmQgaXQgdGFrZXMgYSBtb21lbnQgdG8gcmVzb2x2ZSBiZXR3
ZWVuIHRoaW5ncyBzdWNoIGFzOg0KDQoJaWYgKCEoQSAmJiBCKSkNCgkgIHZzLg0KCWlmICghKEEp
ICYmIEIpDQoNCkFuZCB0aGlzIGlzIGVzcGVjaWFsbHkgdHJ1ZSBpZiAnQScgYW5kICdCJyBhcmUg
bG9uZ2VyIGZ1bmN0aW9uIGNhbGxzLA0Kc3BsaXQgb3ZlciBtdWx0aXBsZSBsaW5lcywgb3IgYXJl
IHRoZW1zZWx2ZXMgY29tcG91bmQgJ3NlY3Rpb25zJy4NCg0KSSdtIG5vdCBvcHBvc2VkIHRvIC9h
bGwvIHN1Y2ggdHJhbnNmb3JtYXRpb25zIC0tIGZvciBleGFtcGxlLCB0aGUgb25lcw0Kd2hlcmUg
dGhlIGxvZ2ljYWwgaW52ZXJzaW9uIGNhbiBiZSAnY29uc3VtZWQnIGJ5IHRvZ2dsaW5nIGEgY29t
cGFyaXNpb24NCm9wZXJhdG9yLCBhcyB5b3UgaGF2ZSBhIGZldyB0aW1lcyBpbiB0aGlzIHBhdGNo
LCBkb24ndCBzYWNyaWZpY2UgYW55DQpyZWFkaWJpbGl0eSwgYW5kIHBlcmhhcHMgZXZlbiBpbXBy
b3ZlIGl0LiANCg0KPiAgCQlyZXR1cm4gLUVOWElPOw0KPiAgDQo+ICAJLyoNCg==
