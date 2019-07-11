Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B8FC74A3F
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CB7E20872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 01:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfGKB2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 21:28:47 -0400
Received: from mx.socionext.com ([202.248.49.38]:59245 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbfGKB2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 21:28:46 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Jul 2019 10:28:44 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id A947A18003C;
        Thu, 11 Jul 2019 10:28:44 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Thu, 11 Jul 2019 10:28:44 +0900
Received: from SOC-EX01V.e01.socionext.com (10.213.24.21) by
 SOC-EX02V.e01.socionext.com (10.213.24.22) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Thu, 11 Jul 2019 10:28:44 +0900
Received: from SOC-EX01V.e01.socionext.com ([10.213.24.21]) by
 SOC-EX01V.e01.socionext.com ([10.213.24.21]) with mapi id 15.00.0995.028;
 Thu, 11 Jul 2019 10:28:43 +0900
From:   <orito.takao@socionext.com>
To:     <robh@kernel.org>
CC:     <ulf.hansson@linaro.org>, <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <sugaya.taichi@socionext.com>,
        <kasai.kazuhiro@socionext.com>, <kanematsu.shinji@socionext.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Thread-Topic: [PATCH v2 1/2] dt-bindings: mmc: add DT bindings for Milbeaut SD
 controller
Thread-Index: AQHVFsjKlX0FEPEPP0y84mvB/ydCMqbA4ywAgANoVQA=
Date:   Thu, 11 Jul 2019 01:28:43 +0000
Message-ID: <20190711102834.DFF0.F0D17A80@socionext.com>
References: <1559208131-426-1-git-send-email-orito.takao@socionext.com>
 <20190708212630.GA20487@bogus>
In-Reply-To: <20190708212630.GA20487@bogus>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Unregistered)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <64C812E50857BB4BB587ACBD0A8AB6A5@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGFua3MgZm9yIGNoZWNraW5nIG15IHBhdGNoLg0KDQo+IE9uIFRodSwgTWF5IDMwLCAyMDE5
IGF0IDA2OjIyOjExUE0gKzA5MDAsIFRha2FvIE9yaXRvIHdyb3RlOg0KPiA+IEFkZCB0aGUgZGV2
aWNlLXRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9uIGZvciBNaWxiZWF1dCBTREhDSSBkcml2ZXIu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogVGFrYW8gT3JpdG8gPG9yaXRvLnRha2FvQHNvY2lv
bmV4dC5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zZGhj
aS1taWxiZWF1dC50eHQgICAgIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1taWxiZWF1dC50eHQNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21t
Yy9zZGhjaS1taWxiZWF1dC50eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bW1jL3NkaGNpLW1pbGJlYXV0LnR4dA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gaW5k
ZXggMDAwMDAwMC4uNjA2MzExNg0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3NkaGNpLW1pbGJlYXV0LnR4dA0KPiA+IEBA
IC0wLDAgKzEsMzIgQEANCj4gPiArKiBTT0NJT05FWFQgTWlsYmVhdXQgU0RIQ0kgY29udHJvbGxl
cg0KPiA+ICsNCj4gPiArVGhpcyBmaWxlIGRvY3VtZW50cyBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRo
ZSBjb3JlIHByb3BlcnRpZXMgaW4gbW1jLnR4dA0KPiA+ICthbmQgdGhlIHByb3BlcnRpZXMgdXNl
ZCBieSB0aGUgc2RoY2lfbWlsYmVhdXQgZHJpdmVyLg0KPiA+ICsNCj4gPiArUmVxdWlyZWQgcHJv
cGVydGllczoNCj4gPiArLSBjb21wYXRpYmxlOiAic29jaW9uZXh0LG1pbGJlYXV0LW0xMHYtc2Ro
Y2ktMy4wIg0KPiA+ICstIGNsb2NrczogTXVzdCBjb250YWluIGFuIGVudHJ5IGZvciBlYWNoIGVu
dHJ5IGluIGNsb2NrLW5hbWVzLiBJdCBpcyBhDQo+ID4gKyAgbGlzdCBvZiBwaGFuZGxlcyBhbmQg
Y2xvY2stc3BlY2lmaWVyIHBhaXJzLg0KPiA+ICsgIFNlZSAuLi9jbG9ja3MvY2xvY2stYmluZGlu
Z3MudHh0IGZvciBkZXRhaWxzLg0KPiA+ICstIGNsb2NrLW5hbWVzOiBTaG91bGQgY29udGFpbiB0
aGUgZm9sbG93aW5nIHR3byBlbnRyaWVzOg0KPiA+ICsJImlmYWNlIiAtIGNsb2NrIHVzZWQgZm9y
IHNkaGNpIGludGVyZmFjZQ0KPiA+ICsJImNvcmUiICAtIGNvcmUgY2xvY2sgZm9yIHNkaGNpIGNv
bnRyb2xsZXINCj4gPiArLSB2bW1jLXN1cHBseTogYSBwaGFuZGxlIG9mIGEgZml4ZWQgR1BJTyBy
ZWd1bGF0b3INCj4gDQo+IEJlaW5nIGEgZml4ZWQgR1BJTyByZWd1bGF0b3IgaXMgYm9hcmQgc3Bl
Y2lmaWMgYW5kIG91dHNpZGUgdGhlIHNjb3BlIG9mIA0KPiB0aGUgYmluZGluZy4gT3RoZXJ3aXNl
LA0KPiANCj4gUmV2aWV3ZWQtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+DQoNCkkg
c2VlLiBJIHdpbGwgcmVtb3ZlIHZtbWMtc3VwcGx5IGFuZCBzZW5kIG5ldyBwYXRjaC4NCg0KVGhh
bmtzDQpPcml0bw0KDQo+IA0KPiA+ICsNCj4gPiArT3B0aW9uYWwgcHJvcGVydGllczoNCj4gPiAr
LSBmdWppdHN1LGNtZC1kYXQtZGVsYXktc2VsZWN0OiBib29sZWFuIHByb3BlcnR5IGluZGljYXRp
bmcgdGhhdCB0aGlzIGhvc3QNCj4gPiArICByZXF1aXJlcyB0aGUgQ01EX0RBVF9ERUxBWSBjb250
cm9sIHRvIGJlIGVuYWJsZWQuDQo+ID4gKw0KPiA+ICtFeGFtcGxlOg0KPiA+ICsJc2RoY2kzOiBt
bWNAMWIwMTAwMDAgew0KPiA+ICsJCWNvbXBhdGlibGUgPSAic29jaW9uZXh0LG1pbGJlYXV0LW0x
MHYtc2RoY2ktMy4wIjsNCj4gPiArCQlyZWcgPSA8MHgxYjAxMDAwMCAweDEwMDAwPjsNCj4gPiAr
CQlpbnRlcnJ1cHRzID0gPDAgMjY1IDB4ND47DQo+ID4gKwkJdm9sdGFnZS1yYW5nZXMgPSA8MzMw
MCAzMzAwPjsNCj4gPiArCQlidXMtd2lkdGggPSA8ND47DQo+ID4gKwkJY2xvY2tzID0gPCZjbGsg
Nz4sIDwmYWhiX2Nsaz47DQo+ID4gKwkJY2xvY2stbmFtZXMgPSAiY29yZSIsICJpZmFjZSI7DQo+
ID4gKwkJY2FwLXNkaW8taXJxOw0KPiA+ICsJCXZtbWMtc3VwcGx5ID0gPCZ2Y2Nfc2RoY2kzPjsN
Cj4gPiArCQlmdWppdHN1LGNtZC1kYXQtZGVsYXktc2VsZWN0Ow0KPiA+ICsJfTsNCj4gPiAtLSAN
Cj4gPiAxLjkuMQ0KPiA+IA0KPiA+IA0KDQotLSANClRha2FvIE9yaXRvIDxvcml0by50YWthb0Bz
b2Npb25leHQuY29tPg0K
