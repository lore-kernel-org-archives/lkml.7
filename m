Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53139C5B57D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBA1218A4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 05:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725894AbfGEFJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 01:09:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:5457 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbfGEFJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 01:09:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jul 2019 22:09:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,453,1557212400"; 
   d="scan'208";a="172566750"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jul 2019 22:09:30 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 4 Jul 2019 22:09:30 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.118]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.94]) with mapi id 14.03.0439.000;
 Thu, 4 Jul 2019 22:09:30 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mroos@linux.ee" <mroos@linux.ee>,
        "linux-ia64@lists.kernel.org" <linux-ia64@lists.kernel.org>
CC:     "namit@vmware.com" <namit@vmware.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [bisected] "mm/vmalloc: Add flag for freeing of special
 permsissions" corrupts memory on ia64
Thread-Topic: [bisected] "mm/vmalloc: Add flag for freeing of special
 permsissions" corrupts memory on ia64
Thread-Index: AQHVMk6Qsqw8+54B1k+gLs9OsfAihaa78F8A
Date:   Fri, 5 Jul 2019 05:09:29 +0000
Message-ID: <096ddb2cfbe83309396c48e75648889cae68e672.camel@intel.com>
References: <daae57de-1eff-f34a-1348-b872c44a6b4c@linux.ee>
In-Reply-To: <daae57de-1eff-f34a-1348-b872c44a6b4c@linux.ee>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
x-originating-ip: [10.254.100.26]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA72A60DEA644D45945FEF66CCB3B920@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA3LTA0IGF0IDEyOjUzICswMzAwLCBNZWVsaXMgUm9vcyB3cm90ZToNCj4g
SSBub3RpY2VkIHRoYXQgd2hpbGUgNS4xIHdvcmtzIG9uIG15IEhQIEludGVncml0eSBSWDI2MjAs
IDUuMi1yYzYNCj4gY3Jhc2hlZCBvbiBib290IG5vbmRldGVybWluaXN0aWNhbGx5Lg0KPiBCaXNl
Y3RpbmcgaXQgdG9vayBtYW55IHRyaWVzIHNpY2UgaXQgZG9lcyBub3QgaGFwcGVuIG9uIGVhY2gg
Ym9vdCBhbmQNCj4gd2hlbiBpdCBoYXBwZXMsIHRoZSBzeW1wdG9tcyBhcmUNCj4gZGlmZmVyZW50
IGVhY2ggdGltZS4gQnV0IG5vdyB0aGUgYmlzZWN0aW9uIGNvbnZlcmdlZCB0bw0KDQpUaGFua3Mg
Zm9yIHRoZSByZXBvcnQuDQoNClRoaXMgYXJjaCBzZWVtcyBzaW1pbGFyIHRvIHNwYXJjIGluIHRo
YXQgdGhlcmUgYXJlIG5vIHNldF9tZW1vcnlfKCkNCmltcGxlbWVudGF0aW9ucywgZXhjZXB0IHRo
YXQgaXQncyBldmVuIHNpbXBsZXIgYmVjYXVzZQ0KZmx1c2hfdGxiX2tlcm5lbF9yYW5nZSgpIGp1
c3QgY2FsbHMgZmx1c2hfdGxiX2FsbCgpIHNvIHRoZSByYW5nZQ0Kc2hvdWxkbid0IG1hdHRlciBl
aXRoZXIuIFNvIHRoaXMgY29tbWl0ICpzaG91bGQqIGhhdmUganVzdCBiZWVuIGFkZGluZw0KYSBU
TEIgZmx1c2gsIHdpdGggbW9zdCBvZiBpdCBub3QgYWZmZWN0aW5nIGlhNjQuDQoNCkZyb20gdGhl
c2UgbG9ncywgZXNwZWNpYWxseSB0aGUgZmF1bHQgc3RhY2sgdHJhY2VzIGFuZCBCVUcoKSdzLCBp
dA0Kc2VlbXMgbGlrZSB0aGUgdm1hbGxvYyBtZW1vcnkgbWlnaHQgYmUgdGhlIGFsbG9jYXRpb25z
IGJlaW5nIGNvcnJ1cHRlZC4NCkFmdGVyIHNjcnV0aW5pemluZyB0aGlzIHNvIG11Y2ggZm9yIHNw
YXJjLCBvbmx5IHRvIGhhdmUgdGhlIGNhdXNlIGJlDQpzcGFyYydzIFRMQiBmbHVzaCBpbiB0aGUg
ZW5kLCBJIHdvbmRlciBpZiBzb21ldGhpbmcgc2ltaWxhciBjb3VsZCBiZQ0KaGFwcGVuaW5nIGhl
cmUuIElmIHRoZSBUTEIgd2Fzbid0IGdldHRpbmcgZmx1c2hlZCBvbiBhbGwgY29yZXMgb3IgaW4N
CnRoZSB2bWFsbG9jIHJhbmdlIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQsIHRoZSBtb2R1bGUgbG9h
ZGVyIG1heSBiZQ0KcmVhZGluZyBhbmQgd3JpdGluZyB0byBvbGQgZW50cmllcyBwb2ludGluZyB0
byByZS1jeWNsZWQgcGFnZXMgYW5kDQpjYXVzZSBzdHJhbmdlIGJlaGF2aW9yIGxpa2UgdGhpcy4N
Cg0KSSBhbSBvdXQgb2YgdGhlIG9mZmljZSBhbmQgZG9uJ3QgaGF2ZSBhY2Nlc3MgdG8gdGhpcyBo
YXJkd2FyZSBlaXRoZXIuIEkNCndpbGwgdHJ5IHRvIGZpbmQgc29tZW9uZSBhdCBJbnRlbCB0aGF0
IGRvZXMgdG8gc3BlZWQgdGhpcyB1cC4gSW4gdGhlDQptZWFudGltZSBJIGNhbiBzZW5kIHlvdSBh
IGxvZ2dpbmcgcGF0Y2ggdG8gZG8gc29tZSBzYW5pdHkgY2hlY2tzIGlmIHlvdQ0KYXJlIGFibGUg
dG8gcnVuIGl0Lg0KDQpJIHRoaW5rIEkgZm91bmQgeW91ciBlYXJsaWVyIG1haWwsIGFuZCBpdCBz
YWlkIDUuMi1yYzEgZGlkIG5vdCBzaG93IHRoZQ0KcHJvYmxlbS4gSSBndWVzcyB0aGlzIHdhc24n
dCB0aGUgY2FzZSBhZnRlciBmdXJ0aGVyIHRlc3RpbmcsIGJ1dCA1LjENCmNvbnRpbnVlZCB0byBi
ZSBwcm9ibGVtIGZyZWU/DQoNClRoYW5rcywNCg0KUmljaw0K
