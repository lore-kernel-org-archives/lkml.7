Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5EAC33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6B5206DA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 08:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgAHIit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 03:38:49 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:43986 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgAHIit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 03:38:49 -0500
X-AuditID: c0a8fbf4-199ff70000001fa6-1a-5e159517af7c
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 89.91.08102.715951E5; Wed,  8 Jan 2020 09:38:47 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Wed, 8 Jan 2020 09:38:42 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
Thread-Topic: [PATCH v2] dt-bindings: bd718x7: Yamlify and add BD71850
Thread-Index: AQHVvKaMBN7j3D8ruE+qrH4t8rs946ffKzWAgAArhACAAR1FgA==
Date:   Wed, 8 Jan 2020 08:38:42 +0000
Message-ID: <821646c01d3efbba1eaabc7f5da8048fe4f25bbd.camel@fi.rohmeurope.com>
References: <20191227111235.GA3370@localhost.localdomain>
         <20200107130155.GK14821@dell>
         <CAL_JsqJzaS1G-ODb4A5QGdhhJ+SXXYPY0nXvKfJnZKoRP+WmAA@mail.gmail.com>
In-Reply-To: <CAL_JsqJzaS1G-ODb4A5QGdhhJ+SXXYPY0nXvKfJnZKoRP+WmAA@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFEA5BC0FF8A474C8FB46774DF0B9065@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUgTYRjvvZvbq3Zxm5t7XRl2BJaVFQUtkpKgWP0haREUOD3z3Cy9yW0r
        DSIphKnRBynYNC2ZULacLW22lsnya0GKzYqiD8Yq1CilsjJBu9ss/et9nuf39cD7QFxmEatg
        PmtiOJYuoMRRoq4b03fWKasV2g0NlavU1YEPYnVD90CE+v1kD1D/HLZgar+7TqxuejmEqeua
        +kXqsofdklSosdfbgea+9a1E42wuF2vevPCINd+dy/dFHI5OyaFNx/fn69j127Oj9Q7bOXHR
        mdji4L2MUtChqACREJGbkfd6L1YBoqCMfA7QkPXyXNPHN7degQoAoZhMQRWvJIJATmpR8PUF
        XODgpBdDXzzBEBBD7kIP/C48TNqNXP2/5wQ70YjvDybUInIlqv1WLRE8CTINNd9kw1mNAPU8
        c4U4kWQ6Kr/bGfIBZDwqL/0amuOkEjk//YoIb00im2cQD9cKNBqcmZtT6OFUQCT44+Rq5HCv
        D0tTka+tHg/XK1BVZSC0GkFKke/KB9FFEGtdkGCdV1sXqK0L1NYF6msgohmgQjq/QEebmI3J
        HGNO5gz6Qv45Yih0gvDP/ugAs949XoBB4AVxEKMUhP+xXCtbkmPILdHTRn0WZy5gjF6AIE7J
        iaS1PEbk0iUnGc7wD1oKRZSSSAxcypSRQtYxhiliuH/oMggpRHy+rNDKpByjY4rz8gtM8zAG
        IwXzKJXcyLC5DEebTfos4TyyjPx9CNBiPrddkBPGIrqQn4alT8AaeHH0aiMOu682NeIyEWtg
        GZWS+HiJp5ICVW9m/weNASUEVAzBVvHoYv68//uM8REYHxE1IhUiTPQ8pCoFzphDurgHtdNb
        qkY8Cadcuf1uqmxS2rF1Mratxb7lHVuzKXHQFv/NG7Q5zF0Jkq7htNj0vTsqtXnL+04fqLFw
        mb3+vo/jM7cXPZ16HumzdGbHr7Jmt9NX7G9/lTh2ZqVS9yZKxqUTjzLsk9sGzIHW5oPOGu5o
        Uuv52bMtObYTbkpk1NMbk3DOSP8FWT4zDpsDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgZGUgSG8gUGVlcHMsDQoNCk9uIFR1ZSwgMjAyMC0wMS0wNyBhdCAwOTozNyAtMDYwMCwgUm9i
