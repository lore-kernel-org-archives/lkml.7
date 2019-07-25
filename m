Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4234C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05782238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbfGYNIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:08:49 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45235 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbfGYNIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:08:49 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-32-vGb2MjMAN-6m5tWQ8A3mXQ-1; Thu, 25 Jul 2019 14:08:46 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 25 Jul 2019 14:08:45 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 25 Jul 2019 14:08:45 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Numfor Mbiziwo-Tiapo' <nums@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "mbd@fb.com" <mbd@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "eranian@google.com" <eranian@google.com>
Subject: RE: [PATCH 1/3] Fix backward-ring-buffer.c format-truncation error
Thread-Topic: [PATCH 1/3] Fix backward-ring-buffer.c format-truncation error
Thread-Index: AQHVQk/6xV2ERLHHO0iFjViscX/1mKbbTykw
Date:   Thu, 25 Jul 2019 13:08:45 +0000
Message-ID: <8ec2cbb1bb2a4aceab09ca685255119a@AcuMS.aculab.com>
References: <20190724184512.162887-1-nums@google.com>
 <20190724184512.162887-2-nums@google.com>
In-Reply-To: <20190724184512.162887-2-nums@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: vGb2MjMAN-6m5tWQ8A3mXQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTnVtZm9yIE1iaXppd28tVGlhcG8NCj4gU2VudDogMjQgSnVseSAyMDE5IDE5OjQ1DQo+
DQo+IFBlcmYgZG9lcyBub3QgYnVpbGQgd2l0aCB0aGUgdWJzYW4gKHVuZGVmaW5lZCBiZWhhdmlv
ciBzYW5pdGl6ZXIpDQo+IGFuZCB0aGVyZSBpcyBhbiBlcnJvciB0aGF0IHNheXM6DQo+IA0KPiB0
ZXN0cy9iYWNrd2FyZC1yaW5nLWJ1ZmZlci5jOjIzOjQ1OiBlcnJvcjog4oCYJWTigJkgZGlyZWN0
aXZlIG91dHB1dA0KPiBtYXkgYmUgdHJ1bmNhdGVkIHdyaXRpbmcgYmV0d2VlbiAxIGFuZCAxMCBi
eXRlcyBpbnRvIGEgcmVnaW9uIG9mDQo+IHNpemUgOCBbLVdlcnJvcj1mb3JtYXQtdHJ1bmNhdGlv
bj1dDQo+ICAgIHNucHJpbnRmKHByb2NfbmFtZSwgc2l6ZW9mKHByb2NfbmFtZSksICJwOiVkXG4i
LCBpKTsNCj4gDQo+IFRoaXMgY2FuIGJlIHJlcHJvZHVjZWQgYnkgcnVubmluZyAoZnJvbSB0aGUg
dGlwIGRpcmVjdG9yeSk6DQo+IG1ha2UgLUMgdG9vbHMvcGVyZiBVU0VfQ0xBTkc9MSBFWFRSQV9D
RkxBR1M9Ii1mc2FuaXRpemU9dW5kZWZpbmVkIg0KPiANCj4gVGggZXJyb3Igb2NjdXJzIGJlY2F1
c2UgdGhleSBhcmUgd3JpdGluZyB0byB0aGUgMTAgYnl0ZSBidWZmZXIgLSB0aGUNCj4gaW5kZXgg
J2knIG9mIHRoZSBmb3IgbG9vcCBhbmQgdGhlIDIgYnl0ZSBoYXJkY29kZWQgc3RyaW5nLiBJZiBz
b21laG93ICdpJw0KPiB3YXMgZ3JlYXRlciB0aGFuIDggYnl0ZXMgKDEwIC0gMiksIHRoZW4gdGhl
IHNucHJpbnRmIGZ1bmN0aW9uIHdvdWxkDQo+IHRydW5jYXRlIHRoZSBzdHJpbmcuIEluY3JlYXNp
bmcgdGhlIHNpemUgb2YgdGhlIGJ1ZmZlciBmaXhlcyB0aGUgZXJyb3IuDQoNCkdldCB0aGUgY29t
cGlsZXIgZml4ZWQgc28gdGhhdCBpdCBrbm93cyB0aGUgZG9tYWluIG9mIHRoZSB2YWx1ZSBjYW4g
bmV2ZXINCmV4Y2VlZCB0aGUgY29tcGlsZS10aW1lIGNvbnN0YW50IE5SX0lURVJTLg0KDQo+IFNp
Z25lZC1vZmYtYnk6IE51bWZvciBNYml6aXdvLVRpYXBvIDxudW1zQGdvb2dsZS5jb20+DQo+IC0t
LQ0KPiAgdG9vbHMvcGVyZi90ZXN0cy9iYWNrd2FyZC1yaW5nLWJ1ZmZlci5jIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvcGVyZi90ZXN0cy9iYWNrd2FyZC1yaW5nLWJ1ZmZlci5jIGIvdG9vbHMv
cGVyZi90ZXN0cy9iYWNrd2FyZC1yaW5nLWJ1ZmZlci5jDQo+IGluZGV4IDZkNTk4Y2MwNzFhZS4u
MWE5YzNiZWNmNWZmIDEwMDY0NA0KPiAtLS0gYS90b29scy9wZXJmL3Rlc3RzL2JhY2t3YXJkLXJp
bmctYnVmZmVyLmMNCj4gKysrIGIvdG9vbHMvcGVyZi90ZXN0cy9iYWNrd2FyZC1yaW5nLWJ1ZmZl
ci5jDQo+IEBAIC0xOCw3ICsxOCw3IEBAIHN0YXRpYyB2b2lkIHRlc3RjYXNlKHZvaWQpDQo+ICAJ
aW50IGk7DQo+IA0KPiAgCWZvciAoaSA9IDA7IGkgPCBOUl9JVEVSUzsgaSsrKSB7DQo+IC0JCWNo
YXIgcHJvY19uYW1lWzEwXTsNCj4gKwkJY2hhciBwcm9jX25hbWVbMTVdOw0KDQpBdCBsZWFzdCB1
c2UgWzE2XQ0KDQo+IA0KPiAgCQlzbnByaW50Zihwcm9jX25hbWUsIHNpemVvZihwcm9jX25hbWUp
LCAicDolZFxuIiwgaSk7DQo+ICAJCXByY3RsKFBSX1NFVF9OQU1FLCBwcm9jX25hbWUpOw0KPiAt
LQ0KPiAyLjIyLjAuNjU3Lmc5NjBlOTJkMjRmLWdvb2cNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVy
ZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5
bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

