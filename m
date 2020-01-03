Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E3BC32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D290222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 04:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="THuwtRoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgACE6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 23:58:36 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:34599 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725890AbgACE6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 23:58:35 -0500
X-UUID: 6c54cfae75dd4b99ba4a743768849a37-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=rdFrZ9Jcx8qzNQWZZwmRMxMHx3C9rWLkOXwKIpvFHjM=;
        b=THuwtRoKArpk5CFwi9K4tY1xk6K9CouAoQKYCUPz+JPvdomUfDwXjc5OzCGAMoscm5qJHZOnG45OvT4PwmK5a+uUiPGPQBgAFuT4LRCrKi34GIi2vgr7giqta/LrPk7fQC1ZraTT6rv48f4sy7+zuumr1PS6OALhFaRpAd/JC5M=;
X-UUID: 6c54cfae75dd4b99ba4a743768849a37-20200103
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 627967508; Fri, 03 Jan 2020 12:58:25 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 12:57:12 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 12:58:48 +0800
Message-ID: <1578027500.30178.0.camel@mtksdaap41>
Subject: Re: [RESEND PATCH v6 00/17] add drm support for MT8183
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
Date:   Fri, 3 Jan 2020 12:58:20 +0800
In-Reply-To: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FB3FFA3455567347BB4B802EBF6FC3E22F76B49220CCA2C99D4FD73A8E25E2142000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KVGhpcyAnUkVTRU5EIHY2JyBpcyBkaWZmZXJlbnQgd2l0aCB2Niwg
c28gSSB0aGluayB5b3Ugc2hvdWxkIGNhbGwgdGhpcw0KdjcuDQoNClJlZ2FyZHMsDQpDSw0KDQpP
biBGcmksIDIwMjAtMDEtMDMgYXQgMTE6MTIgKzA4MDAsIFlvbmdxaWFuZyBOaXUgd3JvdGU6DQo+
IFRoaXMgc2VyaWVzIGFyZSBiYXNlZCBvbiA1LjUtcmMxIGFuZCBwcm92aWQgMTcgcGF0Y2gNCj4g
dG8gc3VwcG9ydCBtZWRpYXRlayBTT0MgTVQ4MTgzDQo+IA0KPiBDaGFuZ2Ugc2luY2UgdjUNCj4g
LSBmaXggcmV2aWV3ZWQgaXNzdWUgaW4gdjUNCj4gYmFzZSBodHRwczovL3BhdGNod29yay5rZXJu
ZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTIxMzIxOQ0KPiANCj4g
Q2hhbmdlIHNpbmNlIHY0DQo+IC0gZml4IHJldmlld2VkIGlzc3VlIGluIHY0DQo+IA0KPiBDaGFu
Z2Ugc2luY2UgdjMNCj4gLSBmaXggcmV2aWV3ZWQgaXNzdWUgaW4gdjMNCj4gLSBmaXggdHlwZSBl
cnJvciBpbiB2Mw0KPiAtIGZpeCBjb25mbGljdCB3aXRoIGlvbW11IHBhdGNoDQo+IA0KPiBDaGFu
Z2Ugc2luY2UgdjINCj4gLSBmaXggcmV2aWV3ZWQgaXNzdWUgaW4gdjINCj4gLSBhZGQgbXV0ZXgg
bm9kZSBpbnRvIGR0cyBmaWxlDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiAtIGZpeCByZXZp
ZXdlZCBpc3N1ZSBpbiB2MQ0KPiAtIGFkZCBkdHMgZm9yIG10ODE4MyBkaXNwbGF5IG5vZGVzDQo+
IC0gYWRqdXN0IGRpc3BsYXkgY2xvY2sgY29udHJvbCBmbG93IGluIHBhdGNoIDIyDQo+IC0gYWRk
IHZtYXAgc3VwcG9ydCBmb3IgbWVkaWF0ZWsgZHJtIGluIHBhdGNoIDIzDQo+IC0gZml4IHBhZ2Ug
b2Zmc2V0IGlzc3VlIGZvciBtbWFwIGZ1bmN0aW9uIGluIHBhdGNoIDI0DQo+IC0gZW5hYmxlIGFs
bG93X2ZiX21vZGlmaWVycyBmb3IgbWVkaWF0ZWsgZHJtIGluIHBhdGNoIDI1DQo+IA0KPiBZb25n
cWlhbmcgTml1ICgxNyk6DQo+ICAgZHQtYmluZGluZ3M6IG1lZGlhdGVrOiBhZGQgcmRtYV9maWZv
X3NpemUgZGVzY3JpcHRpb24gZm9yIG10ODE4Mw0KPiAgICAgZGlzcGxheQ0KPiAgIGFybTY0OiBk
dHM6IGFkZCBkaXNwbGF5IG5vZGVzIGZvciBtdDgxODMNCj4gICBkcm0vbWVkaWF0ZWs6IG1vdmUg
ZHNpL2RwaSBzZWxlY3QgaW5wdXQgaW50byBtdGtfZGRwX3NlbF9pbg0KPiAgIGRybS9tZWRpYXRl
azogbWFrZSBzb3V0IHNlbGVjdCBmdW5jdGlvbiBmb3JtYXQgc2FtZSB3aXRoIHNlbGVjdCBpbnB1
dA0KPiAgIGRybS9tZWRpYXRlazogYWRkIG1tc3lzIHByaXZhdGUgZGF0YSBmb3IgZGRwIHBhdGgg
Y29uZmlnDQo+ICAgZHJtL21lZGlhdGVrOiBhZGQgcHJpdmF0ZSBkYXRhIGZvciByZG1hMSB0byBk
cGkwIGNvbm5lY3Rpb24NCj4gICBkcm0vbWVkaWF0ZWs6IGFkZCBwcml2YXRlIGRhdGEgZm9yIHJk
bWExIHRvIGRzaTAgY29ubmVjdGlvbg0KPiAgIGRybS9tZWRpYXRlazogbW92ZSByZG1hIHNvdXQg
ZnJvbSBtdGtfZGRwX21vdXRfZW4gaW50bw0KPiAgICAgbXRrX2RkcF9zb3V0X3NlbA0KPiAgIGRy
bS9tZWRpYXRlazogYWRkIGNvbm5lY3Rpb24gZnJvbSBPVkwwIHRvIE9WTF8yTDANCj4gICBkcm0v
bWVkaWF0ZWs6IGFkZCBjb25uZWN0aW9uIGZyb20gUkRNQTAgdG8gQ09MT1IwDQo+ICAgZHJtL21l
ZGlhdGVrOiBhZGQgY29ubmVjdGlvbiBmcm9tIFJETUExIHRvIERTSTANCj4gICBkcm0vbWVkaWF0
ZWs6IGFkZCBjb25uZWN0aW9uIGZyb20gT1ZMXzJMMCB0byBSRE1BMA0KPiAgIGRybS9tZWRpYXRl
azogYWRkIGNvbm5lY3Rpb24gZnJvbSBPVkxfMkwxIHRvIFJETUExDQo+ICAgZHJtL21lZGlhdGVr
OiBhZGQgY29ubmVjdGlvbiBmcm9tIERJVEhFUjAgdG8gRFNJMA0KPiAgIGRybS9tZWRpYXRlazog
YWRkIGNvbm5lY3Rpb24gZnJvbSBSRE1BMCB0byBEU0kwDQo+ICAgZHJtL21lZGlhdGVrOiBhZGQg
Zmlmb19zaXplIGludG8gcmRtYSBwcml2YXRlIGRhdGENCj4gICBkcm0vbWVkaWF0ZWs6IGFkZCBz
dXBwb3J0IGZvciBtZWRpYXRlayBTT0MgTVQ4MTgzDQo+IA0KPiAgLi4uL2JpbmRpbmdzL2Rpc3Bs
YXkvbWVkaWF0ZWsvbWVkaWF0ZWssZGlzcC50eHQgICAgfCAgMTMgKw0KPiAgYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSAgICAgICAgICAgfCAgOTggKysrKysrKw0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jICAgICAgICAgICAgfCAgMTgg
KysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgICAgICAgICAg
IHwgIDI1ICstDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMgICAg
ICAgICAgICB8ICAgNCArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHAu
YyAgICAgICAgICAgICB8IDI4OCArKysrKysrKysrKysrKysrLS0tLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcC5oICAgICAgICAgICAgIHwgICA3ICsNCj4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5jICAgICAgICAgICAgIHwgIDQ5ICsrKysN
Cj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Rydi5oICAgICAgICAgICAgIHwg
ICAzICsNCj4gIDkgZmlsZXMgY2hhbmdlZCwgNDM1IGluc2VydGlvbnMoKyksIDcwIGRlbGV0aW9u
cygtKQ0KPiANCg0K

