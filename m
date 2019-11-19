Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1411C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E9D2230C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 07:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PDT3vL3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfKSH52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 02:57:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:9526 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727007AbfKSH52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 02:57:28 -0500
X-UUID: a7163a41c1394fa3b0f25bf86255122d-20191119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=yBnu1NtPajEa00aUiIIxVlbDQ8eChoLCV7rmSdXtLH4=;
        b=PDT3vL3EhKmVaDjFzp+2dEvjD54PpDO7kDG3B9MDJev5ur3npY9ZwcSTCtnxiKFKMA5UthNLEWgWtbILacQXvBHVftLSuitUIsefXCobp5KDTiYwhm57SkTqZC7od2q/tcEes1DyMM+U+lvbds7ABaRHhV9cSd7xRYzWqk+YlSs=;
X-UUID: a7163a41c1394fa3b0f25bf86255122d-20191119
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1361509069; Tue, 19 Nov 2019 15:57:22 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Nov
 2019 15:57:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by mtkcas07.mediatek.inc
 (172.21.101.84) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 19 Nov
 2019 15:57:08 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Nov 2019 15:57:08 +0800
Message-ID: <1574150240.19262.7.camel@mtksdccf07>
Subject: Re: [RESEND, PATCH 1/1] arm: dts: mediatek: add mt7629 pwm support
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 19 Nov 2019 15:57:20 +0800
In-Reply-To: <31fddc2b-65c7-02e8-dca2-b5d6dc050f87@gmail.com>
References: <1571751001-28588-1-git-send-email-sam.shih@mediatek.com>
         <1571751001-28588-2-git-send-email-sam.shih@mediatek.com>
         <31fddc2b-65c7-02e8-dca2-b5d6dc050f87@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCAyMDE5LTExLTEwIGF0IDIxOjUxICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjIvMTAvMjAxOSAxNTozMCwgU2FtIFNoaWggd3JvdGU6DQo+ID4gVGhpcyBh
ZGRzIHB3bSBzdXBwb3J0IGZvciBNVDc2MjkuDQo+ID4gVXNlZDoNCj4gPiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3BhdGNoLzExMTYwODUxLw0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IFNhbSBTaGloIDxzYW0uc2hpaEBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJt
L2Jvb3QvZHRzL210NzYyOS5kdHNpIHwgMTUgKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2Jvb3QvZHRzL210NzYyOS5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbXQ3NjI5LmR0c2kNCj4g
PiBpbmRleCA5NjA4YmMyY2NiM2YuLjI0Mzc1ZmM1ZjkzNiAxMDA2NDQNCj4gPiAtLS0gYS9hcmNo
L2FybS9ib290L2R0cy9tdDc2MjkuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL210
NzYyOS5kdHNpDQo+ID4gQEAgLTI0MSw2ICsyNDEsMjEgQEANCj4gPiAgCQkJc3RhdHVzID0gImRp
c2FibGVkIjsNCj4gPiAgCQl9Ow0KPiA+ICANCj4gPiArCQlwd206IHB3bUAxMTAwNjAwMCB7DQo+
ID4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ3NjI5LXB3bSI7DQo+ID4gKwkJCXJlZyA9
IDwweDExMDA2MDAwIDB4MTAwMD47DQo+ID4gKwkJCWludGVycnVwdHMgPSA8R0lDX1NQSSA3NyBJ
UlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiA+ICsJCQljbG9ja3MgPSA8JnRvcGNrZ2VuIENMS19UT1Bf
UFdNX1NFTD4sDQo+ID4gKwkJCQkgPCZwZXJpY2ZnIENMS19QRVJJX1BXTV9QRD4sDQo+ID4gKwkJ
CQkgPCZwZXJpY2ZnIENMS19QRVJJX1BXTTFfUEQ+Ow0KPiA+ICsJCQljbG9jay1uYW1lcyA9ICJ0
b3AiLCAibWFpbiIsICJwd20xIjsNCj4gPiArCQkJYXNzaWduZWQtY2xvY2tzID0gPCZ0b3Bja2dl
biBDTEtfVE9QX1BXTV9TRUw+Ow0KPiA+ICsJCQlhc3NpZ25lZC1jbG9jay1wYXJlbnRzID0NCj4g
PiArCQkJCQk8JnRvcGNrZ2VuIENMS19UT1BfVU5JVlBMTDJfRDQ+Ow0KPiA+ICsJCQludW0tcHdt
cyA9IDwxPjsNCj4gDQo+IG51bS1wd21zIGlzIG5vdCBkZWZpbmVkLiBEaWQgeW91IG1lYW4gcHdt
LWNlbGxzPw0KPiANCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4gDQo+ID4gKwkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7DQo+ID4gKwkJfTsNCj4gPiArDQo+ID4gIAkJaTJjOiBpMmNAMTEwMDcwMDAg
ew0KPiA+ICAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyOS1pMmMiLA0KPiA+ICAJCQkJ
ICAgICAibWVkaWF0ZWssbXQyNzEyLWkyYyI7DQo+ID4gDQo+IA0KPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBMaW51eC1tZWRpYXRlayBtYWlsaW5n
IGxpc3QNCj4gTGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW1lZGlhdGVrDQoNCg0KU29y
cnkgZm9yIHRoZSBMYXRlIFJlcGx5LA0KVGhlIG51bS1wd21zIGZpZWxkIGlzIHJlZHVuZGFudCBh
ZnRlciB3ZSBkZXJpdmUgaXQgZnJvbSB0aGUgY29tcGF0aWJsZQ0Kc3RyaW5nLiBJIGZvcmdvdCB0
byByZW1vdmUgaXQgZnJvbSB0aGUgZGV2aWNlIHRyZWUuDQpJIHdpbGwgc2VuZCBhIG5ldyB2ZXJz
aW9uLg0KDQpUaGFua3MsDQpCZXN0IFJlZ2FyZHMsDQpTYW0gU2hpaA0KDQo=

