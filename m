Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D676C4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E65206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 19:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfDYTTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:19:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:18820 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbfDYTTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 15:19:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Apr 2019 12:19:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,394,1549958400"; 
   d="scan'208";a="226718970"
Received: from orsmsx101.amr.corp.intel.com ([10.22.225.128])
  by orsmga001.jf.intel.com with ESMTP; 25 Apr 2019 12:19:15 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.109]) by
 ORSMSX101.amr.corp.intel.com ([169.254.8.212]) with mapi id 14.03.0415.000;
 Thu, 25 Apr 2019 12:19:15 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux_dti@icloud.com" <linux_dti@icloud.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
Subject: Re: [PATCH v4 19/23] x86/ftrace: Use vmalloc special flag
Thread-Topic: [PATCH v4 19/23] x86/ftrace: Use vmalloc special flag
Thread-Index: AQHU+T1q49bvmRxIpk2PRaAn55zB0aZNrBqAgAAONIA=
Date:   Thu, 25 Apr 2019 19:19:14 +0000
Message-ID: <e07ed452377e9c48fc50c08fc80b6893d2b26ead.camel@intel.com>
References: <20190422185805.1169-1-rick.p.edgecombe@intel.com>
         <20190422185805.1169-20-rick.p.edgecombe@intel.com>
         <20190425142803.4f2e354a@gandalf.local.home>
In-Reply-To: <20190425142803.4f2e354a@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B35D9A494A9B654C884ED7C35585F23C@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA0LTI1IGF0IDE0OjI4IC0wNDAwLCBTdGV2ZW4gUm9zdGVkdCB3cm90ZToN
Cj4gT24gTW9uLCAyMiBBcHIgMjAxOSAxMTo1ODowMSAtMDcwMA0KPiBSaWNrIEVkZ2Vjb21iZSA8
cmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gPiBVc2UgbmV3IGZsYWcg
Vk1fRkxVU0hfUkVTRVRfUEVSTVMgZm9yIGhhbmRsaW5nIGZyZWVpbmcgb2Ygc3BlY2lhbA0KPiA+
IHBlcm1pc3Npb25lZCBtZW1vcnkgaW4gdm1hbGxvYyBhbmQgcmVtb3ZlIHBsYWNlcyB3aGVyZSBt
ZW1vcnkgd2FzIHNldCBOWA0KPiA+IGFuZCBSVyBiZWZvcmUgZnJlZWluZyB3aGljaCBpcyBubyBs
b25nZXIgbmVlZGVkLg0KPiA+IA0KPiA+IENjOiBTdGV2ZW4gUm9zdGVkdCA8cm9zdGVkdEBnb29k
bWlzLm9yZz4NCj4gPiBBY2tlZC1ieTogU3RldmVuIFJvc3RlZHQgKFZNd2FyZSkgPHJvc3RlZHRA
Z29vZG1pcy5vcmc+DQo+ID4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPg0KPiANCj4gVGVzdGVkLWJ5OiBTdGV2ZW4gUm9zdGVkdCAoVk13
YXJlKSA8cm9zdGVkdEBnb29kbWlzLm9yZz4NCj4gQWNrZWQtYnk6IFN0ZXZlbiBSb3N0ZWR0IChW
TXdhcmUpIDxyb3N0ZWR0QGdvZG9taXMub3JnPg0KPiANCj4gLS0gU3RldmUNCg0KVGhhbmtzIQ0K
DQpSaWNrDQo=
