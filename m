Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312CEC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB6821479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 23:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfETXqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 19:46:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:15738 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfETXqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 19:46:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 16:46:22 -0700
X-ExtLoop1: 1
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga007.jf.intel.com with ESMTP; 20 May 2019 16:46:22 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 20 May 2019 16:46:21 -0700
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.79]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.142]) with mapi id 14.03.0415.000;
 Mon, 20 May 2019 16:46:21 -0700
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "luto@amacapital.net" <luto@amacapital.net>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "namit@vmware.com" <namit@vmware.com>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH v2 0/2] Fix issues with vmalloc flush flag
Thread-Topic: [PATCH v2 0/2] Fix issues with vmalloc flush flag
Thread-Index: AQHVD2U2cXoGKMM3a0GhDqndH7zde6Z1IwAA
Date:   Mon, 20 May 2019 23:46:21 +0000
Message-ID: <d92aa15b453b2a53bcd0bbaa8f35e8151eaae17b.camel@intel.com>
References: <20190520233841.17194-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20190520233841.17194-1-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
x-originating-ip: [10.254.114.95]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C4DD1DA9B51AB45870C0B33D125E8DB@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTA1LTIwIGF0IDE2OjM4IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gVGhlc2UgdHdvIHBhdGNoZXMgYWRkcmVzcyBpc3N1ZXMgd2l0aCB0aGUgcmVjZW50bHkgYWRk
ZWQNCj4gVk1fRkxVU0hfUkVTRVRfUEVSTVMgdm1hbGxvYyBmbGFnLiBJdCBpcyBub3cgc3BsaXQg
aW50byB0d28gcGF0Y2hlcywNCj4gd2hpY2gNCj4gbWFkZSBzZW5zZSB0byBtZSwgYnV0IGNhbiBz
cGxpdCBpdCBmdXJ0aGVyIGlmIGRlc2lyZWQuDQo+IA0KT29wcywgdGhpcyB3YXMgc3VwcG9zZWQg
dG8gc2F5IFBBVENIIHYzLiBMZXQgbWUga25vdyBpZiBJIHNob3VsZA0KcmVzZW5kLg0K
