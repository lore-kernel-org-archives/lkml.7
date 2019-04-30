Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB88EC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B423E20854
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 17:50:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfD3Rux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 13:50:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:47539 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfD3Ruw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 13:50:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 10:50:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,414,1549958400"; 
   d="scan'208";a="135742996"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga007.jf.intel.com with ESMTP; 30 Apr 2019 10:50:50 -0700
Received: from fmsmsx117.amr.corp.intel.com (10.18.116.17) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 30 Apr 2019 10:50:49 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.30]) by
 fmsmsx117.amr.corp.intel.com ([169.254.3.26]) with mapi id 14.03.0415.000;
 Tue, 30 Apr 2019 10:50:49 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "cai@lca.pw" <cai@lca.pw>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH] nvdimm: fix some compilation warnings
Thread-Topic: [PATCH] nvdimm: fix some compilation warnings
Thread-Index: AQHU/KgTyngM3tWBWkiZUJMsjyMtS6ZVdoOA
Date:   Tue, 30 Apr 2019 17:50:48 +0000
Message-ID: <fe9727f12700816501d320111c585d23cef811f5.camel@intel.com>
References: <20190427031934.94947-1-cai@lca.pw>
In-Reply-To: <20190427031934.94947-1-cai@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE0AA2BD613A9E43856EE77AF17B93E3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDE5LTA0LTI2IGF0IDIzOjE5IC0wNDAwLCBRaWFuIENhaSB3cm90ZToNCj4gU2V2
ZXJhbCBwbGFjZXMgKGRpbW1fZGV2cy5jLCBjb3JlLmMgZXRjKSBpbmNsdWRlIGxhYmVsLmggYnV0
IG9ubHkNCj4gbGFiZWwuYyB1c2VzIE5TSU5ERVhfU0lHTkFUVVJFLCBzbyBtb3ZlIGl0cyBkZWZp
bml0aW9uIHRvIGxhYmVsLmMNCj4gaW5zdGVhZC4NCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGRy
aXZlcnMvbnZkaW1tL2RpbW1fZGV2cy5jOjIzOg0KPiBkcml2ZXJzL252ZGltbS9sYWJlbC5oOjQx
OjE5OiB3YXJuaW5nOiAnTlNJTkRFWF9TSUdOQVRVUkUnIGRlZmluZWQgYnV0DQo+IG5vdCB1c2Vk
IFstV3VudXNlZC1jb25zdC12YXJpYWJsZT1dDQo+IA0KPiBUaGUgY29tbWl0IGQ5YjgzYzc1Njk1
MyAoImxpYm52ZGltbSwgYnR0OiByZXdvcmsgZXJyb3IgY2xlYXJpbmciKSBsZWZ0DQo+IGFuIHVu
dXNlZCB2YXJpYWJsZS4NCj4gZHJpdmVycy9udmRpbW0vYnR0LmM6IEluIGZ1bmN0aW9uICdidHRf
cmVhZF9wZyc6DQo+IGRyaXZlcnMvbnZkaW1tL2J0dC5jOjEyNzI6ODogd2FybmluZzogdmFyaWFi
bGUgJ3JjJyBzZXQgYnV0IG5vdCB1c2VkDQo+IFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0K
PiANCj4gTGFzdCwgc29tZSBwbGFjZXMgYWJ1c2UgIi8qKiIgd2hpY2ggaXMgb25seSByZXNlcnZl
ZCBmb3IgdGhlIGtlcm5lbC1kb2MuDQo+IGRyaXZlcnMvbnZkaW1tL2J1cy5jOjY0ODogd2Fybmlu
ZzogY2Fubm90IHVuZGVyc3RhbmQgZnVuY3Rpb24gcHJvdG90eXBlOg0KPiAnc3RydWN0IGF0dHJp
YnV0ZV9ncm91cCBuZF9kZXZpY2VfYXR0cmlidXRlX2dyb3VwID0gJw0KPiBkcml2ZXJzL252ZGlt
bS9idXMuYzo2Nzc6IHdhcm5pbmc6IGNhbm5vdCB1bmRlcnN0YW5kIGZ1bmN0aW9uIHByb3RvdHlw
ZToNCj4gJ3N0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgbmRfbnVtYV9hdHRyaWJ1dGVfZ3JvdXAgPSAn
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBRaWFuIENhaSA8Y2FpQGxjYS5wdz4NCj4gLS0tDQo+ICBk
cml2ZXJzL252ZGltbS9idHQuYyAgIHwgNiArKy0tLS0NCj4gIGRyaXZlcnMvbnZkaW1tL2J1cy5j
ICAgfCA0ICsrLS0NCj4gIGRyaXZlcnMvbnZkaW1tL2xhYmVsLmMgfCAyICsrDQo+ICBkcml2ZXJz
L252ZGltbS9sYWJlbC5oIHwgMiAtLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pDQoNClRoZXNlIGxvb2sgZ29vZCB0byBtZSwNClJldmlld2VkLWJ5
OiBWaXNoYWwgVmVybWEgPHZpc2hhbC5sLnZlcm1hQGludGVsLmNvbT4NCg0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZkaW1tL2J0dC5jIGIvZHJpdmVycy9udmRpbW0vYnR0LmMNCj4gaW5k
ZXggNDY3MTc3NmY1NjIzLi45ZjAyYTk5Y2ZhYzAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZk
aW1tL2J0dC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL2J0dC5jDQo+IEBAIC0xMjY5LDExICsx
MjY5LDkgQEAgc3RhdGljIGludCBidHRfcmVhZF9wZyhzdHJ1Y3QgYnR0ICpidHQsIHN0cnVjdCBi
aW9faW50ZWdyaXR5X3BheWxvYWQgKmJpcCwNCj4gIA0KPiAgCQlyZXQgPSBidHRfZGF0YV9yZWFk
KGFyZW5hLCBwYWdlLCBvZmYsIHBvc3RtYXAsIGN1cl9sZW4pOw0KPiAgCQlpZiAocmV0KSB7DQo+
IC0JCQlpbnQgcmM7DQo+IC0NCj4gIAkJCS8qIE1lZGlhIGVycm9yIC0gc2V0IHRoZSBlX2ZsYWcg
Ki8NCj4gLQkJCXJjID0gYnR0X21hcF93cml0ZShhcmVuYSwgcHJlbWFwLCBwb3N0bWFwLCAwLCAx
LA0KPiAtCQkJCU5WRElNTV9JT19BVE9NSUMpOw0KPiArCQkJYnR0X21hcF93cml0ZShhcmVuYSwg
cHJlbWFwLCBwb3N0bWFwLCAwLCAxLA0KPiArCQkJCSAgICAgIE5WRElNTV9JT19BVE9NSUMpOw0K
PiAgCQkJZ290byBvdXRfcnR0Ow0KPiAgCQl9DQo+ICANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZkaW1tL2J1cy5jIGIvZHJpdmVycy9udmRpbW0vYnVzLmMNCj4gaW5kZXggN2ZmNjg0MTU5ZjI5
Li4yZWI2YTZjZmU5ZTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZkaW1tL2J1cy5jDQo+ICsr
KyBiL2RyaXZlcnMvbnZkaW1tL2J1cy5jDQo+IEBAIC02NDIsNyArNjQyLDcgQEAgc3RhdGljIHN0
cnVjdCBhdHRyaWJ1dGUgKm5kX2RldmljZV9hdHRyaWJ1dGVzW10gPSB7DQo+ICAJTlVMTCwNCj4g
IH07DQo+ICANCj4gLS8qKg0KPiArLyoNCj4gICAqIG5kX2RldmljZV9hdHRyaWJ1dGVfZ3JvdXAg
LSBnZW5lcmljIGF0dHJpYnV0ZXMgZm9yIGFsbCBkZXZpY2VzIG9uIGFuIG5kIGJ1cw0KPiAgICov
DQo+ICBzdHJ1Y3QgYXR0cmlidXRlX2dyb3VwIG5kX2RldmljZV9hdHRyaWJ1dGVfZ3JvdXAgPSB7
DQo+IEBAIC02NzEsNyArNjcxLDcgQEAgc3RhdGljIHVtb2RlX3QgbmRfbnVtYV9hdHRyX3Zpc2li
bGUoc3RydWN0IGtvYmplY3QgKmtvYmosIHN0cnVjdCBhdHRyaWJ1dGUgKmEsDQo+ICAJcmV0dXJu
IGEtPm1vZGU7DQo+ICB9DQo+ICANCj4gLS8qKg0KPiArLyoNCj4gICAqIG5kX251bWFfYXR0cmli
dXRlX2dyb3VwIC0gTlVNQSBhdHRyaWJ1dGVzIGZvciBhbGwgZGV2aWNlcyBvbiBhbiBuZCBidXMN
Cj4gICAqLw0KPiAgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCBuZF9udW1hX2F0dHJpYnV0ZV9ncm91
cCA9IHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZkaW1tL2xhYmVsLmMgYi9kcml2ZXJzL252
ZGltbS9sYWJlbC5jDQo+IGluZGV4IGYzZDc1M2QzMTY5Yy4uMDJhNTFiNzc3NWUxIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL252ZGltbS9sYWJlbC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL2xh
YmVsLmMNCj4gQEAgLTI1LDYgKzI1LDggQEAgc3RhdGljIGd1aWRfdCBudmRpbW1fYnR0Ml9ndWlk
Ow0KPiAgc3RhdGljIGd1aWRfdCBudmRpbW1fcGZuX2d1aWQ7DQo+ICBzdGF0aWMgZ3VpZF90IG52
ZGltbV9kYXhfZ3VpZDsNCj4gIA0KPiArc3RhdGljIGNvbnN0IGNoYXIgTlNJTkRFWF9TSUdOQVRV
UkVbXSA9ICJOQU1FU1BBQ0VfSU5ERVhcMCI7DQo+ICsNCj4gIHN0YXRpYyB1MzIgYmVzdF9zZXEo
dTMyIGEsIHUzMiBiKQ0KPiAgew0KPiAgCWEgJj0gTlNJTkRFWF9TRVFfTUFTSzsNCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZkaW1tL2xhYmVsLmggYi9kcml2ZXJzL252ZGltbS9sYWJlbC5oDQo+
IGluZGV4IGU5YTJhZDNjMjE1MC4uNGJiN2FkZDM5NTgwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L252ZGltbS9sYWJlbC5oDQo+ICsrKyBiL2RyaXZlcnMvbnZkaW1tL2xhYmVsLmgNCj4gQEAgLTM4
LDggKzM4LDYgQEAgZW51bSB7DQo+ICAJTkRfTlNJTkRFWF9JTklUID0gMHgxLA0KPiAgfTsNCj4g
IA0KPiAtc3RhdGljIGNvbnN0IGNoYXIgTlNJTkRFWF9TSUdOQVRVUkVbXSA9ICJOQU1FU1BBQ0Vf
SU5ERVhcMCI7DQo+IC0NCj4gIC8qKg0KPiAgICogc3RydWN0IG5kX25hbWVzcGFjZV9pbmRleCAt
IGxhYmVsIHNldCBzdXBlcmJsb2NrDQo+ICAgKiBAc2lnOiBOQU1FU1BBQ0VfSU5ERVhcMA0KDQo=
