Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712CCECDE27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF402089F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 07:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfIKHTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 03:19:41 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46245 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbfIKHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 03:19:41 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8B7J9CP030933, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8B7J9CP030933
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Sep 2019 15:19:09 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCAS12.realtek.com.tw ([::1]) with mapi id 14.03.0439.000; Wed, 11 Sep
 2019 15:19:08 +0800
From:   =?utf-8?B?SmFtZXMgVGFpW+aItOW/l+WzsF0=?= <james.tai@realtek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        "jamestai.sky@gmail.com" <jamestai.sky@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>
Subject: RE: [PATCH] dt-bindings: arm: Convert Realtek board/soc bindings to json-schema
Thread-Topic: [PATCH] dt-bindings: arm: Convert Realtek board/soc bindings
 to json-schema
Thread-Index: AQHVY8OhdZTqLc5DtUGoMsMJcc90yqccSQwAgAnQ1gA=
Date:   Wed, 11 Sep 2019 07:19:06 +0000
Message-ID: <43B123F21A8CFE44A9641C099E4196FFCF8DA124@RTITMBSVM04.realtek.com.tw>
References: <20190905081721.1548-1-james.tai@realtek.com>
 <CAL_JsqKGX1n-jsi0xtG8_Q=1LAhT=ufe0y2ZNBNoE3fR10K_xQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKGX1n-jsi0xtG8_Q=1LAhT=ufe0y2ZNBNoE3fR10K_xQ@mail.gmail.com>
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogYXJtOiBDb252ZXJ0IFJlYWx0ZWsg
Ym9hcmQvc29jIGJpbmRpbmdzIHRvDQo+IGpzb24tc2NoZW1hDQo+IA0KPiBPbiBUaHUsIFNlcCA1
LCAyMDE5IGF0IDk6MTkgQU0gPGphbWVzdGFpLnNreUBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+
ID4gRnJvbTogImphbWVzLnRhaSIgPGphbWVzLnRhaUByZWFsdGVrLmNvbT4NCj4gPg0KPiA+IENv
bnZlcnQgUmVhbHRlayBTb0MgYmluZGluZ3MgdG8gRFQgc2NoZW1hIGZvcm1hdCB1c2luZyBqc29u
LXNjaGVtYS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IGphbWVzLnRhaSA8amFtZXMudGFpQHJl
YWx0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vcmVh
bHRlay50eHQgICAgICAgfCAyMiAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIC4uLi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9yZWFsdGVrLnlhbWwgICAgICB8IDE3ICsrKysrKysrKysrKysrDQo+
ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pICBk
ZWxldGUgbW9kZQ0KPiA+IDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL3JlYWx0ZWsudHh0DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL3JlYWx0ZWsueWFtbA0KPiANCj4gSSd2ZSBhbHJlYWR5
IHN1Ym1pdHRlZCBhIHBhdGNoIGZvciB0aGlzIHRoYXQncyAqc3RpbGwqIHdhaXRpbmcgb24gQW5k
cmVhcyB0byBhcHBseQ0KPiBvciBjb21tZW50IG9uIHRoZSBsaWNlbnNpbmcuDQoNClRoYW5rcyBm
b3IgeW91ciByZXBseS4NCg0KPiBBbHNvLCB5b3VyIHBhdGNoIGlzbid0IHZhbGlkIHNjaGVtYS4g
UGxlYXNlIGNoZWNrIHdpdGggJ21ha2UNCj4gZHRfYmluZGluZ19jaGVjaycuDQo+IA0KSSB3aWxs
IGNoZWNrIHdpdGggJ21ha2UgZHRfYmluZGluZ19jaGVjaycuIA0KVGhhbmtzIQ0KDQo+IC0tLS0t
LVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1t
YWlsLg0K
