Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F68C4360C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 02:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063C32080F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 02:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfJGCct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 22:32:49 -0400
Received: from mx.socionext.com ([202.248.49.38]:41744 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfJGCct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 22:32:49 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Oct 2019 11:32:46 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 668F6605F8;
        Mon,  7 Oct 2019 11:32:46 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Mon, 7 Oct 2019 11:32:46 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX01V.e01.socionext.com (10.213.24.21) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Mon, 7 Oct 2019 11:32:45 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Mon, 7 Oct 2019 11:32:45 +0900
From:   <orito.takao@socionext.com>
To:     <ulf.hansson@linaro.org>
CC:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <masami.hiramatsu@linaro.org>, <jaswinder.singh@linaro.org>,
        <sugaya.taichi@socionext.com>, <kasai.kazuhiro@socionext.com>,
        <kanematsu.shinji@socionext.com>
Subject: Re: [PATCH v3 0/2] mmc: sdhci-milbeaut: add Milbeaut SD driver
Thread-Topic: [PATCH v3 0/2] mmc: sdhci-milbeaut: add Milbeaut SD driver
Thread-Index: AQHVZ3ihYlxK3AfGCE+319PUx3aqu6dIPRWAgAXMGQA=
Date:   Mon, 7 Oct 2019 02:32:44 +0000
Message-ID: <20191007113235.355F.F0D17A80@socionext.com>
References: <1568079631-28808-1-git-send-email-orito.takao@socionext.com>
 <CAPDyKFq6wbscGGq_0Q3_8eGLXk-+xBtmPbjq97jiejR7Qd_QbA@mail.gmail.com>
In-Reply-To: <CAPDyKFq6wbscGGq_0Q3_8eGLXk-+xBtmPbjq97jiejR7Qd_QbA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Unregistered)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <36AE662AED835746B2F222A52E6199E0@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpUaGFua3MgZm9yIGNoZWNraW5nIGFuZCBwdXNoaW5nIG15IHBhdGNoICENCg0KT3JpdG8NCg0K
PiBPbiBUdWUsIDEwIFNlcCAyMDE5IGF0IDAzOjM5LCBUYWthbyBPcml0byA8b3JpdG8udGFrYW9A
c29jaW9uZXh0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBUaGUgZm9sbG93aW5nIHBhdGNoZXMgYWRk
IGRyaXZlciBmb3IgU0QgSG9zdCBjb250cm9sbGVyIG9uDQo+ID4gU29jaW9uZXh0J3MgTWlsYmVh
dXQgTTEwViBwbGF0Zm9ybXMuDQo+ID4NCj4gPiBTRCBIb3N0IGNvbnRyb2xsZXIgb24gTWlsYmVh
dXQgY29uc2lzdHMgb2YgdHdvIGNvbnRyb2xsZXIgcGFydHMuDQo+ID4gT25lIGlzIGNvcmUgY29u
dHJvbGxlciBGX1NESDMwLCB0aGlzIGlzIHNpbWlsYXIgdG8gc2RoY2ktZnVqaXRzdQ0KPiA+IGNv
bnRyb2xsZXIuDQo+ID4gQW5vdGhlciBpcyBicmlkZ2UgY29udHJvbGxlci4gVGhpcyBicmlkZ2Ug
Y29udHJvbGxlciBpcyBub3QgY29tcGF0aWJsZQ0KPiA+IHdpdGggc2RoY2ktZnVqaXRzdSBjb250
cm9sbGVyLiBUaGlzIGlzIHNwZWNpYWwgZm9yIE1pbGJlYXV0IHNlcmllcy4NCj4gPg0KPiA+IEl0
IGhhcyB0aGUgc2V2ZXJhbCBwYXJ0cywNCj4gPiAgLSByZXNldCBjb250cm9sDQo+ID4gIC0gY2xv
Y2sgZW5hYmxlIC8gc2VsZWN0IGZvciBTRFI1MC8yNS8xMg0KPiA+ICAtIGhvbGQgY29udHJvbCBv
ZiBEQVRBL0NNRCBsaW5lDQo+ID4gIC0gc2VsZWN0IGNoYXJhY3RlcmlzdGljcyBmb3IgV1AvQ0Qv
TEVEIGxpbmUNCj4gPiAgLSBSZS10dW5pbmcgY29udHJvbCBmb3IgbW9kZTMNCj4gPiAgLSBDYXBh
YmlsaXR5IHNldHRpbmcNCj4gPiAgICBUaW1lb3V0IENsb2NrIC8gQmFzZSBDbG9jayAvIFRpbWVy
IENvdW50IGZvciBSZS1UdW5pbmcgLw0KPiA+ICAgIERlYm91bmNlIHBlcmlvZA0KPiA+IFRoZXNl
IHJlcXVpcmVzIHNwZWNpYWwgcHJvY2VkdXJlcyBhdCByZXNldCBvciBjbG9jayBlbmFibGUvY2hh
bmdlIG9yDQo+ID4gIGZ1cnRoZXIgdHVuaW5nIG9mIGNsb2NrLg0KPiA+DQo+ID4gVGFrYW8gT3Jp
dG8gKDIpOg0KPiA+ICAgZHQtYmluZGluZ3M6IG1tYzogYWRkIERUIGJpbmRpbmdzIGZvciBNaWxi
ZWF1dCBTRCBjb250cm9sbGVyDQo+ID4gICBtbWM6IHNkaGNpLW1pbGJlYXV0OiBhZGQgTWlsYmVh
dXQgU0QgY29udHJvbGxlciBkcml2ZXINCj4gPg0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5n
cy9tbWMvc2RoY2ktbWlsYmVhdXQudHh0ICAgICB8ICAzMCArKw0KPiA+ICBkcml2ZXJzL21tYy9o
b3N0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMSArDQo+ID4gIGRyaXZl
cnMvbW1jL2hvc3QvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4g
PiAgZHJpdmVycy9tbWMvaG9zdC9zZGhjaS1taWxiZWF1dC5jICAgICAgICAgICAgICAgICAgfCAz
NjIgKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2lfZl9z
ZGgzMC5jICAgICAgICAgICAgICAgICAgIHwgIDI2ICstDQo+ID4gIGRyaXZlcnMvbW1jL2hvc3Qv
c2RoY2lfZl9zZGgzMC5oICAgICAgICAgICAgICAgICAgIHwgIDMyICsrDQo+ID4gIDYgZmlsZXMg
Y2hhbmdlZCwgNDM3IGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygtKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zZGhjaS1t
aWxiZWF1dC50eHQNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbW1jL2hvc3Qvc2Ro
Y2ktbWlsYmVhdXQuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tbWMvaG9zdC9z
ZGhjaV9mX3NkaDMwLmgNCj4gPg0KPiA+IC0tDQo+ID4gMS45LjENCj4gPg0KPiA+DQo+IA0KPiBB
cHBsaWVkIGZvciBuZXh0LCB0aGFua3MhDQo+IA0KPiBLaW5kIHJlZ2FyZHMNCj4gVWZmZQ0KDQot
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KVGFrYW8gT3JpdG8NClNvY2lvbmV4dCBJbmMuDQpFLW1haWw6b3JpdG8udGFrYW9A
c29jaW9uZXh0LmNvbQ0KVGVsOis4MS04MC05ODE1LTE0NjANCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo=
