Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A71ECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8F821835
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440574AbfJQRHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:07:31 -0400
Received: from mga12.intel.com ([192.55.52.136]:11460 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728639AbfJQRHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:07:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2019 10:07:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,308,1566889200"; 
   d="scan'208";a="195221751"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga008.fm.intel.com with ESMTP; 17 Oct 2019 10:07:30 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 17 Oct 2019 10:07:30 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX110.amr.corp.intel.com ([169.254.14.36]) with mapi id 14.03.0439.000;
 Thu, 17 Oct 2019 10:07:30 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "david@redhat.com" <david@redhat.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [RFC] Memory Tiering
Thread-Topic: [RFC] Memory Tiering
Thread-Index: AQHVhF0fDgxP0x3sFEuPa5YVlQuRsKde8FuAgABnXoCAAC+cgA==
Date:   Thu, 17 Oct 2019 17:07:29 +0000
Message-ID: <655c9d239ee1be425571aa1d71c681314e20984a.camel@intel.com>
References: <c3d6de4d-f7c3-b505-2e64-8ee5f70b2118@intel.com>
         <0679872d-3d03-2fa3-5bd2-80f694357203@redhat.com>
         <2e193c88-f247-4c8f-f61c-c9b28303d62f@intel.com>
In-Reply-To: <2e193c88-f247-4c8f-f61c-c9b28303d62f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6406BF28AD4F0945A479302A6CCA1CAF@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBUaHUsIDIwMTktMTAtMTcgYXQgMDc6MTcgLTA3MDAsIERhdmUgSGFuc2VuIHdyb3RlOg0K
PiBPbiAxMC8xNy8xOSAxOjA3IEFNLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToNCj4gPiBWZXJ5
IGludGVyZXN0aW5nIHRvcGljLiBJIGhlYXJkIHNpbWlsYXIgZGVtYW5kIGZyb20gSFBDIGZvbGtz
IA0KPiA+IChlc3BlY2lhbGx5IGludm9sdmluZyBvdGhlciBtZW1vcnkgdHlwZXMgKCJ0aWVycyIp
KS4gVGhlcmUsIEkgdGhpbmsNCj4gPiB5b3Ugb2Z0ZW4gd2FudCB0byBsZXQgdGhlIGFwcGxpY2F0
aW9uIG1hbmFnZSB0aGF0LiBCdXQgb2YgY291cnNlLCBmb3INCj4gPiBtYW55IGFwcGxpY2F0aW9u
cyBhbiBhdXRvbWF0aWMgbWFuYWdlbWVudCBtaWdodCBhbHJlYWR5IGJlDQo+ID4gYmVuZWZpY2lh
bC4NCj4gPiANCj4gPiBBbSBJIGNvcnJlY3QgdGhhdCB5b3UgYXJlIHVzaW5nIFBNRU0gaW4gdGhp
cyBhcmVhIGFsb25nIHdpdGgNCj4gPiBaT05FX0RFVklDRSBhbmQgbm90IGJ5IGdpdmluZyBQTUVN
IHRvIHRoZSBidWRkeSAoYWRkX21lbW9yeSgpKT8NCj4gDQo+IFRoZSBQTUVNIHN0YXJ0cyBvdXQg
YXMgWk9ORV9ERVZJQ0UsIGJ1dCB3ZSB1bmJpbmQgaXQgZnJvbSBpdHMgb3JpZ2luYWwNCj4gZHJp
dmVyIGFuZCBiaW5kIGl0IHRvIHRoaXMgc3R1YiBvZiBhICJkcml2ZXIiOiBkcml2ZXJzL2RheC9r
bWVtLmMgd2hpY2gNCj4gdXNlcyBhZGRfbWVtb3J5KCkgb24gaXQuDQo+IA0KPiBUaGVyZSdzIHNv
bWUgbmljZSB0b29saW5nIGluc2lkZSB0aGUgZGF4Y3RsIGNvbXBvbmVudCBvZiBuZGN0bCB0byBk
byBhbGwNCj4gdGhlIHN5c2ZzIG1hZ2ljIHRvIG1ha2UgdGhpcyBoYXBwZW4uDQo+IA0KSGVyZSBp
cyBtb3JlIGluZm8gYWJvdXQgdGhlIGRheGN0bCBjb21tYW5kIGluIHF1ZXN0aW9uOg0KDQpodHRw
czovL3BtZW0uaW8vbmRjdGwvZGF4Y3RsLXJlY29uZmlndXJlLWRldmljZS5odG1sDQo=
