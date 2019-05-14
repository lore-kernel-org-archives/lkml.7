Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B44EC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D643208CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 06:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfENGOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 02:14:52 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:61464 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbfENGOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 02:14:47 -0400
X-AuditID: c0a8fbf4-519ff700000014c1-98-5cda5cd5eff3
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 02.23.05313.5DC5ADC5; Tue, 14 May 2019 08:14:45 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Tue, 14 May 2019 08:14:41 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "angus@akkea.ca" <angus@akkea.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>
Subject: regulator: BD71837: possible regression
Thread-Topic: regulator: BD71837: possible regression
Thread-Index: AQHVChxRpztiZk/CxkiSfV6HgmFFIw==
Date:   Tue, 14 May 2019 06:14:41 +0000
Message-ID: <4efe8d75766719eee3987fd80b2c11a0e66c75fa.camel@fi.rohmeurope.com>
References: <34f520784f0b489861d62bc30749bf2a@www.akkea.ca>
In-Reply-To: <34f520784f0b489861d62bc30749bf2a@www.akkea.ca>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE478F9CF38C5C478ABFD0D5168622A4@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIKsWRmVeSWpSXmKPExsVyYMXvTbpXY27FGPxp0LZ4fP82o8XUh0/Y
        LC7vmsPmwOwxtWsFo8emVZ1sHp83yQUwR3HbJCWWlAVnpufp2yVwZyzcYFvQoFFxfV4/cwPj
        H7UuRk4OCQETiflPVrN2MXJxCAlcY5TY//gXI4RzglFi9pI9QBkODjYBG4mum+wgDSICqhLn
        Ti5iBqlhFljEKLHt4GlWkISwgIHE7I3HoIpMJdqntUPZehKTF14Em8MC1Nw5RR8kzCvgJ3Gl
        7SVYWEjAWmL6LneQMCfQpp/HboJNZBSQlehseMcEYjMLiEtsevadFeJmAYkle84zQ9iiEi8f
        /4OKK0ns/fmQBWQks4CmxPpd+hCtDhITZ31hh7AVJaZ0P2SHuEBQ4uTMJywTGMVmIdkwC6F7
        FpLuWUi6ZyHpXsDIuopRIjcxMyc9sSTVUK8otVSvKD8jF0gl5+duYoRE2pcdjP8PeR5iFOBg
        VOLhlTW/FSPEmlhWXJl7iFGSg0lJlPdx340YIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8UYpA
        Od6UxMqq1KJ8mJQ0B4uSOO/vXQdjhARANmenphakFsFkZTg4lCR4s6OB9ggWpaanVqRl5pQg
        pJk4OEGGc0mJFKfmpaQWJZaWZMSDkkp8MTCtgKR4gPY+BmnnLS5IzAWKQrSeYtTmOLDo4Vxm
        jrcHn89lFmLJy89LlRLnvRsFVCoAUppRmge36BWjONC/wrzOIIN4gOkYbs4roBVMQCsCiq+B
        rChJREhJNTCuFOG6+XJG2vx9NXVbJ8t1NJxrqNjHljfBkD3L1vXO9lkHzl6Vn37l4NMU1SUt
        uSvt1b21zvyq3rWrzm6uPMvCTcvkOt67GsVOli1kTuGJar82dfm962+6BWwLH63ftk37WOnf
        FaHHuJI1Ep8YVSXWcW8TsOTKm/GR95XUi8MpXcZt1ftFy0uUWIozEg21mIuKEwHlk0yohAMA
        AA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gQW5ndXMsDQoNCkknbGwgYWRkIHRoZSBsaW51eCBsaXN0IGFuZCBNYXJrIHRvIENDIGFz
