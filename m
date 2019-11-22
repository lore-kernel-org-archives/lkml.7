Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26CDC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22CC2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Rz+aX8Hg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKVKNT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:13:19 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:54970 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726613AbfKVKNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:13:19 -0500
X-UUID: 90a7ec6875a74c60862802dee2a1de5f-20191122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=hK85BWO5PB72avyugc76FhRfS++eD6TPM5BELRKbSFs=;
        b=Rz+aX8HgQ+jCzopEyCY6rKva3jwGjNbMKujh1ylJ0j2rJgQ0ZESkp+rX0aEk7To/z0aZ5M61iwQbz4yS3LA816jW2FIme7H8BaxEA66YIZi5AKaiFcjtDvOn+E3RtH3aK5C70XNEXNajrjPfdBzQcHRIE5kQJXK1eqWGD38hCRI=;
X-UUID: 90a7ec6875a74c60862802dee2a1de5f-20191122
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1789497985; Fri, 22 Nov 2019 18:13:13 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Nov 2019 18:11:42 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 22 Nov 2019 18:12:10 +0800
Message-ID: <1574417507.11977.14.camel@mtkswgap22>
Subject: Re: [PATCH v1 07/12] soc: mediatek: cmdq: add write_s function
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
Date:   Fri, 22 Nov 2019 18:11:47 +0800
In-Reply-To: <1574412997.19450.16.camel@mtksdaap41>
References: <1574327552-11806-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574327552-11806-8-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574412997.19450.16.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ0ssDQoNCk9uIEZyaSwgMjAxOS0xMS0yMiBhdCAxNjo1NiArMDgwMCwgQ0sgSHUgd3JvdGU6
DQo+IEhpLCBEZW5uaXM6DQo+IA0KPiBPbiBUaHUsIDIwMTktMTEtMjEgYXQgMTc6MTIgKzA4MDAs
IERlbm5pcyBZQyBIc2llaCB3cm90ZToNCj4gPiBhZGQgd3JpdGVfcyBmdW5jdGlvbiBpbiBjbWRx
IGhlbHBlciBmdW5jdGlvbnMgd2hpY2gNCj4gPiBzdXBwb3J0IGxhcmdlIGRtYSBhY2Nlc3MuDQo+
ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVubmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhA
bWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21k
cS1oZWxwZXIuYyAgIHwgICAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
aW5jbHVkZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaCB8ICAgIDIgKysNCj4gPiAg
aW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaCAgICB8ICAgMTMgKysrKysrKysr
KysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyBiL2RyaXZl
cnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+ID4gaW5kZXggZDQxOWU5OS4uMWIw
NzRhOSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxw
ZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jDQo+
ID4gQEAgLTE1LDYgKzE1LDkgQEANCj4gPiAgI2RlZmluZSBDTURRX0VPQ19DTUQJCSgodTY0KSgo
Q01EUV9DT0RFX0VPQyA8PCBDTURRX09QX0NPREVfU0hJRlQpKSBcDQo+ID4gIAkJCQk8PCAzMiB8
IENNRFFfRU9DX0lSUV9FTikNCj4gPiAgI2RlZmluZSBDTURRX1JFR19UWVBFCQkxDQo+ID4gKyNk
ZWZpbmUgQ01EUV9BRERSX0hJR0goYWRkcikJKCh1MzIpKCgoYWRkcikgPj4gMTYpICYgR0VOTUFT
SygzMSwgMCkpKQ0KPiA+ICsjZGVmaW5lIENNRFFfQUREUl9MT1dfQklUCUJJVCgxKQ0KPiA+ICsj
ZGVmaW5lIENNRFFfQUREUl9MT1coYWRkcikJKCh1MTYpKGFkZHIpIHwgQ01EUV9BRERSX0xPV19C
SVQpDQo+ID4gIA0KPiA+ICBzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiB7DQo+ID4gIAl1bmlvbiB7
DQo+ID4gQEAgLTIyNCw2ICsyMjcsMzcgQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0
IGNtZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAgfQ0KPiA+ICBFWFBPUlRfU1lNQk9MKGNt
ZHFfcGt0X3dyaXRlX21hc2spOw0KPiA+ICANCj4gPiAraW50IGNtZHFfcGt0X3dyaXRlX3Moc3Ry
dWN0IGNtZHFfcGt0ICpwa3QsIGRtYV9hZGRyX3QgYWRkciwNCj4gPiArCQkgICAgIHUzMiB2YWx1
ZSwgdTMyIG1hc2spDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBjbWRxX2luc3RydWN0aW9uIGluc3Qg
PSB7IHswfSB9Ow0KPiA+ICsJaW50IGVycjsNCj4gPiArCWNvbnN0IHUxNiBkc3RfcmVnX2lkeCA9
IENNRFFfU1BSX1RFTVA7DQo+ID4gKw0KPiA+ICsJZXJyID0gY21kcV9wa3RfYXNzaWduKHBrdCwg
ZHN0X3JlZ19pZHgsIENNRFFfQUREUl9ISUdIKGFkZHIpKTsNCj4gPiArCWlmIChlcnIgPCAwKQ0K
PiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKw0KPiA+ICsJaWYgKG1hc2sgIT0gVTMyX01BWCkgew0K
PiA+ICsJCWluc3Qub3AgPSBDTURRX0NPREVfTUFTSzsNCj4gPiArCQlpbnN0Lm1hc2sgPSB+bWFz
azsNCj4gPiArCQllcnIgPSBjbWRxX3BrdF9hcHBlbmRfY29tbWFuZChwa3QsIGluc3QpOw0KPiA+
ICsJCWlmIChlcnIgPCAwKQ0KPiA+ICsJCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gPiArCQlpbnN0
Lm9wID0gQ01EUV9DT0RFX1dSSVRFX1NfTUFTSzsNCj4gPiArCX0gZWxzZSB7DQo+ID4gKwkJaW5z
dC5vcCA9IENNRFFfQ09ERV9XUklURV9TOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWluc3Quc29w
ID0gZHN0X3JlZ19pZHg7DQo+ID4gKwlpbnN0Lm9mZnNldCA9IENNRFFfQUREUl9MT1coYWRkcik7
DQo+ID4gKwlpbnN0LnZhbHVlID0gdmFsdWU7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGNtZHFfcGt0
X2FwcGVuZF9jb21tYW5kKHBrdCwgaW5zdCk7DQo+ID4gK30NCj4gPiArRVhQT1JUX1NZTUJPTChj
bWRxX3BrdF93cml0ZV9zKTsNCj4gPiArDQo+ID4gIGludCBjbWRxX3BrdF93ZmUoc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHUxNiBldmVudCkNCj4gPiAgew0KPiA+ICAJc3RydWN0IGNtZHFfaW5zdHJ1
Y3Rpb24gaW5zdCA9IHsgezB9IH07DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWFp
bGJveC9tdGstY21kcS1tYWlsYm94LmggYi9pbmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEt
bWFpbGJveC5oDQo+ID4gaW5kZXggMTIxYzNiYi4uOGVmODdlMSAxMDA2NDQNCj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5oDQo+ID4gKysrIGIvaW5jbHVk
ZS9saW51eC9tYWlsYm94L210ay1jbWRxLW1haWxib3guaA0KPiA+IEBAIC01OSw2ICs1OSw4IEBA
IGVudW0gY21kcV9jb2RlIHsNCj4gPiAgCUNNRFFfQ09ERV9KVU1QID0gMHgxMCwNCj4gPiAgCUNN
RFFfQ09ERV9XRkUgPSAweDIwLA0KPiA+ICAJQ01EUV9DT0RFX0VPQyA9IDB4NDAsDQo+ID4gKwlD
TURRX0NPREVfV1JJVEVfUyA9IDB4OTAsDQo+ID4gKwlDTURRX0NPREVfV1JJVEVfU19NQVNLID0g
MHg5MSwNCj4gPiAgCUNNRFFfQ09ERV9MT0dJQyA9IDB4YTAsDQo+ID4gIH07DQo+ID4gIA0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oIGIvaW5j
bHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IGluZGV4IDgzMzQwMjEuLjhk
YmQwNDYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0ZWsvbXRrLWNt
ZHEuaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
PiBAQCAtMTIsNiArMTIsNyBAQA0KPiA+ICAjaW5jbHVkZSA8bGludXgvdGltZXIuaD4NCj4gPiAg
DQo+ID4gICNkZWZpbmUgQ01EUV9OT19USU1FT1VUCQkweGZmZmZmZmZmdQ0KPiA+ICsjZGVmaW5l
IENNRFFfU1BSX1RFTVAJCTANCj4gPiAgDQo+ID4gIHN0cnVjdCBjbWRxX3BrdDsNCj4gPiAgDQo+
ID4gQEAgLTEwMyw2ICsxMDQsMTggQEAgaW50IGNtZHFfcGt0X3dyaXRlX21hc2soc3RydWN0IGNt
ZHFfcGt0ICpwa3QsIHU4IHN1YnN5cywNCj4gPiAgCQkJdTE2IG9mZnNldCwgdTMyIHZhbHVlLCB1
MzIgbWFzayk7DQo+ID4gIA0KPiA+ICAvKioNCj4gPiArICogY21kcV9wa3Rfd3JpdGVfcygpIC0g
YXBwZW5kIHdyaXRlX3MgY29tbWFuZCB3aXRoIG1hc2sgdG8gdGhlIENNRFEgcGFja2V0DQo+ID4g
KyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+ICsgKiBAYWRkcjoJdGhlIHBoeXNpY2FsIGFk
ZHJlc3Mgb2YgcmVnaXN0ZXIgb3IgZG1hDQo+ID4gKyAqIEB2YWx1ZToJdGhlIHNwZWNpZmllZCB0
YXJnZXQgdmFsdWUNCj4gPiArICogQG1hc2s6CXRoZSBzcGVjaWZpZWQgdGFyZ2V0IG1hc2sNCj4g
PiArICoNCj4gPiArICogUmV0dXJuOiAwIGZvciBzdWNjZXNzOyBlbHNlIHRoZSBlcnJvciBjb2Rl
IGlzIHJldHVybmVkDQo+ID4gKyAqLw0KPiA+ICtpbnQgY21kcV9wa3Rfd3JpdGVfcyhzdHJ1Y3Qg
Y21kcV9wa3QgKnBrdCwgZG1hX2FkZHJfdCBhZGRyLA0KPiA+ICsJCSAgICAgdTMyIHZhbHVlLCB1
MzIgbWFzayk7DQo+IA0KPiBZb3UgaGF2ZSBhbiBBUEkgY21kcV9wa3RfcmVhZF9zKCkgd2hpY2gg
cmVhZCBkYXRhIGludG8gZ2NlIGludGVybmFsDQo+IHJlZ2lzdGVyLCBzbyBJIGV4cGVjdCB0aGF0
IGNtZHFfcGt0X3dyaXRlX3MoKSBpcyBhbiBBUEkgd2hpY2ggd3JpdGUgZGF0YQ0KPiBmcm9tIGdj
ZSBpbnRlcm5hbCByZWdpc3RlciwgdGhlIGV4cGVjdGVkIHByb3RvdHlwZSBpcw0KPiANCj4gaW50
IGNtZHFfcGt0X3dyaXRlX3Moc3RydWN0IGNtZHFfcGt0ICpwa3QsIHBoeXNfYWRkcl90IGFkZHIs
IHUxNg0KPiByZWdfaWR4KTsNCj4gDQo+IFlvdXIgdmVyc2lvbiB3b3VsZCBjb25mdXNlIHRoZSB1
c2VyIGJlY2F1c2UgeW91IGhpZGUgdGhlIGludGVybmFsDQo+IHJlZ2lzdGVyIHBhcmFtZXRlci4g
SWYgeW91IHdhbnQgdG8gcHJvdmlkZSB0aGlzIHNlcnZpY2UsIEkgd291bGQgbGlrZQ0KPiB5b3Ug
dG8gY2hhbmdlIHRoZSBmdW5jdGlvbiBuYW1lIHNvIHRoYXQgdXNlciB3b3VsZCBub3QgYmUgY29u
ZnVzZWQgYW5kDQo+IGVhc2lseSB0byB1bmRlcnN0YW5kIHdoYXQgeW91IHdhbnQgdG8gZG8gaW4g
dGhpcyBmdW5jdGlvbi4NCj4gDQo+IEFub3RoZXIgY2hvaWNlIGlzOiBjbWRxX3BrdF93cml0ZV9z
KCkgaXMgaW1wbGVtZW50ZWQgaW4gbXkgZGVmaW5pdGlvbiwNCj4gYW5kIHVzZXIgY291bGQgY2Fs
bCBjbWRxX3BrdF9hc3NpZ24oKSBhbmQgY21kcV9wa3Rfd3JpdGVfcygpIHRvIGFjaGlldmUNCj4g
dGhpcyBmdW5jdGlvbi4NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KDQpUaGFua3MgZm9yIHlv
dXIgY29tbWVudC4NCg0KT2ssIHdlIGhhdmUgdG8gcHJvdmlkZSB3cml0ZSBjb25zdGFudCB2YWx1
ZSBzZXJ2aWNlIHRvIGNsaWVudCwgc28gSSB3aWxsDQpjaGFuZ2UgdGhlIGZ1bmN0aW9uIG5hbWUg
dG8gY21kcV9wa3Rfd3JpdGVfc192YWx1ZSgpIGluIHRoaXMgcGF0Y2guDQoNCkFuZCBzaW5jZSBp
dCBpcyBiZXR0ZXIgdG8gcHJvdmlkZSBjb25zaXN0ZW50IEFQSSBzbyBJIHdpbGwgZGVzaWduDQph
bm90aGVyIGZ1bmN0aW9uIHdpdGggaW50ZXJmYWNlIGFzIHlvdXIgc3VnZ2VzdGlvbjoNCmludCBj
bWRxX3BrdF93cml0ZV9zKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBwaHlzX2FkZHJfdCBhZGRyLCB1
MTYNCnJlZ19pZHgpOw0KDQpJbiBhbm90aGVyIHBhdGNoIEkgcHJvdmlkZSBjbWRxX3BrdF9tZW1f
bW92ZSgpLiBJIHdpbGwgbW92ZSBwYXJ0IG9mDQppbXBsZW1lbnRhdGlvbiB0byBjbWRxX3BrdF93
cml0ZV9zKCksIHNvIHRoYXQgY21kcV9wa3RfbWVtX21vdmUoKSBjYW4gYmUNCmNvbWJpbmF0aW9u
IG9mIGNtZHFfcGt0X3JlYWRfcygpIGFuZCBjbWRxX3BrdF93cml0ZV9zKCkuDQoNCkhvdyBkbyB5
b3UgdGhpbms/DQoNCg0KUmVnYXJkcywNCkRlbm5pcw0KDQo+ID4gKw0KPiA+ICsvKioNCj4gPiAg
ICogY21kcV9wa3Rfd2ZlKCkgLSBhcHBlbmQgd2FpdCBmb3IgZXZlbnQgY29tbWFuZCB0byB0aGUg
Q01EUSBwYWNrZXQNCj4gPiAgICogQHBrdDoJdGhlIENNRFEgcGFja2V0DQo+ID4gICAqIEBldmVu
dDoJdGhlIGRlc2lyZWQgZXZlbnQgdHlwZSB0byAid2FpdCBhbmQgQ0xFQVIiDQo+IA0KPiANCg0K

