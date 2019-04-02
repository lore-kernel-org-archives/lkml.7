Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11B85C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D593020857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbfDBKZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:25:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:41971 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbfDBKZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:25:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-6HOur-ojMKWgvSRAKelcEg-1; Tue, 02 Apr 2019 11:25:24 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 2 Apr 2019 11:26:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 2 Apr 2019 11:26:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>, Jann Horn <jannh@google.com>
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
Thread-Index: AQHU6TsNmzNw9bfABUGSSCXaVCkeoqYoqP3g
Date:   Tue, 2 Apr 2019 10:26:30 +0000
Message-ID: <fa9c73f385a649cfbedae47f21a5447f@AcuMS.aculab.com>
References: <20190329214652.258477-1-jannh@google.com>
 <20190329214652.258477-2-jannh@google.com> <20190401173031.GK28264@zn.tnic>
 <CAG48ez04ARfFNXHUsod1kCH08k=-EvTbQkgLoLMfegNfyj-0zg@mail.gmail.com>
 <20190402100134.GE6826@zn.tnic>
In-Reply-To: <20190402100134.GE6826@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 6HOur-ojMKWgvSRAKelcEg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQm9yaXNsYXYgUGV0a292DQo+IFNlbnQ6IDAyIEFwcmlsIDIwMTkgMTE6MDINCj4gDQo+
IE9uIE1vbiwgQXByIDAxLCAyMDE5IGF0IDA3OjUzOjQ2UE0gKzAyMDAsIEphbm4gSG9ybiB3cm90
ZToNCj4gPiBIbS4gcmVxdWVzdF9taWNyb2NvZGVfZncoKSBnZXRzIHRoYXQgYnVmZmVyIGZyb20N
Cj4gPiByZXF1ZXN0X2Zpcm13YXJlX2RpcmVjdCgpLCB3aGljaCBkb2VzIHRoaXM6DQo+ID4NCj4g
PiAgICAgICAgIF9fbW9kdWxlX2dldChUSElTX01PRFVMRSk7DQo+ID4gICAgICAgICByZXQgPSBf
cmVxdWVzdF9maXJtd2FyZShmaXJtd2FyZV9wLCBuYW1lLCBkZXZpY2UsIE5VTEwsIDAsDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBGV19PUFRfVUVWRU5UIHwgRldfT1BUX05P
X1dBUk4gfA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRldfT1BUX05PRkFM
TEJBQ0spOw0KPiA+ICAgICAgICAgbW9kdWxlX3B1dChUSElTX01PRFVMRSk7DQo+ID4gICAgICAg
ICByZXR1cm4gcmV0Ow0KPiA+DQo+ID4gV2hhdCBpcyB0aGF0IG1vZHVsZV9nZXQoKS9tb2R1bGVf
cHV0KCkgc3VwcG9zZWQgdG8gYmUgZ29vZCBmb3I/IEFyZSB3ZQ0KPiA+IGV4cGVjdGluZyB0aGF0
IGNhbGxlciB0byBkbyBzb21ldGhpbmcgcmlkaWN1bG91cyBsaWtlIGNhbGxpbmcNCj4gPiBtb2R1
bGVfcHV0KCkgb24gdXM/IFRoaXMgZG9lc24ndCBzZWVtIHRvIG1ha2UgYW55IHNlbnNlLg0KPiAN
Cj4gWWFoLCB0aGUgbWljcm9jb2RlIHRoaW5nIHVzZWQgdG8gYmUgYSBtb2R1bGUuIE5vdCBhbnlt
b3JlLg0KDQpUaGF0IHByb2JhYmx5IG1ha2VzIGRpZGRseS1zcXVpdCBkaWZmZXJlbmNlLg0KVGhl
cmUgaGFzIHRvIGJlIGEgJ2hvbGQnIG9uIFRISVNfTU9EVUxFIGluIG9yZGVyIHRvIGJlIGV4ZWN1
dGluZw0KY29kZSBmcm9tIGl0Lg0KWW91IG9ubHkgKHVzdWFsbHkpIG5lZWQgYW4gZXh0cmEgcmVm
ZXJlbmNlIGZvciBhIGtlcm5lbCB0aHJlYWQsDQphbmQgdGhhdCBuZWVkcyB0byBleGl0IHdpdGgg
bW9kdWxlX3B1dF9hbmRfZXhpdCgpLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNz
IExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAx
UFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

