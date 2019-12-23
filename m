Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD500C2D0D4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92B3B206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 08:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="c1jKL4cT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbfLWI7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 03:59:46 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:61003 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725947AbfLWI7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 03:59:46 -0500
X-UUID: fdbe423be5424ef0b7b0a6fa0cef7895-20191223
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=GIxkr6Z3J7HgwOFSpLaPB2mv26seiJrHqASnjdQ/WuM=;
        b=c1jKL4cTWnGtOxIq36oOVI39ctbinDcNdvG/SnInr75JnU8Xvp9tSrrTEwttbrLIW36IXiT07fliI3/ncn99PJdV0Xva0MAe6szb/mHs1GC4NpxlN3WSmlZRIKirhNuuv3w//vtn23sem0lkDfj3FXFCF3Jr0RXfRdyTlx22ThE=;
X-UUID: fdbe423be5424ef0b7b0a6fa0cef7895-20191223
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 103425353; Mon, 23 Dec 2019 16:59:37 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Dec 2019 16:59:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Dec 2019 16:59:48 +0800
Message-ID: <1577091576.20525.4.camel@mtksdaap41>
Subject: Re: [PATCH v5 6/7] drm/mediatek: support CMDQ interface in ddp
 component
From:   CK Hu <ck.hu@mediatek.com>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
CC:     Bibby Hsieh <bibby.hsieh@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "Tomasz Figa" <tfiga@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 23 Dec 2019 16:59:36 +0800
In-Reply-To: <CAJMQK-jdMwoC54XpWj-XYW_yZkM=TcGcJpy94DTdYBN2t1wqmw@mail.gmail.com>
References: <20191210050526.4437-1-bibby.hsieh@mediatek.com>
         <20191210050526.4437-7-bibby.hsieh@mediatek.com>
         <CAJMQK-jdMwoC54XpWj-XYW_yZkM=TcGcJpy94DTdYBN2t1wqmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEhzaW4teWk6DQoNCk9uIEZyaSwgMjAxOS0xMi0yMCBhdCAyMToyNyArMDgwMCwgSHNpbi1Z
aSBXYW5nIHdyb3RlOg0KPiBPbiBUdWUsIERlYyAxMCwgMjAxOSBhdCA1OjA1IEFNIEJpYmJ5IEhz
aWVoIDxiaWJieS5oc2llaEBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiANCj4gPg0KPiA+ICt2b2lk
IG10a19kZHBfd3JpdGUoc3RydWN0IGNtZHFfcGt0ICpjbWRxX3BrdCwgdW5zaWduZWQgaW50IHZh
bHVlLA0KPiA+ICsgICAgICAgICAgICAgICAgICBzdHJ1Y3QgbXRrX2RkcF9jb21wICpjb21wLCB1
bnNpZ25lZCBpbnQgb2Zmc2V0KQ0KPiA+ICt7DQo+ID4gKyNpZiBJU19FTkFCTEVEKENPTkZJR19N
VEtfQ01EUSkNCj4gU2hvdWxkIHdlIHVzZSAjaWZkZWYgbGlrZSBpbiB2ND8gaHR0cHM6Ly9wYXRj
aHdvcmsua2VybmVsLm9yZy9wYXRjaC8xMTI3NDQzOS8NCj4gDQo+IFdlIGdvdCB3YXJuaW5ncyB3
aGlsZSBjb21waWxpbmcga2VybmVscyBpZiBDT05GSUdfTVRLX0NNRFEgaXMgbm90IHNldCwNCj4g
c2luY2UgY21kcV9wa3Rfd3JpdGUoKSB3b3VsZCBzdGlsbCBiZSBjb21waWxlZC4NCj4gU2ltaWxh
ciBpbiBvdGhlciAjaWYgSVNfRU5BQkxFRChDT05GSUdfTVRLX0NNRFEpIChhbHNvIGluIDcvNw0K
PiBodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3BhdGNoLzExMjgxMzQ5LykNCj4gDQoNCkkn
dmUgY2hhbmdlZCBJU19FTkFCTEVEKCkgdG8gSVNfUkVBQ0hBQkxFKClpbiBtZWRpYXRlay1kcm0t
bmV4dC01LjYgWzFdDQpmb3IgdGhlIGNvcnJlY3QgcmVsYXRpb25zaGlwIGJldHdlZW4gTVRLX0RS
TSBhbmQgTVRLX0NNRFEuDQoNClsxXQ0KaHR0cHM6Ly9naXRodWIuY29tL2NraHUtbWVkaWF0ZWsv
bGludXguZ2l0LXRhZ3MvY29tbWl0cy9tZWRpYXRlay1kcm0tbmV4dC01LjYNCg0KUmVnYXJkcywN
CkNLDQoNCj4gDQo+ID4gKyAgICAgICBpZiAoY21kcV9wa3QpDQo+ID4gKyAgICAgICAgICAgICAg
IGNtZHFfcGt0X3dyaXRlKGNtZHFfcGt0LCBjb21wLT5zdWJzeXMsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbXAtPnJlZ3NfcGEgKyBvZmZzZXQsIHZhbHVlKTsNCj4gPiAr
ICAgICAgIGVsc2UNCj4gPiArI2VuZGlmDQo+ID4gKyAgICAgICAgICAgICAgIHdyaXRlbCh2YWx1
ZSwgY29tcC0+cmVncyArIG9mZnNldCk7DQo+ID4gK30NCj4gPiArDQoNCg==

