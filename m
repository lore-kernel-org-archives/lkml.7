Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F77C17442
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C6E206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 01:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="H2kOYdgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfKKBiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 20:38:24 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:40387 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726733AbfKKBiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 20:38:24 -0500
X-UUID: 7174e2fad0424b07b0c239fba7514fad-20191111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Z1wjq7BHhl5SV+QLzicEwl3bPZzqKzQNsT/nQQRovnA=;
        b=H2kOYdgmddEgEmhVK8OJuYxmkhntvDqO33X07Yr090JIKxhVJLq5ydkP8QIAOQrgPY6BiGQ4rZEClKjqC3PUBKwzTpyFnCZaJh0aLAQ8hLelT7eprkSEQQV3A9xmAz5ZFoeagPLTVYgDpCtuDEawvYRok8/YXmJHpyANal3q4+E=;
X-UUID: 7174e2fad0424b07b0c239fba7514fad-20191111
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <eason.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 732595513; Mon, 11 Nov 2019 09:38:16 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 11 Nov 2019 09:38:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 11 Nov 2019 09:38:13 +0800
Message-ID: <1573436294.12075.14.camel@mtkswgap22>
Subject: Re: [PATCH v1 1/1] soc: mediatek: add SMC fid table for SIP
 interface
From:   Eason Yen <eason.yen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <Eason.Yen@mediatek.com>
Date:   Mon, 11 Nov 2019 09:38:14 +0800
In-Reply-To: <44bddcd1-457d-bde6-791f-def248f787b3@gmail.com>
References: <1572247749-4276-1-git-send-email-eason.yen@mediatek.com>
         <1572247749-4276-2-git-send-email-eason.yen@mediatek.com>
         <44bddcd1-457d-bde6-791f-def248f787b3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5EC5FA932747D3C8A9D88655AFE52152DB7FEFFFF18BD072339340E490D9EE922000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBNYXR0aGlhcywNCg0KICAgIFRoaXMgaGVhZGVyIGZpbGVzIGlzIHVzZWQgZm9yIG10ayBw
