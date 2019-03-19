Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FB720854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 03:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfCSDM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 23:12:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10278 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726788AbfCSDM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 23:12:27 -0400
X-UUID: 4e8c51946baf4815bd0f18ac89cef9c4-20190319
X-UUID: 4e8c51946baf4815bd0f18ac89cef9c4-20190319
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1736314218; Tue, 19 Mar 2019 11:12:17 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Mar 2019 11:12:15 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Mar 2019 11:12:09 +0800
Message-ID: <1552965129.7881.5.camel@mtksdaap41>
Subject: Re: Aw: Re:  [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer
 device
From:   CK Hu <ck.hu@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, <srv_heupstream@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "\"Noralf =?UTF-8?Q?Tr=EF=BF=BDnnes=22?=" <noralf@tronnes.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 19 Mar 2019 11:12:09 +0800
In-Reply-To: <trinity-1c369adc-b489-43dd-87c9-5b43d49561c5-1547991406711@3c-app-gmx-bs40>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
         <20190116013924.11345-2-ck.hu@mediatek.com>
         <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
         <1547775975.4221.11.camel@mtksdaap41>
         <74eba84d-4686-698a-6100-d72dabd15a21@gmail.com>
         <trinity-1c369adc-b489-43dd-87c9-5b43d49561c5-1547991406711@3c-app-gmx-bs40>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 3F58EF261E99D59EA64FFE4A32DBD777DB0720C4DC083B29F51724B5CB67B4EF2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Frank:

My platform's fbcon works correctly, so I've applied this series to [1].
If you have another patch, I'd treat it as a bug-fix.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-5.1

Regards,
CK

On Sun, 2019-01-20 at 14:36 +0100, Frank Wunderlich wrote:
> Tested with mmsys-Patch, but same result, no fbcon, tft is switched on but i see no kernel-log
> 
> after boot is finished, i see X-server, until this point i see only black screen
> 
> regards Frank
> 
> 
> > Gesendet: Freitag, 18. Januar 2019 um 09:39 Uhr
> > Von: "Matthias Brugger" <matthias.bgg@gmail.com>
> > may it be the not yet fixed mmsys compatible problem?
> > Frank, did you test with my last series [1]?
> > [1] https://patchwork.kernel.org/cover/10686345/


