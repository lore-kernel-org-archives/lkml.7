Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B15C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D88824653
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dOmIJ0Eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfLLBdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:33:51 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:18098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727351AbfLLBdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:33:50 -0500
X-UUID: bf4c1f74419146da87338a099d456b7e-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ARecqApZNNYt1nHRIt9ZYfGP9FOkfwd1O+i0oCs1XL0=;
        b=dOmIJ0Eb/dEGSqxcnZspet2VG4fdzQysCRKzSETcg2EwiVcb/Lk8bOWU1Adjfrt7iHbgy9IysBD9rWpJME5N4O7OG5kkXloAE6rI2Xmt07Pe1U3xycCOXVTH0zzJQcPzUXKWEHKkA9jh40jkiTB7WnJOOutEYhP9axrrzE3bGxg=;
X-UUID: bf4c1f74419146da87338a099d456b7e-20191212
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1959977323; Thu, 12 Dec 2019 09:33:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:33:26 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:33:41 +0800
Message-ID: <1576114425.17653.11.camel@mtkswgap22>
Subject: Re: [PATCH v2 09/14] soc: mediatek: cmdq: add read_s function
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
Date:   Thu, 12 Dec 2019 09:33:45 +0800
In-Reply-To: <1575964515.13210.3.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-11-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575964515.13210.3.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAxNTo1NSArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBXZWQsIDIwMTktMTEtMjcgYXQgMDk6NTggKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBBZGQgcmVhZF9zIGZ1bmN0aW9uIGluIGNtZHEg
aGVscGVyIGZ1bmN0aW9ucyB3aGljaCBzdXBwb3J0IHJlYWQgdmFsdWUgZnJvbQ0KPiA+IHJlZ2lz
dGVyIG9yIGRtYSBwaHlzaWNhbCBhZGRyZXNzIGludG8gZ2NlIGludGVybmFsIHJlZ2lzdGVyLg0K
PiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXljLmhzaWVo
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEtaGVscGVyLmMgICB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1ZGUvbGlu
dXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmggfCAgMSArDQo+ID4gIGluY2x1ZGUvbGludXgv
c29jL21lZGlhdGVrL210ay1jbWRxLmggICAgfCAxMCArKysrKysrKysrDQo+ID4gIDMgZmlsZXMg
Y2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210
ay1jbWRxLWhlbHBlci5jDQo+ID4gaW5kZXggMmVkYmMwOTU0ZDk3Li4yY2Q2OTNlMzQ5ODAgMTAw
NjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4g
PiArKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYw0KPiA+IEBAIC0y
MzEsNiArMjMxLDI2IEBAIGludCBjbWRxX3BrdF93cml0ZV9tYXNrKHN0cnVjdCBjbWRxX3BrdCAq
cGt0LCB1OCBzdWJzeXMsDQo+ID4gIH0NCj4gPiAgRVhQT1JUX1NZTUJPTChjbWRxX3BrdF93cml0
ZV9tYXNrKTsNCj4gPiAgDQo+ID4gK2ludCBjbWRxX3BrdF9yZWFkX3Moc3RydWN0IGNtZHFfcGt0
ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIsIHUxNiByZWdfaWR4KQ0KPiA+ICt7DQo+IA0KPiBTaG91
bGQgYWRkciBiZSBzaGlmdGVkIGluIG10Njc3OT8NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0K
DQpubywgb25seSBwYyBhbmQgZW5kIHJlZ2lzdGVyIHNoaWZ0IGFkZHJlc3MNCm5vIG5lZWQgdG8g
c2hpZnQgaW4gaW5zdHJ1Y3Rpb24NCg0KDQpSZWdhcmRzLA0KRGVubmlzDQoNCj4gPiArCXN0cnVj
dCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+ICsJaW50IGVycjsNCj4gPiAr
CWNvbnN0IHUxNiBzcmNfcmVnX2lkeCA9IENNRFFfU1BSX1RFTVA7DQo+ID4gKw0KPiA+ICsJZXJy
ID0gY21kcV9wa3RfYXNzaWduKHBrdCwgc3JjX3JlZ19pZHgsIENNRFFfQUREUl9ISUdIKGFkZHIp
KTsNCj4gPiArCWlmIChlcnIgPCAwKQ0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKw0KPiA+ICsJ
aW5zdC5vcCA9IENNRFFfQ09ERV9SRUFEX1M7DQo+ID4gKwlpbnN0LmRzdF90ID0gQ01EUV9SRUdf
VFlQRTsNCj4gPiArCWluc3Quc29wID0gc3JjX3JlZ19pZHg7DQo+ID4gKwlpbnN0LnJlZ19kc3Qg
PSByZWdfaWR4Ow0KPiA+ICsJaW5zdC5hcmdfYiA9IENNRFFfQUREUl9MT1coYWRkcik7DQo+ID4g
Kw0KPiA+ICsJcmV0dXJuIGNtZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4g
K30NCj4gPiArRVhQT1JUX1NZTUJPTChjbWRxX3BrdF9yZWFkX3MpOw0KPiA+ICsNCj4gPiAgaW50
IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIs
IHUxNiByZWdfaWR4LA0KPiA+ICAJCSAgICAgdTMyIG1hc2spDQo+ID4gIHsNCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCBiL2luY2x1ZGUv
bGludXgvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmgNCj4gPiBpbmRleCA4ZWY4N2UxYmQwM2Iu
LjNmNmJjMGRmZDVkYSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRr
LWNtZHEtbWFpbGJveC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRx
LW1haWxib3guaA0KPiA+IEBAIC01OSw2ICs1OSw3IEBAIGVudW0gY21kcV9jb2RlIHsNCj4gPiAg
CUNNRFFfQ09ERV9KVU1QID0gMHgxMCwNCj4gPiAgCUNNRFFfQ09ERV9XRkUgPSAweDIwLA0KPiA+
ICAJQ01EUV9DT0RFX0VPQyA9IDB4NDAsDQo+ID4gKwlDTURRX0NPREVfUkVBRF9TID0gMHg4MCwN
Cj4gPiAgCUNNRFFfQ09ERV9XUklURV9TID0gMHg5MCwNCj4gPiAgCUNNRFFfQ09ERV9XUklURV9T
X01BU0sgPSAweDkxLA0KPiA+ICAJQ01EUV9DT0RFX0xPR0lDID0gMHhhMCwNCj4gPiBkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGlu
dXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBpbmRleCA1NmZmMTk3MDE5N2MuLmJjMjhh
NDFkNzc4MCAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGst
Y21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0K
PiA+IEBAIC0xMDYsNiArMTA2LDE2IEBAIGludCBjbWRxX3BrdF93cml0ZShzdHJ1Y3QgY21kcV9w
a3QgKnBrdCwgdTggc3Vic3lzLCB1MTYgb2Zmc2V0LCB1MzIgdmFsdWUpOw0KPiA+ICBpbnQgY21k
cV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTggc3Vic3lzLA0KPiA+ICAJ
CQl1MTYgb2Zmc2V0LCB1MzIgdmFsdWUsIHUzMiBtYXNrKTsNCj4gPiAgDQo+ID4gKy8qKg0KPiA+
ICsgKiBjbWRxX3BrdF9yZWFkX3MoKSAtIGFwcGVuZCByZWFkX3MgY29tbWFuZCB0byB0aGUgQ01E
USBwYWNrZXQNCj4gPiArICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4gKyAqIEBhZGRyOgl0
aGUgcGh5c2ljYWwgYWRkcmVzcyBvZiByZWdpc3RlciBvciBkbWEgdG8gcmVhZA0KPiA+ICsgKiBA
cmVnX2lkeDoJdGhlIENNRFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQgdG8gY2FjaGUgcmVhZCBkYXRh
DQo+ID4gKyAqDQo+ID4gKyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3Ig
Y29kZSBpcyByZXR1cm5lZA0KPiA+ICsgKi8NCj4gPiAraW50IGNtZHFfcGt0X3JlYWRfcyhzdHJ1
Y3QgY21kcV9wa3QgKnBrdCwgcGh5c19hZGRyX3QgYWRkciwgdTE2IHJlZ19pZHgpOw0KPiA+ICsN
Cj4gPiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X3dyaXRlX3NfbWFzaygpIC0gYXBwZW5kIHdyaXRl
X3MgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPiAgICogQHBrdDoJdGhlIENNRFEgcGFj
a2V0DQo+IA0KPiANCg0K

