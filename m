Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BA6C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D4120815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CTn4oY6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfKYHlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 02:41:16 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:35870 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725875AbfKYHlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 02:41:15 -0500
X-UUID: efedb465b6f04affb1bdab95d07abc40-20191125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dKoy+Dj949qquDmvkLLiMXT3sCo/sHKTe8EGHTNJRjE=;
        b=CTn4oY6MT2wOJ0kzFZvDENY4K7Ieq0x2H3cedeFvd6/tmlhLWeQ/8KEnjgwBeGruL41WtJD6WbYSrb+AhaR4nOSXhmwZcF6xVZuHTP6CLwRC6Yv26KBwnI7lLZK8Ff6+BQk8HrjqmnfhsNsC2+qsyvBjesuFfowGcoTXdz4vLDM=;
X-UUID: efedb465b6f04affb1bdab95d07abc40-20191125
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 305352692; Mon, 25 Nov 2019 15:41:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 25 Nov 2019 15:40:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 25 Nov 2019 15:40:24 +0800
Message-ID: <1574667666.9851.5.camel@mtkswgap22>
Subject: Re: [PATCH v1 06/12] soc: mediatek: cmdq: add assign function
From:   Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 25 Nov 2019 15:41:06 +0800
In-Reply-To: <1574660121.26500.1.camel@mtksdaap41>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574327552-11806-7-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574660121.26500.1.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIE1vbiwgMjAxOS0xMS0yNSBhdCAxMzozNSArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBUaHUsIDIwMTktMTEtMjEgYXQgMTc6MTIgKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBBZGQgYXNzaWduIGZ1bmN0aW9uIGluIGNtZHEg
aGVscGVyIHdoaWNoIGFzc2lnbiBjb25zdGFudCB2YWx1ZSBpbnRvDQo+ID4gaW50ZXJuYWwgcmVn
aXN0ZXIgYnkgaW5kZXguDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVo
IDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgICAyNCArKysrKysrKysrKysrKysrKysr
KysrKy0NCj4gPiAgaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAg
IDEgKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICAgIHwgICAx
NCArKysrKysrKysrKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDM4IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEtaGVscGVyLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KPiA+IGluZGV4IDI3NGY2ZjMuLmQ0MTllOTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiArKysgYi9kcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0xNCw2ICsxNCw3IEBADQo+ID4gICNk
ZWZpbmUgQ01EUV9FT0NfSVJRX0VOCQlCSVQoMCkNCj4gPiAgI2RlZmluZSBDTURRX0VPQ19DTUQJ
CSgodTY0KSgoQ01EUV9DT0RFX0VPQyA8PCBDTURRX09QX0NPREVfU0hJRlQpKSBcDQo+ID4gIAkJ
CQk8PCAzMiB8IENNRFFfRU9DX0lSUV9FTikNCj4gPiArI2RlZmluZSBDTURRX1JFR19UWVBFCQkx
DQo+ID4gIA0KPiA+ICBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQo+ID4gIAl1bmlvbiB7DQo+
ID4gQEAgLTIzLDggKzI0LDE3IEBAIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCj4gPiAgCXVu
aW9uIHsNCj4gPiAgCQl1MTYgb2Zmc2V0Ow0KPiA+ICAJCXUxNiBldmVudDsNCj4gPiArCQl1MTYg
cmVnX2RzdDsNCj4gPiArCX07DQo+ID4gKwl1bmlvbiB7DQo+ID4gKwkJdTggc3Vic3lzOw0KPiA+
ICsJCXN0cnVjdCB7DQo+ID4gKwkJCXU4IHNvcDo1Ow0KPiA+ICsJCQl1OCBhcmdfY190OjE7DQo+
ID4gKwkJCXU4IGFyZ19iX3Q6MTsNCj4gPiArCQkJdTggYXJnX2FfdDoxOw0KPiA+ICsJCX07DQo+
ID4gIAl9Ow0KPiA+IC0JdTggc3Vic3lzOw0KPiA+ICAJdTggb3A7DQo+ID4gIH07DQo+ID4gIA0K
PiA+IEBAIC0yNzksNiArMjg5LDE4IEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGNtZHFf
cGt0X3BvbGxfbWFzayk7DQo+ID4gIA0KPiA+ICtpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBj
bWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1
Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiArDQo+ID4gKwlpbnN0Lm9w
ID0gQ01EUV9DT0RFX0xPR0lDOw0KPiA+ICsJaW5zdC5hcmdfYV90ID0gQ01EUV9SRUdfVFlQRTsN
Cj4gDQo+IEl0IGxvb2tzIGxpa2UgdGhhdCBhcmdfYV90IGNvdWxkIGhhdmUgYSBtZWFuaW5nZnVs
IG5hbWUuDQo+IA0KPiBSZWdhcmRzLA0KPiBDSw0KPiANCg0KT2ssIEknbGwgcmVuYW1lIGl0Lg0K
VGhhbmtzIGZvciB5b3VyIGNvbW1lbnQuDQoNCg0KUmVnYXJkcywNCkRlbm5pcw0KDQo+ID4gKwlp
bnN0LnJlZ19kc3QgPSByZWdfaWR4Ow0KPiA+ICsJaW5zdC52YWx1ZSA9IHZhbHVlOw0KPiA+ICsJ
cmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gK30NCj4gPiAr
RVhQT1JUX1NZTUJPTChjbWRxX3BrdF9hc3NpZ24pOw0KPiA+ICsNCj4gPiAgc3RhdGljIGludCBj
bWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gPiAgew0KPiA+ICAJc3Ry
dWN0IGNtZHFfY2xpZW50ICpjbCA9IHBrdC0+Y2w7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gv
bXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gaW5kZXggZGZlNWIyZS4uMTIxYzNiYiAxMDA2NDQNCj4g
PiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gKysr
IGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+IEBAIC01OSw2
ICs1OSw3IEBAIGVudW0gY21kcV9jb2RlIHsNCj4gPiAgCUNNRFFfQ09ERV9KVU1QID0gMHgxMCwN
Cj4gPiAgCUNNRFFfQ09ERV9XRkUgPSAweDIwLA0KPiA+ICAJQ01EUV9DT0RFX0VPQyA9IDB4NDAs
DQo+ID4gKwlDTURRX0NPREVfTE9HSUMgPSAweGEwLA0KPiA+ICB9Ow0KPiA+ICANCj4gPiAgZW51
bSBjbWRxX2NiX3N0YXR1cyB7DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21l
ZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5o
DQo+ID4gaW5kZXggYTc0YzFkNS4uODMzNDAyMSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2Mv
bWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IEBAIC0xNTIsNiArMTUyLDIwIEBAIGludCBjbWRxX3Br
dF9wb2xsKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+ID4gICAqLw0KPiA+ICBp
bnQgY21kcV9wa3RfcG9sbF9tYXNrKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1OCBzdWJzeXMsDQo+
ID4gIAkJICAgICAgIHUxNiBvZmZzZXQsIHUzMiB2YWx1ZSwgdTMyIG1hc2spOw0KPiA+ICsNCj4g
PiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X2Fzc2lnbigpIC0gQXBwZW5kIGxvZ2ljIGFzc2lnbiBj
b21tYW5kIHRvIHRoZSBDTURRIHBhY2tldCwgYXNrIEdDRQ0KPiA+ICsgKgkJICAgICAgIHRvIGV4
ZWN1dGUgYW4gaW5zdHJ1Y3Rpb24gdGhhdCBzZXQgYSBjb25zdGFudCB2YWx1ZSBpbnRvDQo+ID4g
KyAqCQkgICAgICAgaW50ZXJuYWwgcmVnaXN0ZXIgYW5kIHVzZSBhcyB2YWx1ZSwgbWFzayBvciBh
ZGRyZXNzIGluDQo+ID4gKyAqCQkgICAgICAgcmVhZC93cml0ZSBpbnN0cnVjdGlvbi4NCj4gPiAr
ICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4gKyAqIEByZWdfaWR4Ogl0aGUgQ01EUSBpbnRl
cm5hbCByZWdpc3RlciBJRA0KPiA+ICsgKiBAdmFsdWU6CXRoZSBzcGVjaWZpZWQgdmFsdWUNCj4g
PiArICoNCj4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2Rl
IGlzIHJldHVybmVkDQo+ID4gKyAqLw0KPiA+ICtpbnQgY21kcV9wa3RfYXNzaWduKHN0cnVjdCBj
bWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKTsNCj4gPiArDQo+ID4gIC8qKg0K
PiA+ICAgKiBjbWRxX3BrdF9mbHVzaF9hc3luYygpIC0gdHJpZ2dlciBDTURRIHRvIGFzeW5jaHJv
bm91c2x5IGV4ZWN1dGUgdGhlIENNRFENCj4gPiAgICogICAgICAgICAgICAgICAgICAgICAgICAg
IHBhY2tldCBhbmQgY2FsbCBiYWNrIGF0IHRoZSBlbmQgb2YgZG9uZSBwYWNrZXQNCj4gDQo+IA0K
DQo=

