Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94475C17442
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641EB222BD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 03:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tBIcmgqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKMDSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 22:18:40 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:36218 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727097AbfKMDSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 22:18:40 -0500
X-UUID: 3dfcd6c630954fea86af6c6faea02cb8-20191113
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=1PTVv09MJjB2RKE9rgKvj5d7tEfBX8IFX331P3cJgFc=;
        b=tBIcmgqJaEc0Gy26g3KLy0gQtohKXEKRom3/g+Edm/Ie2VO3BLK2COJ9RlKUSFsqweK4K62avpFgM65cOd0OcfpKib4KHzGpCJFiRIySqssgyfIsxz62ZfmtmrjWWqA1mI4+CW4C+EBQsfqDt45Lz7FDtXggpJ5pBMlUC9dUA8Q=;
X-UUID: 3dfcd6c630954fea86af6c6faea02cb8-20191113
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 331661075; Wed, 13 Nov 2019 11:18:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 13 Nov
 2019 11:18:21 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 13 Nov 2019 11:18:21 +0800
Message-ID: <1573615102.7173.9.camel@mhfsdcap03>
Subject: Re: [PATCH v4 11/11] arm64: dts: mt2712: use non-empty ranges for
 usb-phy
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Date:   Wed, 13 Nov 2019 11:18:22 +0800
In-Reply-To: <c23531cd-432d-1857-1e99-48d87956338e@gmail.com>
References: <1573547796-29566-1-git-send-email-chunfeng.yun@mediatek.com>
         <1573547796-29566-11-git-send-email-chunfeng.yun@mediatek.com>
         <c23531cd-432d-1857-1e99-48d87956338e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4A04EC74D93A3F15A39E1C1ED84053571B8EBB86F8A73CC07646E046490CADBC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDE5LTExLTEyIGF0IDE0OjEyICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMTIvMTEvMjAxOSAwOTozNiwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+IFVz
