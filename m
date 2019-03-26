Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259DCC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0139420856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 05:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfCZFl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 01:41:59 -0400
Received: from mx.socionext.com ([202.248.49.38]:10758 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZFl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 01:41:58 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 26 Mar 2019 14:41:56 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id CF31D6117D;
        Tue, 26 Mar 2019 14:41:56 +0900 (JST)
Received: from 10.213.24.1 (10.213.24.1) by m-FILTER with ESMTP; Tue, 26 Mar 2019 14:41:56 +0900
Received: from SOC-EX02V.e01.socionext.com (10.213.24.22) by
 SOC-EX03V.e01.socionext.com (10.213.24.23) with Microsoft SMTP Server (TLS)
 id 15.0.995.29; Tue, 26 Mar 2019 14:41:55 +0900
Received: from SOC-EX02V.e01.socionext.com ([10.213.25.22]) by
 SOC-EX02V.e01.socionext.com ([10.213.25.22]) with mapi id 15.00.0995.028;
 Tue, 26 Mar 2019 14:41:55 +0900
From:   <orito.takao@socionext.com>
To:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <masami.hiramatsu@linaro.org>,
        <jaswinder.singh@linaro.org>, <sugaya.taichi@socionext.com>,
        <kasai.kazuhiro@socionext.com>, <kanematsu.shinji@socionext.com>,
        <orito.takao@socionext.com>
Subject: Re: [Milbeaut PATCH v0.4 0/2] mmc: sdhci_f_sdh30: Add support for
 Milbeaut
Thread-Topic: [Milbeaut PATCH v0.4 0/2] mmc: sdhci_f_sdh30: Add support for
 Milbeaut
Thread-Index: AQHU45A5pbCXUFjQzUagCLDakbwvPqYczzwA
Date:   Tue, 26 Mar 2019 05:41:55 +0000
Message-ID: <20190326144149.6AAC.F0D17A80@socionext.com>
References: <1553576281-5813-1-git-send-email-orito.takao@socionext.com>
In-Reply-To: <1553576281-5813-1-git-send-email-orito.takao@socionext.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Becky! ver. 2.74.02 [ja] (Evaluation)
x-originating-ip: [10.213.24.1]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <A2BA792336201C4B8D85972951CB0429@socionext.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpIaSBBbGwNCg0KSSdtIHNvcnJ5LCBJIGhhZCBtaXN0YWtlbiB0aGUgU3ViamVjdCBmb3JtYXQg
b2YgbXkgcGF0Y2ggc2VyaWVzLg0KSSB3aWxsIHNlbmQgbmV3IHBhdGNoZXMgd2l0aCByaWdodCBm
b3JtYXQuDQpQbGVhc2UgaWdub3JlIHRoaXMgc2VyaWVzLg0KDQpPcml0bw0KDQo+IFRoZSBmb2xs
b3dpbmcgcGF0Y2hlcyBhZGQgZHJpdmVyIHN1cHBvcnQgZm9yIFNEIEhvc3QgY29udHJvbGxlciBv
bg0KPiBTb2Npb25leHQncyBNaWxiZWF1dCBNMTBWIHBsYXRmb3Jtcy4NCj4gDQo+IFNEIEhvc3Qg
Y29udHJvbGxlciBvbiBNaWxiZWF1dCBpcyBjb25zaXN0IG9mIHR3byBjb250cm9sbGVyIHBhcnRz
Lg0KPiBPbmUgaXMgY29yZSBjb250cm9sbGVyIEZfU0RIMzAsIHRoaXMgaXMgc2ltaWxhciB0byBz
ZGhjaS1mdWppdHN1DQo+IGNvbnRyb2xsZXIuDQo+IEFub3RoZXIgaXMgYnJpZGdlIGNvbnRyb2xs
ZXIuIFRoaXMgYnJpZGdlIGNvbnRyb2xsZXIgaXMgbm90IGNvbXBhdGlibGUNCj4gd2l0aCBzZGhj
aS1mdWppdHN1IGNvbnRyb2xsZXIuIFRoaXMgaXMgc3BlY2lhbCBmb3IgTWlsYmVhdXQgc2VyaWVz
Lg0KPiANCj4gSXQgaGFzIHRoZSBzZXZlcmFsIHBhcnRzLA0KPiAgLSByZXNldCBjb250cm9sDQo+
ICAtIGNsb2NrIGVuYWJsZSAvIHNlbGVjdCBmb3IgU0RSNTAvMjUvMTINCj4gIC0gaG9sZCBjb250
cm9sIG9mIERBVEEvQ01EIGxpbmUNCj4gIC0gc2VsZWN0IGNoYXJhY3RlcmlzdGljcyBmb3IgV1Av
Q0QvTEVEIGxpbmUNCj4gIC0gUmUtdHVuaW5nIGNvbnRyb2wgZm9yIG1vZGUzDQo+ICAtIENhcGFi
aWxpdHkgc2V0dGluZw0KPiAgICBUaW1lb3V0IENsb2NrIC8gQmFzZSBDbG9jayAvIFRpbWVyIENv
dW50IGZvciBSZS1UdW5pbmcgLw0KPiAgICBEZWJvdW5jZSBwZXJpb2QNCj4gVGhlc2UgcmVxdWly
ZXMgc3BlY2lhbCBwcm9jZWR1cmVzIGF0IHJlc2V0IG9yIGNsb2NrIGVuYWJsZS9jaGFuZ2Ugb3IN
Cj4gIGZ1cnRoZXIgdHVuaW5nIG9mIGNsb2NrLg0KPiANCj4gVGFrYW8gT3JpdG8gKDIpOg0KPiAg
IGR0LWJpbmRpbmdzOiBtbWM6IHNkaGNpLWZ1aml0c3UudHh0OiBhZGQgbWlpbGJlYXV0IGRyaXZl
cg0KPiAgIG1tYzogc2RoY2lfZl9zZGgzMDogQWRkIHN1cHBvcnQgZm9yIE1pbGJlYXV0IE0xMFYg
aG9zdCBjb250cm9sbGVyDQo+IA0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3NkaGNp
LWZ1aml0c3UudHh0ICAgICAgfCAgMjIgKy0NCj4gIGRyaXZlcnMvbW1jL2hvc3Qvc2RoY2lfZl9z
ZGgzMC5jICAgICAgICAgICAgICAgICAgIHwgMzI0ICsrKysrKysrKysrKysrKysrKystLQ0KPiAg
MiBmaWxlcyBjaGFuZ2VkLCAzMTUgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQo+IA0K
PiAtLSANCj4gMS45LjENCj4gDQoNCi0tIA0KVGFrYW8gT3JpdG8gPG9yaXRvLnRha2FvQHNvY2lv
bmV4dC5jb20+DQo=
