Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBC4CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC8E217D9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 20:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfKAUwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 16:52:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:40669 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfKAUwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 16:52:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Nov 2019 13:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,257,1569308400"; 
   d="scan'208";a="199916667"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga007.fm.intel.com with ESMTP; 01 Nov 2019 13:52:54 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 1 Nov 2019 13:52:54 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX126.amr.corp.intel.com ([169.254.1.167]) with mapi id 14.03.0439.000;
 Fri, 1 Nov 2019 13:52:53 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH] libnvdimm/pmem: Delete include of nd-core.h
Thread-Topic: [PATCH] libnvdimm/pmem: Delete include of nd-core.h
Thread-Index: AQHVkE2z3NSFKZ0vREyUBbLgylDZYad3QWQA
Date:   Fri, 1 Nov 2019 20:52:52 +0000
Message-ID: <86ea4fc17a94446df545af450e9de704e674b68c.camel@intel.com>
References: <157256829077.1212326.8726596129631121970.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157256829077.1212326.8726596129631121970.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FAEA65EFF47F44A81AEC60455BFA102@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEwLTMxIGF0IDE3OjMxIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFRoZSBlbnRpcmUgcG9pbnQgb2YgbmQtY29yZS5oIGlzIHRvIGhpZGUgZnVuY3Rpb25hbGl0eSB0
aGF0IG5vIGxlYWYNCj4gZHJpdmVyIHNob3VsZCB0b3VjaC4gSW4gZmFjdCwgdGhlIGNvbW1pdCB0
aGF0IGFkZGVkIGl0IGhhZCBubyBuZWVkIHRvDQo+IGluY2x1ZGUgaXQuDQo+IA0KPiBGaXhlczog
MDZlOGNjZGFiMTVmICgiYWNwaTogbmZpdDogQWRkIHN1cHBvcnQgZm9yIGRldGVjdCBwbGF0Zm9y
bS4uLiIpDQo+IENjOiBJcmEgV2VpbnkgPGlyYS53ZWlueUBpbnRlbC5jb20+DQo+IENjOiBEYXZl
IEppYW5nIDxkYXZlLmppYW5nQGludGVsLmNvbT4NCj4gQ2M6IFZpc2hhbCBWZXJtYSA8dmlzaGFs
LmwudmVybWFAaW50ZWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL252ZGltbS9wbWVtLmMgfCAg
ICAxIC0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQoNCkxvb2tzIGdvb2QsDQpS
ZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+DQoNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9wbWVtLmMgYi9kcml2ZXJzL252ZGltbS9w
bWVtLmMNCj4gaW5kZXggN2E2ZjQ1MDFkY2RhLi5hZDhlNGRmMTI4MmIgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPiArKysgYi9kcml2ZXJzL252ZGltbS9wbWVtLmMNCj4g
QEAgLTI4LDcgKzI4LDYgQEANCj4gICNpbmNsdWRlICJwbWVtLmgiDQo+ICAjaW5jbHVkZSAicGZu
LmgiDQo+ICAjaW5jbHVkZSAibmQuaCINCj4gLSNpbmNsdWRlICJuZC1jb3JlLmgiDQo+ICANCj4g
IHN0YXRpYyBzdHJ1Y3QgZGV2aWNlICp0b19kZXYoc3RydWN0IHBtZW1fZGV2aWNlICpwbWVtKQ0K
PiAgew0KPiANCg0K
