Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE1BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6B720823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfCDUgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:36:40 -0500
Received: from mga06.intel.com ([134.134.136.31]:14352 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbfCDUgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:36:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2019 12:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,441,1544515200"; 
   d="scan'208";a="148528335"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga002.fm.intel.com with ESMTP; 04 Mar 2019 12:36:37 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 4 Mar 2019 12:36:37 -0800
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.220]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.137]) with mapi id 14.03.0415.000;
 Mon, 4 Mar 2019 12:36:37 -0800
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] libnvdimm/namespace: Clean up holder_class_store()
Thread-Topic: [PATCH] libnvdimm/namespace: Clean up holder_class_store()
Thread-Index: AQHU0sic3P6LyihHdE+rLyus8q2G8KX8dHQA
Date:   Mon, 4 Mar 2019 20:36:35 +0000
Message-ID: <a96203c060b8e7d589a251f53bec2cd0e57292d7.camel@intel.com>
References: <155173044436.4154095.17954771880753980013.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155173044436.4154095.17954771880753980013.stgit@dwillia2-desk3.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC28E659EF09A458B0AC603C40B4DBB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTA0IGF0IDEyOjE0IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IFVzZSBzeXNmc19zdHJlcSgpIGluIHBsYWNlIG9mIG9wZW4tY29kZWQgc3RyY21wKCkncyB0aGF0
IGNoZWNrIGZvciBhbg0KPiBvcHRpb25hbCAiXG4iIGF0IHRoZSBlbmQgb2YgdGhlIGlucHV0Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRGFuIFdpbGxpYW1zIDxkYW4uai53aWxsaWFtc0BpbnRlbC5j
b20+DQo+IC0tLQ0KPiAgZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYyB8ICAgIDggKysr
Ky0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0p
DQoNCkxvb2tzIGdvb2QsDQpSZXZpZXdlZC1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJt
YUBpbnRlbC5jb20+DQoNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252ZGltbS9uYW1lc3Bh
Y2VfZGV2cy5jDQo+IGIvZHJpdmVycy9udmRpbW0vbmFtZXNwYWNlX2RldnMuYw0KPiBpbmRleCAz
Njc3YjBjNGEzM2QuLjE3ZmI3ZjkzMWYwYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udmRpbW0v
bmFtZXNwYWNlX2RldnMuYw0KPiArKysgYi9kcml2ZXJzL252ZGltbS9uYW1lc3BhY2VfZGV2cy5j
DQo+IEBAIC0xNTA2LDEzICsxNTA2LDEzIEBAIHN0YXRpYyBzc2l6ZV90IF9faG9sZGVyX2NsYXNz
X3N0b3JlKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwgY29uc3QgY2hhciAqYnVmKQ0KPiAgCWlmIChk
ZXYtPmRyaXZlciB8fCBuZG5zLT5jbGFpbSkNCj4gIAkJcmV0dXJuIC1FQlVTWTsNCj4gIA0KPiAt
CWlmIChzdHJjbXAoYnVmLCAiYnR0IikgPT0gMCB8fCBzdHJjbXAoYnVmLCAiYnR0XG4iKSA9PSAw
KQ0KPiArCWlmIChzeXNmc19zdHJlcShidWYsICJidHQiKSkNCj4gIAkJbmRucy0+Y2xhaW1fY2xh
c3MgPSBidHRfY2xhaW1fY2xhc3MoZGV2KTsNCj4gLQllbHNlIGlmIChzdHJjbXAoYnVmLCAicGZu
IikgPT0gMCB8fCBzdHJjbXAoYnVmLCAicGZuXG4iKSA9PSAwKQ0KPiArCWVsc2UgaWYgKHN5c2Zz
X3N0cmVxKGJ1ZiwgInBmbiIpKQ0KPiAgCQluZG5zLT5jbGFpbV9jbGFzcyA9IE5WRElNTV9DQ0xB
U1NfUEZOOw0KPiAtCWVsc2UgaWYgKHN0cmNtcChidWYsICJkYXgiKSA9PSAwIHx8IHN0cmNtcChi
dWYsICJkYXhcbiIpID09IDApDQo+ICsJZWxzZSBpZiAoc3lzZnNfc3RyZXEoYnVmLCAiZGF4Iikp
DQo+ICAJCW5kbnMtPmNsYWltX2NsYXNzID0gTlZESU1NX0NDTEFTU19EQVg7DQo+IC0JZWxzZSBp
ZiAoc3RyY21wKGJ1ZiwgIiIpID09IDAgfHwgc3RyY21wKGJ1ZiwgIlxuIikgPT0gMCkNCj4gKwll
bHNlIGlmIChzeXNmc19zdHJlcShidWYsICIiKSkNCj4gIAkJbmRucy0+Y2xhaW1fY2xhc3MgPSBO
VkRJTU1fQ0NMQVNTX05PTkU7DQo+ICAJZWxzZQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gDQoN
Cg==
