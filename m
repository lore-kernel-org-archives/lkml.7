Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82152C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AB120675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 10:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbfCFKSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 05:18:24 -0500
Received: from mail.osukl.com ([81.134.89.156]:19449 "EHLO mail.osukl.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727133AbfCFKSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 05:18:24 -0500
Received: from OS01.os.local ([fe80::dd48:92d6:34f3:22da]) by OS01.os.local
 ([fe80::dd48:92d6:34f3:22da%16]) with mapi id 14.03.0389.001; Wed, 6 Mar 2019
 10:18:20 +0000
From:   Ryan Pannell <ryan@osukl.com>
To:     Jagan Teki <jagan@amarulasolutions.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-amarula@amarulasolutions.com" 
        <linux-amarula@amarulasolutions.com>
Subject: RE: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD
 initial support
Thread-Topic: [PATCH 2/2] arm64: allwinner: a64: Add Oceanic A64-5inMFD
 initial support
Thread-Index: AQHUzZj1PzRBqQmkXEOapWN/my/XQKXzyHUAgAAMv4CAAw3CAIAAIXsAgAY5JYCAAAJsgIAABYNggAEc0gCAAAJ7AIAACzJA
Date:   Wed, 6 Mar 2019 10:18:18 +0000
Message-ID: <7AB137701821F94BAF7B06C1747BA691011A3FE164@OS01.os.local>
References: <20190226060240.8783-1-jagan@amarulasolutions.com>
 <20190226060240.8783-2-jagan@amarulasolutions.com>
 <20190227153346.dwd3stsbsvf7rwly@flea>
 <CAMty3ZDSZvaxMjcQJLNaTDJQ5OjJ9NbjpOJKWMUE5PhRCzYvqw@mail.gmail.com>
 <20190301145724.vhvyoqkkxdflg2g7@flea>
 <CAMty3ZCUSsN71Q5h_nj6de0Smhqht1S5zq0pLKUqpwq=85XqXw@mail.gmail.com>
 <20190305155919.cm3yrve3vqp7jimh@flea>
 <CAMty3ZD6Bsu7B6phhf4h7jreoM1uvM-ZQNCaUZKKa=1DNOtb8A@mail.gmail.com>
 <7AB137701821F94BAF7B06C1747BA691011A3FE123@OS01.os.local>
 <20190306092708.2pjc7uz6wvku4hkb@flea>
 <CAMty3ZDRAqV10u7QkujxkXtJYOUX8zbxkKtb5oxJMt+2jUbaHg@mail.gmail.com>
In-Reply-To: <CAMty3ZDRAqV10u7QkujxkXtJYOUX8zbxkKtb5oxJMt+2jUbaHg@mail.gmail.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.16.61]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmFnYW4sDQoNClRoZSBjb21wYXRpYmxlIGlzIGZvciB0aGUgcmVhbCBoYXJkd2FyZSBuYW1lIGFz
IE1heGltZSBwcmV2aW91c2x5IGV4cGxhaW5lZC4gVGhlIHBsYXRmb3JtIGlzIGRlc2NyaWJlZCBp
biB0aGUgbGF0dGVyIHBhcnQuDQpQbGVhc2UgdXNlOg0KY29tcGF0aWJsZSA9ICJvY2VhbmljLDUy
MDUtNWlubWZkIiwgImFsbHdpbm5lcixzdW41MGktYTY0IjsNCg0KVGhhbmtzLA0KUnlhbiBQYW5u
ZWxsDQpEZXZlbG9wbWVudCBUZWFtIExlYWQNCk9jZWFuaWMgU3lzdGVtcyAoVUspIEx0ZA0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogSmFnYW4gVGVraSA8amFnYW5AYW1hcnVs
YXNvbHV0aW9ucy5jb20+IA0KU2VudDogMDYgTWFyY2ggMjAxOSAwOTozNg0KVG86IE1heGltZSBS
aXBhcmQgPG1heGltZS5yaXBhcmRAYm9vdGxpbi5jb20+DQpDYzogUnlhbiBQYW5uZWxsIDxyeWFu
QG9zdWtsLmNvbT47IENoZW4tWXUgVHNhaSA8d2Vuc0Bjc2llLm9yZz47IFJvYiBIZXJyaW5nIDxy
b2JoK2R0QGtlcm5lbC5vcmc+OyBNYXJrIFJ1dGxhbmQgPG1hcmsucnV0bGFuZEBhcm0uY29tPjsg
TWljaGFlbCBUcmltYXJjaGkgPG1pY2hhZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBsaW51eC1h
cm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+OyBkZXZpY2V0
cmVlIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbCA8bGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWFtYXJ1bGFAYW1hcnVsYXNvbHV0aW9ucy5jb20N
ClN1YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBhcm02NDogYWxsd2lubmVyOiBhNjQ6IEFkZCBPY2Vh
bmljIEE2NC01aW5NRkQgaW5pdGlhbCBzdXBwb3J0DQoNCk9uIFdlZCwgTWFyIDYsIDIwMTkgYXQg
Mjo1NyBQTSBNYXhpbWUgUmlwYXJkIDxtYXhpbWUucmlwYXJkQGJvb3RsaW4uY29tPiB3cm90ZToN
Cj4NCj4gT24gVHVlLCBNYXIgMDUsIDIwMTkgYXQgMDQ6MzU6MDRQTSArMDAwMCwgUnlhbiBQYW5u
ZWxsIHdyb3RlOg0KPiA+IFdlIGRvbid0IG1pbmQgaWYgaXQgaGFzIHRvIGJlOg0KPiA+IGNvbXBh
dGlibGUgPSAib2NlYW5pYyw1aW5tZmQiLCAiYWxsd2lubmVyLHN1bjUwaS1hNjQiOw0KPiA+DQo+
ID4gSG93ZXZlciwgdG8gYXZvaWQgY29uZnVzaW9uLCBtaWdodCBpdCBiZSB3b3J0aCBpbmNsdWRp
bmcgdGhlIHBhcnQgbnVtYmVyIChXZSBsaXN0IHRoaXMgYXMgJzUyMDUgNSIgTUZEJykgc28gdGhp
cyB3b3VsZCBiZWNvbWU6DQo+ID4gY29tcGF0aWJsZSA9ICJvY2VhbmljLDUyMDUtNWlubWZkIiwg
ImFsbHdpbm5lcixzdW41MGktYTY0IjsNCj4gPg0KPiA+IFBlcmhhcHMgdGhpcyBzb2x2ZXMgdGhl
IGlzc3VlLiBQbGVhc2UgbGV0IG1lIGtub3cgdGhvdWdodHMuDQo+DQo+IFllcCwgdGhhdCB3b3Jr
cyBmb3IgbWUNCg0KQTY0IGluc3RlYWQgb2YgcGFydC1udW1iZXIgNTIwNSBzZWVtcyBsZXNzIGNv
bmZ1c2VkIGlzbid0IGl0PyBvciB3ZSBuZWVkIHRvIGdpdmUgbW9yZSBwcmlvcml0eSB3aXRoIHJl
YWwgaGFyZHdhcmUgZGVmaW5pdGlvbj8NCg==
