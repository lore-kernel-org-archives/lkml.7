Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E912C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F51720830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDCMBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:01:01 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:60596 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCMBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:01:00 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 08:00:59 EDT
X-AuditID: c0a8fbf4-501ff700000014c1-dc-5ca49cf4e312
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 0F.8A.05313.4FC94AC5; Wed,  3 Apr 2019 13:45:56 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Wed, 3 Apr 2019 13:45:51 +0200
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
Thread-Index: AQHU4wL8Fp/G2VuRn0+8cMWLA5gmIqYp9w8AgABCplmAACBVUv//5ACA
Date:   Wed, 3 Apr 2019 11:45:50 +0000
Message-ID: <85b20828bb4fb51e6df1d5d9d1c1f667db3a7c48.camel@fi.rohmeurope.com>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
         <39efebe0396dd42de30d37c6f3c1ef2926c90210.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
         <20190403073152.GM4187@dell> <20190403084732.GA3493@localhost.localdomain>
         <20190403093015.GJ11301@dell> <20190403101003.GC3493@localhost.localdomain>
         <20190403112559.GP11301@dell>
In-Reply-To: <20190403112559.GP11301@dell>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <92B1E7367AA9934D865F65F13A34DA84@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUgTcRjH+d3d7s7lxbVW+7VewFFERpn0wo+oCKK4XpDoDQlpXXo6yW1y
        23QW6OjNl4oKVuHyrZi92DBcEb1o5bCcJoVkpmHJULOslqX2KtadV+lf9+X5Pt/n8/zgORrX
        fCH1dKrFLogWPs1AqokHl39VLRgs8iYsOlK1CHmbn1MoN3yRQoPFjQQ6HeomUWndExXqHHoI
        0NeWPAy5hy9h6POx1yp0vXQYoGd3ikg0cLwOoEdXW0jUVnmPQt3nmzBU/qIZQ0XlQQI1N65F
        h2vqKDTSWkWgx3ftqOvdCL56Kucr8QHuU9thiivx7edue15RnL8in+Q6WqtJ7orPp+Juf3NR
        3NmSHxg34J+1Wb1zwoo9vD1ja2qKJWbV7gmm68e+UOmXlzuHOvpJF3iLCkAEDdkl0NVbRRYA
        Na1hWwEsqshTyYaGrQewxe0sADRNsitgQTsll7VsLPQGewhZ42x7BOy6ECfryexG+OJmLaH0
        bILhg22YotfBoYOto1mCnQ2Hwp9GxzNsHPx5Ig9XuCEMNh3qGW2KYKPho19PcFkDdibMd4Ux
        BaaD/jffVMrSLPRWP8UVPQW+6xr5WzfAmh8hQt4ZZ+fBa3dilOhqOJCbjys6CrqPhihlh0mw
        obCbOAmmesYRPGNpz7i0Z1zaMy5dBlQVAJr51LQU3i7ELhQFx0LRajJLn0Sr2Q+Uqxm8BX4H
        1gcASwNDJHPmjDdBo+IzbFnmAJhGY4YpzLJsqTRxjzUpy8TbTEbRkSbYAgDSuEHLNJ0oS9Aw
        SXzWPkG0/rOm04RBx2RecidoWJm8VxDSBfGfO4OmDZAB56Shk0QhRXAmp6bZx2yMjpCHq/Va
        m2BJEkTeYTcZ5WMx2qRrka1IifveI8UZWzpvlqpKtBHMpx9cCBXj9Mfa3mJcQ1isFkGvY4wy
        iZVbTQ7Lf1Af0EnvncwIshsp/Uj/5/RJCExCIEepjLDzY5beBa6tyZzlPurP2XFy65y5fTHb
        tRvDLcNC1IdKQpvREJ+3Ltp3bxsdv+VUSaI/Z2mF82lccnJ8stUR3LAfN3bUBNfULi7fdT/7
        RlIgp7Ow/3Fd/cUDuV1zyuYXJs4LdeoehuEp50ymf+33KE25OjO7uje4Uv/y/TOL0ZlV2dNk
        b5+93UDYTHxsNC7a+D+78skLBQQAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTA0LTAzIGF0IDEyOjI1ICswMTAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFdlZCwgMDMgQXByIDIwMTksIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gDQo+ID4gT24gV2Vk
