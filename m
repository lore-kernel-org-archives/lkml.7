Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56083C10F05
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2179720882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 06:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfDDGMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 02:12:46 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:50904 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDGMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 02:12:46 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Apr 2019 02:12:44 EDT
X-AuditID: c0a8fbf4-501ff700000014c1-8c-5ca59cd568f7
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 93.DF.05313.5DC95AC5; Thu,  4 Apr 2019 07:57:41 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Thu, 4 Apr 2019 07:57:37 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Thread-Topic: [PATCH v11 2/8] mfd: bd70528: Support ROHM bd70528 PMIC - core
Thread-Index: AQHU4wL8Fp/G2VuRn0+8cMWLA5gmIqYp9w8AgABCplmAACBVUv//5ACAgAD9UQCAADO0gA==
Date:   Thu, 4 Apr 2019 05:57:34 +0000
Message-ID: <6775a75d1ee3ab96123d84b077881beedc358d12.camel@fi.rohmeurope.com>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
         <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
         <20190403073152.GM4187@dell> <20190403084732.GA3493@localhost.localdomain>
         <20190403093015.GJ11301@dell> <20190403101003.GC3493@localhost.localdomain>
         <20190403112559.GP11301@dell>
         <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
         <20190404025234.GB6830@dell>
In-Reply-To: <20190404025234.GB6830@dell>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CE960D699C74D40B348E76648F7D5F9@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TaUwTWxTHc2emM0NlyFiRXuuS2PhF9KmNqPeDMSbGZFzjEkl8ojjISNEu
        OG0V0A8EQWUxbiix7AhP0calRH0oEGxwQ4OgFNG4IYgKihFwJ+hcB4VP99zzP//zOzc5lyV1
        PbSBjbU5JdkmWoy0lqo59cP7jz+3NGJGeVkIKmn0M2hv938M6suro9DR1nYaFdTWa9DzT9cB
        +ty0j0BZ/ScJ9DHzmQaVF/QD9OBKLo1699cCdONME41azlYzqL3oLoFKHzYSKLf0FoUa6xai
        1KpaBg00X6DQnatO1PZ2gJwfInjyPUD40JLKCPmenUKF+ykjeE+n0cKT5kpaKPN4NELFlyRG
        yM7/Rgi93gkrtP+OmBslOrevjo2xTZ+3cYT50IUMJq4/Mr4t4zyRBGrWp4MAFvJhcE92A5MO
        tKyObwaw4l6PRr3cBND94jGZDliW5ufC9EcMNgTzJlhy6xWFY5J/FADbipfjeBS/BD68dI1S
        a5bC7t0tBLYG8+FwoDoRpyl+Emw/karBMccvh0VNHjCIIuG77KsEFgL4yfDx/YO/WYAfD9OS
        ugmVpYfeji8adWgellTeI9V4NHzbNjCYN8Kqb60U5pJKn3NXpqvW+XD3iQODI0+EWRmtjDrD
        SHj7eDt1EIS4hxHcQ273MLd7mNs9zF0INKcBtIqxlhjRKZmmyZJrmmw3W5Vjk93qBerW9P0P
        fvoW+QDPAmMgd+RwaYROI253JFh9YAxLGEdzPV0lEbqgKHt0gll0mCNll0Vy+ABkSWMwtxBr
        XLSYkCjJ9j/SWJYy6rkdJ7MidDwmb5WkOEn+o45jWSPkknMUzkhZipHiN8danEMywQbg5lpD
        sEOyRUuy6HKaI/GyRDqUbcFSoMI9jO2cI060KlnVWgemsDXFrXkk+/7a6zxSR9nsNsmg5+bg
        Uh6Xml22v6BOoFfeO4ozYTVQ+Uh/+3QqCEJBIFcBRjjFIcmQBMI6iyEImprcUbknKqrrXfPY
        oGNm39JVPyv8F10Llt3OzKn+mjgrp/f7ypV9Id+BPqU+YYOBcZX7O7pCU4quJ88SVm8i/GVz
        Lm+zzN5SuOZ5eKg15WUhKmtYFDY5k4vf9sl0QDsz//LiHu5lw5tdVWn0ulUrsvvXupyFgWee
        zK5Psxoph1k0hZKyQ/wFuP6TsAUEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTA0LTA0IGF0IDAzOjUyICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFdlZCwgMDMgQXByIDIwMTksIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+IA0KPiA+IE9uIFdl
