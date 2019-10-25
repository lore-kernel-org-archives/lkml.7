Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56EACA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A912120650
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 22:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfJYW4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 18:56:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:63698 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725881AbfJYW4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 18:56:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 15:56:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; 
   d="scan'208";a="192681144"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 25 Oct 2019 15:56:41 -0700
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.30]) by
 FMSMSX103.amr.corp.intel.com ([169.254.2.173]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 15:56:41 -0700
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Phillips, D Scott" <d.scott.phillips@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "jerry.hoemann@hpe.com" <jerry.hoemann@hpe.com>,
        "toshi.kani@hpe.com" <toshi.kani@hpe.com>,
        "stuart.w.hayes@gmail.com" <stuart.w.hayes@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Thread-Topic: [PATCH] uapi: Add the BSD-2-Clause license to ndctl.h
Thread-Index: AQHVi11zx/Vg7UPM5E6mX4rKODcEtqdsam+AgAADGwA=
Date:   Fri, 25 Oct 2019 22:56:40 +0000
Message-ID: <38f7f4852ad1cc76c7c7473a6fda85cb9acae14c.camel@intel.com>
References: <20191025175553.63271-1-d.scott.phillips@intel.com>
         <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
In-Reply-To: <CAPcyv4iQpO+JF8b7NUJUZ3fQFU=PWFeiWrXSd47QGnQPeRsrTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.5 (3.30.5-1.fc29) 
x-originating-ip: [10.232.112.164]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF2368668D1A8B41AFDAAD42333BA373@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBGcmksIDIwMTktMTAtMjUgYXQgMTU6NDUgLTA3MDAsIERhbiBXaWxsaWFtcyB3cm90ZToN
Cj4gT24gRnJpLCBPY3QgMjUsIDIwMTkgYXQgMTA6NTUgQU0gRCBTY290dCBQaGlsbGlwcw0KPiA8
ZC5zY290dC5waGlsbGlwc0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+IEFsbG93IG5kY3RsLmggdG8g
YmUgbGljZW5zZWQgd2l0aCBCU0QtMi1DbGF1c2Ugc28gdGhhdCBvdGhlcg0KPiA+IG9wZXJhdGlu
ZyBzeXN0ZW1zIGNhbiBwcm92aWRlIHRoZSBzYW1lIHVzZXIgbGV2ZWwgaW50ZXJmYWNlLg0KPiA+
IC0tLQ0KPiA+IA0KPiA+IEkndmUgYmVlbiB3b3JraW5nIG9uIG52ZGltbSBzdXBwb3J0IGluIEZy
ZWVCU0QgYW5kIHdvdWxkIGxpa2UgdG8NCj4gPiBvZmZlciB0aGUgc2FtZSBuZGN0bCBBUEkgdGhl
cmUgdG8gZWFzZSBwb3J0aW5nIG9mIGFwcGxpY2F0aW9uDQo+ID4gY29kZS4gSGVyZSBJJ20gcHJv
cG9zaW5nIHRvIGFkZCB0aGUgQlNELTItQ2xhdXNlIGxpY2Vuc2UgdG8gdGhpcw0KPiA+IGhlYWRl
ciBmaWxlLCBzbyB0aGF0IGl0IGNhbiBsYXRlciBiZSBjb3BpZWQgaW50byBGcmVlQlNELg0KPiA+
IA0KPiA+IEkgYmVsaWV2ZSB0aGF0IGFsbCB0aGUgYXV0aG9ycyBvZiBjaGFuZ2VzIHRvIHRoaXMg
ZmlsZSAoaW4gdGhlIFRvOg0KPiA+IGxpc3QpIHdvdWxkIG5lZWQgdG8gYWdyZWUgdG8gdGhpcyBj
aGFuZ2UgYmVmb3JlIGl0IGNvdWxkIGJlDQo+ID4gYWNjZXB0ZWQsIHNvIGFueSBzaWduZWQtb2Zm
LWJ5IGlzIGludGVudGlvbmFsbHkgb21taXRlZCBmb3Igbm93Lg0KPiA+IFRoYW5rcywNCj4gDQo+
IEkgaGF2ZSBubyBwcm9ibGVtIHdpdGggdGhpcyBjaGFuZ2UsIGJ1dCBsZXQncyB0YWtlIHRoZSBv
cHBvcnR1bml0eSB0bw0KPiBsZXQgU1BEWCBkbyBpdHMgam9iIGFuZCBkcm9wIHRoZSBmdWxsIGxp
Y2Vuc2UgdGV4dC4NCg0KVGhpcyBpcyBmaW5lIGJ5IG1lIHRvbywgYmFycmluZyB0aGUgZnVsbCBs
aWNlbnNlIHRleHQgdnMuIFNQRFggY2F2ZWF0DQpEYW4gbWVudGlvbnMuDQo=
