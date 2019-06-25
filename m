Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9A4C48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FB1214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 13:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729806AbfFYNAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 09:00:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:30928 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728507AbfFYNAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 09:00:22 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-62-ev5tpLMfNUW724LjKFIIIg-1; Tue, 25 Jun 2019 14:00:18 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 25 Jun 2019 14:00:18 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 25 Jun 2019 14:00:18 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andy.shevchenko@gmail.com>
CC:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        "Benoit Parrot" <bparrot@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] Input: edt-ft5x06 - use get_unaligned_be16()
Thread-Topic: [PATCH 1/2] Input: edt-ft5x06 - use get_unaligned_be16()
Thread-Index: AQHVKY1hAj6tejpQ3kG1+0ev0Psa8KasERZwgAASn4CAADS6oA==
Date:   Tue, 25 Jun 2019 13:00:18 +0000
Message-ID: <23f190781ea44eda9dc77bcf5100765b@AcuMS.aculab.com>
References: <20190623063153.261546-1-dmitry.torokhov@gmail.com>
 <011d62995b20493f977ead43f4b494a2@AcuMS.aculab.com>
 <CAHp75VfJQp4TqfyvjGtFcnvN-md++9fQUis6a-dFKn_2OUN=0A@mail.gmail.com>
In-Reply-To: <CAHp75VfJQp4TqfyvjGtFcnvN-md++9fQUis6a-dFKn_2OUN=0A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ev5tpLMfNUW724LjKFIIIg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBTaGV2Y2hlbmtvDQo+IFNlbnQ6IDI1IEp1bmUgMjAxOSAxMTo1MA0KPiBUbzog
RGF2aWQgTGFpZ2h0DQo+IENjOiBEbWl0cnkgVG9yb2tob3Y7IGxpbnV4LWlucHV0QHZnZXIua2Vy
bmVsLm9yZzsgTWFyY28gRmVsc2NoOyBCZW5vaXQgUGFycm90OyBsaW51eC0NCj4ga2VybmVsQHZn
ZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gSW5wdXQ6IGVkdC1mdDV4
MDYgLSB1c2UgZ2V0X3VuYWxpZ25lZF9iZTE2KCkNCj4gDQo+IE9uIFR1ZSwgSnVuIDI1LCAyMDE5
IGF0IDExOjQ0IEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4gRnJvbTogRG1pdHJ5IFRvcm9raG92DQo+ID4gPiBTZW50OiAyMyBKdW5lIDIw
MTkgMDc6MzINCj4gPiA+DQo+ID4gPiBJbnN0ZWFkIG9mIGRvaW5nIGNvbnZlcnNpb24gYnkgaGFu
ZCwgbGV0J3MgdXNlIHRoZSBwcm9wZXIgYWNjZXNzb3JzLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IERtaXRyeSBUb3Jva2hvdiA8ZG1pdHJ5LnRvcm9raG92QGdtYWlsLmNvbT4NCj4gPiA+
IC0tLQ0KPiA+ID4gIGRyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vZWR0LWZ0NXgwNi5jIHwgNSAr
KystLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4v
ZWR0LWZ0NXgwNi5jIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9lZHQtZnQ1eDA2LmMNCj4g
PiA+IGluZGV4IGM2MzllYmNlOTE0Yy4uZWM3NzAyMjZlMTE5IDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9lZHQtZnQ1eDA2LmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvaW5wdXQvdG91Y2hzY3JlZW4vZWR0LWZ0NXgwNi5jDQo+ID4gPiBAQCAtMjcsNiArMjcsNyBA
QA0KPiA+ID4gICNpbmNsdWRlIDxsaW51eC9ncGlvL2NvbnN1bWVyLmg+DQo+ID4gPiAgI2luY2x1
ZGUgPGxpbnV4L2lucHV0L210Lmg+DQo+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2lucHV0L3RvdWNo
c2NyZWVuLmg+DQo+ID4gPiArI2luY2x1ZGUgPGFzbS91bmFsaWduZWQuaD4NCj4gPiA+DQo+ID4g
PiAgI2RlZmluZSBXT1JLX1JFR0lTVEVSX1RIUkVTSE9MRCAgICAgICAgICAgICAgMHgwMA0KPiA+
ID4gICNkZWZpbmUgV09SS19SRUdJU1RFUl9SRVBPUlRfUkFURSAgICAweDA4DQo+ID4gPiBAQCAt
MjM5LDggKzI0MCw4IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBlZHRfZnQ1eDA2X3RzX2lzcihpbnQg
aXJxLCB2b2lkICpkZXZfaWQpDQo+ID4gPiAgICAgICAgICAgICAgIGlmICh0c2RhdGEtPnZlcnNp
b24gPT0gRURUX00wNiAmJiB0eXBlID09IFRPVUNIX0VWRU5UX0RPV04pDQo+ID4gPiAgICAgICAg
ICAgICAgICAgICAgICAgY29udGludWU7DQo+ID4gPg0KPiA+ID4gLSAgICAgICAgICAgICB4ID0g
KChidWZbMF0gPDwgOCkgfCBidWZbMV0pICYgMHgwZmZmOw0KPiA+ID4gLSAgICAgICAgICAgICB5
ID0gKChidWZbMl0gPDwgOCkgfCBidWZbM10pICYgMHgwZmZmOw0KPiA+ID4gKyAgICAgICAgICAg
ICB4ID0gZ2V0X3VuYWxpZ25lZF9iZTE2KGJ1ZikgJiAweDBmZmY7DQo+ID4gPiArICAgICAgICAg
ICAgIHkgPSBnZXRfdW5hbGlnbmVkX2JlMTYoYnVmICsgMikgJiAweDBmZmY7DQo+ID4NCj4gPiBZ
b3UgbWlnaHQgYXMgd2VsbCBkZWxldGUgdGhlIHBvaW50bGVzcyBtYXNraW5nIHdpdGggMHhmZi4N
Cj4gDQo+IEhtbS4uLiBEb2VzIGl0IGd1YXJhbnRlZSB0aGUgbW9zdCBzaWduaWZpY2FudCBuaWJi
bGUgdG8gYmUgYWx3YXlzIDA/DQo+IChOb3RlIDE2LWJpdCB2YWx1ZSBhbmQgdGhyZWUgZjpzIGlu
IHRoZSBtYXNrKQ0KDQpTb3JyeSwgSSBtaXNyZWFkIGl0IDotKA0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

