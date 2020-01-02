Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55786C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC0722525
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 05:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E8aniT6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgABFoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 00:44:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:61102 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725788AbgABFoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 00:44:21 -0500
X-UUID: ff7f549597e94f02bc9f66c7ec3850d8-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:Reply-To:From:Subject:Message-ID; bh=vyS7IWI4BRwbY7rXWub/fMYSKrH1gB0wk72YU/M9xPs=;
        b=E8aniT6kL8DKFgcVP6lGajjs5ANPZQTKeHZF8HDbx1MvwbvTVM+LqbmzWEUG1vLdu8Da7XyaKivHp7mF94TaFzFfeq9/6z3i1TooERNgyZCkTGagJxUhILdHS4xIuslLf/yn2i1DdnSNT8XTfOiKL8F5CoQPS7xmU4Q836u7xoU=;
X-UUID: ff7f549597e94f02bc9f66c7ec3850d8-20200102
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 790673981; Thu, 02 Jan 2020 13:44:17 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 2 Jan
 2020 13:43:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 13:44:40 +0800
Message-ID: <1577943764.15116.3.camel@mhfsdcap03>
Subject: Re: [PATCH v6, 13/14] drm/mediatek: add fifo_size into rdma private
 data
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 2 Jan 2020 13:42:44 +0800
In-Reply-To: <1577942440.24650.5.camel@mtksdaap41>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-14-git-send-email-yongqiang.niu@mediatek.com>
         <1577942440.24650.5.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTAyIGF0IDEzOjIwICswODAwLCBDSyBIdSB3cm90ZToNCj4gSGksIFlv
