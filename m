Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06E7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA01218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 13:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbfCUNFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 09:05:35 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:53710 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728113AbfCUNFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 09:05:35 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 09:05:34 EDT
X-AuditID: c0a8fbf4-519ff700000014c1-a5-5c9388976947
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 14.2E.05313.798839C5; Thu, 21 Mar 2019 13:50:31 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Thu, 21 Mar 2019 13:50:31 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "lee.jones@linaro.org" <lee.jones@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "elven.wang@nxp.com" <elven.wang@nxp.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "angus.ainslie@puri.sm" <angus.ainslie@puri.sm>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "anson.huang@nxp.com" <anson.huang@nxp.com>,
        "matt.vaittinen@fi.rohmeurope.com" <matt.vaittinen@fi.rohmeurope.com>,
        "yibin.gong@nxp.com" <yibin.gong@nxp.com>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH v3 1/3] devicetree: bindings: bd718x7: document HW state
 related ROHM specific properties
Thread-Topic: [PATCH v3 1/3] devicetree: bindings: bd718x7: document HW
 state related ROHM specific properties
Thread-Index: AQHUxEiO3hjN4ldMcEGqO0lz+ru+2qYUoSeAgAFVBB6AADnOgA==
Date:   Thu, 21 Mar 2019 12:50:30 +0000
Message-ID: <74b5d125c5cac75b3ab37ff2202966fb3f3395a1.camel@fi.rohmeurope.com>
References: <cover.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
         <6ed4238fb083f52de0f5f013647b2334bad8ebe4.1550135853.git.matti.vaittinen@fi.rohmeurope.com>
         <20190320130259.GN4731@dell> <20190320141701.GA6208@localhost.localdomain>
         <20190321082338.GT4731@dell>
In-Reply-To: <20190321082338.GT4731@dell>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A9EDC7EB113F94184FBFE7E244C0153@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUgTYRzHe+5ut3Pu4pove1pvtIioUFMqrgjTIFoRvdAfvSjomdcmupfu
        NtmCYEVqzrIXk3CkiRmUmLWBOU1pLgsLKqRcWZbMVtbAkEwlg+yuq9w/9/ye3/f3/X2eh+d3
        BKpqxzVEgcnKciamSIsrMP+Nn56ky6erstf4hmm62xNE6baaw3R1KIzTV3ueyehG1xeUHpp4
        COjJl6cR+kXHFZy+/qoPoa9c78Xokq4eOV1x5ynIUOqa65qBrt39Tq7zNpXjusFgJ67zfPUh
        umHfG6Ab9y7eIz8UuymPsRbvK9CbUtJzYw2/KidRS328/cKEGzjBYJwLxBCQWgsDZddwF1AQ
        KqofwPqZelTa9AqbiW+ICxAETm2CrgG5aIinUmFj70dMrEGp9zI4+HlMLtbEUWYYPHtcqrHA
        Bw3lMineAi/e7f9TglHLYWs/K6ZJahccmOyRS6gLCLx3qhYRhRhqJay8P4WJMaAWwXLn1z95
        lFJD76cpmXRoCjZ2PkelOAF++fDrb14Lu36EMJGFCn1ud6RI1gx4xtWFS/FSeKkiJJfOMA8+
        rglj50GiO4rgnnW7o9zuKLc7yl0PZE0AGpmCIj1jZVOTOdaWzJkNRmE5bDZ6gfTs331gJrA9
        ACgCaJVka3FVtkrGFPMOYwDMJxBtAllnF1Jz88z5DgPDG3I4WxHLBwAkUG082ZElaGQ+4zjG
        cuZ/0gIC06rJ1QZBokRyIctaWO6fupAgtJBUCqOmmsexetZ+pKDIOisjRIzYXKGJ51lTPssx
        NqshRxyWHF6YFlFSCtzpMpHLWxijkJWsT0Aq4W8I1aJE95T4He0eqUVVmMlsYjVqsk80UKLB
        YDP9x0WAWrh1HHmzVFCVwv/wv1tEACECqKXunAiyMrOSxgm4RGzjTGd6zavpjWlvHyY9vX2q
        ZWTu3rz9udXfs5wXI+cWlZYoUsL2Hfq0yPiJdH8M2HbQ7h7avKS9bHq0caeCGC59sAFT+5PC
        Ncgc9GTb/OTXoZOaxJJMz2CedSwrwB0wNq27+xjTbS1tde2OXbqCf3SoL9hQeGv9sgZbJnAc
        1WK8gUldhXI88xsdS39tzAMAAA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTAzLTIxIGF0IDA4OjIzICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+IE9u
