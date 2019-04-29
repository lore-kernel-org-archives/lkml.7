Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD3C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A48120656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfD2Ooe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:44:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:20801 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbfD2Ood (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:44:33 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-45-jwDIhfeQPpe1TZfWbs-_nQ-1; Mon, 29 Apr 2019 15:44:29 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 29 Apr 2019 15:44:27 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 29 Apr 2019 15:44:27 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Gustavo A. R. Silva'" <gustavo@embeddedor.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH] usbip: vhci_hcd: Mark expected switch fall-through
Thread-Topic: [PATCH] usbip: vhci_hcd: Mark expected switch fall-through
Thread-Index: AQHU/plu2318l/GBi0OLId5OVcMGj6ZTNpSw
Date:   Mon, 29 Apr 2019 14:44:27 +0000
Message-ID: <1daec8c8929e4d18b2059ab1dfbfdf4a@AcuMS.aculab.com>
References: <20190429143957.GA6725@embeddedor>
In-Reply-To: <20190429143957.GA6725@embeddedor>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: jwDIhfeQPpe1TZfWbs-_nQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR3VzdGF2byBBLiBSLiBTaWx2YQ0KPiBTZW50OiAyOSBBcHJpbCAyMDE5IDE1OjQwDQo+
IEluIHByZXBhcmF0aW9uIHRvIGVuYWJsaW5nIC1XaW1wbGljaXQtZmFsbHRocm91Z2gsIG1hcmsg
c3dpdGNoDQo+IGNhc2VzIHdoZXJlIHdlIGFyZSBleHBlY3RpbmcgdG8gZmFsbCB0aHJvdWdoLg0K
Li4uDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi91c2JpcC92aGNpX2hjZC5jIGIvZHJpdmVy
cy91c2IvdXNiaXAvdmhjaV9oY2QuYw0KPiBpbmRleCA2NjdkOWMwZWM5MDUuLjAwMGFiNzIyNTcx
NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvdXNiaXAvdmhjaV9oY2QuYw0KPiArKysgYi9k
cml2ZXJzL3VzYi91c2JpcC92aGNpX2hjZC5jDQo+IEBAIC01MDgsNiArNTA4LDcgQEAgc3RhdGlj
IGludCB2aGNpX2h1Yl9jb250cm9sKHN0cnVjdCB1c2JfaGNkICpoY2QsIHUxNiB0eXBlUmVxLCB1
MTYgd1ZhbHVlLA0KPiAgCQljYXNlIFVTQl9QT1JUX0ZFQVRfVTFfVElNRU9VVDoNCj4gIAkJCXVz
YmlwX2RiZ192aGNpX3JoKA0KPiAgCQkJCSIgU2V0UG9ydEZlYXR1cmU6IFVTQl9QT1JUX0ZFQVRf
VTFfVElNRU9VVFxuIik7DQo+ICsJCQkvKiBGYWxsIHRocm91Z2ggKi8NCj4gIAkJY2FzZSBVU0Jf
UE9SVF9GRUFUX1UyX1RJTUVPVVQ6DQo+ICAJCQl1c2JpcF9kYmdfdmhjaV9yaCgNCj4gIAkJCQki
IFNldFBvcnRGZWF0dXJlOiBVU0JfUE9SVF9GRUFUX1UyX1RJTUVPVVRcbiIpOw0KDQpUaGF0IGRv
ZXNuJ3QgbG9vayByaWdodCwgYm90aCBkZWJ1ZyBtZXNzYWdlcyBzZWVtIHRvIGdldCBwcmludGVk
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

