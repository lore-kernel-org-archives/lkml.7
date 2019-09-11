Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19006C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06C52084F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 17:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729580AbfIKReJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 13:34:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:25335 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfIKReJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 13:34:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Sep 2019 10:34:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,489,1559545200"; 
   d="scan'208";a="384774516"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga005.fm.intel.com with ESMTP; 11 Sep 2019 10:34:08 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Sep 2019 10:34:08 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.68]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.218]) with mapi id 14.03.0439.000;
 Wed, 11 Sep 2019 10:34:08 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "me@tobin.cc" <me@tobin.cc>,
        "stfrench@microsoft.com" <stfrench@microsoft.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: Re: [Ksummit-discuss] [PATCH v2 2/3] Maintainer Handbook:
 Maintainer Entry Profile
Thread-Topic: [Ksummit-discuss] [PATCH v2 2/3] Maintainer Handbook:
 Maintainer Entry Profile
Thread-Index: AQHVaLpqINt3BK3afk2+UTXTBVR/lqcnMh2A
Date:   Wed, 11 Sep 2019 17:34:08 +0000
Message-ID: <78b0d48ac797d565b0dd98de02fc21bd2ce5769a.camel@intel.com>
References: <156821692280.2951081.18036584954940423225.stgit@dwillia2-desk3.amr.corp.intel.com>
         <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <156821693396.2951081.7340292149329436920.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8972A5658F548449D6EC7503DE2C959@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA5LTExIGF0IDA4OjQ4IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQoN
Cj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggM2YxNzEz
MzlkZjUzLi5lNWQxMTFhODZlNjEgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBi
L01BSU5UQUlORVJTDQo+IEBAIC05OCw2ICs5OCwxMCBAQCBEZXNjcmlwdGlvbnMgb2Ygc2VjdGlv
biBlbnRyaWVzOg0KPiAgCSAgIE9ic29sZXRlOglPbGQgY29kZS4gU29tZXRoaW5nIHRhZ2dlZCBv
YnNvbGV0ZSBnZW5lcmFsbHkgbWVhbnMNCj4gIAkJCWl0IGhhcyBiZWVuIHJlcGxhY2VkIGJ5IGEg
YmV0dGVyIHN5c3RlbSBhbmQgeW91DQo+ICAJCQlzaG91bGQgYmUgdXNpbmcgdGhhdC4NCj4gKwlQ
OiBTdWJzeXN0ZW0gUHJvZmlsZSBkb2N1bWVudCBmb3IgbW9yZSBkZXRhaWxzIHN1Ym1pdHRpbmcN
Cj4gKwkgICBwYXRjaGVzIHRvIHRoZSBnaXZlbiBzdWJzeXN0ZW0uIFRoaXMgaXMgZWl0aGVyIGFu
IGluLXRyZWUgZmlsZSwNCj4gKwkgICBvciBhIFVSSS4gU2VlIERvY3VtZW50YXRpb24vbWFpbnRh
aW5lci9tYWludGFpbmVyLWVudHJ5LXByb2ZpbGUucnN0DQo+ICsJICAgZm9yIGRldGFpbHMuDQoN
CkNvbnNpZGVyaW5nIGVhY2ggbWFpbnRhaW5lciBlbnRyeSBvciBkcml2ZXIgbWF5IG5vdCBoYXZl
IGEgc3ViZGlyZWN0b3J5DQp1bmRlciBEb2N1bWVudGF0aW9uLyB0byBwdXQgdGhlc2UgdW5kZXIs
IHdvdWxkIGl0IGJlIGJldHRlciB0byBjb2xsZWN0DQp0aGVtIGluIG9uZSBwbGFjZSwgc2F5IERv
Y3VtZW50YXRpb24vbWFpbnRhaW5lci1lbnRyeS1wcm9maWxlcy8gPw0K