IEhlcnJpbmcgd3JvdGU6DQo+IE9uIFR1ZSwgSmFuIDcsIDIwMjAgYXQgNzowMSBBTSBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0KPiB3cm90ZToNCj4gPiBPbiBGcmksIDI3IERlYyAy
MDE5LCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gDQo+ID4gPiBDb252ZXJ0IFJPSE0gYmQ3
MTgzNyBhbmQgYmQ3MTg0NyBQTUlDIGJpbmRpbmcgdGV4dCBkb2NzIHRvIHlhbWwuDQo+ID4gPiBT
cGxpdA0KPiA+ID4gdGhlIGJpbmRpbmcgZG9jdW1lbnQgdG8gdHdvIHNlcGFyYXRlIGRvY3VtZW50
cyAob3duIGRvY3VtZW50cyBmb3INCj4gPiA+IEJENzE4MzcNCj4gPiA+IGFuZCBCRDcxODQ3KSBh
cyB0aGV5IGhhdmUgZGlmZmVyZW50IGFtb3VudCBvZiByZWd1bGF0b3JzLiBUaGlzDQo+ID4gPiB3
YXkgd2UgY2FuDQo+ID4gPiBiZXR0ZXIgZW5mb3JjZSB0aGUgbm9kZSBuYW1lIGNoZWNrIGZvciBy
ZWd1bGF0b3JzLiBST0hNIGlzIGFsc28NCj4gPiA+IHByb3ZpZGluZw0KPiA+ID4gQkQ3MTg1MCAt
IHdoaWNoIGlzIGFsbW9zdCBpZGVudGljYWwgdG8gQkQ3MTg0NyAtIG1haW4gZGlmZmVyZW5jZQ0K
PiA+ID4gaXMgc29tZQ0KPiA+ID4gaW5pdGlhbCByZWd1bGF0b3Igc3RhdGVzLiBUaGUgQkQ3MTg1
MCBjYW4gYmUgZHJpdmVuIGJ5IHNhbWUNCj4gPiA+IGRyaXZlciBhbmQgaXQNCj4gPiA+IGhhcyBz
YW1lIGJ1Y2svTERPIHNldHVwIGFzIEJENzE4NDcgLSBhZGQgaXQgdG8gQkQ3MTg0NyBiaW5kaW5n
DQo+ID4gPiBkb2N1bWVudCBhbmQNCj4gPiA+IGludHJvZHVjZSBjb21wYXRpYmxlIGZvciBpdC4N
Cj4gPiA+IA0KPiA+ID4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDxtYXR0aS52YWl0
dGluZW5AZmkucm9obWV1cm9wZS5jb20NCj4gPiA+ID4NCj4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4g
PiBjaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ID4gLSBjb25zdHJhaW5zIHRvIHNob3J0IGFuZCBsb25n
IHByZXNzZXMuDQo+ID4gPiAtIHJld29yZGVkIGNvbW1pdCBtZXNzYWdlIHRvIHNob3J0ZW4gYSBs
aW5lIGV4Y2VlZGluZyA3NSBjaGFycw0KPiA+ID4gLSBhZGRlZCAnYWRkaXRpb25hbFByb3BlcnRp
ZXM6IGZhbHNlJw0KPiA+ID4gLSByZW1vdmVkICdjbG9jay1uYW1lcycgZnJvbSBleGFtcGxlIG5v
ZGUNCj4gPiA+IA0KPiA+ID4gIC4uLi9iaW5kaW5ncy9tZmQvcm9obSxiZDcxODM3LXBtaWMudHh0
ICAgICAgICB8ICA5MCAtLS0tLS0tDQo+ID4gPiAgLi4uL2JpbmRpbmdzL21mZC9yb2htLGJkNzE4
MzctcG1pYy55YW1sICAgICAgIHwgMjM2DQo+ID4gPiArKysrKysrKysrKysrKysrKysNCj4gPiA+
ICAuLi4vYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTg0Ny1wbWljLnlhbWwgICAgICAgfCAyMjINCj4g
PiA+ICsrKysrKysrKysrKysrKysNCj4gPiA+ICAuLi4vcmVndWxhdG9yL3JvaG0sYmQ3MTgzNy1y
ZWd1bGF0b3IudHh0ICAgICAgfCAxNjIgLS0tLS0tLS0tLS0tDQo+ID4gPiAgLi4uL3JlZ3VsYXRv
ci9yb2htLGJkNzE4MzctcmVndWxhdG9yLnlhbWwgICAgIHwgMTAzICsrKysrKysrDQo+ID4gPiAg
Li4uL3JlZ3VsYXRvci9yb2htLGJkNzE4NDctcmVndWxhdG9yLnlhbWwgICAgIHwgIDk3ICsrKysr
KysNCj4gPiANCj4gPiBDYW4geW91IHNwbGl0IHRoZXNlIG91dCBwZXItc3Vic3lzdGVtLCBzbyB0
aGF0IEkgY2FuIGFwcGx5IHRoZSBNRkQNCj4gPiBjaGFuZ2VzIHBsZWFzZT8NCj4gDQo+IFRoYXQn
cyBub3QgZ29pbmcgdG8gd29yayBhbnkgbW9yZS4gVGhlIE1GRCBiaW5kaW5nIHJlZmVyZW5jZXMg
dGhlDQo+IGNoaWxkIGJpbmRpbmdzIGFuZCB0aGUgY29tcGxldGUgZXhhbXBsZShzKSByZXNpZGVz
IGluIHRoZSBNRkQNCj4gYmluZGluZy4NCg0KU28gaXMgaXQgT2sgdG8gdGFrZSBhbGwgb2YgdGhl
c2UgaW4gTUZEIHRyZWUgLSBvciBob3cgc2hvdWxkIHRoaXMgYmUNCmRvbmU/IENhbiBSb2IgZ2V0
IHRoZW0gaW4gYWZ0ZXIgYWNrcyBmcm9tIExlZS9NYXJrPw0KDQpCciwNCglNYXR0aSBWYWl0dGlu
ZW4NCg0K
