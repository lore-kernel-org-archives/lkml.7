Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75706C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EFD02075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfDCNld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:41:33 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45693 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfDCNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:41:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-228-Th9rimmcPRC2NwhNCrp6LA-1; Wed, 03 Apr 2019 14:41:30 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed,
 3 Apr 2019 14:42:36 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 3 Apr 2019 14:42:36 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Garrett' <matthewgarrett@google.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "roberto.sassu@huawei.com" <roberto.sassu@huawei.com>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tweek@google.com" <tweek@google.com>,
        Matthew Garrett <mjg59@google.com>
Subject: RE: [PATCH 1/2] efi: Fix cast to pointer from integer of different
 size in TPM log code
Thread-Topic: [PATCH 1/2] efi: Fix cast to pointer from integer of different
 size in TPM log code
Thread-Index: AQHU6Z8JdZ+UHAYfaUqRGxcPZ+xJEaYqcfag
Date:   Wed, 3 Apr 2019 13:42:36 +0000
Message-ID: <89e1cf4093d7405987c55f682519f9fc@AcuMS.aculab.com>
References: <20190402215556.257406-1-matthewgarrett@google.com>
 <20190402215556.257406-2-matthewgarrett@google.com>
In-Reply-To: <20190402215556.257406-2-matthewgarrett@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: Th9rimmcPRC2NwhNCrp6LA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWF0dGhldyBHYXJyZXR0DQo+IFNlbnQ6IDAyIEFwcmlsIDIwMTkgMjI6NTYNCj4gDQo+
IDhiZmNmZjRhNmExZDlkNzIyNmJiNjNhN2RhNzU4YjgyZDlhYjQzNzMgaW50cm9kdWNlZCBhIGNh
c3QgZnJvbQ0KPiBlZmlfcGh5c2ljYWxfYWRkcmVzc190IHRvICh2b2lkICopLCB3aGljaCBhcmUg
ZGlmZmVyZW50IHNpemVzIG9uIDMyLWJpdC4NCj4gRml4IHRoYXQuIENhdWdodCBieSB0aGUgMC1k
YXkgdGVzdCBib3QuDQoNCkNhc3RpbmcgYSBwaHlzaWNhbCBhZGRyZXNzIHRvICd2b2lkIConIHNl
ZW1zIGNvbXBsZXRlbHkgd3JvbmcuDQpBbHNvIHlvdSdkIG5lZWQgYSBndWFyYW50ZWUgdGhhdCB0
aGUgYWRkcmVzcyB3YXMgYmVsb3cgNEcgb3IgdGhlIHJlc3VsdA0KaXMgbWVhbmluZ2xlc3MuDQpM
b29rcyB0byBtZSBsaWtlIHNvbWV0aGluZyBpcyB1c2luZyB0aGUgd3JvbmcgdHlwZXMgc29tZXdo
ZXJlLg0KDQoJRGF2aWQNCg0KPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGV3IEdhcnJldHQgPG1qZzU5
QGdvb2dsZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi90cG0u
YyB8IDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3Rw
bS5jIGIvZHJpdmVycy9maXJtd2FyZS9lZmkvbGlic3R1Yi90cG0uYw0KPiBpbmRleCBiNmU5M2Ux
NGZjZjEuLjZiM2I1MDdhNTRlYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9maXJtd2FyZS9lZmkv
bGlic3R1Yi90cG0uYw0KPiArKysgYi9kcml2ZXJzL2Zpcm13YXJlL2VmaS9saWJzdHViL3RwbS5j
DQo+IEBAIC0xMTQsOCArMTE0LDggQEAgdm9pZCBlZmlfcmV0cmlldmVfdHBtMl9ldmVudGxvZyhl
Zmlfc3lzdGVtX3RhYmxlX3QgKnN5c190YWJsZV9hcmcpDQo+ICAJCQkgKi8NCj4gIAkJCWxhc3Rf
ZW50cnlfc2l6ZSA9DQo+ICAJCQkJX19jYWxjX3RwbTJfZXZlbnRfc2l6ZSgodm9pZCAqKWxhc3Rf
ZW50cnlfYWRkciwNCj4gLQkJCQkJCSAgICAgICAodm9pZCAqKWxvZ19sb2NhdGlvbiwNCj4gLQkJ
CQkJCSAgICAgICBmYWxzZSk7DQo+ICsJCQkJCQkgICAgKHZvaWQgKikobG9uZylsb2dfbG9jYXRp
b24sDQo+ICsJCQkJCQkgICAgZmFsc2UpOw0KPiAgCQl9IGVsc2Ugew0KPiAgCQkJbGFzdF9lbnRy
eV9zaXplID0gc2l6ZW9mKHN0cnVjdCB0Y3BhX2V2ZW50KSArDQo+ICAJCQkgICAoKHN0cnVjdCB0
Y3BhX2V2ZW50ICopIGxhc3RfZW50cnlfYWRkciktPmV2ZW50X3NpemU7DQo+IC0tDQo+IDIuMjEu
MC4zOTIuZ2Y4ZjY3ODcxNTllLWdvb2cNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

