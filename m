Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3FBC742A1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 214D621019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 22:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbfGKW0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 18:26:53 -0400
Received: from mga05.intel.com ([192.55.52.43]:42749 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfGKW0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 18:26:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 15:26:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="317815388"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 11 Jul 2019 15:26:52 -0700
Received: from fmsmsx117.amr.corp.intel.com ([169.254.3.206]) by
 FMSMSX108.amr.corp.intel.com ([169.254.9.235]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 15:26:52 -0700
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Topic: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Index: AQHVN8s6u18XhfEo0kuWcj/kjNqW06bGT1sAgAAD6QCAAADBAIAAGPCAgAAIRAA=
Date:   Thu, 11 Jul 2019 22:26:50 +0000
Message-ID: <dad073fb4b06cf0abb7ab702a9474b9c443186eb.camel@intel.com>
References: <1561834612.3071.6.camel@HansenPartnership.com>
         <156283735757.12757.8954391372130933707@skylake-alporthouse-com>
         <1562875878.2840.0.camel@HansenPartnership.com>
         <27a5b2ca8cfc79bf617387a363ea7192acc4e1f0.camel@intel.com>
         <1562876880.2840.12.camel@HansenPartnership.com>
         <1562882235.13723.1.camel@HansenPartnership.com>
In-Reply-To: <1562882235.13723.1.camel@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.24.9.133]
Content-Type: text/plain; charset="utf-8"
Content-ID: <19D31CD4DB5B1444B4B3CA7D1E2267A9@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA3LTExIGF0IDE0OjU3IC0wNzAwLCBKYW1lcyBCb3R0b21sZXkgd3JvdGU6
DQo+IE9uIFRodSwgMjAxOS0wNy0xMSBhdCAxMzoyOCAtMDcwMCwgSmFtZXMgQm90dG9tbGV5IHdy
b3RlOg0KPiA+IEkndmUgYWxzbyB1cGRhdGVkIHRvIHRoZSByZWxlYXNlZCA1LjIga2VybmVsIGFu
ZCBhbSBydW5uaW5nIHdpdGgNCj4gPiB0aGUNCj4gPiBkZWJ1ZyBwYXJhbWV0ZXJzIHlvdSByZXF1
ZXN0ZWQgLi4uIGJ1dCBzbyBmYXIgbm8gcmVwcm9kdWN0aW9uLg0KPiANCj4gT0ssIGl0J3MgaGFw
cGVuZWQuICBJJ3ZlIGF0dGFjaGVkIHRoZSBkbWVzZyAoaXQncyA0TUIgdW5jb21wcmVzc2VkKS4g
DQo+IElzIHRoZXJlIGFueSBvdGhlciBvdXRwdXQgeW91J2QgbGlrZSBmcm9tIHRoZSBtYWNoaW5l
PyAgSSd2ZSBnb3QgYW4NCj4gc3NoDQo+IHNlc3Npb24gaW50byBpdCBzbyBJIGNhbiB0cnkgYW55
dGhpbmcuDQoNClRoYW5rcywgY291bGQgeW91IGFsc28gc2hhcmUgdGhlIG91dHB1dCBvZiB0aGlz
IGFmdGVyIHRoZSBzY3JlZW4NCmZyZWV6ZT8NCg0KL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvaTkx
NV9lZHBfcHNyX3N0YXR1cw0KL3N5cy9rZXJuZWwvZGVidWcvZHJpLzAvaTkxNV9kaXNwbGF5X2lu
Zm8NCi9zeXMva2VybmVsL2RlYnVnL2RyaS8wL2k5MTVfZG1jX2luZm8NCi9zeXMva2VybmVsL2Rl
YnVnL3BtY19jb3JlL3BhY2thZ2VfY3N0YXRlX3Nob3cNCg0KSXQgZXZlbnR1YWxseSBjb21lcyBi
YWNrIGZyb20gc2NyZWVuIGZyZWV6ZT8gTGlrZSBtb3ZpbmcgdGhlIG1vdXNlIG9yDQp0eXBpbmcg
YnJpbmdzIGl0IGJhY2s/DQoNCj4gDQo+IEphbWVzDQo=
