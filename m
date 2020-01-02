Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A618C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3672F215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ptTe+t9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgABHcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:32:09 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:7233 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726078AbgABHcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:32:08 -0500
X-UUID: 61fee457429949338280c00d953cb770-20200102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=PCH3d6ww20Xcb8eTPquPc5VeMWFXLY/lz4kI3WEDJSA=;
        b=ptTe+t9wX5cT1eWh3tiaue7/s4w9FkX1JQb8KxZBigS6kJse9P2T4KR3L0eHGs5VUFHm/YaEfqd6GLqgDhgtbM+3zw1iCR7M/krCX5FSpcEpIqZzHgtKZKK/TnuGrDD+AZnbY6zSt42qEiYp5dIbckAD5WUpKeu2ODPR56bxrd4=;
X-UUID: 61fee457429949338280c00d953cb770-20200102
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1369051708; Thu, 02 Jan 2020 15:32:00 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 2 Jan 2020 15:30:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 2 Jan 2020 15:32:24 +0800
Message-ID: <1577950317.12633.3.camel@mtksdaap41>
Subject: Re: [PATCH v6, 13/14] drm/mediatek: add fifo_size into rdma private
 data
From:   CK Hu <ck.hu@mediatek.com>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Thu, 2 Jan 2020 15:31:57 +0800
In-Reply-To: <1577943764.15116.3.camel@mhfsdcap03>
References: <1577937624-14313-1-git-send-email-yongqiang.niu@mediatek.com>
         <1577937624-14313-14-git-send-email-yongqiang.niu@mediatek.com>
         <1577942440.24650.5.camel@mtksdaap41> <1577943764.15116.3.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 235C97CA29A4272D17AFBE5A53C10D0B4DF8A318DC6B8E23D5887A814BBD57882000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVGh1LCAyMDIwLTAxLTAyIGF0IDEzOjQyICswODAwLCBZb25n
