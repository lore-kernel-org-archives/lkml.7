Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0D1C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40EF222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 01:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="m7AdmdtF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfLLBnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 20:43:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:8618 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727649AbfLLBnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 20:43:01 -0500
X-UUID: 2852b13916f540a09307fbd4b35acc9d-20191212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=phDsoiIyJCBnu4asobwbcjbE3yzCEaKCfb7CC35r6aw=;
        b=m7AdmdtFaKS/md5+QEqjxR+L5OrA0PxvbrRYKDbLwgwpLWcWikGGq3iufCjmEwA7T04RZsOLN/ZmekFiDS8KcqM7AVdjde+n/wwGGFbQwOeybnsvmpXcVpnHAiblQPWheK2VyIBNyrWsobV/j7bTz/gz+xtNTKVV+C+D641OLls=;
X-UUID: 2852b13916f540a09307fbd4b35acc9d-20191212
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <dennis-yc.hsieh@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1915842643; Thu, 12 Dec 2019 09:42:56 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 12 Dec 2019 09:42:35 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 12 Dec 2019 09:42:51 +0800
Message-ID: <1576114975.17653.16.camel@mtkswgap22>
Subject: Re: [PATCH v2 13/14] soc: mediatek: cmdq: add wait no clear event
 function
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
Date:   Thu, 12 Dec 2019 09:42:55 +0800
In-Reply-To: <1576029887.19653.17.camel@mtksdaap41>
References: <1574819937-6246-1-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1574819937-6246-15-git-send-email-dennis-yc.hsieh@mediatek.com>
         <1576029887.19653.17.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDE5LTEyLTExIGF0IDEwOjA0ICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIERl
