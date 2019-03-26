Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70996C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B18B20856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbfCZOGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:06:52 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:56168 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfCZOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:06:52 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 10:06:50 EDT
X-AuditID: c0a8fbf4-501ff700000014c1-2a-5c9a2e74340c
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 4C.52.05313.47E2A9C5; Tue, 26 Mar 2019 14:51:48 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Tue, 26 Mar 2019 14:51:42 +0100
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
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>
Subject: Re: [PATCH v11 6/8] rtc: bd70528: Initial support for ROHM bd70528
 RTC
Thread-Topic: [PATCH v11 6/8] rtc: bd70528: Initial support for ROHM bd70528
 RTC
Thread-Index: AQHU4wM0NTHdITzPbEeZv/Wju2wT1qYcgu6AgAFcYgA=
Date:   Tue, 26 Mar 2019 13:51:40 +0000
Message-ID: <1db28c6d6223f2c052c0853121fd7b7aa6f7b227.camel@fi.rohmeurope.com>
References: <cover.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
         <901900e12e2a06865b3649ec94af511fcc6443a3.1553515333.git.matti.vaittinen@fi.rohmeurope.com>
         <20190325170451.GQ30105@piout.net>
In-Reply-To: <20190325170451.GQ30105@piout.net>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <81AF68924370B84D802F4EC304942223@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0wTWRj1zkxnprWjYwW5VtfEJhofCJJocuMa48aYHX6464P4JOJoZ9vG
        Psh0qjySTY3RlcpGExFxltYXD8VGtI1GRQxU3BVcNSggJr6qVZH4wEVXUUFnKAq/7ne/c853
        zk2+S+OGbtJI25ySIDp5u4nUEXVHP4VmSCly5syuFwZU1txKoT9eVVDorb+JQHujMRIdaLiu
        QQ/eXQbo/5YdGCr6XImhN4X3NSh84DNAt86Xkqj7zwaA/j7eQqL2ExcpFDv0L4bKbzdjqLT8
        CoGamxaibbUNFOprO0WgqzUSevy8D58/hgsGgoB73b6N4gLBfO6cfI/iQlUFJHe37QLJHQsG
        Ndy5916K2xfowbju0ITFutXD567npU3LbBZn6rx1w62BshaQfUafEy6d4gWFeh/Q0pCdBesK
        C4AP6GgD2wpgzae9RPxyBcBg6zvMB2iaZOdC3x1KFSSwC2DgxvZ+Ds5e1sJdb4o1KjCaXQKr
        ox/JOGkp7Oj9Z6CeA4t39WJqTbCTYG1pF6HWDPsLbKqqHjBrBPCvYE0/ScumQrngSL8bYH+A
        Bd5X/X2cTYKhp+818dgsLLtwA4/XifD5476BvgnW9kQJNTTOToXV51Pj0vlwR8+TgTETYdHO
        KBXPMAo27o8Ru8EYeYiDPKiWh6jlIWp5iPog0FQB6OBtdgsvCWkpouBJEV1Wh3JscDlCIL42
        b8+CL5H0CGBpYNIz0alypkHDb3LnOiJgLI2ZEplfk5XWiPUuc66Vd1uzRI9dcEcApHFTAhNL
        LMk0MGY+N08QXd+gcTRhSmI2VxZlGljVeaMgZAviN3Q8TZsgkzhDGTpKFCxCzm82uzQIY7RW
        Ha4zJrgFp1kQeY9kzVK3JcutrIsK6RXfH9VMjDubdyjduLQJTKfrDkf9OP2y/pkfNxBOl1Mw
        JjFrVSqrUq0e53ejTpCkvHc0U6Hm0Cs/6fucTsUCUyzG+vapFhI/CBm9YGvQfE3O/6/14MWM
        vMquXnFY6gdh8uyVkwLy1a3a6ZTHu+zhSeLF/gx+ws3wpfrfLY3oRP3PtVLzvEXH6xrSdK4t
        i/yRn0oO5WdsyT5tX55cVtmYPmJkpMLWYfGvmtPZlnxtZHty284v66YFzOEjayLpe4ofxR6V
        5BlzilZkwclhs4lwW/m0abjo5r8CEDzg8AYEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDE5LTAzLTI1IGF0IDE4OjA0ICswMTAwLCBBbGV4YW5kcmUgQmVsbG9uaSB3cm90
ZToNCj4gT24gMjUvMDMvMjAxOSAxNDowNjo0MiswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6
DQo+ID4gU3VwcG9ydCBSVEMgYmxvY2sgaW4gUk9ITSBiZDcwNTI4IHBvd2VyIG1hbmFnZW1lbnQg
SUMuIFN1cHBvcnQNCj4gPiBnZXR0aW5nIGFuZCBzZXR0aW5nIHRoZSB0aW1lIGFuZCBkYXRlIGFz
IHdlbGwgYXMgYXJtaW5nIGFuIGFsYXJtDQo+ID4gd2hpY2ggY2FuIGFsc28gYmUgdXNlZCB0byB3
YWtlIHRoZSBQTUlDIGZyb20gc3RhbmRieSBzdGF0ZS4NCj4gPiANCj4gPiBIVyBzdXBwb3J0cyB3
YWtlIGludGVycnVwdCBvbmx5IGZvciB0aGUgbmV4dCAyNCBob3VycyAoc2VjLCBtaW51dGUNCj4g
PiBhbmQgaG91ciBpbmZvcm1hdGlvbiBvbmx5KSBzbyB3ZSBsaW1pdCBhbHNvIHRoZSBhbGFybSBp
bnRlcnJ1cHQgdG8NCj4gPiB0aGlzIDI0IGhvdXJzIGZvciB0aGUgc2FrZSBvZiBjb25zaXN0ZW5j
eS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0
aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gDQo+IEFja2VkLWJ5OiBBbGV4YW5kcmUgQmVsbG9u
aSA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+DQo+IA0KPiA+ICsJci0+dGltZS5ob3Vy
IHw9IEJENzA1MjhfTUFTS19SVENfSE9VUl8yNEg7DQo+ID4gKwlyLT5kYXkgfD0gYmluMmJjZCh0
LT50bV9tZGF5KTsNCj4gPiArCXItPndlZWsgfD0gYmluMmJjZCh0LT50bV93ZGF5KTsNCj4gPiAr
CXItPm1vbnRoIHw9IGJpbjJiY2QodC0+dG1fbW9uICsgMSk7DQo+ID4gKwlyLT55ZWFyID0gYmlu
MmJjZCh0LT50bV95ZWFyLTEwMCk7DQo+IA0KPiBJZiB5b3UgZXZlciBoYXZlIHRvIHJlc2VuZCwg
cGxlYXNlIGFkZCBzcGFjZXMgYXJvdW5kIHRoYXQgLQ0KDQpHb29kIGNhdGNoLCB0aGFua3MhIEkg
d29uZGVyIHdoeSBJIGRpZG4ndCBnZXQgY2hlY2twYXRjaCB3YXJuaW5nLi4uIEkNCnNob3VsZCd2
ZSBoYWQgb25lLiAoSSB1c3VhbGx5IGRvIHJ1biBjaGVja3BhdGNoKS4NCg0KQW55d2F5cywgSSds
bCBhZGQgc3BhY2VzIGlmIEkgbmVlZCB0byByZXNwaW4gdGhlIHNlcmllcy4NCg0KQnIsDQogICAg
TWF0dGkgVmFpdHRpbmVuDQoNCg==
