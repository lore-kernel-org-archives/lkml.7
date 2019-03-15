Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D22C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7F52186A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 02:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfCOCGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 22:06:31 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39639 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726711AbfCOCGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 22:06:30 -0400
X-UUID: f25c6d2c58d445af84726c0aba958afa-20190315
X-UUID: f25c6d2c58d445af84726c0aba958afa-20190315
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 593922312; Fri, 15 Mar 2019 10:06:23 +0800
Received: from MTKMBS01DR.mediatek.inc (172.21.101.111) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 15 Mar 2019 10:06:22 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs01dr.mediatek.inc
 (172.21.101.111) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 15 Mar
 2019 10:06:18 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 15 Mar 2019 10:06:16 +0800
Message-ID: <1552615576.31200.19.camel@mhfsdcap03>
Subject: Re: [PATCH 03/18] drm/mediatek: redefine mtk_ddp_sout_sel
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
Reply-To: <yongqiang.niu@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 15 Mar 2019 10:06:16 +0800
In-Reply-To: <CANMq1KBTN61hmWy2K+rrx3NL0eR7AXhFQBkCpcHu5nhUw_6xjw@mail.gmail.com>
References: <1545638931-24938-1-git-send-email-yongqiang.niu@mediatek.com>
         <1545638931-24938-4-git-send-email-yongqiang.niu@mediatek.com>
         <CANMq1KBTN61hmWy2K+rrx3NL0eR7AXhFQBkCpcHu5nhUw_6xjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-12-25 at 11:57 +0800, Nicolas Boichat wrote:
> On Mon, Dec 24, 2018 at 6:52 PM Yongqiang Niu
> <yongqiang.niu@mediatek.com> wrote:
> >
> > This patch redefine mtk_ddp_sout_sel
> 
> Can you describe a bit more why you are making this change?

the format of "mtk_ddp_sout_sel"was not flexible, after we add more
mediatek SOC support, that will be redundant

set this function format like mtk_ddp_mout_en and mtk_ddp_sel_in

> 
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 32 ++++++++++++++++++++------------
> >  1 file changed, 20 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index adb37e4..592f852 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -405,21 +405,27 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> >         return value;
> >  }
> >
> > -static void mtk_ddp_sout_sel(void __iomem *config_regs,
> > -                            enum mtk_ddp_comp_id cur,
> > -                            enum mtk_ddp_comp_id next)
> > +static unsigned int mtk_ddp_sout_sel(void __iomem *config_regs,
> 
> You don't use config_regs anymore, drop it.

ok, will drop it in next version

> 
> > +                                    enum mtk_ddp_comp_id cur,
> > +                                    enum mtk_ddp_comp_id next,
> > +                                    unsigned int *addr)
> >  {
> > +       unsigned int value;
> > +
> >         if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
> > -               writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
> > -                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> > +               *addr = DISP_REG_CONFIG_OUT_SEL;
> > +               value = BLS_TO_DSI_RDMA1_TO_DPI1;
> 
> You can directly return BLS_TO_DSI_RDMA1_TO_DPI1.

just format this like mtk_ddp_mout_en and mtk_ddp_sel_in

> 
> >         } else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> > -               writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> > -                              config_regs + DISP_REG_CONFIG_OUT_SEL);
> > -               writel_relaxed(DSI_SEL_IN_RDMA,
> > -                              config_regs + DISP_REG_CONFIG_DSI_SEL);
> > -               writel_relaxed(DPI_SEL_IN_BLS,
> > -                              config_regs + DISP_REG_CONFIG_DPI_SEL);
> > +               *addr = DISP_REG_CONFIG_OUT_SEL;
> > +               value = BLS_TO_DPI_RDMA1_TO_DSI;
> 
> I (kind of) understand the change above, as you still end up writing
> BLS_TO_DSI_RDMA1_TO_DPI1 in DISP_REG_CONFIG_OUT_SEL.
> 
> This changes the behaviour, as now you only write
> BLS_TO_DPI_RDMA1_TO_DSI to DISP_REG_CONFIG_OUT_SEL, but the previous
> revision of the code would also write to DISP_REG_CONFIG_DSI_SEL and
> DISP_REG_CONFIG_DPI_SEL. Why?
> 

DISP_REG_CONFIG_DSI_SEL set in the next lines.
DPI_SEL_IN_BLS is 0 for DISP_REG_CONFIG_DPI_SEL set, and hardware
default setting is also 0, so this one is no need anymore

> > +       } else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> > +               *addr = DISP_REG_CONFIG_DSI_SEL;
> > +               value = DSI_SEL_IN_RDMA;
> > +       } else {
> > +               value = 0;
> >         }
> > +
> > +       return value;
> >  }
> >
> >  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> > @@ -434,7 +440,9 @@ void mtk_ddp_add_comp_to_path(void __iomem *config_regs,
> >                 writel_relaxed(reg, config_regs + addr);
> >         }
> >
> > -       mtk_ddp_sout_sel(config_regs, cur, next);
> > +       value = mtk_ddp_sout_sel(cur, next, &addr);
> > +       if (value)
> > +               writel_relaxed(value, config_regs + addr);
> 
> Why this change? I don't see mtk_ddp_sout_sel being used later in the
> series, so I'm not sure why we don't directly write the value into the
> register.
> 
in the patch "[PATCH 04/18] drm/mediatek: move rdma sout from
mtk_ddp_mout_en into mtk_ddp_sout_sel", i moved all rdma out to here,
rdma only have single out, no multi out.
if keep this format, there will many writel_relaxed in mtk_ddp_sout_sel.
and modify this format like mtk_ddp_mout_en and mtk_ddp_sel_in looks
better.

> 
> 
> >         value = mtk_ddp_sel_in(cur, next, &addr);
> >         if (value) {
> > --
> > 1.8.1.1.dirty
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel


