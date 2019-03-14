Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276DAC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F08F82184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 08:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727263AbfCNIFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 04:05:35 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2511 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbfCNIFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 04:05:35 -0400
Received: from dggemi403-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 84421760837CF26F6D55;
        Thu, 14 Mar 2019 16:05:31 +0800 (CST)
Received: from DGGEMI529-MBX.china.huawei.com ([169.254.6.208]) by
 dggemi403-hub.china.huawei.com ([10.3.17.136]) with mapi id 14.03.0415.000;
 Thu, 14 Mar 2019 16:05:24 +0800
From:   "Tangnianyao (ICT)" <tangnianyao@huawei.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Tangnianyao (ICT)" <tangnianyao@huawei.com>
Subject: RE: [PATCH] KVM: arm/arm64: Set ICH_HCR_EN in guest anyway when
 using gicv4
Thread-Topic: [PATCH] KVM: arm/arm64: Set ICH_HCR_EN in guest anyway when
 using gicv4
Thread-Index: AdTYyuAikIHNpW42RlW7GKeJeYlLpP//uj2AgAFSSYCAAEMcgIAACNCA//6MzgA=
Date:   Thu, 14 Mar 2019 08:05:24 +0000
Message-ID: <F348A9E21A573744858FF7E5D32E29D81FEFC965@DGGEMI529-MBX.china.huawei.com>
References: <F348A9E21A573744858FF7E5D32E29D81FEFA462@DGGEMI529-MBX.china.huawei.com>
 <3993685d-a78f-2e73-e22a-8ade3b6a6279@arm.com>
 <d97bd073-8775-f0cf-637a-ea1b04afbd8f@arm.com>
 <5FC3163CFD30C246ABAA99954A238FA839311C4F@lhreml524-mbs.china.huawei.com>
 <09a615e5-9dce-d194-6290-b8897abd5d12@arm.com>
In-Reply-To: <09a615e5-9dce-d194-6290-b8897abd5d12@arm.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.57.56.75]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIE1hcmMsIFNoYW1lZXINCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBNYXJjIFp5bmdpZXIgW21haWx0bzptYXJjLnp5bmdpZXJAYXJtLmNvbV0NCj4gU2VudDogVGh1
cnNkYXksIE1hcmNoIDE0LCAyMDE5IDEyOjMxIEFNDQo+IFRvOiBTaGFtZWVyYWxpIEtvbG90aHVt
IFRob2RpIDxzaGFtZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20+Ow0KPiBUYW5nbmlh
bnlhbyAoSUNUKSA8dGFuZ25pYW55YW9AaHVhd2VpLmNvbT47IENocmlzdG9mZmVyIERhbGwNCj4g
PGNocmlzdG9mZmVyLmRhbGxAYXJtLmNvbT47IGphbWVzLm1vcnNlQGFybS5jb207IGp1bGllbi50
aGllcnJ5QGFybS5jb207DQo+IHN1enVraS5wb3Vsb3NlQGFybS5jb207IGNhdGFsaW4ubWFyaW5h
c0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOw0KPiBhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
OyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgYW5kcmUucHJ6eXdhcmFAYXJtLmNvbTsNCj4gWmhhbmdz
aGFva3VuIDx6aGFuZ3NoYW9rdW5AaGlzaWxpY29uLmNvbT47IGtlZXNjb29rQGNocm9taXVtLm9y
ZzsNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBrdm1hcm1AbGlzdHMu
Y3MuY29sdW1iaWEuZWR1Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBM
aW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gS1ZN
OiBhcm0vYXJtNjQ6IFNldCBJQ0hfSENSX0VOIGluIGd1ZXN0IGFueXdheSB3aGVuDQo+IHVzaW5n
IGdpY3Y0DQo+IA0KPiBPbiAxMy8wMy8yMDE5IDE1OjU5LCBTaGFtZWVyYWxpIEtvbG90aHVtIFRo
b2RpIHdyb3RlOg0KPiANCj4gSGkgU2hhbWVlciwNCj4gDQo+ID4+IENhbiB5b3UgcGxlYXNlIGdp
dmUgdGhlIGZvbGxvd2luZyBwYXRjaCBhIGdvPyBJIGNhbid0IHRlc3QgaXQsIGJ1dA0KPiA+PiBo
b3BlZnVsbHkgeW91IGNhbi4NCj4gPg0KPiA+IFRoYW5rcyBmb3IgeW91ciBxdWljayByZXNwb25z
ZS4gSSBqdXN0IGRpZCBhIHF1aWNrIHRlc3Qgb24gb25lIG9mIG91cg0KPiA+IHBsYXRmb3JtcyB3
aXRoIFZIRStHSUN2NCBhbmQgaXQgc2VlbXMgdG8gZml4IHRoZSBwZXJmb3JtYW5jZSBpc3N1ZSB3
ZQ0KPiA+IHdlcmUgc2VlaW5nIHdoZW4gR0lDdjQgaXMgZW5hYmxlZC4NCj4gPg0KPiA+IFRlc3Qg
c2V0dXA6DQo+ID4NCj4gPiBIb3N0IGNvbm5lY3RlZCB0byBhIFBDIG92ZXIgYSAxMEcgcG9ydC4N
Cj4gPiBMYXVuY2ggR3Vlc3Qgd2l0aCBhbiBhc3NpZ25lZCB2ZiBkZXYuDQo+ID4gUnVuIGlwZXJm
IGZyb20gR3Vlc3QsDQo+ID4NCj4gPiA1LjAga2VybmVsOg0KPiA+IFsgSURdICBJbnRlcnZhbCAg
ICAgICBUcmFuc2ZlciAgICAgQmFuZHdpZHRoDQo+ID4gWyAgM10gIDAuMC0xMC4wIHNlYyAgMS4z
MCBHQnl0ZXMgIDEuMTIgR2JpdHMvc2VjDQo+ID4NCj4gPiArUGF0Y2g6DQo+ID4NCj4gPiBbIElE
XSAJSW50ZXJ2YWwgICAgICAgVHJhbnNmZXIgICAgIEJhbmR3aWR0aA0KPiA+IFsgIDNdICAwLjAt
MTAuMCBzZWMgIDEwLjkgR0J5dGVzICA5LjM5IEdiaXRzL3NlYw0KPiANCj4gQWgsIHRoYXQgbG9v
a3MgbXVjaCBiZXR0ZXIhIEknbGwgdHJ5IHRvIHdyaXRlIGl0IHByb3Blcmx5LCBhcyBJIHRoaW5r
IHdoYXQgd2UgaGF2ZQ0KPiB0b2RheSBpcyBzbGlnaHRseSBiaXphcnJlICh3ZSB3cml0ZSBJQ0hf
SENSX0VMMiBmcm9tIHRvbyBtYW55IHBhdGhzLCBhbmQgSQ0KPiBuZWVkIHRvIHJlbWVtYmVyIGhv
dyB0aGUgd2hvbGUgdGhpbmcgd29ya3MpLg0KPiANCj4gVGhhbmtzLA0KPiANCj4gCU0uDQo+IC0t
DQo+IEphenogaXMgbm90IGRlYWQuIEl0IGp1c3Qgc21lbGxzIGZ1bm55Li4uDQoNClRlc3Qgc2V0
dXA6DQpWSEUgZW5hYmxlLiANCkNvbm5lY3RlZCB0byBhbiBpbnRlbCA4MTgwIHNlcnZlciBvdmVy
IDEwRyBwb3J0Lg0KTGF1bmNoIGd1ZXN0IHdpdGggYW4gYXNzaWduZWQgdmYgZGV2Lg0KSW50ZWwg
c2VydmVyIGFzIHNlcnZlci4gQXJtIGd1ZXN0IHZtIGFzIGNsaWVudC4NClJ1biBuZXRwZXJmIGlu
IGd1ZXN0LCBwYWNrYWdlIGxlbmd0aCA1MTJieXRlOg0KDQo1LjAuMC1yYzMga2VybmVsOg0Kd2l0
aG91dCBwYXRjaDoNCjI2MDAgTWJpdHMvcw0Kd2l0aCBwYXRjaDoNCjU4MDAgTWJpdHMvcw0KDQoN
ClRoYW5rcywNCi1OaWFueWFvIFRhbmcNCg==
