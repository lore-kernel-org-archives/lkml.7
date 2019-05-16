Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AE6C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2647A20873
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbfEPBqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:48771 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfEPAZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:25:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 17:25:19 -0700
X-ExtLoop1: 1
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga005.fm.intel.com with ESMTP; 15 May 2019 17:25:19 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 15 May 2019 17:25:18 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 FMSMSX114.amr.corp.intel.com ([169.254.6.54]) with mapi id 14.03.0415.000;
 Wed, 15 May 2019 17:25:18 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "cai@lca.pw" <cai@lca.pw>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
Thread-Topic: [RESEND PATCH] nvdimm: fix some compilation warnings
Thread-Index: AQHVCmbrIPMA4NdLGku6pgbfwA21dKZtS3IAgAAQxYA=
Date:   Thu, 16 May 2019 00:25:18 +0000
Message-ID: <7ba8164b60be4e41707559ed6623f9462c942735.camel@intel.com>
References: <20190514150735.39625-1-cai@lca.pw>
         <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
In-Reply-To: <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A65C713145B05845999BB3A6BC695874@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA1LTE1IGF0IDE2OjI1IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9idHQuYyBiL2RyaXZlcnMvbnZkaW1t
L2J0dC5jDQo+ID4gaW5kZXggNDY3MTc3NmY1NjIzLi45ZjAyYTk5Y2ZhYzAgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9udmRpbW0vYnR0LmMNCj4gPiArKysgYi9kcml2ZXJzL252ZGltbS9idHQu
Yw0KPiA+IEBAIC0xMjY5LDExICsxMjY5LDkgQEAgc3RhdGljIGludCBidHRfcmVhZF9wZyhzdHJ1
Y3QgYnR0ICpidHQsIHN0cnVjdCBiaW9faW50ZWdyaXR5X3BheWxvYWQgKmJpcCwNCj4gPiANCj4g
PiAgICAgICAgICAgICAgICAgcmV0ID0gYnR0X2RhdGFfcmVhZChhcmVuYSwgcGFnZSwgb2ZmLCBw
b3N0bWFwLCBjdXJfbGVuKTsNCj4gPiAgICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgIGludCByYzsNCj4gPiAtDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgICAgLyogTWVkaWEgZXJyb3IgLSBzZXQgdGhlIGVfZmxhZyAqLw0KPiA+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHJjID0gYnR0X21hcF93cml0ZShhcmVuYSwgcHJlbWFwLCBwb3N0bWFw
LCAwLCAxLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZESU1NX0lPX0FU
T01JQyk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYnR0X21hcF93cml0ZShhcmVuYSwg
cHJlbWFwLCBwb3N0bWFwLCAwLCAxLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTlZESU1NX0lPX0FUT01JQyk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
Z290byBvdXRfcnR0Ow0KPiANCj4gVGhpcyBkb2Vzbid0IGxvb2sgY29ycmVjdCB0byBtZSwgc2hv
dWxkbid0IHdlIGF0IGxlYXN0IGJlIGxvZ2dpbmcgdGhhdA0KPiB0aGUgYmFkLWJsb2NrIGZhaWxl
ZCB0byBiZSBwZXJzaXN0ZW50bHkgdHJhY2tlZD8NCg0KWWVzIGxvZ2dpbmcgaXQgc291bmRzIGdv
b2QgdG8gbWUuIFFpYW4sIGNhbiB5b3UgaW5jbHVkZSB0aGlzIGluIHlvdXINCnJlc3BpbiBvciBz
aGFsbCBJIHNlbmQgYSBmaXggZm9yIGl0IHNlcGFyYXRlbHkgKHNpbmNlIHdlIHdlcmUgYWx3YXlz
DQppZ25vcmluZyB0aGUgZmFpbHVyZSBoZXJlIHJlZ2FyZGxlc3Mgb2YgdGhpcyBwYXRjaCk/DQoN
Cg0K