cWlhbmcgTml1IHdyb3RlOg0KPiBPbiBUaHUsIDIwMjAtMDEtMDIgYXQgMTM6MjAgKzA4MDAsIENL
IEh1IHdyb3RlOg0KPiA+IEhpLCBZb25ncWlhbmc6DQo+ID4gDQo+ID4gT24gVGh1LCAyMDIwLTAx
LTAyIGF0IDEyOjAwICswODAwLCBZb25ncWlhbmcgTml1IHdyb3RlOg0KPiA+ID4gdGhlIGZpZm8g
c2l6ZSBvZiByZG1hIGluIG10ODE4MyBpcyBkaWZmZXJlbnQuDQo+ID4gPiByZG1hMCBmaWZvIHNp
emUgaXMgNWsNCj4gPiA+IHJkbWExIGZpZm8gc2l6ZSBpcyAyaw0KPiA+ID4gDQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBZb25ncWlhbmcgTml1IDx5b25ncWlhbmcubml1QG1lZGlhdGVrLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMg
fCAyMSArKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX3JkbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCj4gPiA+IGluZGV4IDQwNWFmZWYuLjY5MTQ4MGIgMTAw
NjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5j
DQo+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQo+
ID4gPiBAQCAtNjIsNiArNjIsNyBAQCBzdHJ1Y3QgbXRrX2Rpc3BfcmRtYSB7DQo+ID4gPiAgCXN0
cnVjdCBtdGtfZGRwX2NvbXAJCWRkcF9jb21wOw0KPiA+ID4gIAlzdHJ1Y3QgZHJtX2NydGMJCQkq
Y3J0YzsNCj4gPiA+ICAJY29uc3Qgc3RydWN0IG10a19kaXNwX3JkbWFfZGF0YQkqZGF0YTsNCj4g
PiA+ICsJdTMyCQkJCWZpZm9fc2l6ZTsNCj4gPiA+ICB9Ow0KPiA+ID4gIA0KPiA+ID4gIHN0YXRp
YyBpbmxpbmUgc3RydWN0IG10a19kaXNwX3JkbWEgKmNvbXBfdG9fcmRtYShzdHJ1Y3QgbXRrX2Rk
cF9jb21wICpjb21wKQ0KPiA+ID4gQEAgLTEzMCwxMCArMTMxLDE2IEBAIHN0YXRpYyB2b2lkIG10
a19yZG1hX2NvbmZpZyhzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCB1bnNpZ25lZCBpbnQgd2lk
dGgsDQo+ID4gPiAgCXVuc2lnbmVkIGludCB0aHJlc2hvbGQ7DQo+ID4gPiAgCXVuc2lnbmVkIGlu
dCByZWc7DQo+ID4gPiAgCXN0cnVjdCBtdGtfZGlzcF9yZG1hICpyZG1hID0gY29tcF90b19yZG1h
KGNvbXApOw0KPiA+ID4gKwl1MzIgcmRtYV9maWZvX3NpemU7DQo+ID4gPiAgDQo+ID4gPiAgCXJk
bWFfdXBkYXRlX2JpdHMoY29tcCwgRElTUF9SRUdfUkRNQV9TSVpFX0NPTl8wLCAweGZmZiwgd2lk
dGgpOw0KPiA+ID4gIAlyZG1hX3VwZGF0ZV9iaXRzKGNvbXAsIERJU1BfUkVHX1JETUFfU0laRV9D
T05fMSwgMHhmZmZmZiwgaGVpZ2h0KTsNCj4gPiA+ICANCj4gPiA+ICsJaWYgKHJkbWEtPmZpZm9f
c2l6ZSkNCj4gPiA+ICsJCXJkbWFfZmlmb19zaXplID0gcmRtYS0+Zmlmb19zaXplOw0KPiA+ID4g
KwllbHNlDQo+ID4gPiArCQlyZG1hX2ZpZm9fc2l6ZSA9IFJETUFfRklGT19TSVpFKHJkbWEpOw0K
PiA+ID4gKw0KPiA+ID4gIAkvKg0KPiA+ID4gIAkgKiBFbmFibGUgRklGTyB1bmRlcmZsb3cgc2lu
Y2UgRFNJIGFuZCBEUEkgY2FuJ3QgYmUgYmxvY2tlZC4NCj4gPiA+ICAJICogS2VlcCB0aGUgRklG
TyBwc2V1ZG8gc2l6ZSByZXNldCBkZWZhdWx0IG9mIDggS2lCLiBTZXQgdGhlDQo+ID4gPiBAQCAt
MTQyLDcgKzE0OSw3IEBAIHN0YXRpYyB2b2lkIG10a19yZG1hX2NvbmZpZyhzdHJ1Y3QgbXRrX2Rk
cF9jb21wICpjb21wLCB1bnNpZ25lZCBpbnQgd2lkdGgsDQo+ID4gPiAgCSAqLw0KPiA+ID4gIAl0
aHJlc2hvbGQgPSB3aWR0aCAqIGhlaWdodCAqIHZyZWZyZXNoICogNCAqIDcgLyAxMDAwMDAwOw0K
PiA+ID4gIAlyZWcgPSBSRE1BX0ZJRk9fVU5ERVJGTE9XX0VOIHwNCj4gPiA+IC0JICAgICAgUkRN
QV9GSUZPX1BTRVVET19TSVpFKFJETUFfRklGT19TSVpFKHJkbWEpKSB8DQo+ID4gPiArCSAgICAg
IFJETUFfRklGT19QU0VVRE9fU0laRShyZG1hX2ZpZm9fc2l6ZSkgfA0KPiA+ID4gIAkgICAgICBS
RE1BX09VVFBVVF9WQUxJRF9GSUZPX1RIUkVTSE9MRCh0aHJlc2hvbGQpOw0KPiA+ID4gIAl3cml0
ZWwocmVnLCBjb21wLT5yZWdzICsgRElTUF9SRUdfUkRNQV9GSUZPX0NPTik7DQo+ID4gPiAgfQ0K
PiA+ID4gQEAgLTI4NCw2ICsyOTEsMTggQEAgc3RhdGljIGludCBtdGtfZGlzcF9yZG1hX3Byb2Jl
KHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiAgCQlyZXR1cm4gY29tcF9pZDsN
Cj4gPiA+ICAJfQ0KPiA+ID4gIA0KPiA+ID4gKwlpZiAob2ZfZmluZF9wcm9wZXJ0eShkZXYtPm9m
X25vZGUsICJtZWRpYXRlayxyZG1hX2ZpZm9fc2l6ZSIsICZyZXQpKSB7DQo+ID4gDQo+ID4gIm1l
ZGlhdGVrLHJkbWFfZmlmb19zaXplIiBkb2VzIG5vdCBleGlzdHMgaW4gYmluZGluZyBkb2N1bWVu
dC4NCj4gPiANCj4gPiA+ICsJCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKGRldi0+b2Zfbm9k
ZSwNCj4gPiA+ICsJCQkJCSAgICJtZWRpYXRlayxyZG1hX2ZpZm9fc2l6ZSIsDQo+ID4gPiArCQkJ
CQkgICAmcHJpdi0+Zmlmb19zaXplKTsNCj4gPiA+ICsJCWlmIChyZXQpIHsNCj4gPiA+ICsJCQlk
ZXZfZXJyKGRldiwgIkZhaWxlZCB0byBnZXQgcmRtYSBmaWZvIHNpemVcbiIpOw0KPiA+ID4gKwkJ
CXJldHVybiByZXQ7DQo+ID4gPiArCQl9DQo+ID4gPiArDQo+ID4gPiArCQlwcml2LT5maWZvX3Np
emUgKj0gU1pfMUs7DQo+ID4gDQo+ID4gV2h5IG5vdCBkZWZpbmUgZmlmb19zaXplIGluICdieXRl
cycgPw0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gDQo+IHRoaXMgaXMgYWxpZ24gdGhl
IGRlZmluaXRpb24gb2YgZmlmb19zaXplIGluIG10a19kaXNwX3JkbWFfZGF0YSwgaXQgaXMNCj4g
U1pfMUssIA0KPiBhbmQgdGhlIG1hY3JvIFJETUFfRklGT19QU0VVRE9fU0laRSBjYWxjdWxhdGVk
IHdpdGggU1pfMUsNCg0KSSBtZWFuIHdoeSBub3Qgc2V0IHRoZSBmaWZvIHNpemUgaW4gYnl0ZXMg
aW4gZGV2aWNlIHRyZWUuIFNvIHlvdSBuZWVkDQpub3QgdG8gZG8gJyo9IFNaXzFLJyBoZXJlLiBJ
IHRoaW5rIHVuaXQgb2YgZmlmbyBzaXplIGluIGtlcm5lbCBpcyBieXRlLg0KDQpSZWdhcmRzLA0K
Q0sNCg0KPiA+IA0KPiA+ID4gKwl9DQo+ID4gPiArDQo+ID4gPiAgCXJldCA9IG10a19kZHBfY29t
cF9pbml0KGRldiwgZGV2LT5vZl9ub2RlLCAmcHJpdi0+ZGRwX2NvbXAsIGNvbXBfaWQsDQo+ID4g
PiAgCQkJCSZtdGtfZGlzcF9yZG1hX2Z1bmNzKTsNCj4gPiA+ICAJaWYgKHJldCkgew0KPiA+IA0K
PiA+IA0KPiANCj4gDQoNCg==

