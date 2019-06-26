Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB4C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC9E20665
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFZVnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:43:45 -0400
Received: from mga05.intel.com ([192.55.52.43]:34293 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfFZVnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:43:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 14:43:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,421,1557212400"; 
   d="scan'208";a="185018772"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2019 14:43:45 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 26 Jun 2019 14:43:44 -0700
Received: from fmsmsx113.amr.corp.intel.com ([169.254.13.157]) by
 FMSMSX153.amr.corp.intel.com ([169.254.9.55]) with mapi id 14.03.0439.000;
 Wed, 26 Jun 2019 14:43:44 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "cai@lca.pw" <cai@lca.pw>,
        "Williams, Dan J" <dan.j.williams@intel.com>
CC:     "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [RESEND PATCH] nvdimm: fix some compilation warnings
Thread-Topic: [RESEND PATCH] nvdimm: fix some compilation warnings
Thread-Index: AQHVCmbrIPMA4NdLGku6pgbfwA21dKZtS3IAgAAQxYCAAABlAIAAALUAgEHHlwCAAAwVgA==
Date:   Wed, 26 Jun 2019 21:43:43 +0000
Message-ID: <b56d99494ce47a4d4359edce8c9c96443d618cf1.camel@intel.com>
References: <20190514150735.39625-1-cai@lca.pw>
         <CAPcyv4gGwyPf0j4rXRM3JjsjGSHB6bGdZfwg+v2y8NQ6hNVK8g@mail.gmail.com>
         <7ba8164b60be4e41707559ed6623f9462c942735.camel@intel.com>
         <CAPcyv4gLr_WrNOg58C5tfpZTp2wso1C=kHGDkMvH4+sGniLQMQ@mail.gmail.com>
         <cd6db786ff5758914c77add4d7a9391886038c84.camel@intel.com>
         <1561582828.5154.83.camel@lca.pw>
In-Reply-To: <1561582828.5154.83.camel@lca.pw>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.185]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5EBE85328DA1AA43A3923046448A4135@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBXZWQsIDIwMTktMDYtMjYgYXQgMTc6MDAgLTA0MDAsIFFpYW4gQ2FpIHdyb3RlOg0KPiAN
Cj4gVmVybWEsIGFyZSB5b3Ugc3RpbGwgd29ya2luZyBvbiB0aGlzPyBJIGNhbiBzdGlsbCBzZWUg
dGhpcyB3YXJuaW5nIGluIHRoZSBsYXRlc3QNCj4gbGludXgtbmV4dC4NCj4gDQo+IGRyaXZlcnMv
bnZkaW1tL2J0dC5jOiBJbiBmdW5jdGlvbiAnYnR0X3JlYWRfcGcnOg0KPiBkcml2ZXJzL252ZGlt
bS9idHQuYzoxMjcyOjg6IHdhcm5pbmc6IHZhcmlhYmxlICdyYycgc2V0IGJ1dCBub3QgdXNlZA0K
PiBbLVd1bnVzZWQtYnV0LXNldC12YXJpYWJsZV0NCj4gDQpTb3JyeSwgdGhpcyBmZWxsIG9mZiB0
aGUgbGlzdC4gSSdsbCB0YWtlIGEgbG9vayBzb29uLCBidXQgaW4gdGhlDQptZWFud2hpbGUsIGlm
IGEgcGF0Y2ggd2VyZSB0byBhcHBlYXIsIEknZCBiZSBoYXBweSB0byByZXZpZXcgaXQgOikgDQoo
aS5lLiBmZWVsIGZyZWUgdG8gdGFrZSBhIHNob3QgYXQgaXQpLg0KDQpUaGFua3MsDQotVmlzaGFs
DQo=
