Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DF9C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62CD62077B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 01:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="E3Dz5oIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbfLFB5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 20:57:15 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:14615 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725959AbfLFB5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 20:57:14 -0500
X-UUID: d0df83131e124e1a8bb66abd19c8cad5-20191206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Wi+5R0BXr2YmOXq7DcGeu+ejHYe1KpCMZpa0/9X6xfw=;
        b=E3Dz5oIG8EXHkfoSqa9g8Hs73xTJOfPTZpjNNEGWUQv6pK1ah1qEXr/l+lQTzUbCqTwfwtlF6BlhTJO5EVorF2lQmmHsjlW0EmyHx55XNaKlygl5TYWI9yJ9KpGJatjSyJnIYHqXQ49NtsQR9HPsiFMixzlrth+c0PAun0hzwE8=;
X-UUID: d0df83131e124e1a8bb66abd19c8cad5-20191206
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 271710576; Fri, 06 Dec 2019 09:57:08 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 6 Dec 2019 09:56:54 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 6 Dec 2019 09:56:53 +0800
Message-ID: <1575597427.6328.3.camel@mtksdaap41>
Subject: Re: [PATCH v4 4/7] drm/mediatek: disable all the planes in
 atomic_disable
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>, <tfiga@chromium.org>,
        <drinkcat@chromium.org>, <linux-kernel@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
Date:   Fri, 6 Dec 2019 09:57:07 +0800
In-Reply-To: <20191205092749.4021-5-bibby.hsieh@mediatek.com>
References: <20191205092749.4021-1-bibby.hsieh@mediatek.com>
         <20191205092749.4021-5-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTA1IGF0IDE3OjI3ICswODAwLCBCaWJieSBIc2llaCB3cm90ZToNCj4g
VW5kZXIgc2hhZG93IHJlZ2lzdGVyIGNhc2UsIHdlIGRvIG5vdCBkaXNhYmxlIGFsbCB0aGUgcGxh
bmUgYmVmb3JlDQo+IGRpc2FibGUgYWxsIHRoZSBoYXJkd2FyZXMuIEZpeCBpdC4NCg0KRXhjZXB0
IHRoZSAnRml4ZXMnIHRhZywgSSBjb3VsZCBhZGQgaXQsDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8
Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaWJieSBIc2llaCA8
YmliYnkuaHNpZWhAbWVkaWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHJtX2NydGMuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
Y3J0Yy5jIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IGluZGV4
IGU4ODdhNjg3N2JjZC4uZTQwYzhjZjdkNzRmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC01NTAsNiArNTUwLDcgQEAgc3RhdGljIHZvaWQgbXRr
X2RybV9jcnRjX2F0b21pY19kaXNhYmxlKHN0cnVjdCBkcm1fY3J0YyAqY3J0YywNCj4gIAl9DQo+
ICAJbXRrX2NydGMtPnBlbmRpbmdfcGxhbmVzID0gdHJ1ZTsNCj4gIA0KPiArCW10a19kcm1fY3J0
Y19od19jb25maWcobXRrX2NydGMpOw0KPiAgCS8qIFdhaXQgZm9yIHBsYW5lcyB0byBiZSBkaXNh
YmxlZCAqLw0KPiAgCWRybV9jcnRjX3dhaXRfb25lX3ZibGFuayhjcnRjKTsNCj4gIA0KDQo=

