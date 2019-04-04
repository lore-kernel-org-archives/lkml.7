Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B428C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198DC20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfDDILB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:11:01 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:56132 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDILA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:11:00 -0400
X-AuditID: c0a8fbf4-519ff700000014c1-cf-5ca5bc11d5da
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 34.F0.05313.11CB5AC5; Thu,  4 Apr 2019 10:10:57 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Thu, 4 Apr 2019 10:10:53 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Thread-Topic: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Thread-Index: AQHU4wL8Fp/G2VuRn0+8cMWLA5gmIqYp9w8AgABCplmAACBVUv//5ACAgAD9UQCAADO0gIAAD/4AgAAyz7j//+JsgA==
Date:   Thu, 4 Apr 2019 08:10:52 +0000
Message-ID: <70a8a87a403eb2ab8f0aad2a26456de8a162f363.camel@fi.rohmeurope.com>
References: <20190403073152.GM4187@dell>
         <20190403084732.GA3493@localhost.localdomain> <20190403093015.GJ11301@dell>
         <20190403101003.GC3493@localhost.localdomain> <20190403112559.GP11301@dell>
         <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
         <20190404025234.GB6830@dell>
         <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
         <20190404065452.GD6830@dell> <20190404072449.GE3493@localhost.localdomain>
         <20190404075640.GV22216@piout.net>
In-Reply-To: <20190404075640.GV22216@piout.net>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <77CA96EB2605C44DBED0E5318C266071@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxjH995d767AuZdS6SvuR2xMljGFufjHa0I2EjWe22I29a/Jwk45
        W7C/dtdWcTHpFFBRNzMhy6qU4aiM2rhY4yKIRhpmFXWGiRUzfqyhwYnKIlXQoegdp8Jf99zz
        /X6fz/smz8uShhSdw5Y63KLkEGxmOo069+tEZGFmW7Do/drvcnFj13UG7xw5wuAHdZ0Urk0k
        aVzf8acODzz8A+Cx7l0ErnnSROD7e/t1+ET9E4CvtR6icWpfB8Dnj3bTuOfYWQYnGy4TOHij
        i8CHghco3NW5HFee6WDwZPw4hS+dduPB25NkYTYfDoQB/19PJcMHwt/wLf4+ho+EdtN8b7yN
        5pvDYR3fMu5j+B8Djwk+FXnrs7Qv0gvWC27vmlKLI//Dr9KtiX8rSFfItCWYbAY+0JtdDVgW
        wcVo+99Z1SCNNcA4QP+P+2ntJwZQcLSXUE00LEDVN5lqoGeNcCkKXK2iVA8JY3q0LxilVCEL
        foJu/N5OaaZP0ciOHkKry1BqbAKoNQXno2f3D0/1ObgKVR3/ntRgQySaaIrrVEEP81FFy+jU
        IADfRLt9I1MBEppQZGh8yoMgRI1tV0mtno1uD06+6JvRmccJSj00Cd9Fv7Xma9FCVPPLoxdj
        5qGaPQlGO0MmuvhTktoPsv0zCP7ptH9G2j8j7Z+R/hnoQgDZhVKbRXCLi/Ik0ZMnOa125bPB
        aY8AbW0enALPoiujALLAnMEd+CFYZNAJXrncHgVzWMI8mxu901hkmLXeWVJuFWRrseSxiXIU
        IJY0G7nlqsaVCOVbRcn5UprLUmYTt7mppsgAVfImUXSJ0kv1DZY1I+5iq8LJlESLuGVjqc09
        LROsXh2elmOURUeJKAket7VY3ZZiWVkXVcpQuF+fVuKc7BLsSleLdoL32HOHE3Uke6/9Vh1p
        oBxOh5hj4g6qJKharR7HK9AwMCn3zeJkVc1QXtKrOcMKglAQ2FOvItzCtJTjAw3cksU+5wqm
        edkdYVPI5orNt3xp6Yt/UNsQGP7I8ZqRjYV0Wd50Dnrz9uZu678wWBsw3H26ZLSy/WP92zct
        t6r+iv9jj1VsvefqN87buf3KwPDQusrCVGJswGZae6JszTup1Ru92XVNq48VrPz25IENZY8M
        6aG+tgV93a/PSn6+/6SZkq3ColxSkoXnmr7KdAYEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQWxleGFuZHJlLA0KDQpPbiBUaHUsIDIwMTktMDQtMDQgYXQgMDk6NTYgKzAyMDAsIEFs
ZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBPbiAwNC8wNC8yMDE5IDEwOjI0OjQ5KzAzMDAsIE1h
dHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiBPbiBUaHUsIEFwciAwNCwgMjAxOSBhdCAwNzo1NDo1
MkFNICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDA0IEFwciAyMDE5LCBW
YWl0dGluZW4sIE1hdHRpIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+IEFjdHVhbGx5LCBub3cgdGhh
dCBJIHRoaWsgb2YgaXQgdGhlIHJpZ2h0IHdheSB0byBkbyB0aGlzIHdvdWxkDQo+ID4gPiA+IGhh
dmUNCj4gPiA+ID4gYmVlbiB0aGUgZnVuY3Rpb24gcG9pbnRlciBpbiBwYXJlbnQgZGF0YSBhcyB3
YXMgZG9uZSBpbg0KPiA+ID4gPiBvcmlnaW5hbCBwYXRjaA0KPiA+ID4gPiBzZXQuIEhXLWNvbGxl
YWd1ZXMgdGVuZCB0byByZS11c2UgSFcgYmxvY2tzLCBhbmQgd2UgbGlrZSB0byByZS0NCj4gPiA+
ID4gdXNlIG91cg0KPiA+ID4gPiBkcml2ZXJzLiBJZiB0aGUgbmV4dCBQTUlDIGZyb20gUk9ITSB1
c2VzIHNhbWUgUlRDIGJsb2NrIGJ1dA0KPiA+ID4gPiBkb2VzIG5vdA0KPiA+ID4gPiBwcm92aWRl
IHdhdGNoZG9nIC0gdGhlbiBpdCBpcyBjbGVhbmVzdCBzb2x1dGlvbiB0byBmYWxsIGJhY2sgdG8N
Cj4gPiA+ID4gZnVuY3Rpb24gcG9pbnRlciBhbmQgbGVhdmUgaXQgdG8gTlVMTCB3aGVuIHRoZXJl
IGlzIG5vIFdEVCBvcg0KPiA+ID4gPiB3aGVuIFdEVA0KPiA+ID4gPiBpcyB1bnVzZWQuIEFub3Ro
ZXIgb3B0aW9uIGlzIHRvIGV4cG9ydCBkdW1teSBmdW5jdGlvbiAtIHdoaWNoDQo+ID4gPiA+IGlz
IG5vdCBzbw0KPiA+ID4gPiBuaWNlLg0KPiA+ID4gDQo+ID4gPiBJIHRoaW5rIHRoZSBjb252ZXJz
ZSBpcyB0cnVlLg0KPiA+ID4gDQo+ID4gPiBQb2ludGVycyB0byBmdW5jdGlvbnMgb3V0c2lkZSBv
ZiBhIHN1YnN5c3RlbSBBUEkgY29udGV4dCBhcmUNCj4gPiA+IGdlbmVyYWxseQ0KPiA+ID4gaG9y
cmlibGUuICBJdCdzIG11Y2ggbmljZXIgdG8gY2FsbCBhIGZ1bmN0aW9uIHdoaWNoIGNhbiBiZSBl
YXNpbHkNCj4gPiA+IHN0dWJiZWQgb3V0IGluIGEgaGVhZGVyIGZpbGUgYmFzZWQgb24gYSBLY29u
ZmlnIG9wdGlvbi4gIEl0J3MgaG93DQo+ID4gPiBtb3N0DQo+ID4gPiBrZXJuZWwgQVBJcyB3b3Jr
Lg0KPiA+IA0KPiA+IEkgaGF0ZSB0byBhZG1pdCBidXQgSSBzZWUgeW91ciBwb2ludC4gVGhpcyBu
aWNlbHkgc29sdmVzIGFueSBpc3N1ZXMNCj4gPiBpbg0KPiA+IHN5bmNyb25pemluZyB0aGUgc3Rh
cnR1cCBmb3IgZHJpdmVyIHByb3ZpZGluZyBmdW5jdGlvbiBwb2ludGVyIGFuZA0KPiA+IGZvcg0K
PiA+IGRyaXZlciB1c2luZyBpdC4NCj4gPiANCj4gDQo+IFdvdWxkbid0IGl0IGJlIGVhc2llciB0
byByZWdpc3RlciB0aGUgd2F0Y2hkb2cgZHJpdmVyIGFzIHBhcnQgb2YgdGhlDQo+IFJUQw0KPiBk
cml2ZXI/DQo+IA0KPiBBcyBJIHNlZSBpdCwgdGhlIHdkdCBpcyBqdXN0IGEgZ2xvcmlmaWVkIFJU
QyBhbGFybS4NCg0KRG8geW91IHN1Z2dlc3QgbWUgdG8gcHV0IGFsbCB0aGUgc3R1ZmYgbm93IHBs
YWNlZCBpbg0KZHJpdmVycy93YXRjaGRvZy9iZDcwNTI4X3dkdC5jIGludG8gcnRjIGRyaXZlcj8g
SXQgd291bGQgYmUgZG9hYmxlIC0NCmJ1dCBJJ2QgcmF0aGVyIGtlcHQgdGhlIFdEVCBpbmRlcGVu
ZGVudCBtb2R1bGUgc28gdGhhdCBpdCBjYW4gYmUgbGVmdA0Kb3V0IG9mIGNvbmZpZyBpZiBXRFQg
bmVlZHMgbm90IHRvIGJlIHVzZWQuIEFuZCBzYW1lIHdpdGggUlRDLiBBbHNvLCByZS0NCnVzZSBv
ZiBSVEMgZHJpdmVyIGluIEhXIHdoaWNoIGRvZXMgbm90IGluY2x1ZGUgV0RUIGlzIGVhc2llciB3
aGVuIFdEVA0KaXMgYSBzZXBhcmF0ZSBtb2R1bGUuIFRvIG1lIGl0IGxvb2tzIG11Y2ggY2xlYW5l
ciB0byBoYXZlIHRoZSBXRFQgYXMNCm93biBtb2R1bGUgdGhhbiBwb2xsdXRpbmcgdGhlIFJUQyBk
cml2ZXIgd2l0aCBjb25maWcgaWZkZWZzLg0KDQpCdXQgZnJvbSBIVyBwZXJzcGVjdGl2ZSB5b3Ug
YXJlIGNvcnJlY3QuIFRoZSBXRFQgaW4gQkQ3MDUyOCBzZWVtcyB0byBiZQ0Ka2luZCBvZiBSVEMg
YWxhcm0gd2hpY2ggc2h1dHMgb2YgdGhlIFBNSUMgaWYgdHJpZ2dlcmVkLg0KDQpCciwNCglNYXR0
aSBWYWl0dGluZW4NCg==
