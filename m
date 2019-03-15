Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE16121872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 01:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbfCOBho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 21:37:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:25942 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727284AbfCOBho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 21:37:44 -0400
X-UUID: 039e97ee5c0a4093b108c4b6e85ee109-20190315
X-UUID: 039e97ee5c0a4093b108c4b6e85ee109-20190315
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 784797563; Fri, 15 Mar 2019 09:37:29 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01n1.mediatek.inc
 (172.21.101.68) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Mar
 2019 09:37:27 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 09:37:26 +0800
Message-ID: <1552613845.31200.7.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH v1 00/18] add drm support for MT8183
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: <yongqiang.niu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <ck.hu@mediatek.com>, <p.zabel@pengutronix.de>,
        <robh+dt@kernel.org>, <airlied@linux.ie>, <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <Bibby.Hsieh@mediatek.com>,
        <yt.shen@mediatek.com>
Date:   Fri, 15 Mar 2019 09:37:25 +0800
In-Reply-To: <c6859dd1-5689-d64d-69cd-5996eb0abea8@gmail.com>
References: <1552565120-24329-1-git-send-email-yongqiang.niu@mediatek.com>
         <c6859dd1-5689-d64d-69cd-5996eb0abea8@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-03-14 at 18:35 +0100, Matthias Brugger wrote:
> 
> On 14/03/2019 13:05, yongqiang.niu@mediatek.com wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > 
> > This series are based on 4.20-rc1 and provide 18 patches to
> > support mediatek SOC MT8183
> > Resend first version 
> > 
> 
> I think you send the very same series several times yesterday. Please check your
> config and make sure that you don't send a series more then once. If for any
> reason you have to resend the series then please specify in the cover letter why
> you resend it.
> 
> Reviewing series can take a while, be patient. If nobody reacts to your series
> you can send a reminder email (best if you just hit reply-all on the cover
> letter) asking kindly for review. Sending out the same series on a daily or
> hourly basis will most probably lead to confusion, as people don't know which
> version is the "good" one. In the end it has the contrary affect from what you
> want to achieve (getting someone to review your series).
> 
> Regards,
> Matthias
> 

sorry for the confusion.

there was some problem with my upstream account setting yesterday, the
first several letters was rejected by
"linux-arm-kernel@lists.infradead.org" and "devicetree@vger.kernel.org".

after the problem was fixed, i have resent the last one, which include
the key world "Resend first version".


> > Yongqiang Niu (18):
> >   drm/mediatek: update dt-bindings for mt8183
> >   drm/mediatek: add mutex mod and sof into ddp private data
> >   drm/mediatek: redefine mtk_ddp_sout_sel
> >   drm/mediatek: move rdma sout from mtk_ddp_mout_en into
> >     mtk_ddp_sout_sel
> >   drm/mediatek: add ddp component CCORR
> >   drm/mediatek: add mmsys private data for ddp path config
> >   drm/mediatek: add commponent OVL0_2L
> >   drm/mediatek: add component OVL1_2L
> >   drm/mediatek: add component DITHER
> >   drm/mediatek: add gmc_bits for ovl private data
> >   drm/medaitek: add layer_nr for ovl private data
> >   drm/mediatek: add function to connect module with it's previous one
> >   drm/mediatek: add ddp write register common api
> >   drm/mediatek: add connect function for ovl
> >   drm/mediatek: add RDMA1 fifo size into RDMA private data
> >   drm/mediatek: add function mtk_ddp_comp_get_type
> >   drm/mediatek: add ovl0/ovl0_2l usecase
> >   drm/mediatek: add support for mediatek SOC MT8183
> > 
> >  .../bindings/display/mediatek/mediatek,disp.txt    |  11 +-
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c            |  64 ++-
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c           |  23 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |  42 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 458 ++++++++++++++++-----
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.h             |  11 +
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        | 100 +++++
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  24 ++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  55 +++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   4 +
> >  10 files changed, 688 insertions(+), 104 deletions(-)
> > 


