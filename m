Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28AEC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96855214C6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfEGJUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:20:50 -0400
Received: from mx.socionext.com ([202.248.49.38]:3523 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbfEGJUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:20:49 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 May 2019 18:20:47 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 07BFC6117D;
        Tue,  7 May 2019 18:20:48 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Tue, 7 May 2019 18:20:48 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX03V.e01.socionext.com (10.213.24.23) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Tue, 7 May 2019 18:20:47 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Tue, 7 May 2019 18:20:47 +0900
From:   <orito.takao@socionext.com>
To:     <robh@kernel.org>
CC:     <ulf.hansson@linaro.org>, <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <sugaya.taichi@socionext.com>,
        <kasai.kazuhiro@socionext.com>, <kanematsu.shinji@socionext.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Thread-Topic: [PATCH 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Thread-Index: AQHU+9RXOLUG4XsvaU+oK6YWULWxq6ZWcdUAgAhr8AA=
Date:   Tue, 7 May 2019 09:20:46 +0000
Message-ID: <20190507182039.9D78.F0D17A80@socionext.com>
References: <1556244392-15822-1-git-send-email-orito.takao@socionext.com>
 <20190502004422.GA2242@bogus>
In-Reply-To: <20190502004422.GA2242@bogus>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Unregistered)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <CB4FF968706BD5458AC0FE498EB10D30@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgeW91IGZvciByZXZpZXdpbmcgbXkgcGF0Y2hlcy4NClNvcnJ5IGZvciBteSBsYXRlIHJl
cGx5LiBKYXBhbiB3YXMgaW4gU3ByaW5nIFZhY2F0aW9uLg0KDQo+IE9uIEZyaSwgQXByIDI2LCAy
MDE5IGF0IDExOjA2OjMyQU0gKzA5MDAsIFRha2FvIE9yaXRvIHdyb3RlOg0KPiANCj4gTmVlZHMg
YSBjb21taXQgbXNnLg0KDQpJIHNlZS4gSSB3aWxsIGFkZCBtZXNzYWdlLg0KDQo+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFRha2FvIE9yaXRvIDxvcml0by50YWthb0Bzb2Npb25leHQuY29tPg0KPiA+
IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc2RoY2ktbWlsYmVhdXQudHh0
ICAgICB8IDM1ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM1
IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9tbWMvc2RoY2ktbWlsYmVhdXQudHh0DQo+ID4gDQo+ID4gZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc2RoY2ktbWlsYmVh
dXQudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1taWxi
ZWF1dC50eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjcw
MDg0NjINCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1taWxiZWF1dC50eHQNCj4gPiBAQCAtMCwwICsxLDM1IEBA
DQo+ID4gKyogU09DSU9ORVhUIFNESENJIGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK1RoaXMgZmls
ZSBkb2N1bWVudHMgZGlmZmVyZW5jZXMgYmV0d2VlbiB0aGUgY29yZSBwcm9wZXJ0aWVzIGluIG1t
Yy50eHQNCj4gPiArYW5kIHRoZSBwcm9wZXJ0aWVzIHVzZWQgYnkgdGhlIHNkaGNpX21pbGJlYXV0
IGRyaXZlci4NCj4gPiArDQo+ID4gK1JlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gKy0gY29tcGF0
aWJsZTogInNvY2lvbmV4dCxtaWxiZWF1dC1tMTB2LXNkaGNpLTMuMCINCj4gPiArLSBjbG9ja3M6
IE11c3QgY29udGFpbiBhbiBlbnRyeSBmb3IgZWFjaCBlbnRyeSBpbiBjbG9jay1uYW1lcy4gSXQg
aXMgYQ0KPiA+ICsgIGxpc3Qgb2YgcGhhbmRsZXMgYW5kIGNsb2NrLXNwZWNpZmllciBwYWlycy4N
Cj4gPiArICBTZWUgLi4vY2xvY2tzL2Nsb2NrLWJpbmRpbmdzLnR4dCBmb3IgZGV0YWlscy4NCj4g
PiArLSBjbG9jay1uYW1lczogU2hvdWxkIGNvbnRhaW4gdGhlIGZvbGxvd2luZyB0d28gZW50cmll
czoNCj4gPiArCSJpZmFjZSIgLSBjbG9jayB1c2VkIGZvciBzZGhjaSBpbnRlcmZhY2UNCj4gPiAr
CSJjb3JlIiAgLSBjb3JlIGNsb2NrIGZvciBzZGhjaSBjb250cm9sbGVyDQo+ID4gKw0KPiA+ICtP
cHRpb25hbCBwcm9wZXJ0aWVzOg0KPiA+ICstIHZxbW1jLXN1cHBseTogcGhhbmRsZSB0byB0aGUg
cmVndWxhdG9yIGRldmljZSB0cmVlIG5vZGUsIG1lbnRpb25lZA0KPiA+ICsgIGFzIHRoZSBWQ0NR
L1ZERF9JTyBzdXBwbHkgaW4gdGhlIGVNTUMvU0Qgc3BlY3MuDQo+ID4gKy0gZnVqaXRzdSxjbWQt
ZGF0LWRlbGF5LXNlbGVjdDogYm9vbGVhbiBwcm9wZXJ0eSBpbmRpY2F0aW5nIHRoYXQgdGhpcyBo
b3N0DQo+ID4gKyAgcmVxdWlyZXMgdGhlIENNRF9EQVRfREVMQVkgY29udHJvbCB0byBiZSBlbmFi
bGVkLg0KPiA+ICstIHNuaSxtbWMtcG93ZXItZ3Bpbzogc2V0IHByb3BlcnR5IGluZGljYXRpbmcg
dGhhdCBwb3dlciBvbiBvciBvZmYgbmVlZHMNCj4gPiArICBjb250cm9sIG9mIGdwaW9zLg0KPiA+
ICsNCj4gPiArRXhhbXBsZToNCj4gPiArCXNkaGNpMzogbW1jQDFiMDEwMDAwIHsNCj4gPiArCQlj
b21wYXRpYmxlID0gInNvY2lvbmV4dCxtaWxiZWF1dC1tMTB2LXNkaGNpLTMuMCI7DQo+ID4gKwkJ
cmVnID0gPDB4MWIwMTAwMDAgMHgxMDAwMD47DQo+ID4gKwkJaW50ZXJydXB0cyA9IDwwIDI2NSAw
eDQ+Ow0KPiA+ICsJCXZvbHRhZ2UtcmFuZ2VzID0gPDMzMDAgMzMwMD47DQo+ID4gKwkJYnVzLXdp
ZHRoID0gPDQ+Ow0KPiA+ICsJCWNsb2NrcyA9IDwmY2xrIDc+LCA8JmFoYl9jbGs+Ow0KPiA+ICsJ
CWNsb2NrLW5hbWVzID0gImNvcmUiLCAiaWZhY2UiOw0KPiA+ICsJCWNhcC1zZGlvLWlycTsNCj4g
PiArCQlzbmksbW1jLXBvd2VyLWdwaW8gPSA8JnBpbmN0cmwgNTMgR1BJT19BQ1RJVkVfSElHSD47
DQo+ID4gKwkJCWZ1aml0c3UsY21kLWRhdC1kZWxheS1zZWxlY3Q7DQo+IA0KPiBXaGl0ZXNwYWNl
IHByb2JsZW0uDQoNClNvcnJ5LCBJIHdpbGwgZml4Lg0KDQpUaGFua3MNCk9yaXRvDQoNCj4gDQo+
ID4gKwl9Ow0KPiA+IC0tIA0KPiA+IDEuOS4xDQo+ID4gDQo+ID4gDQoNCi0tIA0KVGFrYW8gT3Jp
dG8gPG9yaXRvLnRha2FvQHNvY2lvbmV4dC5jb20+DQo=
