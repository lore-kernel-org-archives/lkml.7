Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E44C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2FC21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pIzoge9N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLLBPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:15:07 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:12479 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726791AbfLLBPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:15:07 -0500
X-UUID: 01d595a00e4e485c81ffc37da6944f23-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=S7n6BLXFBYrGU/yLiTGj/uEVDc5Kend99TF6tXx8EAI=;
        b=pIzoge9NbhMCQefIEXvCMsp7O3fTiZpbja5sppxPRkSoaNfEbGcBZzQSXjSxO6/vFd+Y/A5zYwzvMrsHj6Z98uWoRyn812tsUlJWhINhg/whq68EJq1GI2fy6OMbGDQCeQ/s0C5uZ+ucycbxWIJtpu1ES24E2bonBpSGqIBoI4s=;
X-UUID: 01d595a00e4e485c81ffc37da6944f23-20191212
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 566963519; Thu, 12 Dec 2019 09:15:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:14:41 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:14:56 +0800
Message-ID: <1576113300.17653.7.camel@mtkswgap22>
Subject: Re: [PATCH v2 07/14] soc: mediatek: cmdq: add assign function
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
Date:   Thu, 12 Dec 2019 09:15:00 +0800
In-Reply-To: <1575948247.9195.0.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-9-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575948247.9195.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAxMToyNCArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBXZWQsIDIwMTktMTEtMjcgYXQgMDk6NTggKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBBZGQgYXNzaWduIGZ1bmN0aW9uIGluIGNtZHEg
aGVscGVyIHdoaWNoIGFzc2lnbiBjb25zdGFudCB2YWx1ZSBpbnRvDQo+ID4gaW50ZXJuYWwgcmVn
aXN0ZXIgYnkgaW5kZXguDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVo
IDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3Nv
Yy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyAgIHwgMjQgKysrKysrKysrKysrKysrKysrKysr
KystDQo+ID4gIGluY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgMSAr
DQo+ID4gIGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAxOCArKysr
KysrKysrKysrKysrKysNCj4gPiAgMyBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVr
L210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVy
LmMNCj4gPiBpbmRleCA4NDIxYjQwOTAzMDQuLjljYzIzNGYwOGVjNSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gQEAgLTE0LDYgKzE0LDcgQEAN
Cj4gPiAgI2RlZmluZSBDTURRX0VPQ19JUlFfRU4JCUJJVCgwKQ0KPiA+ICAjZGVmaW5lIENNRFFf
RU9DX0NNRAkJKCh1NjQpKChDTURRX0NPREVfRU9DIDw8IENNRFFfT1BfQ09ERV9TSElGVCkpIFwN
Cj4gPiAgCQkJCTw8IDMyIHwgQ01EUV9FT0NfSVJRX0VOKQ0KPiA+ICsjZGVmaW5lIENNRFFfUkVH
X1RZUEUJCTENCj4gPiAgDQo+ID4gIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCj4gPiAgCXVu
aW9uIHsNCj4gPiBAQCAtMjMsOCArMjQsMTcgQEAgc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gew0K
PiA+ICAJdW5pb24gew0KPiA+ICAJCXUxNiBvZmZzZXQ7DQo+ID4gIAkJdTE2IGV2ZW50Ow0KPiA+
ICsJCXUxNiByZWdfZHN0Ow0KPiA+ICsJfTsNCj4gPiArCXVuaW9uIHsNCj4gPiArCQl1OCBzdWJz
eXM7DQo+ID4gKwkJc3RydWN0IHsNCj4gPiArCQkJdTggc29wOjU7DQo+ID4gKwkJCXU4IGFyZ19j
X3Q6MTsNCj4gPiArCQkJdTggYXJnX2JfdDoxOw0KPiA+ICsJCQl1OCBkc3RfdDoxOw0KPiA+ICsJ
CX07DQo+ID4gIAl9Ow0KPiA+IC0JdTggc3Vic3lzOw0KPiA+ICAJdTggb3A7DQo+ID4gIH07DQo+
ID4gIA0KPiA+IEBAIC0yNzksNiArMjg5LDE4IEBAIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9M
KGNtZHFfcGt0X3BvbGxfbWFzayk7DQo+ID4gIA0KPiA+ICtpbnQgY21kcV9wa3RfYXNzaWduKHN0
cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgcmVnX2lkeCwgdTMyIHZhbHVlKQ0KPiA+ICt7DQo+ID4g
KwlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBpbnN0ID0geyB7MH0gfTsNCj4gPiArDQo+ID4gKwlp
bnN0Lm9wID0gQ01EUV9DT0RFX0xPR0lDOw0KPiA+ICsJaW5zdC5kc3RfdCA9IENNRFFfUkVHX1RZ
UEU7DQo+ID4gKwlpbnN0LnJlZ19kc3QgPSByZWdfaWR4Ow0KPiA+ICsJaW5zdC52YWx1ZSA9IHZh
bHVlOw0KPiA+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+
ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9hc3NpZ24pOw0KPiA+ICsNCj4gPiAg
c3RhdGljIGludCBjbWRxX3BrdF9maW5hbGl6ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCkNCj4gPiAg
ew0KPiA+ICAJc3RydWN0IGNtZHFfY2xpZW50ICpjbCA9IHBrdC0+Y2w7DQo+ID4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xp
bnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gaW5kZXggZGZlNWIyZWI4NWNjLi4x
MjFjM2JiNmQzZGUgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1j
bWRxLW1haWxib3guaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbWFpbGJveC9tdGstY21kcS1t
YWlsYm94LmgNCj4gPiBAQCAtNTksNiArNTksNyBAQCBlbnVtIGNtZHFfY29kZSB7DQo+ID4gIAlD
TURRX0NPREVfSlVNUCA9IDB4MTAsDQo+ID4gIAlDTURRX0NPREVfV0ZFID0gMHgyMCwNCj4gPiAg
CUNNRFFfQ09ERV9FT0MgPSAweDQwLA0KPiA+ICsJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCj4g
PiAgfTsNCj4gPiAgDQo+ID4gIGVudW0gY21kcV9jYl9zdGF0dXMgew0KPiA+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IGE3NGMxZDVhY2RmMy4uYzY2YjNhMGRh
MmEyIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRx
LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4g
QEAgLTEyLDYgKzEyLDEwIEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC90aW1lci5oPg0KPiA+ICAN
Cj4gPiAgI2RlZmluZSBDTURRX05PX1RJTUVPVVQJCTB4ZmZmZmZmZmZ1DQo+ID4gKyNkZWZpbmUg
Q01EUV9TUFJfVEVNUAkJMA0KPiA+ICsjZGVmaW5lIENNRFFfU1BSMQkJMQ0KPiA+ICsjZGVmaW5l
IENNRFFfU1BSMgkJMg0KPiA+ICsjZGVmaW5lIENNRFFfU1BSMwkJMw0KPiANCj4gVGhlc2UgZG9l
cyBub3QgcmVsYXRlIHRvIGFzc2lnbiBmdW5jdGlvbiwgc28gcmVtb3ZlIHRoZW0uDQo+IA0KPiBS
ZWdhcmRzLA0KPiBDSw0KPiANCg0Kd2lsbCByZW1vdmUNCg0KDQpSZWdhcmRzLA0KRGVubmlzDQoN
Cj4gPiAgDQo+ID4gIHN0cnVjdCBjbWRxX3BrdDsNCj4gPiAgDQo+ID4gQEAgLTE1Miw2ICsxNTYs
MjAgQEAgaW50IGNtZHFfcGt0X3BvbGwoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywN
Cj4gPiAgICovDQo+ID4gIGludCBjbWRxX3BrdF9wb2xsX21hc2soc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHU4IHN1YnN5cywNCj4gPiAgCQkgICAgICAgdTE2IG9mZnNldCwgdTMyIHZhbHVlLCB1MzIg
bWFzayk7DQo+ID4gKw0KPiA+ICsvKioNCj4gPiArICogY21kcV9wa3RfYXNzaWduKCkgLSBBcHBl
bmQgbG9naWMgYXNzaWduIGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0LCBhc2sgR0NFDQo+ID4g
KyAqCQkgICAgICAgdG8gZXhlY3V0ZSBhbiBpbnN0cnVjdGlvbiB0aGF0IHNldCBhIGNvbnN0YW50
IHZhbHVlIGludG8NCj4gPiArICoJCSAgICAgICBpbnRlcm5hbCByZWdpc3RlciBhbmQgdXNlIGFz
IHZhbHVlLCBtYXNrIG9yIGFkZHJlc3MgaW4NCj4gPiArICoJCSAgICAgICByZWFkL3dyaXRlIGlu
c3RydWN0aW9uLg0KPiA+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gPiArICogQHJlZ19p
ZHg6CXRoZSBDTURRIGludGVybmFsIHJlZ2lzdGVyIElEDQo+ID4gKyAqIEB2YWx1ZToJdGhlIHNw
ZWNpZmllZCB2YWx1ZQ0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IDAgZm9yIHN1Y2Nlc3M7IGVs
c2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4gPiArICovDQo+ID4gK2ludCBjbWRxX3Br
dF9hc3NpZ24oc3RydWN0IGNtZHFfcGt0ICpwa3QsIHUxNiByZWdfaWR4LCB1MzIgdmFsdWUpOw0K
PiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X2ZsdXNoX2FzeW5jKCkgLSB0cmlnZ2Vy
IENNRFEgdG8gYXN5bmNocm9ub3VzbHkgZXhlY3V0ZSB0aGUgQ01EUQ0KPiA+ICAgKiAgICAgICAg
ICAgICAgICAgICAgICAgICAgcGFja2V0IGFuZCBjYWxsIGJhY2sgYXQgdGhlIGVuZCBvZiBkb25l
IHBhY2tldA0KPiANCj4gDQoNCg==