IHRoaXMgc291bmRzIGxpa2UgYSByZWdyZXNzaW9uDQp3aGljaCBtYXkgaW1wYWN0IHRvIG90aGVy
IHJlZ3VsYXRvciBkcml2ZXJzIHRvby4gTWFyaywgcGxlYXNlIGxldCBtZQ0Ka25vdyBpZiB5b3Ug
ZG9uJ3QgZmVlbCBhZGRpbmcgeW91IHRvIGRpc2N1c3Npb25zIGxpa2UgdGhpcyBhcmUNCmFwcHJv
cHJpYXRlIHNvIEkgZG9uJ3QgZG8gaXQgaW4gdGhlIGZ1dHVyZS4NCg0KT24gTW9uLCAyMDE5LTA1
LTEzIGF0IDE3OjIxIC0wNzAwLCBBbmd1cyBBaW5zbGllIHdyb3RlOg0KPiBIaSBNYXR0aSwNCj4g
DQo+IEkndmUgYmVlbiBkb2luZyBzb21lIGludGVncmF0aW9uIHdpdGggb3VyIGZlYXR1cmUgYnJh
bmNoZXMgb24gbGludXgtDQo+IG5leHQgDQo+IChuZXh0LTIwMTkwNTEwKSBhbmQgSSBoaXQgYSBz
bmFnIGFzIHNvb24gYXMgSSBlbmFibGUgdGhlIEJENzE4MzcuDQo+IA0KPiBUaGVyZSdzIGEgY291
cGxlIG9mIHdlaXJkIHRoaW5ncyBJJ20gc2VlaW5nDQo+IA0KPiBbICAgIDAuOTA3MDI1XSBiZDcx
OHh4LXBtaWMgYmQ3MTh4eC1wbWljLjIuYXV0bzogbm8gZGVmYXVsdCBwaW5jdHJsIA0KPiBzdGF0
ZQ0KPiBbICAgIDAuOTA3NjUxXSBiZDcxOHh4LXBtaWMgYmQ3MTh4eC1wbWljLjIuYXV0bzogVW5s
b2NrZWQgbG9jaw0KPiByZWdpc3RlciANCj4gMHgyZg0KPiBbICAgIDAuOTMyNDgzXSByb2htLWJk
NzE4eDcgMC0wMDRiOiBMb29raW5nIHVwIGJ1Y2s2LXN1cHBseSBmcm9tDQo+IGRldmljZSANCj4g
dHJlZQ0KPiBbICAgIDAuOTMyNDk5XSByb2htLWJkNzE4eDcgMC0wMDRiOiBMb29raW5nIHVwIGJ1
Y2s2LXN1cHBseSBwcm9wZXJ0eQ0KPiBpbiANCj4gbm9kZSAvc29jQDAvYnVzQDMwODAwMDAwL2ky
Y0AzMGEyMDAwMC9wbWljQDRiIGZhDQo+IGlsZWQNCj4gWyAgICAwLjkzNzg2MV0gcm9obS1iZDcx
OHg3IDAtMDA0YjogTG9va2luZyB1cCBidWNrNy1zdXBwbHkgZnJvbQ0KPiBkZXZpY2UgDQo+IHRy
ZWUNCj4gWyAgICAwLjkzNzg3N10gcm9obS1iZDcxOHg3IDAtMDA0YjogTG9va2luZyB1cCBidWNr
Ny1zdXBwbHkgcHJvcGVydHkNCj4gaW4gDQo+IG5vZGUgL3NvY0AwL2J1c0AzMDgwMDAwMC9pMmNA
MzBhMjAwMDAvcG1pY0A0YiBmYQ0KPiBpbGVkDQoNCkRvZXMgdGhpcyBtZWFuIHdlIGhhdmUgYSBy
ZWdyZXNzaW9uIGluIGxpbnV4LW5leHQ/IEkgZ3Vlc3MgeW91IGhhdmUgbm90DQpzZWVuIHRoZXNl
IGlzc3VlcyBpbiBvbGRlciBrZXJuZWxzPw0KDQo+IFdoYXQgc2hvdWxkIGJ1Y2s2Lzcgc3VwcGx5
IGJlIHNldCB0byA/DQoNClRoZSBidWNrNiBhbmQgYnVjazcgYXJlIG5vdCBzdXBwbGllZCBieSBh
bnkgb3RoZXIgcmVndWxhdG9ycy4gV2hhdCBpcw0Kc3BlY2lhbCBhYm91dCBidWNrNiBhbmQgYnVj
azcgaXMgdGhhdCB0aGV5IGFyZSBzdXBwbHlpbmcgTERPcyA1IGFuZCA2Lg0KU28gSSBhc3N1bWUg
dGhlIHByb2JsZW0gZW1lcmdlcyB3aGVuIExET3MgYXJlIHRyeWluZyB0byBmaW5kIHRoZWlyDQpz
dXBwbGllcnMuIChJIGFtIG5vdCBzdXJlIGlmIHN1cHBsaWVyIGlzIGNvcnJlY3Qgd29yZCAtIGJ1
dCB3aGF0IEkgbWVhbg0KaXMgdGhhdCBidWNrcyA2IGFuZCA3IGFyZSBraW5kIG9mIHBhcmVudHMg
Zm9yIExET3MpLiBUaGlzIGlzIHJlZmxlY3RlZA0KaW4gcmVndWxhdG9yX2Rlc2MgZm9yIExET3Mu
IChUaGUgc3VwcGx5X25hbWUgZmllbGQgaXMgc2V0KS4NCg0KSSBhbSBub3Qgc3VyZSBidXQgcGVy
aGFwcyB0aGUgcmVndWxhdG9yIGNvcmUgaXMgY2hhbmdlZCBzbyB0aGF0IHRoaXMNCnBhcmVudC9j
aGlsZCByZWxhdGlvbiBtdXN0IGJlIG1vZGVsbGVkIHVzaW5nIDxmb28+LXN1cHBseSBwcm9wZXJ0
aWVzIGluDQpkZXZpY2UtdHJlZS4gQXJlIHlvdSBhYmxlIHRvIGJpc2VjdCB0aGUgY2hhbmdlIHdo
aWNoIGJyZWFrcyB0aGlzPyBUaGVyZQ0KbWF5IGJlIG90aGVyIHJlZ3VsYXRvciBkcml2ZXJzIGRv
aW5nIHRoZSBzYW1lIGFzIGJkNzE4eDcgaXMgKHdoaWNoDQptZWFucyB0cnVzaXRpbmcgdG8gc2V0
dGluZyB0aGUgc3VwcGx5X25hbWUgaW4gZGVzYyB0byBiZSBlbm91Z2ggLSBhbmQNCndpdGhvdXQg
ZGVlcGVyIHVuZGVyc3RhbmRpbmcgSSdkIHNheSBpdCBzaG91bGQgYmUgZW5vdWdoKS4NCg0KSWYg
dGhpcyBjaGFuZ2UgaXMgaW50ZW50aW9uYWwgYW5kIGJ1Y2s2LXN1cHBseSBhbmQgYnVjazctc3Vw
cGx5IGFyZSBib3cNCnJlcXVpcmVkIGFsc28gaW4gRFQsIHRoZW4gd2Ugc2hvdWxkIHJlZmxlY3Qg
dGhpcyBmYWN0IGFsc28gaW4gYmluZGluZ3MNCmRvYyBmb3IgQkQ3MTgzNyBhbmQgQkQ3MTg0Ny4N
Cg0KPiBUaGUgcnRjIGFsc28gc2VlbXMgdG8gaGF2ZSBsb3N0IGl0J3MgbWluZA0KPiANCj4gWyAg
NDk3LjM2MzYyMV0gcnRjIHJ0YzA6IFRpbWVvdXQgd2FpdGluZyBmb3IgTFBTUlQgQ291bnRlciB0
byBjaGFuZ2UNCj4gDQo+IEFtIEkgbWlzc2luZyBsaW5raW5nIHRoZSBiZDcxODM3IGNsb2NrIHRv
IHRoZSBydGMgc29tZWhvdyA/DQoNCkkgZG9uJ3QgdGhpbmsgdGhlcmUgaXMgYW55IFNXIGFjdGlv
bnMgcmVxdWlyZWQuIFRoZSAzMC43MksgY2xvY2sgY2FuIGJlDQpjb250cm9sbGVkIHVzaW5nIGNs
ay1iZDcxOHg3IGRyaXZlciAtIGJ1dCBJIGRvbid0IHRoaW5rIHRoZXJlIGhhcyBiZWVuDQpjaGFu
Z2VzIHRoZXJlIGFuZCB0aGlzIGRyaXZlcnMgc2hvdWxkIG5vdCB0b3VjaCB0aGUgY2xrIGdhdGUg
dW5sZXNzDQphc2tlZCBieSBzb21lIHVzZXIuIFN0aWxsLCBpZiB0aGUgYnVja3M2LzcgZ2V0IGRp
c2FibGVkIGZvciBzb21lIHJlYXNvbg0KKG9yIGlmIExET3MgYXJlIGVuYWJsZWQgYmVmb3JlIHRo
ZXNlIGJ1Y2tzIGFyZSBlbmFibGVkKSAtIHRoZW4sIHdpdGhvdXQNCnRoZSBjb3JyZWN0IHBhcmVu
dCBjaGlsZCByZWxhdGlvbiB0aGUgTERPcyBjYW4ndCBnZXQgZW5hYmxlZCAtIGFuZA0Kdm9sdGFn
ZSBtb25pdG9yaW5nIG1heSBraWNrLWluLiBZZXQsIGFzc3VtaW5nIHRoZSBTb0MgaXMgcG93ZXJl
ZCBieQ0KYmQ3MTgzNyB0aGlzIHNob3VsZCBwcm9iYWJseSBsZWFkIHRvIHJlc2V0LWxvb3AgYW5k
IG5vdCBqdXN0IHRvIGNsb2NrDQplcnJvcnMuLi4NCg0KSSB3b3VsZCBkZWZpbml0ZWx5IHN0YXJ0
IGxvb2tpbmcgYXQgdGhlIGNoYW5nZXMgaW4gaG93IHN1cHBsaWVycyBhcmUNCmxvb2tlZCB1cCBh
bmQgbWF5YmUgYWxzbyB0cmllZCBzZXR0aW5nIHRoZSBidWNrNi1zdXBwbHkgYW5kIGJ1Y2s3LQ0K
c3VwcGx5IHByb3BlcnRpZXMgd2l0aCBwaGFuZGxlcyB0byBidWNrNiBhbmQgYnVjazcgbm9kZXMu
IEkgY2FuIGFsc28NCnRyeSBjaGVja2luZyB0aGUgY29yZSBpZiB5b3UgZG9uJ3QgaGF2ZSB0aGUg
cG9zc2liaWxpdHkgdG8gZG8gYmlzZWN0aW5nDQotIGJ1dCBJIGFtIG5vdCBhYmxlIHRvIGRvIGl0
IHJpZ2h0IG5vdy4gSXQgbWF5IGJlIEkgY2FuIGNoZWNrIHRoaXMgb25seQ0KYXQgbmV4dCB3ZWVr
Lg0KDQo+IEFuZCBmaW5hbGx5IHRoZSByZXNldCBpcyBoYW5naW5nIGFnYWluIGV2ZW4gd2l0aCAN
Cj4gInJvaG0scmVzZXQtc252cy1wb3dlcmVkIi4NCg0KVGhpcyBjb3VsZCB3ZWxsIGJlIGR1ZSB0
byB0aGUgbWlzc2luZyBwYXJlbnQvY2hpbGQgcmVsYXRpb24gYmV0d2Vlbg0KYnVja3MgYW5kIExE
T3MuDQoNCj4gDQo+IFBvaW50ZXJzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0KPiANCj4gVGhhbmtz
DQo+IEFuZ3VzDQoNCkJyLA0KCU1hdHRpIFZhaXR0aW5lbg0K
