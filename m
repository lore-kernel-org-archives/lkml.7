Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94C6C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8C520859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388532AbfFJSpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:45:24 -0400
Received: from mga04.intel.com ([192.55.52.120]:30827 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387643AbfFJSpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:45:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jun 2019 11:45:23 -0700
X-ExtLoop1: 1
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga002.jf.intel.com with ESMTP; 10 Jun 2019 11:45:23 -0700
Received: from orsmsx113.amr.corp.intel.com ([169.254.9.248]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.187]) with mapi id 14.03.0415.000;
 Mon, 10 Jun 2019 11:45:23 -0700
From:   "Mehta, Sohil" <sohil.mehta@intel.com>
To:     "joro@8bytes.org" <joro@8bytes.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        "cai@lca.pw" <cai@lca.pw>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH 5/6] iommu/vt-d: Cleanup after delegating DMA domain to
 generic iommu
Thread-Topic: [PATCH 5/6] iommu/vt-d: Cleanup after delegating DMA domain to
 generic iommu
Thread-Index: AQHVHm1riigSOeMSoEKdi5DrOzgP5aaVsjoA
Date:   Mon, 10 Jun 2019 18:45:23 +0000
Message-ID: <1560192412.27481.12.camel@intel.com>
References: <20190609023803.23832-1-baolu.lu@linux.intel.com>
         <20190609023803.23832-6-baolu.lu@linux.intel.com>
In-Reply-To: <20190609023803.23832-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.110.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <06FAD7A4365DF84993512DC9E698AAA7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTA2LTA5IGF0IDEwOjM4ICswODAwLCBMdSBCYW9sdSB3cm90ZToNCj4gwqBz
dGF0aWMgaW50IF9faW5pdCBzaV9kb21haW5faW5pdChpbnQgaHcpDQo+IEBAIC0zMzA2LDE0ICsz
MjUyLDEzIEBAIHN0YXRpYyBpbnQgX19pbml0IGluaXRfZG1hcnModm9pZCkNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocGFzaWRfc3VwcG9ydGVkKGlvbW11KSkNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZWxfc3ZtX2lu
aXQoaW9tbXUpOw0KPiDCoCNlbmRpZg0KPiAtwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IC3CoMKg
wqDCoMKgwqDCoC8qDQo+IC3CoMKgwqDCoMKgwqDCoCAqIE5vdyB0aGF0IHFpIGlzIGVuYWJsZWQg
b24gYWxsIGlvbW11cywgc2V0IHRoZSByb290IGVudHJ5DQo+IGFuZCBmbHVzaA0KPiAtwqDCoMKg
wqDCoMKgwqAgKiBjYWNoZXMuIFRoaXMgaXMgcmVxdWlyZWQgb24gc29tZSBJbnRlbCBYNTggY2hp
cHNldHMsDQo+IG90aGVyd2lzZSB0aGUNCj4gLcKgwqDCoMKgwqDCoMKgICogZmx1c2hfY29udGV4
dCBmdW5jdGlvbiB3aWxsIGxvb3AgZm9yZXZlciBhbmQgdGhlIGJvb3QNCj4gaGFuZ3MuDQo+IC3C
oMKgwqDCoMKgwqDCoCAqLw0KPiAtwqDCoMKgwqDCoMKgwqBmb3JfZWFjaF9hY3RpdmVfaW9tbXUo
aW9tbXUsIGRyaGQpIHsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qDQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBOb3cgdGhhdCBxaSBpcyBlbmFibGVkIG9u
IGFsbCBpb21tdXMsIHNldCB0aGUgcm9vdA0KPiBlbnRyeSBhbmQNCj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqIGZsdXNoIGNhY2hlcy4gVGhpcyBpcyByZXF1aXJlZCBvbiBzb21l
IEludGVsIFg1OA0KPiBjaGlwc2V0cywNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIG90aGVyd2lzZSB0aGUgZmx1c2hfY29udGV4dCBmdW5jdGlvbiB3aWxsIGxvb3ANCj4gZm9y
ZXZlciBhbmQNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHRoZSBib290IGhh
bmdzLg0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovDQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaW9tbXVfZmx1c2hfd3JpdGVfYnVmZmVyKGlvbW11KTsNCj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpb21tdV9zZXRfcm9vdF9lbnRyeShpb21t
dSk7DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW9tbXUtPmZsdXNoLmZsdXNo
X2NvbnRleHQoaW9tbXUsIDAsIDAsIDAsDQo+IERNQV9DQ01EX0dMT0JBTF9JTlZMKTsNCg0KDQpU
aGlzIGNoYW5nZXMgdGhlIGludGVudCBvZiB0aGUgb3JpZ2luYWwgY29kZS4gQXMgdGhlIGNvbW1l
bnQgc2F5cw0KZW5hYmxlIFFJIG9uIGFsbCBJT01NVXMsIHRoZW4gZmx1c2ggdGhlIGNhY2hlcyBh
bmQgc2V0IHRoZSByb290IGVudHJ5Lg0KVGhlIG9yZGVyIG9mIHNldHRpbmcgdGhlIHJvb3QgZW50
cmllcyBoYXMgY2hhbmdlZCBub3cuDQoNClJlZmVyOsKgDQpDb21taXQgYTRjMzRmZjFjMDI5ICgn
aW9tbXUvdnQtZDogRW5hYmxlIFFJIG9uIGFsbCBJT01NVXMgYmVmb3JlDQpzZXR0aW5nIHJvb3Qg
ZW50cnknKQ0KDQotLVNvaGls
