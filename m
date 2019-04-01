Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA63C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1222520856
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 14:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfDAOgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 10:36:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:30685 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726514AbfDAOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 10:36:20 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-182-dWEfmz4fNiaWXGzbiijT8A-1; Mon, 01 Apr 2019 15:36:17 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 1 Apr 2019 15:37:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 1 Apr 2019 15:37:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jann Horn' <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Signed-off-by : Qiaowei Ren" <qiaowei.ren@intel.com>
Subject: RE: [PATCH 2/2] x86: fix __user annotations
Thread-Topic: [PATCH 2/2] x86: fix __user annotations
Thread-Index: AQHU5ayoMjJz+KWSR0ebfYs0pJiIL6YnZLxQ
Date:   Mon, 1 Apr 2019 14:37:23 +0000
Message-ID: <ca2d792df2e9420090383f1a65a6d99f@AcuMS.aculab.com>
References: <20190328212321.92463-1-jannh@google.com>
 <20190328212321.92463-2-jannh@google.com>
In-Reply-To: <20190328212321.92463-2-jannh@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: dWEfmz4fNiaWXGzbiijT8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSmFubiBIb3JuDQo+IFNlbnQ6IDI4IE1hcmNoIDIwMTkgMjE6MjMNCj4gRml4IF9fdXNl
ciBhbm5vdGF0aW9ucyBpbiB2YXJpb3VzIHBsYWNlcyBhY3Jvc3MgdGhlIHg4NiB0cmVlOg0KPiAN
Ci4uLg0KPiAgLSBnZW5lcmljX2xvYWRfbWljcm9jb2RlKCkgZGVhbHMgd2l0aCBhIHBvaW50ZXIg
dGhhdCBjYW4gYmUgZWl0aGVyIGENCj4gICAga2VybmVsIHBvaW50ZXIgb3IgYSB1c2VyIHBvaW50
ZXI7IGNoYW5nZSB0aGUgY29kZSB0byBwYXNzIGl0IGFyb3VuZCBhcw0KPiAgICBhIF9fdXNlciBw
b2ludGVyLCBhbmQgYWRkIGV4cGxpY2l0IGNhc3RzIHRvIGNvbnZlcnQgYmV0d2VlbiBfX3VzZXIg
YW5kDQo+ICAgIF9fa2VybmVsDQouLi4NCj4gLXN0YXRpYyBpbnQgZ2V0X3Vjb2RlX2Z3KHZvaWQg
KnRvLCBjb25zdCB2b2lkICpmcm9tLCBzaXplX3QgbikNCj4gK3N0YXRpYyBpbnQgZ2V0X3Vjb2Rl
X2Z3KHZvaWQgKnRvLCBjb25zdCB2b2lkIF9fdXNlciAqZnJvbSwgc2l6ZV90IG4pDQo+ICB7DQo+
IC0JbWVtY3B5KHRvLCBmcm9tLCBuKTsNCj4gKwkvKiBjYXN0IHBhaXJlZCB3aXRoIHJlcXVlc3Rf
bWljcm9jb2RlX2Z3KCkgKi8NCj4gKwltZW1jcHkodG8sIChjb25zdCB2b2lkIF9fZm9yY2UgKilm
cm9tLCBuKTsNCj4gIAlyZXR1cm4gMDsNCj4gIH0NCj4gDQo+IEBAIC05OTMsNyArOTk2LDggQEAg
c3RhdGljIGVudW0gdWNvZGVfc3RhdGUgcmVxdWVzdF9taWNyb2NvZGVfZncoaW50IGNwdSwgc3Ry
dWN0IGRldmljZSAqZGV2aWNlLA0KPiAgCQlyZXR1cm4gVUNPREVfTkZPVU5EOw0KPiAgCX0NCj4g
DQo+IC0JcmV0ID0gZ2VuZXJpY19sb2FkX21pY3JvY29kZShjcHUsICh2b2lkICopZmlybXdhcmUt
PmRhdGEsDQo+ICsJLyogY2FzdCBwYWlyZWQgd2l0aCBnZXRfdWNvZGVfZncoKSAqLw0KPiArCXJl
dCA9IGdlbmVyaWNfbG9hZF9taWNyb2NvZGUoY3B1LCAodm9pZCBfX2ZvcmNlIF9fdXNlciAqKWZp
cm13YXJlLT5kYXRhLA0KPiAgCQkJCSAgICAgZmlybXdhcmUtPnNpemUsICZnZXRfdWNvZGVfZncp
Ow0KPiANCj4gIAlyZWxlYXNlX2Zpcm13YXJlKGZpcm13YXJlKTsNCj4gQEAgLTEwMDEsNyArMTAw
NSw3IEBAIHN0YXRpYyBlbnVtIHVjb2RlX3N0YXRlIHJlcXVlc3RfbWljcm9jb2RlX2Z3KGludCBj
cHUsIHN0cnVjdCBkZXZpY2UgKmRldmljZSwNCj4gIAlyZXR1cm4gcmV0Ow0KPiAgfQ0KPiANCj4g
LXN0YXRpYyBpbnQgZ2V0X3Vjb2RlX3VzZXIodm9pZCAqdG8sIGNvbnN0IHZvaWQgKmZyb20sIHNp
emVfdCBuKQ0KPiArc3RhdGljIGludCBnZXRfdWNvZGVfdXNlcih2b2lkICp0bywgY29uc3Qgdm9p
ZCBfX3VzZXIgKmZyb20sIHNpemVfdCBuKQ0KPiAgew0KPiAgCXJldHVybiBjb3B5X2Zyb21fdXNl
cih0bywgZnJvbSwgbik7DQo+ICB9DQo+IEBAIC0xMDEyLDcgKzEwMTYsNyBAQCByZXF1ZXN0X21p
Y3JvY29kZV91c2VyKGludCBjcHUsIGNvbnN0IHZvaWQgX191c2VyICpidWYsIHNpemVfdCBzaXpl
KQ0KPiAgCWlmIChpc19ibGFja2xpc3RlZChjcHUpKQ0KPiAgCQlyZXR1cm4gVUNPREVfTkZPVU5E
Ow0KPiANCj4gLQlyZXR1cm4gZ2VuZXJpY19sb2FkX21pY3JvY29kZShjcHUsICh2b2lkICopYnVm
LCBzaXplLCAmZ2V0X3Vjb2RlX3VzZXIpOw0KPiArCXJldHVybiBnZW5lcmljX2xvYWRfbWljcm9j
b2RlKGNwdSwgYnVmLCBzaXplLCAmZ2V0X3Vjb2RlX3VzZXIpOw0KDQpUaGF0IGlzIGFsbCBhbiAn
YWNjaWRlbnQgd2FpdGluZyB0byBoYXBwZW4nIC4uLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

