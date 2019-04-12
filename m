Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00C6C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D86D2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfDLPrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:47:13 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:33526 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbfDLPrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:47:12 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-218-gq7fBo9YOcW6YAamhup0eQ-1; Fri, 12 Apr 2019 16:47:09 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 12 Apr 2019 16:48:18 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 12 Apr 2019 16:48:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Louis Taylor <louis@kragniz.eu>
CC:     David Howells <dhowells@redhat.com>,
        "linux-afs@lists.infradead.org" <linux-afs@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH v2] afs: use correct format characters
Thread-Topic: [PATCH v2] afs: use correct format characters
Thread-Index: AQHU7/BGUMhZ9UQTg0a0N2UXEtUZh6Y4rhVg
Date:   Fri, 12 Apr 2019 15:48:18 +0000
Message-ID: <c0183559e20747a69c8955bcb619fc07@AcuMS.aculab.com>
References: <20190410220301.2332-1-louis@kragniz.eu>
 <20190410224124.6901-1-louis@kragniz.eu>
 <CAKwvOdmCHfRZ8miaCie=f2Fd_2QoJAnhS7TC8T0NYyQdcop9zA@mail.gmail.com>
In-Reply-To: <CAKwvOdmCHfRZ8miaCie=f2Fd_2QoJAnhS7TC8T0NYyQdcop9zA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: gq7fBo9YOcW6YAamhup0eQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAxMCBBcHJpbCAyMDE5IDIzOjUyDQo+IE9u
IFdlZCwgQXByIDEwLCAyMDE5IGF0IDM6NDEgUE0gTG91aXMgVGF5bG9yIDxsb3Vpc0BrcmFnbml6
LmV1PiB3cm90ZToNCj4gPg0KPiA+IFdoZW4gY29tcGlsaW5nIHdpdGggLVdmb3JtYXQsIGNsYW5n
IHdhcm5zOg0KPiA+DQo+ID4gZnMvYWZzL2Zsb2NrLmM6NjMyOjI5OiB3YXJuaW5nOiBmb3JtYXQg
c3BlY2lmaWVzIHR5cGUgJ3Nob3J0JyBidXQgdGhlIGFyZ3VtZW50IGhhcyB0eXBlDQo+ID4gICAg
ICAgJ3Vuc2lnbmVkIGNoYXInIFstV2Zvcm1hdF0NCj4gPiAgICAgICAgIF9sZWF2ZSgiID0gJWQg
WyVoZF0iLCByZXQsIGZsLT5mbF90eXBlKTsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIH5+
fiAgICAgICAgIF5+fn5+fn5+fn5+DQo+ID4NCj4gPiBmcy9hZnMvZGlyLmM6MTM4OjExOiB3YXJu
aW5nOiBmb3JtYXQgc3BlY2lmaWVzIHR5cGUgJ3Vuc2lnbmVkIHNob3J0JyBidXQNCj4gPiB0aGUg
YXJndW1lbnQgaGFzIHR5cGUgJ2ludCcgWy1XZm9ybWF0XQ0KPiA+ICAgICAgICBudG9ocyhkYnVm
LT5ibG9ja3NbdG1wXS5oZHIubWFnaWMpKTsNCj4gPiAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiA+DQo+ID4gZmxfdHlwZSBpcyBkZWNsYXJlZCBhcyBhbiB1bnNp
Z25lZCBjaGFyIHVuY29uZGl0aW9uYWxseSBpbg0KPiA+IGluY2x1ZGUvbGludXgvZnMuaCwgc28g
dXNlIHRoZSBjb3JyZWN0IGZvcm1hdCBjaGFyYWN0ZXJzLg0KPiANCj4gVGhhbmtzIGZvciB0aGUg
djIsIHByb2JhYmx5IHNob3VsZCBpbmNsdWRlIGEgbm90ZSBhYm91dCBudG9ocy4gIFRoYXQNCj4g
Y2FzZSBpbiBwYXJ0aWN1bGFyIGxvb2tzIG1vcmUgY29tcGxpY2F0ZWQsIGR1ZSB0byB0aGUgZGVm
aW5pdGlvbiBvZg0KPiBudG9ocyAod2hpY2ggdXNlcyBfX3N3YWIxNikuDQo+IA0KPiBJZiB5b3Ug
a2VlcCB0aGUgcHJldmlvdXMgZmxhZyBvZiAlMDRoeCwgYnV0IGFkZCBhbiBleHBsaWNpdCBjYXN0
IHRvDQo+IHUxNiwgZG9lcyB0aGUgd2FybmluZyBnbyBhd2F5PyBJZiBzbywgdGhhdCBtaWdodCBi
ZSBhIGJldHRlciBmaXguDQo+IA0KPiAtIG50b2hzKGRidWYtPmJsb2Nrc1t0bXBdLmhkci5tYWdp
YykpOw0KPiArICh1MTYpbnRvaHMoZGJ1Zi0+YmxvY2tzW3RtcF0uaGRyLm1hZ2ljKSk7DQoNCk9y
IGp1c3QgYXBwZW5kICcrIDB1JyBmb3JjaW5nIHRoZSB0eXBlIHRvICd1bnNpZ25lZCBpbnQnLg0K
DQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQs
IE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86
IDEzOTczODYgKFdhbGVzKQ0K

