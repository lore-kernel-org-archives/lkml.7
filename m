Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED4C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE80520692
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 18:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfLHSkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 13:40:02 -0500
Received: from mail1.med.uni-goettingen.de ([134.76.103.230]:44884 "EHLO
        mail1.med.uni-goettingen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726474AbfLHSkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 13:40:02 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Dec 2019 13:40:01 EST
Received: from umg-exc-3.ads.local.med.uni-goettingen.de ([10.76.100.70]:64492)
        by mail1.med.uni-goettingen.de with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <Martin.Uecker@med.uni-goettingen.de>)
        id 1ie1OE-0003Th-2K
        for linux-kernel@vger.kernel.org; Sun, 08 Dec 2019 19:34:42 +0100
Received: from UMG-EXC-1.ads.local.med.uni-goettingen.de
 ([fe80::c97f:60fd:6a2d:e4b9]) by umg-exc-3.ads.local.med.uni-goettingen.de
 ([fe80::f513:fb91:9f16:b175%13]) with mapi id 14.03.0439.000; Sun, 8 Dec 2019
 19:34:42 +0100
From:   "Uecker, Martin" <Martin.Uecker@med.uni-goettingen.de>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Needed: kernel API for requesting/caching of file hashes
Thread-Topic: Needed: kernel API for requesting/caching of file hashes
Thread-Index: AQHVrfYn1GLEi6fTF0i+QrvLrotgZQ==
Date:   Sun, 8 Dec 2019 18:34:41 +0000
Message-ID: <1575830081.11636.17.camel@med.uni-goettingen.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [134.76.125.20]
Content-Type: text/plain; charset="utf-8"
Content-ID: <94D23A23225ECA4296320492AFFBC834@ads.local.med.uni-goettingen.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBhbGwsDQoNCmhlcmUgaXMgYW4gcHJvcG9zYWwgZm9yIGEgbmV3IEFQSS4gVW5mb3J0dW5h
dGVseSwNCkkgbmV2ZXIgZm91bmQgdGltZSB0byB3b3JrIG9uIGEga2VybmVsIGltcGxlbWVudGF0
aW9uLA0Kc28gSSB0aG91Z2h0IEkganVzdCB0aHJvdyBpdCBvdXQuIEluIG15IG9waW5pb24sDQpp
dCBjb3VsZCBiZSB2ZXJ5IHVzZWZ1bCBmb3IgYSB2YXJpZXR5IG9mIGFwcGxpY2F0aW9ucy4NCg0K
DQpUaGUgbmV3IEFQSSB3b3VsZCBhbGxvdyB0byByZXF1ZXN0IHRoZSBoYXNoIG9mIGENCmZpbGUg
ZnJvbSB0aGUga2VybmVsIHdpdGggdGhlIGtlcm5lbCBnaXZpbmcgYQ0KZ3VhcmFudGVlIHRoYXQg
dGhlIGhhc2ggaXMgdXAtdG8tZGF0ZSBhbmQNCmNvcnJlY3QuDQoNClJlcXVlc3RpbmcgYSBoYXNo
IHRoZSBmaXJzdCB0aW1lIHdvdWxkDQp0cmlnZ2VyIHRoZSBjb21wdXRhdGlvbiBvZiB0aGUgaGFz
aC4gSWYgdGhlIGZpbGUNCmlzIG1vZGlmaWVkIGR1cmluZyB0aGUgY29tcHV0YXRpb24sIHRoaXMg
cHJvY2Vzcw0KaXMgYWJvcnRlZCBhbmQgYW4gZXJyb3IgaXMgcmV0dXJuZWQgKGFuZCBtYXliZQ0K
YWxyZWFkeSB3aGVuIGEgd3JpdGFibGUgbWFwcGluZyBpcyBjcmVhdGVkKS4NClRoZSBoYXNoIGlz
IHRoZW4gY2FjaGVkIGJ5IHRoZSBrZXJuZWwgYW5kL29ywqANCnRoZSBmaWxlIHN5c3RlbSBpbiBh
IHByb3RlY3RlZCBhdHRyaWJ1dGUgKGkuZS4NCm5vdCBtb2RpZmlhYmxlIGJ5IG5vbi1wcml2aWxl
Z2VkIHVzZXJzKS4NCklmIHRoZSBoYXNoIGlzIHJlcXVlc3RlZCBhZ2FpbiwgdGhlIGNhY2hlZCBo
YXNoDQppcyByZXR1cm5lZCBidXQgb25seSBpZiB0aGUgZmlsZSBoYXNuJ3QgY2hhbmdlZCBpbg0K
dGhlIG1lYW50aW1lLiBUaGVyZSBuZWVkIHRvIGJlIG9wdGlvbnMgdG8gcmV0dXJuDQp0aGUgb2xk
IHN0YWxlIGhhc2ggYW5kIGFsc28gdG8gcmVmcmVzaCB0aGUgaGFzaC4NCg0KT2YgY291cnNlLCBo
YXNoZXMgY2FuIGFsc28gYmUgY29tcHV0ZWQgYW5kDQpzdG9yZWQgaW4gYXR0cmlidXRlcyBmcm9t
IGEgdXNlci1zcGFjZQ0KcHJvZ3JhbSwgYW5kIGhlcmUgaXMgbXkgcHJvb2Ytb2YtcHJpbmNpcGxl
DQppbXBsZW1lbnRhdGlvbiBvZiB0aGlzIGlkZWE6DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS91ZWNr
ZXIvaGFzaGNhY2hlDQoNCg0KLi5idXQgbW92aW5nIHNvbWV0aGluZyBsaWtlIHRoaXMgaW50byB0
aGUNCmtlcm5lbCB3b3VsZCBzb2x2ZSB0d28gcHJvYmxlbXM6DQoNCjEpIGl0IHdvdWxkIG1ha2Ug
aXQgcG9zc2libGUgdG8gcmVsaWFibGUgZGV0ZWN0DQpmaWxlIGNoYW5nZXMNCg0KMikgaXQgd291
bGQgbWFrZSBpdCBwb3NzaWJsZSB0byBzaGFyZSB0aGUNCihleHBlbnNpdmUgdG8gY29tcHV0ZSkg
aGFzaGVzIGJldHdlZW4gZGlmZmVyZW50DQphcHBsaWNhdGlvbnMgLyB1c2VycyBldmVuIGlmIHRo
ZXkgZG8gbm90DQp0cnVzdCBlYWNoIG90aGVyDQoNCg0KVXNlcnMgb2Ygc3VjaCBhbiBBUEkgY291
bGQgYmUgdmVyc2lvbiBjb250cm9sDQpzeXN0ZW1zIChpdCBpcyBzaW1pbGFyIHRvIHRoZSBnaXQg
aW5kZXggbW92ZWQNCnRvIHRoZSBrZXJuZWwsIEkgdGhpbmspLCByc3luYywgdG9vbHMgZm9yIGJh
Y2t1cCwNCmRlLWR1cGxpY2F0aW9uLCBhbmQgZmlsZSBzaGFyaW5nLCBpbnRlZ3JpdHkNCmNoZWNr
ZXJzLCBldGMuDQoNCg0KVGhlIGltcGxlbWVudGF0aW9uIGNvdWxkIHByb2JhYmx5IGJlIGJhc2Vk
IG9uIElNQQ0KKGFsdGhvdWdoIGl0IGhhcyBhIGRpZmZlcmVudCBnb2FsKSBhbmQgY291bGQNCnJl
dXNlIGhhc2hlcyBmcm9tIGZpbGUgc3lzdGVtcyAob3IgZnMtdmVyaXR5KQ0Kd2hlcmUgdGhleSBh
cmUgYXZhaWxhYmxlLg0KDQoNClJlZ2FyZHMsDQpNYXJ0aW4NCg0K
