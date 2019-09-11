Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BBECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88909222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 08:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfIKIGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 04:06:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50060 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726341AbfIKIGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 04:06:37 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8B86Ipg018361, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8B86Ipg018361
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 11 Sep 2019 16:06:19 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Wed, 11 Sep
 2019 16:06:18 +0800
From:   =?utf-8?B?SmFtZXMgVGFpW+aItOW/l+WzsF0=?= <james.tai@realtek.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        "jamestai.sky@gmail.com" <jamestai.sky@gmail.com>
CC:     DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>
Subject: RE: [PATCH] ARM: dts: realtek: Add support for Realtek RTD16XX evaluation board
Thread-Topic: [PATCH] ARM: dts: realtek: Add support for Realtek RTD16XX
 evaluation board
Thread-Index: AQHVY8FprGHksjiwU0q9UKXzrLrLWqccQJYAgAnWzrA=
Date:   Wed, 11 Sep 2019 08:06:17 +0000
Message-ID: <43B123F21A8CFE44A9641C099E4196FFCF8DA278@RTITMBSVM04.realtek.com.tw>
References: <20190905080835.1376-1-james.tai@realtek.com>
 <CAK8P3a3L7mzR+FUMgG75_hrp4HQm4vJR3hsUO_BkQp_247OLsA@mail.gmail.com>
In-Reply-To: <CAK8P3a3L7mzR+FUMgG75_hrp4HQm4vJR3hsUO_BkQp_247OLsA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IGR0czogcmVhbHRlazogQWRkIHN1cHBvcnQgZm9y
IFJlYWx0ZWsgUlREMTZYWA0KPiBldmFsdWF0aW9uIGJvYXJkDQo+IA0KPiBPbiBUaHUsIFNlcCA1
LCAyMDE5IGF0IDEwOjEwIEFNIDxqYW1lc3RhaS5za3lAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+
ID4gKw0KPiA+ICsvIHsNCj4gPiArICAgICAgIG1vZGVsPSAiUmVhbHRlayBNam9sbmlyIEV2YWx1
YXRpb24gQm9hcmQiOw0KPiA+ICsgICAgICAgbW9kZWxfaGV4PSA8MHgwMDAwMDY1Mz47DQo+IA0K
PiBUaGUgJ21vZGVfaGV4JyBwcm9wZXJ0eSBpcyByYXRoZXIgdW51c3VhbCwgcGxlYXNlIGRyb3Ag
dGhhdCBmb3Igbm93Lg0KDQpJIHdpbGwgcmVtb3ZlIHRoZSAnbW9kZV9oZXgnIHByb3BlcnR5IGlu
IG5ldyB2ZXJzaW9uIHBhdGNoLg0KDQo+IA0KPiA+ICsgICAgICAgY2hvc2VuIHsNCj4gPiArICAg
ICAgICAgICAgICAgYm9vdGFyZ3MgPSAiY29uc29sZT10dHlTMCwxMTUyMDAgZWFybHljb24iOw0K
PiA+ICsgICAgICAgfTsNCj4gPiArDQo+ID4gKyAgICAgICBtZW1vcnlAMCB7DQo+ID4gKyAgICAg
ICAgICAgICAgIGRldmljZV90eXBlID0gIm1lbW9yeSI7DQo+ID4gKyAgICAgICAgICAgICAgIHJl
ZyA9IDwweDAgMHgwIDB4MCAweDgwMDAwMDAwPjsNCj4gPiArICAgICAgIH07DQo+ID4gKw0KPiA+
ICsgICAgICAgdWFydDA6IHNlcmlhbDBAOTgwMDc4MDAgew0KPiA+ICsgICAgICAgICAgICAgICBj
b21wYXRpYmxlID0gInNucHMsZHctYXBiLXVhcnQiOw0KPiA+ICsgICAgICAgICAgICAgICByZWcg
PSA8MHgwIDB4OTgwMDc4MDAgMHgwIDB4NDAwPiwNCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICA8MHgwIDB4OTgwMDcwMDAgMHgwIDB4MTAwPjsNCj4gPiArICAgICAgICAgICAgICAgcmVnLXNo
aWZ0ID0gPDI+Ow0KPiA+ICsgICAgICAgICAgICAgICByZWctaW8td2lkdGggPSA8ND47DQo+ID4g
KyAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MCA2OCA0PjsNCj4gPiArICAgICAgICAgICAg
ICAgY2xvY2stZnJlcXVlbmN5ID0gPDI3MDAwMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgc3Rh
dHVzID0gIm9rYXkiOw0KPiA+ICsgICAgICAgfTsNCj4gDQo+IFRoaXMgbG9va3MgbGlrZSBhbiBv
bi1jaGlwIHVhcnQuIFBsZWFzZSBtb3ZlIHRoYXQgaW50byBydGQxNnh4LmR0c2kgaW5zdGVhZCwg
YW5kDQo+IGp1c3QgbWFyayBpdCBhcyAnc3RhdHVzPSJkaXNhYmxlZCInIHRoZXJlIGlmIHRoZXJl
IGFyZSBtdWx0aXBsZSB1YXJ0cyAoYW5kIGFkZCB0aGUNCj4gb3RoZXIgb25lcyBhcyB3ZWxsKSwg
dGhlbiBlbmFibGUgaXQgZm9yIHRoZSBib2FyZCBoZXJlLg0KDQpZZXMuIEl0IGlzIG9uLWNoaXAg
dWFydC4NCkkgd2lsbCBtb3ZlIHVhcnQwIGludG8gJ3J0ZDE2eHguZHRzaScgYW5kIG1hcmsgaXQg
YXMgJ3N0YXR1cz0iZGlzYWJsZWQiICcuDQoNCj4gVGhlcmUgc2hvdWxkIGFsc28gYmUgYW4gJ2Fs
aWFzZXMnLiBZb3Ugbm9ybWFsbHkgYWxzbyB3YW50IHRvIGFkZA0KDQpJIHdpbGwgYWRkIGFsaWFz
ZXMgaW4gbmV3IHZlcnNpb24gcGF0Y2guDQoNCj4gYWxpYXNlcyB7DQo+ICAgICAgICAgc2VyaWFs
MCA9ICZ1YXJ0MDsNCj4gfTsNCj4gDQo+IGNob3NlbiB7DQo+ICAgICAgICBzdGRvdXQtcGF0aD0g
InNlcmlhbDA6MTE1MjAwbjgiDQo+IH07DQo+IA0KPiBpbiB0aGUgYm9hcmQgZmlsZSB0byBtYWtl
IGVhcmx5Y29uIHdvcmsgcmlnaHQuDQoNCk9LLCBJIHVuZGVyc3RhbmQuDQoNCj4gICAgICAgQXJu
ZA0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJp
bnRpbmcgdGhpcyBlLW1haWwuDQo=
