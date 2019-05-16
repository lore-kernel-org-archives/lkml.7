Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C20C2C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3BD20873
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfEPBqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:46:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:60718 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfEPA3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 20:29:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 17:29:15 -0700
X-ExtLoop1: 1
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga007.fm.intel.com with ESMTP; 15 May 2019 17:29:16 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 15 May 2019 17:29:15 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.118]) by
 FMSMSX110.amr.corp.intel.com ([169.254.14.250]) with mapi id 14.03.0415.000;
 Wed, 15 May 2019 17:29:15 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "cai@lca.pw" <cai@lca.pw>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
Thread-Topic: [RESEND PATCH] nvdimm: fix some compilation warnings
Thread-Index: AQHVCmbrIPMA4NdLGku6pgbfwA21dKZtS3IAgAAQxYCAAABlAIAAALUA
Date:   Thu, 16 May 2019 00:29:15 +0000
Message-ID: <cd6db786ff5758914c77add4d7a9391886038c84.camel@intel.com>
References: <20190514150735.39625-1-cai@lca.pw>
         <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
         <7ba8164b60be4e41707559ed6623f9462c942735.camel@intel.com>
         <CAPcyv4gLr_WrNOg58C5tfpZTp2wso1C=kHGDkMvH4+sGniLQMQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gLr_WrNOg58C5tfpZTp2wso1C=kHGDkMvH4+sGniLQMQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A3A42854626C34E9EAD584400932357@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMTktMDUtMTUgYXQgMTc6MjYgLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gT24gV2VkLCBNYXkgMTUsIDIwMTkgYXQgNToyNSBQTSBWZXJtYSwgVmlzaGFsIEwNCj4gPHZp
c2hhbC5sLnZlcm1hQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gT24gV2VkLCAyMDE5LTA1LTE1IGF0
IDE2OjI1IC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252ZGltbS9idHQuYyBiL2RyaXZlcnMvbnZkaW1tL2J0dC5jDQo+ID4gPiA+IGluZGV4
IDQ2NzE3NzZmNTYyMy4uOWYwMmE5OWNmYWMwIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJz
L252ZGltbS9idHQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL252ZGltbS9idHQuYw0KPiA+ID4g
PiBAQCAtMTI2OSwxMSArMTI2OSw5IEBAIHN0YXRpYyBpbnQgYnR0X3JlYWRfcGcoc3RydWN0IGJ0
dCAqYnR0LA0KPiA+ID4gPiBzdHJ1Y3QgYmlvX2ludGVncml0eV9wYXlsb2FkICpiaXAsDQo+ID4g
PiA+IA0KPiA+ID4gPiAgICAgICAgICAgICAgICAgcmV0ID0gYnR0X2RhdGFfcmVhZChhcmVuYSwg
cGFnZSwgb2ZmLCBwb3N0bWFwLA0KPiA+ID4gPiBjdXJfbGVuKTsNCj4gPiA+ID4gICAgICAgICAg
ICAgICAgIGlmIChyZXQpIHsNCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgaW50IHJj
Ow0KPiA+ID4gPiAtDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIC8qIE1lZGlhIGVy
cm9yIC0gc2V0IHRoZSBlX2ZsYWcgKi8NCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAg
cmMgPSBidHRfbWFwX3dyaXRlKGFyZW5hLCBwcmVtYXAsDQo+ID4gPiA+IHBvc3RtYXAsIDAsIDEs
DQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlZESU1NX0lPX0FUT01J
Qyk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ0dF9tYXBfd3JpdGUoYXJlbmEs
IHByZW1hcCwgcG9zdG1hcCwgMCwNCj4gPiA+ID4gMSwNCj4gPiA+ID4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBOVkRJTU1fSU9fQVRPTUlDKTsNCj4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBvdXRfcnR0Ow0KPiA+ID4gDQo+ID4gPiBUaGlzIGRvZXNu
J3QgbG9vayBjb3JyZWN0IHRvIG1lLCBzaG91bGRuJ3Qgd2UgYXQgbGVhc3QgYmUgbG9nZ2luZw0K
PiA+ID4gdGhhdA0KPiA+ID4gdGhlIGJhZC1ibG9jayBmYWlsZWQgdG8gYmUgcGVyc2lzdGVudGx5
IHRyYWNrZWQ/DQo+ID4gDQo+ID4gWWVzIGxvZ2dpbmcgaXQgc291bmRzIGdvb2QgdG8gbWUuIFFp
YW4sIGNhbiB5b3UgaW5jbHVkZSB0aGlzIGluIHlvdXINCj4gPiByZXNwaW4gb3Igc2hhbGwgSSBz
ZW5kIGEgZml4IGZvciBpdCBzZXBhcmF0ZWx5IChzaW5jZSB3ZSB3ZXJlIGFsd2F5cw0KPiA+IGln
bm9yaW5nIHRoZSBmYWlsdXJlIGhlcmUgcmVnYXJkbGVzcyBvZiB0aGlzIHBhdGNoKT8NCj4gDQo+
IEkgdGhpbmsgYSBzZXBhcmF0ZSBmaXggZm9yIHRoaXMgbWFrZXMgbW9yZSBzZW5zZS4gTGlrZWx5
IGFsc28gbmVlZHMgdG8NCj4gYmUgYSByYXRlbGltaXRlZCBtZXNzYWdlIGluIGNhc2UgYSBzdG9y
bSBvZiBlcnJvcnMgaXMgZW5jb3VudGVyZWQuDQoNClllcyBnb29kIHBvaW50IG9uIHJhdGUgbGlt
aXRpbmcgLSBJIHdhcyB0aGlua2luZyBXQVJOX09OQ0UgYnV0IHRoYXQNCm1pZ2h0IG1hc2sgZXJy
b3JzIGZvciBkaXN0aW5jdCBibG9ja3MsIGJ1dCBhIHJhdGUgbGltaXRlZCBwcmludGsgc2hvdWxk
DQp3b3JrIGJlc3QuIEknbGwgcHJlcGFyZSBhIHBhdGNoLg0KDQo=