ZSBub24tZW1wdHkgcmFuZ2VzIGZvciB1c2ItcGh5IHRvIG1ha2UgdGhlIGxheW91dCBvZg0KPiA+
IGl0cyByZWdpc3RlcnMgY2xlYXJlcjsNCj4gPiBSZXBsYWNlIGRlcHJlY2F0ZWQgY29tcGF0aWJs
ZSBieSBnZW5lcmljDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVuIDxjaHVu
ZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+IHYzfnY0OiBubyBjaGFuZ2VzDQo+
ID4gDQo+ID4gdjI6IHVzZSBnZW5lcmljIGNvbXBhdGlibGUNCj4gPiAtLS0NCj4gPiAgYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDI3MTJlLmR0c2kgfCA0MiArKysrKysrKysrKystLS0t
LS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRp
b25zKC0pDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQyNzEyZS5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDI3MTJlLmR0
c2kNCj4gPiBpbmRleCA0MzMwN2JhZDNmMGQuLmUyNGYyZjJmNjAwNCAxMDA2NDQNCj4gPiAtLS0g
YS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210MjcxMmUuZHRzaQ0KPiA+ICsrKyBiL2Fy
Y2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQyNzEyZS5kdHNpDQo+ID4gQEAgLTY5NywzMCAr
Njk3LDMxIEBADQo+ID4gIAl9Ow0KPiA+ICANCj4gPiAgCXUzcGh5MDogdXNiLXBoeUAxMTI5MDAw
MCB7DQo+ID4gLQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3MTItdTNwaHkiOw0KPiA+IC0J
CSNhZGRyZXNzLWNlbGxzID0gPDI+Ow0KPiA+IC0JCSNzaXplLWNlbGxzID0gPDI+Ow0KPiA+IC0J
CXJhbmdlczsNCj4gPiArCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi10cGh5IiwNCj4g
PiArCQkJICAgICAibWVkaWF0ZWssZ2VuZXJpYy10cGh5LXYyIjsNCj4gPiArCQkjYWRkcmVzcy1j
ZWxscyA9IDwxPjsNCj4gPiArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4gDQo+IEF0IGEgZmlyc3Qg
Z2xhbmNlIEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgeW91IGNoYW5nZSBhZGRyZXNzIGFuZCBzaXpl
IGNlbGxzLg0KPiBDb21taXQgbWVzc2FnZSBkb2Vzbid0IGV4cGxhaW4gaXQgYW5kIEFGQUlTIGl0
J3Mgbm90IHBhcnQgb2YgdGhlIGJpbmRpbmcgY2hhbmdlcy4NCldoZW4gUnlkZXIgc2VudCBEVFMg
cGF0Y2ggZm9yIG10NzYyOSwgUm9iIHN1Z2dlc3RlZCB0byB1c2UgMSBjZWxsLA0Kbm9uLWVtcHR5
IHJhbmdlcyBhbmQgcHJvdmlkZSB0aGUgb2Zmc2V0IGZvciB2MiB0cGh5IHdoaWNoIGhhc24ndCBz
aGFyZWQNCnJlZ2lzdGVycyBiZXR3ZWVuIHN1Yi1waHlzLCBpdCdsbCBtYWtlIGxheW91dCBtb3Jl
IGNsZWFyLg0KDQpTZWU6IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcGF0Y2gvMTA4NTA5
MjUvDQoNCg0KPiANCj4gQ2FuIHlvdSBleHBsYWluIHdoeSB3ZSBuZWVkIHRoYXQsIGFuZCB1cGRh
dGUgdGhlIGNvbW1pdCBtZXNzYWdlIGFjY29yZGluZ2x5Pw0KDQpKdXN0IHdhbnQgdG8gdGFrZSBp
dCBhcyBhbiBleGFtcGxlIHdoZW4gc3VwcG9ydCBvdGhlciBwbGF0Zm9ybXMuDQoNCj4gDQo+IFJl
Z3JhZHMsDQo+IE1hdHRoaWFzDQo+IA0KPiA+ICsJCXJhbmdlcyA9IDwwIDAgMHgxMTI5MDAwMCAw
eDkwMDA+Ow0KPiA+ICAJCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgDQo+ID4gLQkJdTJwb3J0MDog
dXNiLXBoeUAxMTI5MDAwMCB7DQo+ID4gLQkJCXJlZyA9IDwwIDB4MTEyOTAwMDAgMCAweDcwMD47
DQo+ID4gKwkJdTJwb3J0MDogdXNiLXBoeUAwIHsNCj4gPiArCQkJcmVnID0gPDB4MCAweDcwMD47
DQo+ID4gIAkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4gPiAgCQkJY2xvY2stbmFtZXMgPSAicmVm
IjsNCj4gPiAgCQkJI3BoeS1jZWxscyA9IDwxPjsNCj4gPiAgCQkJc3RhdHVzID0gIm9rYXkiOw0K
PiA+ICAJCX07DQo+ID4gIA0KPiA+IC0JCXUycG9ydDE6IHVzYi1waHlAMTEyOTgwMDAgew0KPiA+
IC0JCQlyZWcgPSA8MCAweDExMjk4MDAwIDAgMHg3MDA+Ow0KPiA+ICsJCXUycG9ydDE6IHVzYi1w
aHlAODAwMCB7DQo+ID4gKwkJCXJlZyA9IDwweDgwMDAgMHg3MDA+Ow0KPiA+ICAJCQljbG9ja3Mg
PSA8JmNsazI2bT47DQo+ID4gIAkJCWNsb2NrLW5hbWVzID0gInJlZiI7DQo+ID4gIAkJCSNwaHkt
Y2VsbHMgPSA8MT47DQo+ID4gIAkJCXN0YXR1cyA9ICJva2F5IjsNCj4gPiAgCQl9Ow0KPiA+ICAN
Cj4gPiAtCQl1M3BvcnQwOiB1c2ItcGh5QDExMjk4NzAwIHsNCj4gPiAtCQkJcmVnID0gPDAgMHgx
MTI5ODcwMCAwIDB4OTAwPjsNCj4gPiArCQl1M3BvcnQwOiB1c2ItcGh5QDg3MDAgew0KPiA+ICsJ
CQlyZWcgPSA8MHg4NzAwIDB4OTAwPjsNCj4gPiAgCQkJY2xvY2tzID0gPCZjbGsyNm0+Ow0KPiA+
ICAJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiA+ICAJCQkjcGh5LWNlbGxzID0gPDE+Ow0KPiA+
IEBAIC03NjAsMzAgKzc2MSwzMSBAQA0KPiA+ICAJfTsNCj4gPiAgDQo+ID4gIAl1M3BoeTE6IHVz
Yi1waHlAMTEyZTAwMDAgew0KPiA+IC0JCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQyNzEyLXUz
cGh5IjsNCj4gPiAtCQkjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiAtCQkjc2l6ZS1jZWxscyA9
IDwyPjsNCj4gPiAtCQlyYW5nZXM7DQo+ID4gKwkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDI3
MTItdHBoeSIsDQo+ID4gKwkJCSAgICAgIm1lZGlhdGVrLGdlbmVyaWMtdHBoeS12MiI7DQo+ID4g
KwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKwkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4g
KwkJcmFuZ2VzID0gPDAgMCAweDExMmUwMDAwIDB4OTAwMD47DQo+ID4gIAkJc3RhdHVzID0gIm9r
YXkiOw0KPiA+ICANCj4gPiAtCQl1MnBvcnQyOiB1c2ItcGh5QDExMmUwMDAwIHsNCj4gPiAtCQkJ
cmVnID0gPDAgMHgxMTJlMDAwMCAwIDB4NzAwPjsNCj4gPiArCQl1MnBvcnQyOiB1c2ItcGh5QDAg
ew0KPiA+ICsJCQlyZWcgPSA8MHgwIDB4NzAwPjsNCj4gPiAgCQkJY2xvY2tzID0gPCZjbGsyNm0+
Ow0KPiA+ICAJCQljbG9jay1uYW1lcyA9ICJyZWYiOw0KPiA+ICAJCQkjcGh5LWNlbGxzID0gPDE+
Ow0KPiA+ICAJCQlzdGF0dXMgPSAib2theSI7DQo+ID4gIAkJfTsNCj4gPiAgDQo+ID4gLQkJdTJw
b3J0MzogdXNiLXBoeUAxMTJlODAwMCB7DQo+ID4gLQkJCXJlZyA9IDwwIDB4MTEyZTgwMDAgMCAw
eDcwMD47DQo+ID4gKwkJdTJwb3J0MzogdXNiLXBoeUA4MDAwIHsNCj4gPiArCQkJcmVnID0gPDB4
ODAwMCAweDcwMD47DQo+ID4gIAkJCWNsb2NrcyA9IDwmY2xrMjZtPjsNCj4gPiAgCQkJY2xvY2st
bmFtZXMgPSAicmVmIjsNCj4gPiAgCQkJI3BoeS1jZWxscyA9IDwxPjsNCj4gPiAgCQkJc3RhdHVz
ID0gIm9rYXkiOw0KPiA+ICAJCX07DQo+ID4gIA0KPiA+IC0JCXUzcG9ydDE6IHVzYi1waHlAMTEy
ZTg3MDAgew0KPiA+IC0JCQlyZWcgPSA8MCAweDExMmU4NzAwIDAgMHg5MDA+Ow0KPiA+ICsJCXUz
cG9ydDE6IHVzYi1waHlAODcwMCB7DQo+ID4gKwkJCXJlZyA9IDwweDg3MDAgMHg5MDA+Ow0KPiA+
ICAJCQljbG9ja3MgPSA8JmNsazI2bT47DQo+ID4gIAkJCWNsb2NrLW5hbWVzID0gInJlZiI7DQo+
ID4gIAkJCSNwaHktY2VsbHMgPSA8MT47DQo+ID4gDQoNCg==

