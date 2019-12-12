Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33B6C2D0C6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01E3208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CvmyK1ZE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfLLBbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:31:09 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:9779 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727351AbfLLBbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:31:09 -0500
X-UUID: 29cb4f943b0e41fdbffbe04318898630-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=z3jXfILSOt5N95Q9i/yWWMY8RXxe+WYzygOicgGVo+c=;
        b=CvmyK1ZEyOxeN/Fs1neZS0/I5uk/WNBRs/4ovVFHQU1sdNZIqdvLk5np8L+xx+4nMPnGHm77tHoJOkyUHDzyH/2w0QgZ1ffEeaG6JX58m2dGJORDhKxV9we+Ou/A9XMCxZb0D4PQ3dwN5ctprDkISeM8rnHKKYrCBI2fT96wSF8=;
X-UUID: 29cb4f943b0e41fdbffbe04318898630-20191212
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 191698795; Thu, 12 Dec 2019 09:31:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:30:44 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:30:59 +0800
Message-ID: <1576114263.17653.9.camel@mtkswgap22>
Subject: Re: [PATCH v2 08/14] soc: mediatek: cmdq: add write_s function
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
Date:   Thu, 12 Dec 2019 09:31:03 +0800
In-Reply-To: <1575955103.31262.10.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-10-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1575955103.31262.10.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAxOS0xMi0xMCBhdCAxMzoxOCArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBXZWQsIDIwMTktMTEtMjcgYXQgMDk6NTggKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBhZGQgd3JpdGVfcyBmdW5jdGlvbiBpbiBjbWRx
IGhlbHBlciBmdW5jdGlvbnMgd2hpY2gNCj4gPiB3cml0ZXMgdmFsdWUgY29udGFpbnMgaW4gaW50
ZXJuYWwgcmVnaXN0ZXIgdG8gYWRkcmVzcw0KPiA+IHdpdGggbGFyZ2UgZG1hIGFjY2VzcyBzdXBw
b3J0Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IERlbm5pcyBZQyBIc2llaCA8ZGVubmlzLXlj
LmhzaWVoQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9zb2MvbWVkaWF0ZWsv
bXRrLWNtZHEtaGVscGVyLmMgICB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBp
bmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIHwgIDIgKysNCj4gPiAgaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8IDEyICsrKysrKysNCj4gPiAg
MyBmaWxlcyBjaGFuZ2VkLCA1NCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIvZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCA5Y2MyMzRmMDhlYzUuLjJlZGJjMDk1
NGQ5NyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
ID4gQEAgLTE1LDExICsxNSwxOCBAQA0KPiA+ICAjZGVmaW5lIENNRFFfRU9DX0NNRAkJKCh1NjQp
KChDTURRX0NPREVfRU9DIDw8IENNRFFfT1BfQ09ERV9TSElGVCkpIFwNCj4gPiAgCQkJCTw8IDMy
IHwgQ01EUV9FT0NfSVJRX0VOKQ0KPiA+ICAjZGVmaW5lIENNRFFfUkVHX1RZUEUJCTENCj4gPiAr
I2RlZmluZSBDTURRX0FERFJfSElHSChhZGRyKQkoKHUzMikoKChhZGRyKSA+PiAxNikgJiBHRU5N
QVNLKDMxLCAwKSkpDQo+ID4gKyNkZWZpbmUgQ01EUV9BRERSX0xPV19CSVQJQklUKDEpDQo+ID4g
KyNkZWZpbmUgQ01EUV9BRERSX0xPVyhhZGRyKQkoKHUxNikoYWRkcikgfCBDTURRX0FERFJfTE9X
X0JJVCkNCj4gPiAgDQo+ID4gIHN0cnVjdCBjbWRxX2luc3RydWN0aW9uIHsNCj4gPiAgCXVuaW9u
IHsNCj4gPiAgCQl1MzIgdmFsdWU7DQo+ID4gIAkJdTMyIG1hc2s7DQo+ID4gKwkJc3RydWN0IHsN
Cj4gPiArCQkJdTE2IGFyZ19jOw0KPiA+ICsJCQl1MTYgYXJnX2I7DQo+ID4gKwkJfTsNCj4gPiAg
CX07DQo+ID4gIAl1bmlvbiB7DQo+ID4gIAkJdTE2IG9mZnNldDsNCj4gPiBAQCAtMjI0LDYgKzIz
MSwzOSBAQCBpbnQgY21kcV9wa3Rfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTgg
c3Vic3lzLA0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfbWFzayk7
DQo+ID4gIA0KPiA+ICtpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3QgY21kcV9wa3QgKnBrdCwg
cGh5c19hZGRyX3QgYWRkciwgdTE2IHJlZ19pZHgsDQo+ID4gKwkJICAgICB1MzIgbWFzaykNCj4g
PiArew0KPiA+ICsJc3RydWN0IGNtZHFfaW5zdHJ1Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4g
Kwljb25zdCB1MTYgZHN0X3JlZ19pZHggPSBDTURRX1NQUl9URU1QOw0KPiA+ICsJaW50IGVycjsN
Cj4gPiArDQo+ID4gKwlpZiAobWFzayAhPSBVMzJfTUFYKSB7DQo+ID4gKwkJaW5zdC5vcCA9IENN
RFFfQ09ERV9NQVNLOw0KPiA+ICsJCWluc3QubWFzayA9IH5tYXNrOw0KPiA+ICsJCWVyciA9IGNt
ZHFfcGt0X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gKwkJaWYgKGVyciA8IDApDQo+
ID4gKwkJCXJldHVybiBlcnI7DQo+ID4gKw0KPiA+ICsJCWluc3QubWFzayA9IDA7DQo+ID4gKwkJ
aW5zdC5vcCA9IENNRFFfQ09ERV9XUklURV9TX01BU0s7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJ
CWluc3Qub3AgPSBDTURRX0NPREVfV1JJVEVfUzsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwllcnIg
PSBjbWRxX3BrdF9hc3NpZ24ocGt0LCBkc3RfcmVnX2lkeCwgQ01EUV9BRERSX0hJR0goYWRkcikp
Ow0KPiANCj4gWW91IGNvbWJpbmUgYXNzaWduIGFuZCB3cml0ZV9zIGluIHRoaXMgZnVuY3Rpb24s
IHNvIHlvdSBhbHdheXMgb2NjdXB5DQo+IHJlZ2lzdGVyIENNRFFfU1BSX1RFTVAgZm9yIHRoaXMg
cHVycG9zZSwgY2xpZW50IGNvdWxkIG5vdCB1c2UNCj4gQ01EUV9TUFJfVEVNUCBmb3Igb3RoZXIg
cHVycG9zZS4gU28gSSB3b3VsZCBsaWtlIHlvdSBqdXN0IGRvIHdyaXRlX3MgaW4NCj4gdGhpcyBm
dW5jdGlvbi4gU28gdGhlIGNvZGUgaW4gY2xpZW50IHdvdWxkIGJlOg0KPiANCj4gY21kcV9wa3Rf
YXNzaWduKHBrdCwgaGlnaF9hZGRyX3JlZ19pZHgsIENNRFFfQUREUl9ISUdIKGFkZHIpKTsNCj4g
Y21kcV9wa3Rfd3JpdGVfcyhwa3QsIGhpZ2hfYWRkcl9yZWdfaWR4LCBDTURRX0FERFJfTE9XKGFk
ZHIpLA0KPiBzcmNfcmVnX2lkeCwgbWFzayk7DQo+IA0KPiBMZXQgY2xpZW50IHRvIGRlY2lkZSB3
aGljaCByZWdpc3RlciBmb3IgaGlnaCBhZGRyZXNzLg0KPiANCj4gQW5vdGhlciBiZW5lZml0IG9m
IG5vdCBjb21iaW5pbmcgaW5zdHJ1Y3Rpb24gaXMgdGhhdCBjbGllbnQgZHJpdmVyIG93bmVyDQo+
IHdvdWxkIGJlIG1vcmUgY2xlYXIgYWJvdXQgd2hpY2ggY29tbWFuZCBpcyBpbiBjb21tYW5kIGJ1
ZmZlciBhbmQgaXQncw0KPiBlYXNpZXIgZm9yIHRoZW0gdG8gZGVidWcuDQo+IA0KDQpvaywgaSB3
aWxsIGV4cG9zZSByZWcgaWR4IGFzIHBhcmFtZXRlcg0KDQo+ID4gKwlpZiAoZXJyIDwgMCkNCj4g
PiArCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCWluc3QuYXJnX2JfdCA9IENNRFFfUkVHX1RZ
UEU7DQo+ID4gKwlpbnN0LnNvcCA9IGRzdF9yZWdfaWR4Ow0KPiA+ICsJaW5zdC5vZmZzZXQgPSBD
TURRX0FERFJfTE9XKGFkZHIpOw0KPiA+ICsJaW5zdC5hcmdfYiA9IHJlZ19pZHg7DQo+IA0KPiBJ
IHNlZW1zIGFyZ19iIGhhcyBhIG1lYW5pbmdmdWwgbmFtZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IENL
DQo+IA0KDQpvaywgd2lsbCBjaGFuZ2UgbmFtZQ0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0KPiA+
ICsNCj4gPiArCXJldHVybiBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+
ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0woY21kcV9wa3Rfd3JpdGVfcyk7DQo+ID4gKw0KPiA+ICBp
bnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQo+ID4gIHsN
Cj4gPiAgCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oIGIvaW5jbHVk
ZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+IGluZGV4IDEyMWMzYmI2ZDNk
ZS4uOGVmODdlMWJkMDNiIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvbWFpbGJveC9t
dGstY21kcS1tYWlsYm94LmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNt
ZHEtbWFpbGJveC5oDQo+ID4gQEAgLTU5LDYgKzU5LDggQEAgZW51bSBjbWRxX2NvZGUgew0KPiA+
ICAJQ01EUV9DT0RFX0pVTVAgPSAweDEwLA0KPiA+ICAJQ01EUV9DT0RFX1dGRSA9IDB4MjAsDQo+
ID4gIAlDTURRX0NPREVfRU9DID0gMHg0MCwNCj4gPiArCUNNRFFfQ09ERV9XUklURV9TID0gMHg5
MCwNCj4gPiArCUNNRFFfQ09ERV9XUklURV9TX01BU0sgPSAweDkxLA0KPiA+ICAJQ01EUV9DT0RF
X0xPR0lDID0gMHhhMCwNCj4gPiAgfTsNCj4gPiAgDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRl
ay9tdGstY21kcS5oDQo+ID4gaW5kZXggYzY2YjNhMGRhMmEyLi41NmZmMTk3MDE5N2MgMTAwNjQ0
DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+ICsr
KyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4gPiBAQCAtMTA2LDYg
KzEwNiwxOCBAQCBpbnQgY21kcV9wa3Rfd3JpdGUoc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1
YnN5cywgdTE2IG9mZnNldCwgdTMyIHZhbHVlKTsNCj4gPiAgaW50IGNtZHFfcGt0X3dyaXRlX21h
c2soc3RydWN0IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAgCQkJdTE2IG9mZnNldCwg
dTMyIHZhbHVlLCB1MzIgbWFzayk7DQo+ID4gIA0KPiA+ICsvKioNCj4gPiArICogY21kcV9wa3Rf
d3JpdGVfc19tYXNrKCkgLSBhcHBlbmQgd3JpdGVfcyBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tl
dA0KPiA+ICsgKiBAcGt0Ogl0aGUgQ01EUSBwYWNrZXQNCj4gPiArICogQGFkZHI6CXRoZSBwaHlz
aWNhbCBhZGRyZXNzIG9mIHJlZ2lzdGVyIG9yIGRtYQ0KPiA+ICsgKiBAcmVnX2lkeDoJdGhlIENN
RFEgaW50ZXJuYWwgcmVnaXN0ZXIgSUQgd2hpY2ggY2FjaGUgc291cmNlIHZhbHVlDQo+ID4gKyAq
IEBtYXNrOgl0aGUgc3BlY2lmaWVkIHRhcmdldCByZWdpc3RlciBtYXNrDQo+ID4gKyAqDQo+ID4g
KyAqIFJldHVybjogMCBmb3Igc3VjY2VzczsgZWxzZSB0aGUgZXJyb3IgY29kZSBpcyByZXR1cm5l
ZA0KPiA+ICsgKi8NCj4gPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpw
a3QsIHBoeXNfYWRkcl90IGFkZHIsIHUxNiByZWdfaWR4LA0KPiA+ICsJCSAgICAgdTMyIG1hc2sp
Ow0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X3dmZSgpIC0gYXBwZW5kIHdhaXQg
Zm9yIGV2ZW50IGNvbW1hbmQgdG8gdGhlIENNRFEgcGFja2V0DQo+ID4gICAqIEBwa3Q6CXRoZSBD
TURRIHBhY2tldA0KPiANCj4gDQoNCg==