bm5pczoNCj4gDQo+IE9uIFdlZCwgMjAxOS0xMS0yNyBhdCAwOTo1OCArMDgwMCwgRGVubmlzIFlD
IEhzaWVoIHdyb3RlOg0KPiA+IEFkZCB3YWl0IG5vIGNsZWFyIGV2ZW50IGZ1bmN0aW9uIGluIGNt
ZHEgaGVscGVyIGZ1bmN0aW9ucyB0byB3YWl0IHNwZWNpZmljDQo+ID4gZXZlbnQgd2l0aG91dCBj
bGVhciB0byAwIGFmdGVyIHJlY2VpdmUgaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogRGVu
bmlzIFlDIEhzaWVoIDxkZW5uaXMteWMuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+
ICBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstY21kcS1oZWxwZXIuYyB8IDE1ICsrKysrKysrKysr
KysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oICB8IDEwICsr
KysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspDQo+ID4gDQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1jbWRxLWhlbHBlci5jIGIv
ZHJpdmVycy9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEtaGVscGVyLmMNCj4gPiBpbmRleCAxMGE5YjQ0
ODFlNTguLjZmMjcwZmFkZmI1MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstY21kcS1oZWxwZXIuYw0KPiA+ICsrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1j
bWRxLWhlbHBlci5jDQo+ID4gQEAgLTMzMCw2ICszMzAsMjEgQEAgaW50IGNtZHFfcGt0X3dmZShz
dHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTE2IGV2ZW50KQ0KPiA+ICB9DQo+ID4gIEVYUE9SVF9TWU1C
T0woY21kcV9wa3Rfd2ZlKTsNCj4gPiAgDQo+ID4gK2ludCBjbWRxX3BrdF93YWl0X25vX2NsZWFy
KHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYgZXZlbnQpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBj
bWRxX2luc3RydWN0aW9uIGluc3QgPSB7IHswfSB9Ow0KPiA+ICsNCj4gPiArCWlmIChldmVudCA+
PSBDTURRX01BWF9FVkVOVCkNCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArDQo+ID4gKwlp
bnN0Lm9wID0gQ01EUV9DT0RFX1dGRTsNCj4gPiArCWluc3QudmFsdWUgPSBDTURRX1dGRV9XQUlU
IHwgQ01EUV9XRkVfV0FJVF9WQUxVRTsNCj4gPiArCWluc3QuZXZlbnQgPSBldmVudDsNCj4gPiAr
DQo+ID4gKwlyZXR1cm4gY21kcV9wa3RfYXBwZW5kX2NvbW1hbmQocGt0LCBpbnN0KTsNCj4gPiAr
fQ0KPiA+ICtFWFBPUlRfU1lNQk9MKGNtZHFfcGt0X3dhaXRfbm9fY2xlYXIpOw0KPiANCj4gU28g
dGhlIHdhaXQgY29tbWFuZCBoYXMgdHdvIHZlcnNpb24sIG9uZSBpcyB3YWl0IGFuZCB0aGVuIGNs
ZWFyIGV2ZW50LA0KPiBhbm90aGVyIGlzIHdhaXQgYW5kIG5vdCBjbGVhciBldmVudC4gVGhlIG5h
bWUgb2YgY21kcV9wa3Rfd2ZlKCkgaXMgJ3dhaXQNCj4gZm9yIGV2ZW50Jywgc28gaXQncyB0cml2
aWFsIHRoYXQgd2UgdGhpbmsgaXQgZG9lcyBub3QgY2xlYXIgZXZlbnQuIEkndmUNCj4gdGhyZWUg
c3VnZ2VzdGlvbiBmb3IgdGhpczoNCj4gDQo+IDEuIExldCBjbWRxX3BrdF93ZmUoKSB3YWl0IGFu
ZCBub3QgY2xlYXIgZXZlbnQsIGFuZA0KPiBjbWRxX3BrdF93ZmVfY2xlYXJfZXZlbnQoKSB3YWl0
IGFuZCBjbGVhciBldmVudC4NCj4gDQo+IG9yIA0KPiAyLiBMZXQgY21kcV9wa3Rfd2ZlKCkgaGFz
IGEgcGFyYW1ldGVyIHRvIGluZGljYXRlIHRoYXQgY2xlYXIgZXZlbnQgb3INCj4gbm90IGFmdGVy
IHdhaXQuDQo+IA0KPiBvcg0KPiAzLiBMZXQgY21kcV9wa3Rfd2ZlKCkgd2FpdCBhbmQgbm90IGNs
ZWFyIGV2ZW50LCBhbmQgbm90IHByb3ZpZGUgd2FpdCBhbmQNCj4gY2xlYXIgZXZlbnQgdmVyc2lv
bi4gRm9yIERSTSBhbmQgTURQLCBJIHRoaW5rIGJvdGgganVzdCBuZWVkIHdhaXQgYW5kDQo+IG5v
dCBjbGVhciBldmVudC4NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KDQpvaywgSSB3aWxsIGNo
YW5nZSBjbWRxX3BrdF93ZmUgd2FpdCBhbmQgbm90IGNsZWFyLCBhbmQgZXhwb3NlIGFub3RoZXIN
CmNtZHFfcGt0X3dmZV9jbGVhcl9ldmVudCgpIGFwaQ0KDQoNClJlZ2FyZHMsDQpEZW5uaXMNCg0K
PiANCj4gPiArDQo+ID4gIGludCBjbWRxX3BrdF9jbGVhcl9ldmVudChzdHJ1Y3QgY21kcV9wa3Qg
KnBrdCwgdTE2IGV2ZW50KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgY21kcV9pbnN0cnVjdGlvbiBp
bnN0ID0geyB7MH0gfTsNCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrLWNtZHEuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmgNCj4g
PiBpbmRleCBkMTVkOGM5NDE5OTIuLjQwYmM2MWFkOGQzMSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNs
dWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGstY21kcS5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51
eC9zb2MvbWVkaWF0ZWsvbXRrLWNtZHEuaA0KPiA+IEBAIC0xNDksNiArMTQ5LDE2IEBAIGludCBj
bWRxX3BrdF93cml0ZV9zX3ZhbHVlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCBkbWFfYWRkcl90IGFk
ZHIsDQo+ID4gICAqLw0KPiA+ICBpbnQgY21kcV9wa3Rfd2ZlKHN0cnVjdCBjbWRxX3BrdCAqcGt0
LCB1MTYgZXZlbnQpOw0KPiA+ICANCj4gPiArLyoqDQo+ID4gKyAqIGNtZHFfcGt0X3dhaXRfbm9f
Y2xlYXIoKSAtIEFwcGVuZCB3YWl0IGZvciBldmVudCBjb21tYW5kIHRvIHRoZSBDTURRIHBhY2tl
dCwNCj4gPiArICoJCQkgICAgICB3aXRob3V0IHVwZGF0ZSBldmVudCB0byAwIGFmdGVyIHJlY2Vp
dmUgaXQuDQo+ID4gKyAqIEBwa3Q6CXRoZSBDTURRIHBhY2tldA0KPiA+ICsgKiBAZXZlbnQ6CXRo
ZSBkZXNpcmVkIGV2ZW50IHR5cGUgdG8gd2FpdA0KPiA+ICsgKg0KPiA+ICsgKiBSZXR1cm46IDAg
Zm9yIHN1Y2Nlc3M7IGVsc2UgdGhlIGVycm9yIGNvZGUgaXMgcmV0dXJuZWQNCj4gPiArICovDQo+
ID4gK2ludCBjbWRxX3BrdF93YWl0X25vX2NsZWFyKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MTYg
ZXZlbnQpOw0KPiA+ICsNCj4gPiAgLyoqDQo+ID4gICAqIGNtZHFfcGt0X2NsZWFyX2V2ZW50KCkg
LSBhcHBlbmQgY2xlYXIgZXZlbnQgY29tbWFuZCB0byB0aGUgQ01EUSBwYWNrZXQNCj4gPiAgICog
QHBrdDoJdGhlIENNRFEgcGFja2V0DQo+IA0KPiANCg0K

