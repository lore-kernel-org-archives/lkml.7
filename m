Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFCFC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 16:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE6B208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 16:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbfHJQiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 12:38:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:49029 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726112AbfHJQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 12:38:14 -0400
X-UUID: 4354e03d6b6c4d93b3e200d25d7fc4d8-20190811
X-UUID: 4354e03d6b6c4d93b3e200d25d7fc4d8-20190811
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 629964535; Sun, 11 Aug 2019 00:38:05 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sun, 11 Aug
 2019 00:38:03 +0800
Received: from [10.17.3.153] (172.27.4.253) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Sun, 11 Aug 2019 00:38:01 +0800
Message-ID: <1565455081.19079.36.camel@mhfsdcap03>
Subject: Re: [PATCH v11 09/12] soc: mediatek: cmdq: define the instruction
 struct
From:   houlong wei <houlong.wei@mediatek.com>
To:     Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
        <Bibby.Hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>, "Daniel Kurtz" <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Daoyuan Huang =?UTF-8?Q?=28=E9=BB=83=E9=81=93=E5=8E=9F=29?= 
        <Daoyuan.Huang@mediatek.com>,
        Jiaguang Zhang =?UTF-8?Q?=28=E5=BC=A0=E5=8A=A0=E5=B9=BF=29?= 
        <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh =?UTF-8?Q?=28=E8=AC=9D=E5=AE=87=E5=93=B2=29?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        Ginny Chen =?UTF-8?Q?=28=E9=99=B3=E6=B2=BB=E5=82=91=29?= 
        <ginny.chen@mediatek.com>, <houlong.wei@mediatek.com>
Date:   Sun, 11 Aug 2019 00:38:01 +0800
In-Reply-To: <1565453520.19079.17.camel@mhfsdcap03>
References: <20190729070106.9332-1-bibby.hsieh@mediatek.com>
         <20190729070106.9332-10-bibby.hsieh@mediatek.com>
         <1565453520.19079.17.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 8232FFF279301A39457DCF48E56192120E1B5723579B6362CE045B6813A8FDA22000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-08-11 at 00:12 +0800, houlong wei wrote:
> Hi Bibby, I have inline comment in function cmdq_pkt_write_mask().
> 
> On Mon, 2019-07-29 at 15:01 +0800, Bibby Hsieh wrote:
> > Define an instruction structure for gce driver to append command.
> > This structure can make the client's code more readability.
> > 
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > Reviewed-by: CK Hu <ck.hu@mediatek.com>
> > ---
> >  drivers/soc/mediatek/mtk-cmdq-helper.c   | 103 +++++++++++++++--------
> >  include/linux/mailbox/mtk-cmdq-mailbox.h |   2 +
> >  2 files changed, 72 insertions(+), 33 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > index 7aa0517ff2f3..0886c4967ca4 100644
> > --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> > +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > @@ -9,12 +9,24 @@
> >  #include <linux/mailbox_controller.h>
> >  #include <linux/soc/mediatek/mtk-cmdq.h>
[...]
> >  
> >  int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
> >  			u16 offset, u32 value, u32 mask)
> >  {
> > +	struct cmdq_instruction *inst;
> >  	u32 offset_mask = offset;
> > -	int err = 0;
> >  
> >  	if (mask != 0xffffffff) {
> > -		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
> > +		inst = cmdq_pkt_append_command(pkt);
> > +		if (!inst)
> > +			return -ENOMEM;
> > +
> > +		inst->op = CMDQ_CODE_MASK;
> > +		inst->mask = ~mask;

> >  		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
> >  	}
> > -	err |= cmdq_pkt_write(pkt, value, subsys, offset_mask);
> >  
> > -	return err;
> > +	return cmdq_pkt_write(pkt, subsys, offset_mask, value);

We need add a type conversion here, (u8)offset_mask, for your new
function type. Er... it's better to remove local variable 'offset_mask'
and replace it with 'offset'.

> >  }
[...]


