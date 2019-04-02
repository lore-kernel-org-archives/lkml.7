Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C92EC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE07207E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbfDBJym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:54:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:32590 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727525AbfDBJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:54:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-174-5_NG9E5cNyi_NwT75wl1qA-1; Tue, 02 Apr 2019 10:54:37 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 2 Apr 2019 10:55:43 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 2 Apr 2019 10:55:43 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>, Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Qiaowei Ren <qiaowei.ren@intel.com>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: RE: [PATCH v3 2/4] x86/microcode: Fix __user annotations around
 generic_load_microcode()
Thread-Topic: [PATCH v3 2/4] x86/microcode: Fix __user annotations around
 generic_load_microcode()
Thread-Index: AQHU6LQZmzNw9bfABUGSSCXaVCkeoqYonqLA
Date:   Tue, 2 Apr 2019 09:55:43 +0000
Message-ID: <3c9697611e214d089f7a04086635c5a8@AcuMS.aculab.com>
References: <20190329214652.258477-1-jannh@google.com>
 <20190329214652.258477-2-jannh@google.com> <20190401173031.GK28264@zn.tnic>
 <CAG48ez04ARfFNXHUsod1kCH08k=-EvTbQkgLoLMfegNfyj-0zg@mail.gmail.com>
In-Reply-To: <CAG48ez04ARfFNXHUsod1kCH08k=-EvTbQkgLoLMfegNfyj-0zg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 5_NG9E5cNyi_NwT75wl1qA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFubiBIb3JuDQo+IFNlbnQ6IDAxIEFwcmlsIDIwMTkgMTg6NTQNCi4uLg0KPiA+IFRo
aXMgLT5nZXRfdWNvZGVfZGF0YSgpIEJJT1MtY29kZS1saWtlIGNvbnRyYXB0aW9uIGhhcyBhbHdh
eXMgYnVnZ2VkIG1lDQo+ID4gZm9yIGJlaW5nIHRvbyB1Z2x5IHRvIGxpdmUuDQo+ID4NCj4gPiBI
b3cgYWJvdXQgd2Ugdm1hbGxvYygpIGEgcHJvcGVybHkgc2l6ZWQgYnVmZmVyIC0gYm90aA0KPiA+
IGdlbmVyaWNfbG9hZF9taWNyb2NvZGUoKSBjYWxsZXJzIGhhdmUgdGhlIHNpemUgLSBhbmQgdGhl
biBoYW5kIHRoYXQNCj4gPiBidWZmZXIgaW50byBnZW5lcmljX2xvYWRfbWljcm9jb2RlKCkgPw0K
PiA+DQo+ID4gVGhhdCBzb2x2ZXMgdGhlIF9fdXNlciBhbm5vdGF0aW9uIGZ1biBpbW1lZGlhdGVs
eSBhbmQgd291bGQgc2ltcGxpZnkNCj4gPiBnZW5lcmljX2xvYWRfbWljcm9jb2RlKCkgYWRkaXRp
b25hbGx5Lg0KPiA+DQo+ID4gVGhlIGRpc2FkdmFudGFnZSB3b3VsZCBiZSBoYXZpbmcgdG8gdm1h
bGxvYygpIGEgY291cGxlIG9mLi4uICwgSSB0aGluaw0KPiA+IGl0IGlzIG1lZ2FieXRlcywgd2l0
aCB0aGF0IG9sZCBsb2FkaW5nIG1ldGhvZCByZXF1ZXN0X21pY3JvY29kZV91c2VyKCkNCj4gPiBi
dXQgdGhlbiBpZiB2bWFsbG9jKCkgZmFpbHMsIHRoZW4gaXQgd2FzIGNsZWFybHkgdG9vIGJpZy4g
SSBkb24ndCB0aGluaw0KPiA+IHRoZSBibG9iIGNhbiBldmVyIGJlIHRoYXQgYmlnIHRob3VnaCwg
dG8gZmFpbCB2bWFsbG9jKCksIGJ1dCBJJ20gbm90DQo+ID4gZ29pbmcgdG8gYmV0IG9uIGl0Li4u
DQo+IA0KPiBIbS4gcmVxdWVzdF9taWNyb2NvZGVfZncoKSBnZXRzIHRoYXQgYnVmZmVyIGZyb20N
Cj4gcmVxdWVzdF9maXJtd2FyZV9kaXJlY3QoKSwgd2hpY2ggZG9lcyB0aGlzOg0KPiANCj4gICAg
ICAgICBfX21vZHVsZV9nZXQoVEhJU19NT0RVTEUpOw0KPiAgICAgICAgIHJldCA9IF9yZXF1ZXN0
X2Zpcm13YXJlKGZpcm13YXJlX3AsIG5hbWUsIGRldmljZSwgTlVMTCwgMCwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBGV19PUFRfVUVWRU5UIHwgRldfT1BUX05PX1dBUk4gfA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEZXX09QVF9OT0ZBTExCQUNLKTsNCj4g
ICAgICAgICBtb2R1bGVfcHV0KFRISVNfTU9EVUxFKTsNCj4gICAgICAgICByZXR1cm4gcmV0Ow0K
PiANCj4gV2hhdCBpcyB0aGF0IG1vZHVsZV9nZXQoKS9tb2R1bGVfcHV0KCkgc3VwcG9zZWQgdG8g
YmUgZ29vZCBmb3I/IEFyZSB3ZQ0KPiBleHBlY3RpbmcgdGhhdCBjYWxsZXIgdG8gZG8gc29tZXRo
aW5nIHJpZGljdWxvdXMgbGlrZSBjYWxsaW5nDQo+IG1vZHVsZV9wdXQoKSBvbiB1cz8gVGhpcyBk
b2Vzbid0IHNlZW0gdG8gbWFrZSBhbnkgc2Vuc2UuDQoNCkF0IGxlYXN0IGl0IGlzbid0IGRvaW5n
IGEgdHJ5X21vZHVsZV9nZXQoVEhJU19NT0RVTEUpIDotKQ0KDQo+IEFuZCB0aGVuIF9yZXF1ZXN0
X2Zpcm13YXJlKCkgZ29lcyBhbmQgZW5kcyB1cCBpbiBwbGFjZXMgbGlrZQ0KPiBrZXJuZWxfcmVh
ZF9maWxlKCksIHdoaWNoIGFscmVhZHkgdXNlIHZtYWxsb2MoKS4NCj4gDQo+IA0KPiBBbnl3YXks
IGlzbid0IHRoaXMga2luZCBvZiB0aGluZyBleGFjdGx5IHdoeSB3ZSBoYXZlIHRoYXQgaW92X2l0
ZXINCj4gc3R1ZmY/IHJlcXVlc3RfbWljcm9jb2RlX2Z3KCkgY2FuIGJ1aWxkIGFuIElURVJfS1ZF
QywNCj4gcmVxdWVzdF9taWNyb2NvZGVfdXNlcigpIGNhbiBidWlsZCBhbiBJVEVSX0lPVkVDLiBB
bmQgdGhlbg0KPiBnZW5lcmljX2xvYWRfbWljcm9jb2RlKCkgY2FuIHVzZSBzb21ldGhpbmcgbGlr
ZSBjb3B5X2Zyb21faXRlcigpLiBEb2VzDQo+IHRoYXQgc291bmQgcmVhc29uYWJsZT8NCg0KVGhh
dCBvdWdodCB0byBhbGxvdyB0aGUgbWljcm9jb2RlIGJlIGNvcGllZCBpbiBjaHVua3MgLSByZW1v
dmluZyB0aGUNCm5lZWQgZm9yIGEgbWFzc2l2ZSBidWZmZXI/DQoNClRoZSBsYXJnZXN0IGZpbGUg
d2UgZXZlciBjb3B5IHRvIFBDSWUgY2FyZHMgaXMgYSA2TUIgZnBnYSBpbWFnZS4NCkJ1dCB3ZSBk
byB0aGF0IGJ5IG1tYXBwaW5nIHRoZSBQQ0llIHJlZ2lzdGVycyBkaXJlY3RseSBpbnRvIHVzZXJz
cGFjZS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

