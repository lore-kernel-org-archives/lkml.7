Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C2FC32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D048821775
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 06:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Hbr1iiIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgAFGri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 01:47:38 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:57766 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726294AbgAFGri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 01:47:38 -0500
X-UUID: 3c523dba18a54c0bb9c23614c8d4a172-20200106
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=aYAZgI6ryqNleIeTmQWVE96vhfch+9yXx43Fz3GXDe0=;
        b=Hbr1iiIwM5x+W94EmR46cxymgPfb+HIHweivpVQEJJZCEcrIrBzE+73oyEyn56Qh/CkstUDm8rnDdScizia4Z69tQOZxnI5xBM7ATIZFQrFs7mFrpjbWsWCJ8tSzTXRX6zeUnsTr3GcBEAeRqKEhi+3I3aJqGwilpPKk1jDl8LE=;
X-UUID: 3c523dba18a54c0bb9c23614c8d4a172-20200106
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 506341859; Mon, 06 Jan 2020 14:47:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 6 Jan
 2020 14:47:41 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 6 Jan 2020 14:46:02 +0800
Message-ID: <1578293251.3044.1.camel@mtksdaap41>
Subject: Re: [PATCH] drm/mediatek: fix indentation
From:   CK Hu <ck.hu@mediatek.com>
To:     Fabien Parent <fparent@baylibre.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>
Date:   Mon, 6 Jan 2020 14:47:31 +0800
In-Reply-To: <20200103142445.55036-1-fparent@baylibre.com>
References: <20200103142445.55036-1-fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEZhYmllbjoNCg0KT24gRnJpLCAyMDIwLTAxLTAzIGF0IDE1OjI0ICswMTAwLCBGYWJpZW4g
UGFyZW50IHdyb3RlOg0KPiBGaXggaW5kZW50YXRpb24gaW4gdGhlIE1ha2VmaWxlIGJ5IHJlcGxh
Y2luZyBzcGFjZXMgd2l0aCB0YWJzLg0KPiANCg0KQXBwbGllZCB0byBtZWRpYXRlay1kcm0tbmV4
dC01LjYgWzFdLCB0aGFua3MuDQoNClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0
ZWsvbGludXguZ2l0LXRhZ3MvY29tbWl0cy9tZWRpYXRlay1kcm0tbmV4dC01LjYNCg0KUmVnYXJk
cywNCmNLDQoNCj4gU2lnbmVkLW9mZi1ieTogRmFiaWVuIFBhcmVudCA8ZnBhcmVudEBiYXlsaWJy
ZS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlIHwgMiAr
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlDQo+IGluZGV4IDgwNjdhNGJlODMxMS4uYjJiNTIz
OTEzMTY0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUN
Cj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL01ha2VmaWxlDQo+IEBAIC0yMSw3ICsy
MSw3IEBAIG9iai0kKENPTkZJR19EUk1fTUVESUFURUspICs9IG1lZGlhdGVrLWRybS5vDQo+ICBt
ZWRpYXRlay1kcm0taGRtaS1vYmpzIDo9IG10a19jZWMubyBcDQo+ICAJCQkgIG10a19oZG1pLm8g
XA0KPiAgCQkJICBtdGtfaGRtaV9kZGMubyBcDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
IG10a19tdDI3MDFfaGRtaV9waHkubyBcDQo+ICsJCQkgIG10a19tdDI3MDFfaGRtaV9waHkubyBc
DQo+ICAJCQkgIG10a19tdDgxNzNfaGRtaV9waHkubyBcDQo+ICAJCQkgIG10a19oZG1pX3BoeS5v
DQo+ICANCg0K