ZCwgMjAxOS0wNC0wMyBhdCAxMjoyNSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOg0KPiA+ID4gT24g
V2VkLCAwMyBBcHIgMjAxOSwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiA+
IE9uIFdlZCwgQXByIDAzLCAyMDE5IGF0IDEwOjMwOjE1QU0gKzAxMDAsIExlZSBKb25lcyB3cm90
ZToNCj4gPiA+ID4gPiBPbiBXZWQsIDAzIEFwciAyMDE5LCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBIZWxsbyBMZWUsDQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IFRoYW5rcyBmb3IgdGFraW5nIGEgbG9vayBvbiB0aGlzIGFnYWluID0pIEkgYWdyZWUg
d2l0aCBtb3N0DQo+ID4gPiA+ID4gPiBvZg0KPiA+ID4gPiA+ID4gdGhlDQo+ID4gPiA+ID4gPiBj
b21tZW50cyBhbmQgY29ycmVjdCB0aGVtIGF0IG5leHQgdmVyc2lvbi4NCj4gPiA+ID4gPiA+IA0K
PiA+ID4gPiA+ID4gT24gV2VkLCBBcHIgMDMsIDIwMTkgYXQgMDg6MzE6NTJBTSArMDEwMCwgTGVl
IEpvbmVzIHdyb3RlOg0KPiA+ID4gPiA+ID4gPiBPbiBNb24sIDI1IE1hciAyMDE5LCBNYXR0aSBW
YWl0dGluZW4gd3JvdGU6DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFJPSE0gQkQ3
MDUyOE1XViBpcyBhbiB1bHRyYS1sb3cgcXVpZXNjZW50IGN1cnJlbnQNCj4gPiA+ID4gPiA+ID4g
PiBnZW5lcmFsDQo+ID4gPiA+ID4gPiA+ID4gcHVycG9zZSBzaW5nbGUtY2hpcCBwb3dlciBtYW5h
Z2VtZW50IElDIGZvciBiYXR0ZXJ5LQ0KPiA+ID4gPiA+ID4gPiA+IHBvd2VyZWQNCj4gPiA+ID4g
PiA+ID4gPiBwb3J0YWJsZSBkZXZpY2VzLg0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
PiA+IEFkZCBNRkQgY29yZSB3aGljaCBlbmFibGVzIGNoaXAgYWNjZXNzIGZvciBmb2xsb3dpbmcN
Cj4gPiA+ID4gPiA+ID4gPiBzdWJkZXZpY2VzOg0KPiA+ID4gPiA+ID4gPiA+IAktIHJlZ3VsYXRv
cnMvTEVEIGRyaXZlcnMNCj4gPiA+ID4gPiA+ID4gPiAJLSBiYXR0ZXJ5LWNoYXJnZXINCj4gPiA+
ID4gPiA+ID4gPiAJLSBncGlvcw0KPiA+ID4gPiA+ID4gPiA+IAktIDMyLjc2OGtIeiBjbGsNCj4g
PiA+ID4gPiA+ID4gPiAJLSBSVEMNCj4gPiA+ID4gPiA+ID4gPiAJLSB3YXRjaGRvZw0KPiA+ID4g
PiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5l
biA8DQo+ID4gPiA+ID4gPiA+ID4gbWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0K
PiA+ID4gPiA+ID4gPiA+ICsgKiBNYXBwaW5nIG9mIG1haW4gSVJRIHJlZ2lzdGVyIGJpdHMgdG8g
c3ViIGlycQ0KPiA+ID4gPiA+ID4gPiA+IHJlZ2lzdGVyDQo+ID4gPiA+ID4gPiA+ID4gb2Zmc2V0
cyBzbw0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gInN1Yi1JUlEiDQo+ID4gPiA+ID4g
PiA+IA0KPiA+ID4gPiA+ID4gPiA+ICsgKiB0aGF0IHdlIGNhbiBhY2Nlc3MgY29yZWN0IHN1YiBJ
UlEgcmVnaXN0ZXJzIGJhc2VkDQo+ID4gPiA+ID4gPiA+ID4gb24NCj4gPiA+ID4gPiA+ID4gPiBi
aXRzIHRoYXQNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ICJzdWIgSVJRIiBpcyBhbHNv
IGZpbmUsIGJ1dCBwbGVhc2Ugc3RhbmRhcmRpc2UuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiBJIGRvIHByZWZlciAic3ViLUlSUSIgdGhvdWdoLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+
ID4gPiBJJ2xsIGdvIHdpdGggInN1Yi1JUlEiIHRoZW4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArI2RlZmluZSBXRF9DVFJMX01BR0lDMSAweDU1DQo+
ID4gPiA+ID4gPiA+ID4gKyNkZWZpbmUgV0RfQ1RSTF9NQUdJQzIgMHhBQQ0KPiA+ID4gPiA+ID4g
PiA+ICsvKioNCj4gPiA+ID4gPiA+ID4gPiArICogYmQ3MDUyOF93ZHRfc2V0IC0gYXJtIG9yIGRp
c2FybSB3YXRjaGRvZyB0aW1lcg0KPiA+ID4gPiA+ID4gPiA+ICsgKg0KPiA+ID4gPiA+ID4gPiA+
ICsgKiBAZGF0YToJZGV2aWNlIGRhdGEgZm9yIHRoZSBQTUlDIGluc3RhbmNlIHdlDQo+ID4gPiA+
ID4gPiA+ID4gd2FudCB0bw0KPiA+ID4gPiA+ID4gPiA+IG9wZXJhdGUgb24NCj4gPiA+ID4gPiA+
ID4gPiArICogQGVuYWJsZToJbmV3IHN0YXRlIG9mIFdEVC4gemVybyB0byBkaXNhYmxlLCBub24N
Cj4gPiA+ID4gPiA+ID4gPiB6ZXJvIHRvIGVuYWJsZQ0KPiA+ID4gPiA+ID4gPiA+ICsgKiBAb2xk
X3N0YXRlOglwcmV2aW91cyBzdGF0ZSBvZiBXRFQgd2lsbCBiZSBmaWxsZWQNCj4gPiA+ID4gPiA+
ID4gPiBoZXJlDQo+ID4gPiA+ID4gPiA+ID4gKyAqDQo+ID4gPiA+ID4gPiA+ID4gKyAqIEFybSBv
ciBkaXNhcm0gV0RUIG9uIEJENzA1MjggUE1JQy4gRXhwZWN0ZWQgdG8gYmUNCj4gPiA+ID4gPiA+
ID4gPiBjYWxsZWQgb25seSBieQ0KPiA+ID4gPiA+ID4gPiA+ICsgKiBCRDcwNTI4IFJUQyBhbmQg
QkQ3MDUyOCBXRFQgZHJpdmVycy4gVGhlDQo+ID4gPiA+ID4gPiA+ID4gcnRjX3RpbWVyX2xvY2sN
Cj4gPiA+ID4gPiA+ID4gPiBtdXN0IGJlIHRha2VuDQo+ID4gPiA+ID4gPiA+ID4gKyAqIGJ5IGNh
bGxpbmcgYmQ3MDUyOF93ZHRfbG9jayBiZWZvcmUgY2FsbGluZw0KPiA+ID4gPiA+ID4gPiA+IGJk
NzA1Mjhfd2R0X3NldC4NCj4gPiA+ID4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gPiA+ID4gK2lu
dCBiZDcwNTI4X3dkdF9zZXQoc3RydWN0IHJvaG1fcmVnbWFwX2RldiAqZGF0YSwgaW50DQo+ID4g
PiA+ID4gPiA+ID4gZW5hYmxlLCBpbnQgKm9sZF9zdGF0ZSkNCj4gPiA+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gPiA+IFdoeSBkb2Vzbid0IHRoaXMgcmVzaWRlIGluIHRoZSB3YXRjaGRvZyBkcml2ZXI/
DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElmIG15IG1lbW9yeSBzZXJ2ZXMgbWUgcmlnaHQg
d2Ugc2hvcnRseSBkaXNjdXNzZWQgdGhpcw0KPiA+ID4gPiA+ID4gYWxyZWFkeQ0KPiA+ID4gPiA+
ID4gZHVyaW5nIHY4DQo+ID4gPiA+ID4gPiByZXZpZXcgOykgQ2FudCBibGFtZSB5b3UgdGhvdWdo
IGFzIEkgaGF2ZSBzZWVuIHNvbWUgb2YgdGhlDQo+ID4gPiA+ID4gPiBtYWlsDQo+ID4gPiA+ID4g
PiB0cmFmZmljDQo+ID4gPiA+ID4gPiBnb2luZyB0aHJvdWdoIHlvdXIgaW5ib3ggOkQNCj4gPiA+
ID4gPiA+IA0KPiA+ID4gPiA+ID4gVGhlIG1vdGl2YXRpb24gdG8gaGF2ZSB0aGUgZnVuY3Rpb25z
IGV4cG9ydGVkIGZyb20gTUZEIGlzDQo+ID4gPiA+ID4gPiB0bw0KPiA+ID4gPiA+ID4gbm90IGNy
ZWF0ZQ0KPiA+ID4gPiA+ID4gc2lyZWN0IGRlcGVuZGVuY3kgYmV0d2VlbiBSVEMgYW5kIFdEVC4g
VGhlcmUgbWF5IGJlIGNhc2VzDQo+ID4gPiA+ID4gPiB3aGVyZQ0KPiA+ID4gPiA+ID4gd2Ugd2Fu
dA0KPiA+ID4gPiA+ID4gdG8gbGVhdmUgZWl0aGVyIFJUQyBvciBXRFQgb3V0IG9mIGNvbXBpbGF0
aW9uLiBNRkQgaXMNCj4gPiA+ID4gPiA+IGFsd2F5cw0KPiA+ID4gPiA+ID4gbmVlZGVkIHNvDQo+
ID4gPiA+ID4gPiB0aGUgZGVwZW5kZW5jeSBmcm9tIE1GRCB0byBSVEMvV0RUIGRvZXMgbm90IGhh
cm0uDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IChIZXJlJ3Mgc29tZSBkaXNjdXNzaW9uIG5l
Y3JvbWFuY3kgaWYgeW91IGFyZSBpbnRlcmVzdGVkIGluDQo+ID4gPiA+ID4gPiByZS0NCj4gPiA+
ID4gPiA+IHJlYWRpbmcNCj4gPiA+ID4gPiA+IGhvdyB3ZSBkaWQgZW5kIHVwIHdpdGggdGhpcyBp
bXBsZW1lbnRhdGlvbjoNCj4gPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwv
MjAxOTAyMTIwOTE3MjMuR1oyMDYzOEBkZWxsLykNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
SSBob3BlIHlvdSBhcmUgc3RpbGwgT2sgd2l0aCBoYXZpbmcgdGhlIFdEVCBjb250cm9sDQo+ID4g
PiA+ID4gPiBmdW5jdGlvbnMNCj4gPiA+ID4gPiA+IGluIE1GRC4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBPT0ksIHdoeSBkb2VzIHRoZSBSVEMgbmVlZCB0byBjb250cm9sIHRoZSBXRFQ/DQo+ID4g
PiA+IA0KPiA+ID4gPiBJIHRob3VnaHQgSSBoYWQgYSBjb21tZW50IGFib3V0IHRoaXMgc29tZXdo
ZXJlIGluIGNvZGUuLi4gT19vDQo+ID4gPiA+IE11c3QNCj4gPiA+ID4gaGF2ZQ0KPiA+ID4gPiBi
ZWVuIGluIHNvbWUgZGV2ZWxvcG1lbnQgYnJhbmNoIEkgaGFkIDovDQo+ID4gPiA+IA0KPiA+ID4g
PiBBbnl3YXlzLCBzZXR0aW5nIHRoZSBSVEMgY291bnRlciBtYXkgY2F1c2Ugd2F0Y2hkb2cgdG8g
dHJpZ2dlci4NCj4gPiA+ID4gSXQNCj4gPiA+ID4gaXMgbm90DQo+ID4gPiA+IGZ1cnRoZXIgZXhw
bGFpbmVkIHdoeSBidXQgSSB3b3VsZCBndWVzcyB3YXRjaGRvZyB1c2VzIFJUQw0KPiA+ID4gPiBj
b3VudGVyDQo+ID4gPiA+IHRvIGNoZWNrDQo+ID4gPiA+IGlmIGl0IHNob3VsZCd2ZSBiZWVuIHBp
bmdlZCBhbHJlYWR5LiBTbyBSVEMgbmVlZHMgdG8gZGlzYWJsZQ0KPiA+ID4gPiB3YXRjaA0KPiA+
ID4gPiBkb2cgZm9yDQo+ID4gPiA+IHRoZSBkdXJhdGlvbiBvZiBod2Nsb2NrIHNldHRpbmcgYW5k
IGVuYWJsZSBpdCBhZ2FpbiBhZnRlciB0aGUNCj4gPiA+ID4gbmV3DQo+ID4gPiA+IHRpbWUgaXMN
Cj4gPiA+ID4gc2V0LiBJIGNhbiBhZGQgYSBjb21tZW50IGFib3V0IHRoaXMgdG8gTUZEIGRyaXZl
ciBpZiBpdCBoZWxwcw0KPiA+ID4gPiA6KQ0KPiA+ID4gDQo+ID4gPiBIb3cgZG9lcyB0aGUgdXNl
ciBzZWxlY3QgYmV0d2VlbiB1c2luZyB0aGUgUlRDIGFuZCB0aGUgV0RUPw0KPiA+ID4gDQo+ID4g
PiBPciBhcmUgdGhlIGdlbmVyYWxseSBib3RoIGVuYWJsZWQgYXQgdGhlIHNhbWUgdGltZT8NCj4g
PiA+IA0KPiA+IA0KPiA+IEJvdGggUlRDIGFuZCBXRFQgY2FuIGJlIGVuYWJsZWQgYXQgdGhlIHNh
bWUgdGltZS4gQnV0IHRoZXkgYXJlIG5vdA0KPiA+IHJlcXVpcmVkIHRvIGJlIHVzZWQuIFdoZW4g
V0RUIGlzIGVuYWJsZWQsIGl0IHVzZXMgY3VycmVudCBSVEMgdGltZQ0KPiA+IGFzDQo+ID4gJ2Jh
c2UnIChhbmQgUlRDIHRpbWUgaXMgcnVubmluZyBubyBtYXR0ZXIgaWYgd2UgaGF2ZSB0aGUgUlRD
IGRyaXZlcg0KPiA+IGhlcmUgb3Igbm90KSAtIGFuZCB0aW1lLW91dCBnZXRzIHNjaGVkdWxlZCB0
byBzcGVjaWZpZWQgYW1vdW50IG9mDQo+ID4gdGltZQ0KPiA+IGludG8gZnV0dXJlLiAoU2FtZSBz
ZXR0aW5nIHRpbWVvdXQgaW50byB0aGUgZnV0dXJlIGhhcHBlbnMgd2hlbiBXRFQNCj4gPiBpcw0K
PiA+IHBpbmdlZCkuDQo+ID4gDQo+ID4gV2hlbiB3ZSBzZXQgUlRDLCB3ZSBkaXNhYmxlIFdEVCAo
aWYgaXQgd2FzIGVuYWJsZWQpLCBzZXQgY2xvY2sgYW5kDQo+ID4gcmUtDQo+ID4gZW5hYmxlIFdE
VC4gVGhpcyBjYXVzZXMgdGhlIHByZXZpb3VzbHkgdXNlZCB0aW1lLW91dCB2YWx1ZSB0byBiZQ0K
PiA+IHNldCB0bw0KPiA+IFdEVCBhZ2Fpbi4gVGhpcyB3b3JrcyBPayBiZWNhdXNlIEJENzA1Mjgg
ZG9lcyBub3Qgc3VwcG9ydCAnc2hvcnQNCj4gPiBwaW5nDQo+ID4gZGV0ZWN0aW9uJy4gT25seSBz
aWRlLWVmZmVjdCB3aWxsIGJlIG9uZSAncHJvbG9uZ2VkJyBXRFQgZmVlZGluZw0KPiA+IHBlcmlv
ZA0KPiA+IHdoZW4gUlRDIGlzIHNldC4gKGFic29sdXRlIHRpbWUgd2hlbiBSVEMgd2FzIHNldCBt
aW51cyBhYnNvbHV0ZQ0KPiA+IHRpbWUNCj4gPiB3aGVuIHByZXZpb3VzIFdEIHBpbmcgb3IgZW5h
YmxlIHdhcyBkb25lKSBsb25nZXIgdGhhbiByZXF1bGFyDQo+ID4gcGVyaW9kLg0KPiA+IA0KPiA+
IFNvIHVzZXIgc2hvdWxkIG5vdCBuZWVkIHRvIGNhcmUgYWJvdXQgdGhpcyAnZGVwZW5kZW5jeScu
IEJhc2ljYWxseQ0KPiA+IHRoZQ0KPiA+IG9ubHkgcG9zc2libGUgcHJvYmxlbSBJIHNlZSBpcyB0
aGF0IHNvbWVvbmUgY291bGQgYWNjaWRlbnRhbGx5IGhhbmcNCj4gPiB0aGUNCj4gPiBzeXN0ZW0g
d2l0aCBzb21ldGhpbmcgdGhhdCBrZWVwcyBzZXR0aW5nIHRoZSBSVEMgdGltZSAtIHRoaXMgd291
bGQNCj4gPiB0aGVuDQo+ID4gcHJldmVudCB3YXRjaCBkb2cgZnJvbSBkb2luZyB0aGUgcmVzZXQu
IFRoaXMsIEkgYmVsaWV2ZSwgaXMgYQ0KPiA+IGNvcm5lcg0KPiA+IGNhc2Ugd2hpY2ggSSBkb24n
dCBjb25zaWRlciBub3cgLSBhbmQgaWYgdGhpcyBpcyBjb25zaWRlcmVkIHRvIGJlDQo+ID4gYW4N
Cj4gPiBpc3N1ZSB0aGVuIHN1Y2ggYSBzeXN0ZW0gbWF5IGRpc2FibGUgdGhlIFJUQyBkcml2ZXIg
YW5kIGRvIFJUQw0KPiA+IHNldHRpbmcNCj4gPiBpbiBhIHdoYXQtZXZlci1tYW5uZXIgc2VlcyBw
cmFjdGljYWwuDQo+ID4gDQo+ID4gSSdtIG5vdCBzdXJlIGlmIEkgYW5zd2VyZWQgdG8gcXVlc3Rp
b24geW91IGFza2VkIHRob3VnaCA9KQ0KPiANCj4gSSB0aGluayB5b3UgYW5zd2VyZWQgaXQganVz
dCBmaW5lLg0KPiANCj4gU28gbXkgc3VnZ2VzdGlvbiBpcyB0byBoYXZlIHRoZSBSVEMgZGVwZW5k
IG9uIHRoZSBXUlQgdmlhIEtjb25maWcsDQo+IGFuZA0KPiBwbGFjZSB0aGlzIFdSVCBjb2RlIGlu
IHRoZSBXUlQgZHJpdmVyIHdoZXJlIGl0IGJlbG9uZ3MuICBUaGVzZQ0KPiBmdW5jdGlvbnMgY2Fu
IGJlIGV4cG9ydGVkIGZyb20gdGhlIFdSVCBkcml2ZXIgYW5kIHRoZSBSVEMgY2FuIGNhbGwNCj4g
aW50byB0aGVtIGluIHRoZSBzYW1lIHdheSBpdCBjYWxscyBpbnRvIHRoZSBNRkQgZHJpdmVyIGN1
cnJlbnRseS4NCg0KWWVzLCB3ZSBjb3VsZC4gQnV0IHRoZW4gd2UgbmVlZCB0byBhbHdheXMgY29t
cGlsZSB0aGUgd2F0Y2ggZG9nIGRyaXZlcg0Kd2hlbiB3ZSB3YW50IHRvIHVzZSBSVEMuIEl0IGlz
IG5vdCBhIGh1Z2UgZHJpdmVyIHRob3VnaCBzbyBpdCBwcm9iYWJseQ0Kd29uJ3QgbWF0dGVyLiBT
bywgSSBkb24ndCBsaWtlIHRoaXMgYnV0IEkgY2FuIGRvIGl0IHNvIGlmIHlvdSBpbnNpc3QgOl0N
Cg0KPiBBdm9pZGluZyBhIGRlcGVuZGVuY3kgb24gdGhlIFdSVCB3b3VsZCBzZWVtIHN0cmFuZ2Us
IGJlY2F1c2UgdGhlcmUgaXMNCj4gb25lLg0KDQpUaGUgZGVwZW5kZW5jeSBpcyBhcnRpZmljaWFs
LiBJdCdzIGNhdXNlZCBieSB0aGUgY3VycmVudCBkcml2ZXIgZGVzaWduLg0KSWYgd2F0Y2hkb2cg
aXMgbm90IHVzZWQsIHRoZW4gUlRDIGhhcyBubyByZWFzb24gdG8gdG91Y2ggdGhlIHdhdGNoZG9n
DQpibG9jay4gUlRDIHdvcmtzIGp1c3QgZmluZSB3aXRob3V0IHdhdGNoZG9nLiBTbyBmcm9tIEhX
IHBvaW50IHRoZXJlIGlzDQpubyBkZXBlbmRlbmN5Lg0KDQpBY3R1YWxseSwgbm93IHRoYXQgSSB0
aGlrIG9mIGl0IHRoZSByaWdodCB3YXkgdG8gZG8gdGhpcyB3b3VsZCBoYXZlDQpiZWVuIHRoZSBm
dW5jdGlvbiBwb2ludGVyIGluIHBhcmVudCBkYXRhIGFzIHdhcyBkb25lIGluIG9yaWdpbmFsIHBh
dGNoDQpzZXQuIEhXLWNvbGxlYWd1ZXMgdGVuZCB0byByZS11c2UgSFcgYmxvY2tzLCBhbmQgd2Ug
bGlrZSB0byByZS11c2Ugb3VyDQpkcml2ZXJzLiBJZiB0aGUgbmV4dCBQTUlDIGZyb20gUk9ITSB1
c2VzIHNhbWUgUlRDIGJsb2NrIGJ1dCBkb2VzIG5vdA0KcHJvdmlkZSB3YXRjaGRvZyAtIHRoZW4g
aXQgaXMgY2xlYW5lc3Qgc29sdXRpb24gdG8gZmFsbCBiYWNrIHRvDQpmdW5jdGlvbiBwb2ludGVy
IGFuZCBsZWF2ZSBpdCB0byBOVUxMIHdoZW4gdGhlcmUgaXMgbm8gV0RUIG9yIHdoZW4gV0RUDQpp
cyB1bnVzZWQuIEFub3RoZXIgb3B0aW9uIGlzIHRvIGV4cG9ydCBkdW1teSBmdW5jdGlvbiAtIHdo
aWNoIGlzIG5vdCBzbw0KbmljZS4NCg0KQWRkaXRpb25hbCBiZW5lZml0IGZyb20gZnVuY3Rpb24g
cG9pbnRlciB3b3VsZCBoYXZlIGJlZW4gdGhhdCB0aGUNCmZ1bmN0aW9uIHBvaW50ZXIgY2FuIGJl
IG9ubHkgdXNlZCBieSBkcml2ZXJzIHdoaWNoIGhhdmUgYWNjZXMgdG8gaXQuDQpUaGlzIGV4cG9y
dGVkIGZ1bmN0aW9uIGlzIGdsb2JhbGx5IHZpc2libGUuIFRoZSBXRFQgZGlzYWJsZS9lbmFibGUg
aXMNCnZlcnkgc3BlY2lmaWMgcHJvY2VkdXJlIGFuZCBpdCBhY3R1YWxseSB3b3VsZCBiZSBuaWNl
ciBkZXNpZ24gdG8gbm90DQpoYXZlIGl0IHZpc2libGUgZ2xvYmFsbHkuIEl0IGlzIG5vdCBpbnRl
bmRlZCB0byBiZSB1c2VkIGJ5IGFueXRoaW5nDQplbHNlIGJlc2lkZXMgdGhlIFdEVCBhbmQgUlRD
IGhlcmUuDQoNCkJ1dCBJIGNhbid0IHNheSB0aGVyZSB3aWxsIGJlIFBNSUMgd2l0aCBzYW1lIFJU
QyBhbmQgbm8gV0RUIGNvbWluZyBmcm9tDQpST0hNLiBBbHNvLCBJIGFtIG5vdCB0ZXJyaWJseSBl
eGNpdGVkIGFib3V0IHRoZSBvcHRpb24gb2YgY2hhbmdpbmcgdGhpcw0KYmFjayB0byBmdW5jdGlv
bi1wb2ludGVyIGFzIEkgYWxyZWFkeSByZW1vdmVkIHRoZSBwb2ludGVyIGZyb20gcGFyZW50DQpk
YXRhIGFuZCB0aGlzIGNoYW5nZWQgcGFyZW50IGRhdGEgaXMgYWxyZWFkeSBhZGFwdGVkIHRvIGFs
bCBzdWIgZHJpdmVycw0KLSBzbyB0aGlzIGlzIGFsbCBqdXN0IGJhYmJsaW5nLiBNYXliZSBpdCBp
cyBqdXN0IG15IGh1Z2UgZWdvIHNob3V0aW5nDQp0aGVyZSAtICdJIHdhcyByaWdodCwgSSBtdXN0
IGhhdmUgdGhlIGZpbmFsIHNheScuDQoNCkFzIGEgc2lkZSBub3RlLCBJIGFscmVhZHkgZGlkIHN1
Ym1pdCB2MTIgd2l0aCBvdGhlciBzdHlsaW5nIGZpeGVzIGJ1dA0Kd2hpY2ggbGVmdCB0aGUgV0RU
IGZ1bmN0aW9uIGluIE1GRC4gSWYgeW91IHN0aWxsIHNlZSB0aGUgV0RUIGZ1bmN0aW9ucw0Kc2hv
dWxkIGJlIGV4cG9ydGVkIGZyb20gV0RUIC0gdGhlbiBwbGVhc2UgaWdub3JlIHRoZSB2MTIuIEkn
bGwgZG8gdjEzDQphdCB0aGUgYWZ0ZXJub29uIChteSB0aW1lLCB3aGljaCBpcyBvbmx5IGEgYml0
IGFmdGVyIG5vb24geW91ciB0aW1lIEkNCmd1ZXNzKSB3aGljaCB3aWxsIGV4cG9ydCB0aGVzZSBm
dW5jdGlvbnMgZnJvbSBXRFQuIChXZWxsLCBJIGhhZCB0byB0cnkNCm9uY2UgbW9yZSA6RCkNCg0K
QnIsDQogICAgTWF0dGkgVmFpdHRpbmVuDQo=
