Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003FBC43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBDFB207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 01:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Bq7Fl4Oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfK0Bb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 20:31:59 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:2774 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727662AbfK0Bb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 20:31:59 -0500
X-UUID: 624387a667234246a9ecf48859cfa127-20191127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=FfLWy7hYVqt6twZ6RqO6oRqpE+bo5f378iJWtJ09HPs=;
        b=Bq7Fl4Oi+Lk1tD3cPumLCx2s10Mu4jWil28A3RTJo3pWHNRK6aRpiAyIkLsR8RogIH3PV81b/J+K1sXYDQszV4IbWbTuRajebbtueiosyRG1tkg2Gic46Iwkp/q53UENRRkapchJ+tsK+GkA7c0SvuOlR+ZBHH/WuIBtE3zTPzw=;
X-UUID: 624387a667234246a9ecf48859cfa127-20191127
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1287883452; Wed, 27 Nov 2019 09:31:47 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 27 Nov 2019 09:31:44 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 27 Nov 2019 09:30:52 +0800
Message-ID: <1574818303.15691.10.camel@mtksdaap41>
Subject: Re: [PATCH v1] drm/mediatek: fix up 1440x900 dp display black
 screen issue
From:   CK Hu <ck.hu@mediatek.com>
To:     <yongqiang.niu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "David Airlie" <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 27 Nov 2019 09:31:43 +0800
In-Reply-To: <1574750869-12611-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1574750869-12611-1-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: B6B9FEC13DEDCAA3FED78A3946FCFD3C5E46997A32C15BEB208086C51E86B01A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFlvbmdxaWFuZzoNCg0KT24gVHVlLCAyMDE5LTExLTI2IGF0IDE0OjQ3ICswODAwLCB5b25n
cWlhbmcubml1QG1lZGlhdGVrLmNvbSB3cm90ZToNCj4gRnJvbTogWW9uZ3FpYW5nIE5pdSA8eW9u
Z3FpYW5nLm5pdUBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIGZpeCB1cCAxNDQweDkw
MCBkcCBkaXNwbGF5IGJsYWNrIHNjcmVlbiBpc3N1ZQ0KPiB0aGUgY29tcHV0ZWQgcmVzdWx0IHdp
bGwgb3ZlcmZsb3cgcmRtYTEgZmlmbyBtYXggc2l6ZQ0KPiB3aGVuIGV4dGVybmFsIGRpc3BsYXkg
cGl4ZWwgY2xvY2sgYmlnZ2VyIHRoYW4gNzRNSFoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFlvbmdx
aWFuZyBOaXUgPHlvbmdxaWFuZy5uaXVAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX3JkbWEuYw0KPiBpbmRleCBjMWFiZGUzLi40MTE0M2Y1IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfcmRtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZGlzcF9yZG1hLmMNCj4gQEAgLTE1Miw2ICsxNTIsMTAgQEAgc3Rh
dGljIHZvaWQgbXRrX3JkbWFfY29uZmlnKHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2ln
bmVkIGludCB3aWR0aCwNCj4gIAkgKiBhY2NvdW50IGZvciBibGFua2luZywgYW5kIHdpdGggYSBw
aXhlbCBkZXB0aCBvZiA0IGJ5dGVzOg0KPiAgCSAqLw0KPiAgCXRocmVzaG9sZCA9IHdpZHRoICog
aGVpZ2h0ICogdnJlZnJlc2ggKiA0ICogNyAvIDEwMDAwMDA7DQo+ICsNCj4gKwlpZiAodGhyZXNo
b2xkID4gcmRtYV9maWZvX3NpemUpDQo+ICsJCXRocmVzaG9sZCA9IHJkbWFfZmlmb19zaXplOw0K
PiArDQoNClRoaXMgbG9va3MgbGlrZSB0aGF0IHRocmVzaG9sZCBpcyBvdmVyIHNwZWMuIEkgdGhp
bmsgdGhpcyBGSUZPIGlzIHVzZWQNCnRvIGNvdmVyIHRoZSBsYXRlbmN5IG9mIHJlYWRpbmcgZGF0
YSBmcm9tIERSQU0uIFdoZW4gZGF0YSBpcyByZWFkIGZyb20NCk9WTCBub3QgUkRNQSwgT1ZMIGFs
cmVhZHkgaGFzIGEgRklGTywgc28gUkRNQSBGSUZPIGlzIHVzZWxlc3MuIFNvIEkNCnRoaW5rIHlv
dSBzaG91bGQgc2V0IHRocmVzaG9sZCB0byBhIHNwZWNpYWwgdmFsdWUgd2hlbiBSRE1BIGlzIGlu
IGRpcmVjdA0KbGluayBtb2RlLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgCXJlZyA9IFJETUFfRklG
T19VTkRFUkZMT1dfRU4gfA0KPiAgCSAgICAgIFJETUFfRklGT19QU0VVRE9fU0laRShyZG1hX2Zp
Zm9fc2l6ZSkgfA0KPiAgCSAgICAgIFJETUFfT1VUUFVUX1ZBTElEX0ZJRk9fVEhSRVNIT0xEKHRo
cmVzaG9sZCk7DQoNCg==