IFdlZCwgMjAgTWFyIDIwMTksIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gDQo+ID4gSGVsbG8g
TGVlLCBBbGwNCj4gPiANCj4gPiBPbiBXZWQsIE1hciAyMCwgMjAxOSBhdCAwMTowMjo1OVBNICsw
MDAwLCBMZWUgSm9uZXMgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIDE0IEZlYiAyMDE5LCBNYXR0aSBW
YWl0dGluZW4gd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gQWRkIFJPSE0gQkQ3MTgzNyAvIEJENzE4
NDcgc3BlY2lmaWMgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yDQo+ID4gPiA+IGNvbnRyb2xsaW5n
IHRoZSBQTUlDIHNodXRkb3duL3Jlc2V0IHN0YXRlcyBhbmQgdm9sdGFnZXMgZm9yDQo+ID4gPiA+
IGRpZmZlcmVudCBIVyBzdGF0ZXMuIFRoZSBQTUlDIHdhcyBkZXNpZ25lZCB0byBiZSB1c2VkIHdp
dGggTlhQDQo+ID4gPiA+IGkuTVg4IFNvQyBhbmQgaXQgc3VwcG9ydHMgU05WUyBsb3cgcG93ZXIg
c3RhdGUgd2hpY2ggc2VlbXMgdG8NCj4gPiA+ID4gYmUgdHlwaWNhbCBmb3IgTlhQIGkuTVggU29D
cy4gSG93ZXZlciwgd2hlbiBTTlZTIGlzIHVzZWQgd2UNCj4gPiA+ID4gbXVzdA0KPiA+ID4gPiBu
b3QgYWxsb3cgU1cgdG8gY29udHJvbCBlbmFibGluZy9kaXNhYmxpbmcgdGhvc2UgcmVndWxhdG9y
cw0KPiA+ID4gPiB3aGljaA0KPiA+ID4gPiBhcmUgY3J1Y2lhbCBmb3Igc3lzdGVtIHRvIGJvb3Qg
YXMgdGhlcmUgaXMgYSBIVyBsaW1pdGF0aW9uDQo+ID4gPiA+IHdoaWNoDQo+ID4gPiA+IGNhdXNl
cyBTVyBjb250cm9sbGVkIHJlZ3VsYXRvcnMgdG8gYmUga2VwdCBzaHV0IGRvd24gYWZ0ZXIgU05W
Uw0KPiA+ID4gPiByZXNldC4NCj4gPiA+ID4gDQo+ID4gPiA+IEFsbG93IHNldHRpbmcgdGhlIFNO
VlMgdG8gYmUgdXNlZCBhcyByZXNldCB0YXJnZXQgc3RhdGUgYW5kDQo+ID4gPiA+IGFsbG93DQo+
ID4gPiA+IG1hcmtpbmcgdGhvc2UgcmVndWxhdG9ycyB3aGljaCBhcmUgY3JpdGljYWwgZm9yIGJv
b3QuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPA0K
PiA+ID4gPiBtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL3JvaG0sYmQ3MTgzNy1wbWljLnR4
dCAgfCAxNw0KPiA+ID4gPiArKysrKysrKysrDQo+ID4gPiA+ICAuLi4vYmluZGluZ3MvcmVndWxh
dG9yL3JvaG0sYmQ3MTgzNy1yZWd1bGF0b3IudHh0ICB8IDM4DQo+ID4gPiA+ICsrKysrKysrKysr
KysrKysrKysrKysNCj4gPiA+ID4gIDIgZmlsZXMgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKQ0K
PiA+ID4gDQo+ID4gPiBOZWVkcyBhIERUIEFjay4NCj4gPiANCj4gPiBJIHRoaW5rIHRoaXMgd2Fz
IGFscmVhZHkgYXBwbGllZCB0byByZWd1bGF0b3IgdHJlZSBieSBNYXJrOg0KPiA+IA0KaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYnJvb25pZS9yZWd1bGF0
b3IuZ2l0L2NvbW1pdC8/aD1mb3ItbmV4dCZpZD1mNDNkMWIzODhmOWJlNGFhNDdlZDQyYzMzNjU5
MjQzYTY3NWM1Yzc2DQo+ID4gRG9lcyBpdCBnbyBpbiB2aWEgaGlzIHRyZWUgb3IgZG8gd2UgbmVl
ZCB0byBhcHBseSBpdCBpbiBMZWUncyB0cmVlDQo+ID4gdG9vPw0KPiANCj4gV2h5IGRvbid0IEkg
c2VlIGFuIGVtYWlsIGZyb20gTWFyaz8NCj4gDQoNCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC8yMDE5MDIxNDE2MDAyNS42NUI4RTExMjZGNzhAZGVidXRhbnRlLnNpcmVuYS5vcmcudWsv
DQoNCk1heWJlIHRoYXQncyB3aGF0IHlvdSdyZSBsb29raW5nIGZvcj8NCg0KQnIsDQoJTWF0dGkg
VmFpdHRpbmVuDQo=