LCBBcHIgMDMsIDIwMTkgYXQgMTA6MzA6MTVBTSArMDEwMCwgTGVlIEpvbmVzIHdyb3RlOg0KPiA+
ID4gT24gV2VkLCAwMyBBcHIgMjAxOSwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiA+ID4gDQo+
ID4gPiA+IEhlbGxvIExlZSwNCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgdGFraW5nIGEg
bG9vayBvbiB0aGlzIGFnYWluID0pIEkgYWdyZWUgd2l0aCBtb3N0IG9mDQo+ID4gPiA+IHRoZQ0K
PiA+ID4gPiBjb21tZW50cyBhbmQgY29ycmVjdCB0aGVtIGF0IG5leHQgdmVyc2lvbi4NCj4gPiA+
ID4gDQo+ID4gPiA+IE9uIFdlZCwgQXByIDAzLCAyMDE5IGF0IDA4OjMxOjUyQU0gKzAxMDAsIExl
ZSBKb25lcyB3cm90ZToNCj4gPiA+ID4gPiBPbiBNb24sIDI1IE1hciAyMDE5LCBNYXR0aSBWYWl0
dGluZW4gd3JvdGU6DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBST0hNIEJENzA1MjhNV1YgaXMg
YW4gdWx0cmEtbG93IHF1aWVzY2VudCBjdXJyZW50IGdlbmVyYWwNCj4gPiA+ID4gPiA+IHB1cnBv
c2Ugc2luZ2xlLWNoaXAgcG93ZXIgbWFuYWdlbWVudCBJQyBmb3IgYmF0dGVyeS1wb3dlcmVkDQo+
ID4gPiA+ID4gPiBwb3J0YWJsZSBkZXZpY2VzLg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBB
ZGQgTUZEIGNvcmUgd2hpY2ggZW5hYmxlcyBjaGlwIGFjY2VzcyBmb3IgZm9sbG93aW5nDQo+ID4g
PiA+ID4gPiBzdWJkZXZpY2VzOg0KPiA+ID4gPiA+ID4gCS0gcmVndWxhdG9ycy9MRUQgZHJpdmVy
cw0KPiA+ID4gPiA+ID4gCS0gYmF0dGVyeS1jaGFyZ2VyDQo+ID4gPiA+ID4gPiAJLSBncGlvcw0K
PiA+ID4gPiA+ID4gCS0gMzIuNzY4a0h6IGNsaw0KPiA+ID4gPiA+ID4gCS0gUlRDDQo+ID4gPiA+
ID4gPiAJLSB3YXRjaGRvZw0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBNYXR0aSBWYWl0dGluZW4gPA0KPiA+ID4gPiA+ID4gbWF0dGkudmFpdHRpbmVuQGZpLnJvaG1l
dXJvcGUuY29tPg0KPiA+ID4gPiA+ID4gKyAqIE1hcHBpbmcgb2YgbWFpbiBJUlEgcmVnaXN0ZXIg
Yml0cyB0byBzdWIgaXJxIHJlZ2lzdGVyDQo+ID4gPiA+ID4gPiBvZmZzZXRzIHNvDQo+ID4gPiA+
ID4gDQo+ID4gPiA+ID4gInN1Yi1JUlEiDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiArICogdGhh
dCB3ZSBjYW4gYWNjZXNzIGNvcmVjdCBzdWIgSVJRIHJlZ2lzdGVycyBiYXNlZCBvbg0KPiA+ID4g
PiA+ID4gYml0cyB0aGF0DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gInN1YiBJUlEiIGlzIGFsc28g
ZmluZSwgYnV0IHBsZWFzZSBzdGFuZGFyZGlzZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJIGRv
IHByZWZlciAic3ViLUlSUSIgdGhvdWdoLg0KPiA+ID4gPiANCj4gPiA+ID4gSSdsbCBnbyB3aXRo
ICJzdWItSVJRIiB0aGVuDQo+ID4gPiA+IA0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gKyNk
ZWZpbmUgV0RfQ1RSTF9NQUdJQzEgMHg1NQ0KPiA+ID4gPiA+ID4gKyNkZWZpbmUgV0RfQ1RSTF9N
QUdJQzIgMHhBQQ0KPiA+ID4gPiA+ID4gKy8qKg0KPiA+ID4gPiA+ID4gKyAqIGJkNzA1Mjhfd2R0
X3NldCAtIGFybSBvciBkaXNhcm0gd2F0Y2hkb2cgdGltZXINCj4gPiA+ID4gPiA+ICsgKg0KPiA+
ID4gPiA+ID4gKyAqIEBkYXRhOglkZXZpY2UgZGF0YSBmb3IgdGhlIFBNSUMgaW5zdGFuY2Ugd2Ug
d2FudCB0bw0KPiA+ID4gPiA+ID4gb3BlcmF0ZSBvbg0KPiA+ID4gPiA+ID4gKyAqIEBlbmFibGU6
CW5ldyBzdGF0ZSBvZiBXRFQuIHplcm8gdG8gZGlzYWJsZSwgbm9uDQo+ID4gPiA+ID4gPiB6ZXJv
IHRvIGVuYWJsZQ0KPiA+ID4gPiA+ID4gKyAqIEBvbGRfc3RhdGU6CXByZXZpb3VzIHN0YXRlIG9m
IFdEVCB3aWxsIGJlIGZpbGxlZA0KPiA+ID4gPiA+ID4gaGVyZQ0KPiA+ID4gPiA+ID4gKyAqDQo+
ID4gPiA+ID4gPiArICogQXJtIG9yIGRpc2FybSBXRFQgb24gQkQ3MDUyOCBQTUlDLiBFeHBlY3Rl
ZCB0byBiZQ0KPiA+ID4gPiA+ID4gY2FsbGVkIG9ubHkgYnkNCj4gPiA+ID4gPiA+ICsgKiBCRDcw
NTI4IFJUQyBhbmQgQkQ3MDUyOCBXRFQgZHJpdmVycy4gVGhlIHJ0Y190aW1lcl9sb2NrDQo+ID4g
PiA+ID4gPiBtdXN0IGJlIHRha2VuDQo+ID4gPiA+ID4gPiArICogYnkgY2FsbGluZyBiZDcwNTI4
X3dkdF9sb2NrIGJlZm9yZSBjYWxsaW5nDQo+ID4gPiA+ID4gPiBiZDcwNTI4X3dkdF9zZXQuDQo+
ID4gPiA+ID4gPiArICovDQo+ID4gPiA+ID4gPiAraW50IGJkNzA1Mjhfd2R0X3NldChzdHJ1Y3Qg
cm9obV9yZWdtYXBfZGV2ICpkYXRhLCBpbnQNCj4gPiA+ID4gPiA+IGVuYWJsZSwgaW50ICpvbGRf
c3RhdGUpDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2h5IGRvZXNuJ3QgdGhpcyByZXNpZGUgaW4g
dGhlIHdhdGNoZG9nIGRyaXZlcj8NCj4gPiA+ID4gDQo+ID4gPiA+IElmIG15IG1lbW9yeSBzZXJ2
ZXMgbWUgcmlnaHQgd2Ugc2hvcnRseSBkaXNjdXNzZWQgdGhpcyBhbHJlYWR5DQo+ID4gPiA+IGR1
cmluZyB2OA0KPiA+ID4gPiByZXZpZXcgOykgQ2FudCBibGFtZSB5b3UgdGhvdWdoIGFzIEkgaGF2
ZSBzZWVuIHNvbWUgb2YgdGhlIG1haWwNCj4gPiA+ID4gdHJhZmZpYw0KPiA+ID4gPiBnb2luZyB0
aHJvdWdoIHlvdXIgaW5ib3ggOkQNCj4gPiA+ID4gDQo+ID4gPiA+IFRoZSBtb3RpdmF0aW9uIHRv
IGhhdmUgdGhlIGZ1bmN0aW9ucyBleHBvcnRlZCBmcm9tIE1GRCBpcyB0bw0KPiA+ID4gPiBub3Qg
Y3JlYXRlDQo+ID4gPiA+IHNpcmVjdCBkZXBlbmRlbmN5IGJldHdlZW4gUlRDIGFuZCBXRFQuIFRo
ZXJlIG1heSBiZSBjYXNlcyB3aGVyZQ0KPiA+ID4gPiB3ZSB3YW50DQo+ID4gPiA+IHRvIGxlYXZl
IGVpdGhlciBSVEMgb3IgV0RUIG91dCBvZiBjb21waWxhdGlvbi4gTUZEIGlzIGFsd2F5cw0KPiA+
ID4gPiBuZWVkZWQgc28NCj4gPiA+ID4gdGhlIGRlcGVuZGVuY3kgZnJvbSBNRkQgdG8gUlRDL1dE
VCBkb2VzIG5vdCBoYXJtLg0KPiA+ID4gPiANCj4gPiA+ID4gKEhlcmUncyBzb21lIGRpc2N1c3Np
b24gbmVjcm9tYW5jeSBpZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4gcmUtDQo+ID4gPiA+IHJlYWRp
bmcNCj4gPiA+ID4gaG93IHdlIGRpZCBlbmQgdXAgd2l0aCB0aGlzIGltcGxlbWVudGF0aW9uOg0K
PiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMTkwMjEyMDkxNzIzLkdaMjA2
MzhAZGVsbC8pDQo+ID4gPiA+IA0KPiA+ID4gPiBJIGhvcGUgeW91IGFyZSBzdGlsbCBPayB3aXRo
IGhhdmluZyB0aGUgV0RUIGNvbnRyb2wgZnVuY3Rpb25zDQo+ID4gPiA+IGluIE1GRC4NCj4gPiA+
IA0KPiA+ID4gT09JLCB3aHkgZG9lcyB0aGUgUlRDIG5lZWQgdG8gY29udHJvbCB0aGUgV0RUPw0K
PiA+IA0KPiA+IEkgdGhvdWdodCBJIGhhZCBhIGNvbW1lbnQgYWJvdXQgdGhpcyBzb21ld2hlcmUg
aW4gY29kZS4uLiBPX28gTXVzdA0KPiA+IGhhdmUNCj4gPiBiZWVuIGluIHNvbWUgZGV2ZWxvcG1l
bnQgYnJhbmNoIEkgaGFkIDovDQo+ID4gDQo+ID4gQW55d2F5cywgc2V0dGluZyB0aGUgUlRDIGNv
dW50ZXIgbWF5IGNhdXNlIHdhdGNoZG9nIHRvIHRyaWdnZXIuIEl0DQo+ID4gaXMgbm90DQo+ID4g
ZnVydGhlciBleHBsYWluZWQgd2h5IGJ1dCBJIHdvdWxkIGd1ZXNzIHdhdGNoZG9nIHVzZXMgUlRD
IGNvdW50ZXINCj4gPiB0byBjaGVjaw0KPiA+IGlmIGl0IHNob3VsZCd2ZSBiZWVuIHBpbmdlZCBh
bHJlYWR5LiBTbyBSVEMgbmVlZHMgdG8gZGlzYWJsZSB3YXRjaA0KPiA+IGRvZyBmb3INCj4gPiB0
aGUgZHVyYXRpb24gb2YgaHdjbG9jayBzZXR0aW5nIGFuZCBlbmFibGUgaXQgYWdhaW4gYWZ0ZXIg
dGhlIG5ldw0KPiA+IHRpbWUgaXMNCj4gPiBzZXQuIEkgY2FuIGFkZCBhIGNvbW1lbnQgYWJvdXQg
dGhpcyB0byBNRkQgZHJpdmVyIGlmIGl0IGhlbHBzIDopDQo+IA0KPiBIb3cgZG9lcyB0aGUgdXNl
ciBzZWxlY3QgYmV0d2VlbiB1c2luZyB0aGUgUlRDIGFuZCB0aGUgV0RUPw0KPiANCj4gT3IgYXJl
IHRoZSBnZW5lcmFsbHkgYm90aCBlbmFibGVkIGF0IHRoZSBzYW1lIHRpbWU/DQo+IA0KDQpCb3Ro
IFJUQyBhbmQgV0RUIGNhbiBiZSBlbmFibGVkIGF0IHRoZSBzYW1lIHRpbWUuIEJ1dCB0aGV5IGFy
ZSBub3QNCnJlcXVpcmVkIHRvIGJlIHVzZWQuIFdoZW4gV0RUIGlzIGVuYWJsZWQsIGl0IHVzZXMg
Y3VycmVudCBSVEMgdGltZSBhcw0KJ2Jhc2UnIChhbmQgUlRDIHRpbWUgaXMgcnVubmluZyBubyBt
YXR0ZXIgaWYgd2UgaGF2ZSB0aGUgUlRDIGRyaXZlcg0KaGVyZSBvciBub3QpIC0gYW5kIHRpbWUt
b3V0IGdldHMgc2NoZWR1bGVkIHRvIHNwZWNpZmllZCBhbW91bnQgb2YgdGltZQ0KaW50byBmdXR1
cmUuIChTYW1lIHNldHRpbmcgdGltZW91dCBpbnRvIHRoZSBmdXR1cmUgaGFwcGVucyB3aGVuIFdE
VCBpcw0KcGluZ2VkKS4NCg0KV2hlbiB3ZSBzZXQgUlRDLCB3ZSBkaXNhYmxlIFdEVCAoaWYgaXQg
d2FzIGVuYWJsZWQpLCBzZXQgY2xvY2sgYW5kIHJlLQ0KZW5hYmxlIFdEVC4gVGhpcyBjYXVzZXMg
dGhlIHByZXZpb3VzbHkgdXNlZCB0aW1lLW91dCB2YWx1ZSB0byBiZSBzZXQgdG8NCldEVCBhZ2Fp
bi4gVGhpcyB3b3JrcyBPayBiZWNhdXNlIEJENzA1MjggZG9lcyBub3Qgc3VwcG9ydCAnc2hvcnQg
cGluZw0KZGV0ZWN0aW9uJy4gT25seSBzaWRlLWVmZmVjdCB3aWxsIGJlIG9uZSAncHJvbG9uZ2Vk
JyBXRFQgZmVlZGluZyBwZXJpb2QNCndoZW4gUlRDIGlzIHNldC4gKGFic29sdXRlIHRpbWUgd2hl
biBSVEMgd2FzIHNldCBtaW51cyBhYnNvbHV0ZSB0aW1lDQp3aGVuIHByZXZpb3VzIFdEIHBpbmcg
b3IgZW5hYmxlIHdhcyBkb25lKSBsb25nZXIgdGhhbiByZXF1bGFyIHBlcmlvZC4NCg0KU28gdXNl
ciBzaG91bGQgbm90IG5lZWQgdG8gY2FyZSBhYm91dCB0aGlzICdkZXBlbmRlbmN5Jy4gQmFzaWNh
bGx5IHRoZQ0Kb25seSBwb3NzaWJsZSBwcm9ibGVtIEkgc2VlIGlzIHRoYXQgc29tZW9uZSBjb3Vs
ZCBhY2NpZGVudGFsbHkgaGFuZyB0aGUNCnN5c3RlbSB3aXRoIHNvbWV0aGluZyB0aGF0IGtlZXBz
IHNldHRpbmcgdGhlIFJUQyB0aW1lIC0gdGhpcyB3b3VsZCB0aGVuDQpwcmV2ZW50IHdhdGNoIGRv
ZyBmcm9tIGRvaW5nIHRoZSByZXNldC4gVGhpcywgSSBiZWxpZXZlLCBpcyBhIGNvcm5lcg0KY2Fz
ZSB3aGljaCBJIGRvbid0IGNvbnNpZGVyIG5vdyAtIGFuZCBpZiB0aGlzIGlzIGNvbnNpZGVyZWQg
dG8gYmUgYW4NCmlzc3VlIHRoZW4gc3VjaCBhIHN5c3RlbSBtYXkgZGlzYWJsZSB0aGUgUlRDIGRy
aXZlciBhbmQgZG8gUlRDIHNldHRpbmcNCmluIGEgd2hhdC1ldmVyLW1hbm5lciBzZWVzIHByYWN0
aWNhbC4NCg0KSSdtIG5vdCBzdXJlIGlmIEkgYW5zd2VyZWQgdG8gcXVlc3Rpb24geW91IGFza2Vk
IHRob3VnaCA9KQ0KDQpCciwNCglNYXR0aSBWYWl0dGluZW4NCg==
