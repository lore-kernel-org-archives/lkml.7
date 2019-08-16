Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DD2C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3609920665
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 16:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfHPQdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 12:33:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37112 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726469AbfHPQdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 12:33:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-9-VebloSKBPpiIGPVfEX4ZmQ-1;
 Fri, 16 Aug 2019 17:33:35 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 16 Aug 2019 17:33:34 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 16 Aug 2019 17:33:34 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Luck, Tony'" <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Thread-Topic: [PATCH] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Thread-Index: AQHVUvmohFuCfK9scUWSgr8NyWrQpqb8TdAAgAAoIICAAH6MgP//lLaAgACUa4D//7MogIAA+0WAgAAs4VCAAAEqUA==
Date:   Fri, 16 Aug 2019 16:33:34 +0000
Message-ID: <7541d45519b749deac898f6e5a913366@AcuMS.aculab.com>
References: <20190814234030.30817-1-tony.luck@intel.com>
 <20190815075822.GC15313@zn.tnic>
 <20190815172159.GA4935@agluck-desk2.amr.corp.intel.com>
 <20190815175455.GJ15313@zn.tnic>
 <20190815183055.GA6847@agluck-desk2.amr.corp.intel.com>
 <alpine.DEB.2.21.1908152217070.1908@nanos.tec.linutronix.de>
 <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
 <20190816064625.GD18980@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7F42410E@ORSMSX115.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F42410E@ORSMSX115.amr.corp.intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: VebloSKBPpiIGPVfEX4ZmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHVjaywgVG9ueQ0KPiBTZW50OiAxNiBBdWd1c3QgMjAxOSAxNzoyOQ0KPiA+PiArICog
VGhlIGRlZmluZWQgc3ltYm9sIG5hbWVzIGhhdmUgdGhlIGZvbGxvd2luZyBmb3JtOg0KPiA+PiAr
ICoJSU5URUxfRkFNNntPUFRGQU1JTFl9X3tNSUNST0FSQ0h9e09QVERJRkZ9DQo+ID4NCj4gPiBJ
IHRoaW5rIHlvdSB3YW50IHRvIGhhdmUgdGhlIHVuZGVyc2NvcmVzIGluIHRoZSB0ZW1wbGF0ZToN
Cj4gPg0KPiA+CUlOVEVMX0ZBTTZfe09QVEZBTUlMWX1fe01JQ1JPQVJDSH1fe09QVERJRkZ9DQo+
ID4NCj4gPiBidXQgbm8gbmVlZCB0byByZXNlbmQgaWYgdGhpcyBpcyB0aGUgb25seSBpc3N1ZSAt
IEknbGwgZml4IGl0IHVwIHdoZW4NCj4gPiBhcHBseWluZy4NCj4gDQo+IEkgc3RhcnRlZCB0aGVy
ZSwgYnV0IHRoZW4gaGFkIHRvIGluY2x1ZGUgYSBzZW50ZW5jZSBzYXlpbmcgdG8gc2tpcCB0aGUg
Il8iDQo+IGlmIHlvdSBkaWRuJ3QgaW5jbHVkZSBlaXRoZXIvYm90aCBvZiB0aGUgb3B0aW9uYWwg
ZmllbGRzLg0KDQpNaWdodCBnZXQgZGlmZmljdWx0IHdvcmtpbmcgb3V0IHdoZXRoZXIgSU5URVJf
RkFNNl9GT09fQkFSIGhhcyBhbg0KT1BURkFNSUxZIG9mIEZPTyBhbmQgTUlDUk9BUkNIIG9mIEJB
Uiwgb3IgTUlDUk9BUkNIIG9mIEZPTyBhbmQNCk9QVERJRkYgb2YgQkFSLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K