cm9wcmlldGFyeSBkcml2ZXJzLiAgICANCiAgICBNVEsgU0lQIGNhbGwgY2xpZW50cyBzaG91bGQg
ZGVmaW5lIE1US19TSVBfWFhYIHdpdGggc3BlY2lmaWMgY29udHJvbA0KSUQgb24gdGhpcyBoZWFk
ZXIgZmlsZS4NCiAgIA0KICAgIG10ayBzaXAgY2FsbCBleGFtcGxlIChzb3VuZCBjYXJkIGRyaXZl
cik6DQogICAgYXJtX3NtY2NjX3NtYyhNVEtfU0lQX0FVRElPX0NPTlRST0wsICAvKiBzcGVjaWZp
YyBNVEtfU0lQX1hYWCBpZCAqLw0KICAgICAgICAgICAgICAgICAgTVRLX0FVRElPX1NNQ19PUF9E
UkFNX1JFUVVFU1QsDQogICAgICAgICAgICAgICAgICAwLCAwLCAwLCAwLCAwLCAwLCAmcmVzKTsN
Cg0KICAgIEJlY2F1c2Ugc291bmQgY2FyZCBkcml2ZXIobXQ2Nzc5KSBpcyBzdGlsbCByZXZpZXdp
bmcgaW50ZXJuYWxseSwNCiAgICBJIGp1c3QgdXBzdHJlYW0gdGhpcyBoZWFkZXIgZmlsZSBmaXJz
dC4NCg0KICAgIEkgd2lsbCByZW1vdmUgY2hhbmdlLWlkIGVudHJ5IGFuZCB1cHN0cmVhbSBhZ2Fp
biBzb29uLg0KICAgIFRoYW5rcyBmb3IgeW91ciByZXZpZXdpbmcuDQoNCg0KUmVnYXJkcywNCkVh
c29uDQoNCg0KT24gU3VuLCAyMDE5LTExLTEwIGF0IDIxOjE4ICswMTAwLCBNYXR0aGlhcyBCcnVn
Z2VyIHdyb3RlOg0KPiANCj4gT24gMjgvMTAvMjAxOSAwODoyOSwgRWFzb24gWWVuIHdyb3RlOg0K
PiA+IDEuIEFkZCBhIGhlYWRlciBmaWxlIHRvIHByb3ZpZGUgU0lQIGludGVyZmFjZSB0byBBVEYN
Cj4gPiAyLiBBZGQgQVVESU8gU01DIGZpZA0KPiA+IA0KPiA+IENoYW5nZS1JZDogSTIxOGU5ZjU3
MWNlYTA3OTI2OGE1NDE0NzI1YTgxZTliMzU3MDJlMzMNCj4gDQo+IFBsZWFzZSBkZWxldGUgQ2hh
bmdlLUlkIGVudHJ5Lg0KPiBBcGFydCBmcm9tIHRoYXQsIEkgZG9uJ3QgcmVhbGx5IGdldCB0aGUg
cmVhc29uIGZvciB0aGlzIHBhdGNoLiBXaGljaCBkcml2ZXIgaXMNCj4gc3VwcG9zZWQgdG8gdXNl
IHRoaXMgaGVhZGVyIGZpbGU/DQo+IA0KPiBQbGVhc2UgcHJvdmlkZSBtb3JlIGJhY2tncm91bmQg
aW5mb3JtYXRpb24uDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXR0aGlhcw0KPiANCj4gPiBTaWduZWQt
b2ZmLWJ5OiBFYXNvbiBZZW4gPGVhc29uLnllbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4g
IGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210a19zaXBfc3ZjLmggfCAgIDI4ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMo
KykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210
a19zaXBfc3ZjLmgNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zb2MvbWVk
aWF0ZWsvbXRrX3NpcF9zdmMuaCBiL2luY2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210a19zaXBf
c3ZjLmgNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjAwZWUw
ZjQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrX3NpcF9zdmMuaA0KPiA+IEBAIC0wLDAgKzEsMjggQEANCj4gPiArLyogU1BEWC1MaWNl
bnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgKi8NCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChj
KSAyMDE5IE1lZGlhVGVrIEluYy4NCj4gPiArICovDQo+ID4gKw0KPiA+ICsjaWZuZGVmIF9fTVRL
X1NJUF9TVkNfSF9fDQo+ID4gKyNkZWZpbmUgX19NVEtfU0lQX1NWQ19IX18NCj4gPiArDQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiArDQo+ID4gKy8qIEVycm9yIENvZGUgKi8N
Cj4gPiArI2RlZmluZSBTSVBfU1ZDX0VfU1VDQ0VTUyAgICAgICAgICAgICAgIDANCj4gPiArI2Rl
ZmluZSBTSVBfU1ZDX0VfTk9UX1NVUFBPUlRFRCAgICAgICAgIC0xDQo+ID4gKyNkZWZpbmUgU0lQ
X1NWQ19FX0lOVkFMSURfUEFSQU1TICAgICAgICAtMg0KPiA+ICsjZGVmaW5lIFNJUF9TVkNfRV9J
TlZBTElEX1JhbmdlICAgICAgICAgLTMNCj4gPiArI2RlZmluZSBTSVBfU1ZDX0VfUEVSTUlTU0lP
Tl9ERU5ZICAgICAgIC00DQo+ID4gKw0KPiA+ICsjaWZkZWYgQ09ORklHX0FSTTY0DQo+ID4gKyNk
ZWZpbmUgTVRLX1NJUF9TTUNfQUFSQ0hfQklUCQkJMHg0MDAwMDAwMA0KPiA+ICsjZWxzZQ0KPiA+
ICsjZGVmaW5lIE1US19TSVBfU01DX0FBUkNIX0JJVAkJCTB4MDAwMDAwMDANCj4gPiArI2VuZGlm
DQo+ID4gKw0KPiA+ICsvKiBBVURJTyByZWxhdGVkIFNNQyBjYWxsICovDQo+ID4gKyNkZWZpbmUg
TVRLX1NJUF9BVURJT19DT05UUk9MIFwNCj4gPiArCSgweDgyMDAwNTE3IHwgTVRLX1NJUF9TTUNf
QUFSQ0hfQklUKQ0KPiA+ICsjZW5kaWYNCj4gPiArLyogX19NVEtfU0lQX1NWQ19IX18gKi8NCj4g
PiANCg0K

