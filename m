Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E83C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FD32064B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbfGOVDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:03:03 -0400
Received: from mga02.intel.com ([134.134.136.20]:27554 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729640AbfGOVDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:03:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jul 2019 14:03:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,494,1557212400"; 
   d="scan'208";a="318790562"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga004.jf.intel.com with ESMTP; 15 Jul 2019 14:03:02 -0700
Received: from FMSMSX110.amr.corp.intel.com (10.18.116.10) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jul 2019 14:03:01 -0700
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.206]) by
 FMSMSX110.amr.corp.intel.com ([169.254.14.234]) with mapi id 14.03.0439.000;
 Mon, 15 Jul 2019 14:03:01 -0700
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Topic: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Index: AQHVN8s6u18XhfEo0kuWcj/kjNqW06bGT1sAgAAD6QCAAADBAIAAGPCAgAAIRACAAANRAIAABuIAgAAHAoCAAANkgIAA9aWAgAACeQCABSUwAA==
Date:   Mon, 15 Jul 2019 21:03:01 +0000
Message-ID: <143142cad4a946361a0bf285b6f1701c81096c7b.camel@intel.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
         <1562876880.2840.12.camel@HansenPartnership.com>
         <1562882235.13723.1.camel@HansenPartnership.com>
         <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
         <1562884722.15001.3.camel@HansenPartnership.com>
         <2c4edfabf49998eb5da3a6adcabc006eb64bfe90.camel@tiscali.nl>
         <55f4d1c242d684ca2742e8c14613d810a9ee9504.camel@intel.com>
         <1562888433.2915.0.camel@HansenPartnership.com>
         <1562941185.3398.1.camel@HansenPartnership.com>
         <68472c5f390731e170221809a12d88cb3bc6460e.camel@tiscali.nl>
In-Reply-To: <68472c5f390731e170221809a12d88cb3bc6460e.camel@tiscali.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <C296A0199AAF954FAE17FBA411041854@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFtZXMgYW5kIFBhdWwNCg0KU28gdGhlIGlzc3VlIGRpZCBub3QgaGFwcGVuZWQgYWdhaW4g
d2l0aCB0aGUgcGF0Y2ggYXBwbGllZD8NCg0KSWYgeW91IHN0aWxsIGhhdmUgdGhlIGtlcm5lbCA1
LjEgaW5zdGFsbGVkIGNvdWxkIHlvdSBzaGFyZSB5b3VyDQovc3lzL2tlcm5lbC9kZWJ1Zy9kcmkv
MC9pOTE1X2VkcF9wc3Jfc3RhdHVzIHdpdGggdGhlIG9sZGVyIGtlcm5lbD8NCldlIHdhbnQgdG8g
Y2hlY2sgaWYgdHJhaW5pbmcgdmFsdWVzIGNoYW5nZWQgYmV0d2VlbiBrZXJuZWwgdmVyc2lvbnMu
DQoNCk9uIEZyaSwgMjAxOS0wNy0xMiBhdCAxNjoyOCArMDIwMCwgUGF1bCBCb2xsZSB3cm90ZToN
Cj4gSmFtZXMgQm90dG9tbGV5IHNjaHJlZWYgb3AgdnIgMTItMDctMjAxOSBvbSAwNzoxOSBbLTA3
MDBdOg0KPiA+IEl0IGhhcyBzdXJ2aXZlZCA2aCB3aXRob3V0IG1hbmlmZXN0aW5nIHRoZSByZWdy
ZXNzaW9uLiAgU3RhcnRpbmcNCj4gPiBhZ2Fpbg0KPiA+IHRvIHRyeSBhIHdob2xlIGRheS4NCj4g
DQo+IEFuZCBJJ20gY3VycmVudGx5IGF0IGZvdXIgaG91cnMgd2l0aG91dCBhIHNjcmVlbiBmcmVl
emUuIFdoaWNoIGlzDQo+IG11Y2gsIG11Y2gNCj4gbG9uZ2VyIHRoYW4gSSB3YXMgYWJsZSB0byBh
Y2hpZXZlIHdpdGhvdXQgdGhlIGhhY2sgYXBwbGllZC4NCj4gDQo+IA0KPiBQYXVsIEJvbGxlDQo+
IA0K
