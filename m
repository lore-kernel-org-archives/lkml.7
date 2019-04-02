Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D79AC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C2D20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfDBCFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:05:49 -0400
Received: from mx.socionext.com ([202.248.49.38]:36277 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbfDBCFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:05:49 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 02 Apr 2019 11:05:47 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 76E65180C13;
        Tue,  2 Apr 2019 11:05:47 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Tue, 2 Apr 2019 11:05:47 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Tue, 2 Apr 2019 11:05:46 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Tue, 2 Apr 2019 11:05:46 +0900
From:   <orito.takao@socionext.com>
To:     <robh@kernel.org>
CC:     <ulf.hansson@linaro.org>, <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <sugaya.taichi@socionext.com>,
        <kasai.kazuhiro@socionext.com>, <kanematsu.shinji@socionext.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: mmc: sdhci-fujitsu.txt: add miilbeaut
 driver
Thread-Topic: [PATCH v1 1/2] dt-bindings: mmc: sdhci-fujitsu.txt: add
 miilbeaut driver
Thread-Index: AQHU45f8TUv6xMYByUm/dfzGuQd61KYku6CAgALXeoA=
Date:   Tue, 2 Apr 2019 02:05:46 +0000
Message-ID: <20190402110537.CB01.F0D17A80@socionext.com>
References: <1553579617-6139-1-git-send-email-orito.takao@socionext.com>
 <5ca0613a.1c69fb81.6e7bf.859e@mx.google.com>
In-Reply-To: <5ca0613a.1c69fb81.6e7bf.859e@mx.google.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Evaluation)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <35894A9848BD52409BD292B2CA5BE79D@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaQ0KDQo+IE9uIFR1ZSwgTWFyIDI2LCAyMDE5IGF0IDAyOjUzOjM3UE0gKzA5MDAsIFRha2Fv
IE9yaXRvIHdyb3RlOg0KPiA+IEFkZCBuZXcgY29tcGF0aWJsZSBkZXNjcmlwdGlvbiBmb3IgTWls
YmVhdXQgU29DLiBTb2Npb25leHQNCj4gPiBpbmhlcml0cyBGX1NESDMwIElQIGZyb20gRnVqaXRz
dS4gVGhlbiBuZXcgU29jIHNlcmllcyAiTWlsYmVhdXQiDQo+ID4gaGFzIEZfU0RIMzAgY29udHJv
bGxlciBzcGVjaWZpZWQgYnkgInNvY2lvbmV4dCxtaWxiZWF1dC1tMTB2LXNkaGNpLTMuMCIuDQo+
IA0KPiBTdWJqZWN0IGlzIHdyb25nLCB5b3UncmUgbm90IGFkZGluZyBhIGRyaXZlci4NCg0KT0ss
IEkgd2lsbCBjaGFuZ2UgImR0LWJpbmRpbmdzOiBtbWM6IHNkaGNpLWZ1aml0c3UudHh0OiBhZGQg
bWlsYmVhdXQgc3VwcG9ydCINCg0KPiANCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBUYWthbyBP
cml0byA8b3JpdG8udGFrYW9Ac29jaW9uZXh0LmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbW1jL3NkaGNpLWZ1aml0c3UudHh0ICAgICAgfCAyMiArKysrKysrKysr
KysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbW1jL3NkaGNpLWZ1aml0c3UudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1mdWppdHN1LnR4dA0KPiA+IGluZGV4IDNlZTkyNjMuLjQw
NTgxMWYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21tYy9zZGhjaS1mdWppdHN1LnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvc2RoY2ktZnVqaXRzdS50eHQNCj4gPiBAQCAtMSwxMCArMSwxMCBAQA0K
PiA+IC0qIEZ1aml0c3UgU0RIQ0kgY29udHJvbGxlcg0KPiA+ICsqIEZ1aml0c3UvU29jaW9uZXh0
IFNESENJIGNvbnRyb2xsZXINCj4gPiAgDQo+ID4gIFRoaXMgZmlsZSBkb2N1bWVudHMgZGlmZmVy
ZW5jZXMgYmV0d2VlbiB0aGUgY29yZSBwcm9wZXJ0aWVzIGluIG1tYy50eHQNCj4gPiAtYW5kIHRo
ZSBwcm9wZXJ0aWVzIHVzZWQgYnkgdGhlIHNkaGNpX2Zfc2RoMzAgZHJpdmVyLg0KPiA+ICthbmQg
dGhlIHByb3BlcnRpZXMgdXNlZCBieSB0aGUgc2RoY2lfZl9zZGgzMC4NCj4gPiAgDQo+ID4gIFJl
cXVpcmVkIHByb3BlcnRpZXM6DQo+ID4gLS0gY29tcGF0aWJsZTogImZ1aml0c3UsbWI4NnM3MC1z
ZGhjaS0zLjAiDQo+ID4gKy0gY29tcGF0aWJsZTogImZ1aml0c3UsbWI4NnM3MC1zZGhjaS0zLjAi
LCAic29jaW9uZXh0LG1pbGJlYXV0LW0xMHYtc2RoY2ktMy4wIg0KPiANCj4gT25lIHBlciBsaW5l
IHBsZWFzZS4NCg0KSSBzZWUsIEkgd2lsbCBmaXguDQoNCj4gDQo+ID4gIC0gY2xvY2tzOiBNdXN0
IGNvbnRhaW4gYW4gZW50cnkgZm9yIGVhY2ggZW50cnkgaW4gY2xvY2stbmFtZXMuIEl0IGlzIGEN
Cj4gPiAgICBsaXN0IG9mIHBoYW5kbGVzIGFuZCBjbG9jay1zcGVjaWZpZXIgcGFpcnMuDQo+ID4g
ICAgU2VlIC4uL2Nsb2Nrcy9jbG9jay1iaW5kaW5ncy50eHQgZm9yIGRldGFpbHMuDQo+ID4gQEAg
LTE3LDYgKzE3LDggQEAgT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAgICBhcyB0aGUgVkNDUS9W
RERfSU8gc3VwcGx5IGluIHRoZSBlTU1DL1NEIHNwZWNzLg0KPiA+ICAtIGZ1aml0c3UsY21kLWRh
dC1kZWxheS1zZWxlY3Q6IGJvb2xlYW4gcHJvcGVydHkgaW5kaWNhdGluZyB0aGF0IHRoaXMgaG9z
dA0KPiA+ICAgIHJlcXVpcmVzIHRoZSBDTURfREFUX0RFTEFZIGNvbnRyb2wgdG8gYmUgZW5hYmxl
ZC4NCj4gPiArLSBzbmksbW1jLXBvd2VyLWdwaW86IHNldCBwcm9wZXJ0eSBpbmRpY2F0aW5nIHRo
YXQgcG93ZXIgb24gb3Igb2ZmIG5lZWRzDQo+ID4gKyAgY29udHJvbCBvZiBncGlvLiBUaGlzIGlz
IGZvciBvbmx5ICJzb2Npb25leHQsbWlsYmVhdXQtbTEwdi1zZGhjaS0zLjAiLg0KPiANCj4gcy8t
Z3Bpby8tZ3Bpb3MvDQoNCkkgd2lsbCBmaXguDQoNCj4gDQo+ID4gIA0KPiA+ICBFeGFtcGxlOg0K
PiA+ICANCj4gPiBAQCAtMzAsMyArMzIsMTcgQEAgRXhhbXBsZToNCj4gPiAgCQljbG9ja3MgPSA8
JmNsb2NrIDIgMiAwPiwgPCZjbG9jayAyIDMgMD47DQo+ID4gIAkJY2xvY2stbmFtZXMgPSAiaWZh
Y2UiLCAiY29yZSI7DQo+ID4gIAl9Ow0KPiA+ICsNCj4gPiArRXhzYW1wbGUyOg0KPiA+ICsJc2Ro
Y2kzOiBtbWNAMWIwMTAwMDAgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAic29jaW9uZXh0LG1pbGJl
YXV0LW0xMHYtc2RoY2ktMy4wIjsNCj4gPiArCQlyZWcgPSA8MHgxYjAxMDAwMCAweDEwMDAwPjsN
Cj4gPiArCQlpbnRlcnJ1cHRzID0gPDAgMjY1IDB4ND47DQo+ID4gKwkJdm9sdGFnZS1yYW5nZXMg
PSA8MzMwMCAzMzAwPjsNCj4gPiArCQlidXMtd2lkdGggPSA8ND47DQo+ID4gKwkJY2xvY2tzID0g
PCZ1aHMxY2xrMj4sIDwmYWhiX2Nsaz47DQo+ID4gKwkJY2xvY2stbmFtZXMgPSAiY29yZSIsICJp
ZmFjZSI7DQo+ID4gKwkJY2FwLXNkaW8taXJxOw0KPiA+ICsJCXNuaSxtbWMtcG93ZXItZ3BpbyA9
IDwmcGluY3RybCA1MyBHUElPX0FDVElWRV9ISUdIPjsNCj4gPiArCQkJICAgZnVqaXRzdSxjbWQt
ZGF0LWRlbGF5LXNlbGVjdDsNCj4gDQo+IEluZGVudGF0aW9uIHByb2JsZW0uDQoNClNvcnJ5LCBJ
IHdpbGwgZml4Lg0KDQpUaGFuayB5b3UNCk9yaXRvDQoNCj4gDQo+ID4gKwl9Ow0KPiA+IC0tIA0K
PiA+IDEuOS4xDQo+ID4gDQo+ID4gDQoNCi0tIA0KVGFrYW8gT3JpdG8gPG9yaXRvLnRha2FvQHNv
Y2lvbmV4dC5jb20+DQo=
