Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D15C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA17A233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 19:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387847AbfHVTKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 15:10:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:23126 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730427AbfHVTKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 15:10:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Aug 2019 12:10:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,417,1559545200"; 
   d="scan'208";a="190695444"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga002.jf.intel.com with ESMTP; 22 Aug 2019 12:10:37 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 22 Aug 2019 12:10:36 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.127]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.165]) with mapi id 14.03.0439.000;
 Thu, 22 Aug 2019 12:10:36 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "justin.he@arm.com" <justin.he@arm.com>,
        "jmoyer@redhat.com" <jmoyer@redhat.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH 2/2] drivers/dax/kmem: give a warning if
 CONFIG_DEV_DAX_PMEM_COMPAT is enabled
Thread-Topic: [PATCH 2/2] drivers/dax/kmem: give a warning if
 CONFIG_DEV_DAX_PMEM_COMPAT is enabled
Thread-Index: AQHVWRtCI+fbHAl24k6KFAKDmutKnqcH/a+A
Date:   Thu, 22 Aug 2019 19:10:35 +0000
Message-ID: <91b07911eb6d307c4cb652da6ec53bad661ec066.camel@intel.com>
References: <20190816111844.87442-1-justin.he@arm.com>
         <20190816111844.87442-3-justin.he@arm.com>
         <x49tva9ni68.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49tva9ni68.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FE4E6340A0DCFB4990BDFDF7F44BCDE4@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDE0OjU1IC0wNDAwLCBKZWZmIE1veWVyIHdyb3RlOg0KPiAN
Cj4gV2hlbiB1c2luZyBkYXhjdGwgdG8gb25saW5lIG1lbW9yeSwgeW91IGFscmVhZHkgZ2V0IHRo
ZSBmb2xsb3dpbmcNCj4gbWVzc2FnZToNCj4gDQo+IGxpYmRheGN0bDogZGF4Y3RsX2Rldl9kaXNh
YmxlOiBkYXgwLjA6IGVycm9yOiBkZXZpY2UgbW9kZWwgaXMgZGF4LWNsYXNzDQo+IA0KPiBUaGF0
J3Mgc3RpbGwgbm90IHZlcnkgaGVscGZ1bC4gIEl0IHdvdWxkIGJlIGJldHRlciBpZiB0aGUgbWVz
c2FnZQ0KPiBzdWdnZXN0ZWQgYSBmaXggKGxpa2UgdXNpbmcgbWlncmF0ZS1kZXZpY2UtbW9kZWwp
LiAgVmlzaGFsPw0KDQpZZXMsIGl0IGlzIG9uIG15IGxpc3QgdG8gaW1wcm92ZSB0aGlzLiBDdXJy
ZW50bHkgdGhlIG1hbiBwYWdlIHNob3dzIHRoZQ0KYWJvdmUgZXJyb3IgbWVzc2FnZSwgYW5kIHRh
bGtzIGFib3V0IG1pZ3JhdGUtZGV2aWNlLW1vZGVsLCBidXQgSQ0KcmVjZWl2ZWQgbW9yZSBmZWVk
YmFjayB0byBhZGQgYW5vdGhlciBicmVhZCBjcnVtYiBpbiB0aGUgcHJpbnRlZCBtZXNzYWdlDQpw
b2ludGluZyB0byBtaWdyYXRlLWRldmljZS1tb2RlbC4gIEknbGwgc2VuZCBhIHBhdGNoIGZvciBp
dCBzb29uLg0KDQpUaGFua3MsDQoJLVZpc2hhbA0K
