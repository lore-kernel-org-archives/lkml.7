Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30C1C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC8B821841
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfGXUmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:42:55 -0400
Received: from mga05.intel.com ([192.55.52.43]:45806 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728786AbfGXUmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:42:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2019 13:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,304,1559545200"; 
   d="scan'208";a="368913462"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2019 13:42:54 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 24 Jul 2019 13:42:54 -0700
Received: from fmsmsx116.amr.corp.intel.com ([169.254.2.137]) by
 FMSMSX151.amr.corp.intel.com ([169.254.7.106]) with mapi id 14.03.0439.000;
 Wed, 24 Jul 2019 13:42:54 -0700
From:   "Souza, Jose" <jose.souza@intel.com>
To:     "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Topic: [Intel-gfx] screen freeze with 5.2-rc6 Dell XPS-13 skylake i915
Thread-Index: AQHVN8s6u18XhfEo0kuWcj/kjNqW06bGT1sAgAAD6QCAAADBAIAAGPCAgAAIRACAAANRAIAABuIAgAAHAoCAAANkgIAA9aWAgAACeQCABSUwAIAACPCAgAE98wCAAeSegIAAAIsAgArdJICAABICAIAAA0IAgAAA6YA=
Date:   Wed, 24 Jul 2019 20:42:54 +0000
Message-ID: <b83d8df3aad1497293daede6a7dad287b20aefd8.camel@intel.com>
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
         <143142cad4a946361a0bf285b6f1701c81096c7b.camel@intel.com>
         <595d9bc87bf47717c8675eb5b1a1cbb2bc463752.camel@tiscali.nl>
         <a10f009fc160f05077760ff59cd86a9c99006b39.camel@intel.com>
         <9ef8fc1ae2c3a9bad588899488a781333af4449a.camel@tiscali.nl>
         <1563398966.3438.5.camel@HansenPartnership.com>
         <b22cf290b089cb1174ec0fdeb15bdf2e90bf51dc.camel@tiscali.nl>
         <d084df248afc1943e06c50d391a775d117064743.camel@intel.com>
         <df4d83e5c5650ea2f1afde1469c9dc82d6120644.camel@tiscali.nl>
In-Reply-To: <df4d83e5c5650ea2f1afde1469c9dc82d6120644.camel@tiscali.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.193.213]
Content-Type: text/plain; charset="utf-8"
Content-ID: <85D6645613CEB5489B55780E7C3317B1@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA3LTI0IGF0IDIyOjM5ICswMjAwLCBQYXVsIEJvbGxlIHdyb3RlOg0KPiBI
aSBKb3NlLA0KPiANCj4gU291emEsIEpvc2Ugc2NocmVlZiBvcCB3byAyNC0wNy0yMDE5IG9tIDIw
OjI3IFsrMDAwMF06DQo+ID4gV2UgZml4ZWQgdGhlIHBhdGNoIGluc3RlYWQgb2YgcmV2ZXJ0IGl0
LCBpdCBpcyBtZXJnZWQgb24gZHJtLXRpcA0KPiA+IGFuZCBvbg0KPiA+IGhpcyB3YXkgdG8gbGlu
dXgtc3RhYmxlLg0KPiANCj4gVGhhdCBzaG91bGQgYmUgKGRybS10aXApIGNvbW1pdCBiNWVhOWM5
MzM3MDAgKCJkcm0vaTkxNS92YnQ6IEZpeCBWQlQNCj4gcGFyc2luZw0KPiBmb3IgdGhlIFBTUiBz
ZWN0aW9uIikuIENvcnJlY3Q/DQoNCkV4YWN0bHkNCg0KPiANCj4gPiBIdWdlIHRoYW5rcyBhZ2Fp
bg0KPiANCj4gWW91J3JlIHdlbGNvbWUuDQo+IA0KPiANCj4gUGF1bCBCb2xsZQ0KPiANCg==