bmdxaWFuZzoNCj4gDQo+IE9uIFRodSwgMjAyMC0wMS0wMiBhdCAxMjowMCArMDgwMCwgWW9uZ3Fp
YW5nIE5pdSB3cm90ZToNCj4gPiB0aGUgZmlmbyBzaXplIG9mIHJkbWEgaW4gbXQ4MTgzIGlzIGRp
ZmZlcmVudC4NCj4gPiByZG1hMCBmaWZvIHNpemUgaXMgNWsNCj4gPiByZG1hMSBmaWZvIHNpemUg
aXMgMmsNCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcu
bml1QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX3JkbWEuYyB8IDIxICsrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUg
Y2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYw0KPiA+IGluZGV4IDQwNWFmZWYuLjY5
MTQ4MGIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNw
X3JkbWEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1h
LmMNCj4gPiBAQCAtNjIsNiArNjIsNyBAQCBzdHJ1Y3QgbXRrX2Rpc3BfcmRtYSB7DQo+ID4gIAlz
dHJ1Y3QgbXRrX2RkcF9jb21wCQlkZHBfY29tcDsNCj4gPiAgCXN0cnVjdCBkcm1fY3J0YwkJCSpj
cnRjOw0KPiA+ICAJY29uc3Qgc3RydWN0IG10a19kaXNwX3JkbWFfZGF0YQkqZGF0YTsNCj4gPiAr
CXUzMgkJCQlmaWZvX3NpemU7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICBzdGF0aWMgaW5saW5lIHN0
cnVjdCBtdGtfZGlzcF9yZG1hICpjb21wX3RvX3JkbWEoc3RydWN0IG10a19kZHBfY29tcCAqY29t
cCkNCj4gPiBAQCAtMTMwLDEwICsxMzEsMTYgQEAgc3RhdGljIHZvaWQgbXRrX3JkbWFfY29uZmln
KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2lnbmVkIGludCB3aWR0aCwNCj4gPiAgCXVu
c2lnbmVkIGludCB0aHJlc2hvbGQ7DQo+ID4gIAl1bnNpZ25lZCBpbnQgcmVnOw0KPiA+ICAJc3Ry
dWN0IG10a19kaXNwX3JkbWEgKnJkbWEgPSBjb21wX3RvX3JkbWEoY29tcCk7DQo+ID4gKwl1MzIg
cmRtYV9maWZvX3NpemU7DQo+ID4gIA0KPiA+ICAJcmRtYV91cGRhdGVfYml0cyhjb21wLCBESVNQ
X1JFR19SRE1BX1NJWkVfQ09OXzAsIDB4ZmZmLCB3aWR0aCk7DQo+ID4gIAlyZG1hX3VwZGF0ZV9i
aXRzKGNvbXAsIERJU1BfUkVHX1JETUFfU0laRV9DT05fMSwgMHhmZmZmZiwgaGVpZ2h0KTsNCj4g
PiAgDQo+ID4gKwlpZiAocmRtYS0+Zmlmb19zaXplKQ0KPiA+ICsJCXJkbWFfZmlmb19zaXplID0g
cmRtYS0+Zmlmb19zaXplOw0KPiA+ICsJZWxzZQ0KPiA+ICsJCXJkbWFfZmlmb19zaXplID0gUkRN
QV9GSUZPX1NJWkUocmRtYSk7DQo+ID4gKw0KPiA+ICAJLyoNCj4gPiAgCSAqIEVuYWJsZSBGSUZP
IHVuZGVyZmxvdyBzaW5jZSBEU0kgYW5kIERQSSBjYW4ndCBiZSBibG9ja2VkLg0KPiA+ICAJICog
S2VlcCB0aGUgRklGTyBwc2V1ZG8gc2l6ZSByZXNldCBkZWZhdWx0IG9mIDggS2lCLiBTZXQgdGhl
DQo+ID4gQEAgLTE0Miw3ICsxNDksNyBAQCBzdGF0aWMgdm9pZCBtdGtfcmRtYV9jb25maWcoc3Ry
dWN0IG10a19kZHBfY29tcCAqY29tcCwgdW5zaWduZWQgaW50IHdpZHRoLA0KPiA+ICAJICovDQo+
ID4gIAl0aHJlc2hvbGQgPSB3aWR0aCAqIGhlaWdodCAqIHZyZWZyZXNoICogNCAqIDcgLyAxMDAw
MDAwOw0KPiA+ICAJcmVnID0gUkRNQV9GSUZPX1VOREVSRkxPV19FTiB8DQo+ID4gLQkgICAgICBS
RE1BX0ZJRk9fUFNFVURPX1NJWkUoUkRNQV9GSUZPX1NJWkUocmRtYSkpIHwNCj4gPiArCSAgICAg
IFJETUFfRklGT19QU0VVRE9fU0laRShyZG1hX2ZpZm9fc2l6ZSkgfA0KPiA+ICAJICAgICAgUkRN
QV9PVVRQVVRfVkFMSURfRklGT19USFJFU0hPTEQodGhyZXNob2xkKTsNCj4gPiAgCXdyaXRlbChy
ZWcsIGNvbXAtPnJlZ3MgKyBESVNQX1JFR19SRE1BX0ZJRk9fQ09OKTsNCj4gPiAgfQ0KPiA+IEBA
IC0yODQsNiArMjkxLDE4IEBAIHN0YXRpYyBpbnQgbXRrX2Rpc3BfcmRtYV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJCXJldHVybiBjb21wX2lkOw0KPiA+ICAJfQ0K
PiA+ICANCj4gPiArCWlmIChvZl9maW5kX3Byb3BlcnR5KGRldi0+b2Zfbm9kZSwgIm1lZGlhdGVr
LHJkbWFfZmlmb19zaXplIiwgJnJldCkpIHsNCj4gDQo+ICJtZWRpYXRlayxyZG1hX2ZpZm9fc2l6
ZSIgZG9lcyBub3QgZXhpc3RzIGluIGJpbmRpbmcgZG9jdW1lbnQuDQo+IA0KPiA+ICsJCXJldCA9
IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9kZSwNCj4gPiArCQkJCQkgICAibWVkaWF0
ZWsscmRtYV9maWZvX3NpemUiLA0KPiA+ICsJCQkJCSAgICZwcml2LT5maWZvX3NpemUpOw0KPiA+
ICsJCWlmIChyZXQpIHsNCj4gPiArCQkJZGV2X2VycihkZXYsICJGYWlsZWQgdG8gZ2V0IHJkbWEg
ZmlmbyBzaXplXG4iKTsNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+
ICsJCXByaXYtPmZpZm9fc2l6ZSAqPSBTWl8xSzsNCj4gDQo+IFdoeSBub3QgZGVmaW5lIGZpZm9f
c2l6ZSBpbiAnYnl0ZXMnID8NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQoNCnRoaXMgaXMgYWxpZ24g
dGhlIGRlZmluaXRpb24gb2YgZmlmb19zaXplIGluIG10a19kaXNwX3JkbWFfZGF0YSwgaXQgaXMN
ClNaXzFLLCANCmFuZCB0aGUgbWFjcm8gUkRNQV9GSUZPX1BTRVVET19TSVpFIGNhbGN1bGF0ZWQg
d2l0aCBTWl8xSw0KPiANCj4gPiArCX0NCj4gPiArDQo+ID4gIAlyZXQgPSBtdGtfZGRwX2NvbXBf
aW5pdChkZXYsIGRldi0+b2Zfbm9kZSwgJnByaXYtPmRkcF9jb21wLCBjb21wX2lkLA0KPiA+ICAJ
CQkJJm10a19kaXNwX3JkbWFfZnVuY3MpOw0KPiA+ICAJaWYgKHJldCkgew0KPiANCj4gDQoNCg==

