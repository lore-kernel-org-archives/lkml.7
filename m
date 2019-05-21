Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCE1C04AAC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5331B2177B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 02:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfEUCaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 22:30:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9611 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727613AbfEUCaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 22:30:30 -0400
X-UUID: aaf9d9b149044d459b9dfb05ac2c860e-20190521
X-UUID: aaf9d9b149044d459b9dfb05ac2c860e-20190521
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1668941089; Tue, 21 May 2019 10:30:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 21 May 2019 10:30:21 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 21 May 2019 10:30:21 +0800
Message-ID: <1558405821.25526.2.camel@mtksdaap41>
Subject: Re: [PATCH v7 08/12] soc: mediatek: cmdq: change the type of input
 parameter
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "YT Shen" <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Houlong Wei <houlong.wei@mediatek.com>,
        <ginny.chen@mediatek.com>
Date:   Tue, 21 May 2019 10:30:21 +0800
In-Reply-To: <20190521011108.40428-9-bibby.hsieh@mediatek.com>
References: <20190521011108.40428-1-bibby.hsieh@mediatek.com>
         <20190521011108.40428-9-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: E88ADBB64ED6F6756962BB9AC0D0364B8ABFDF368B7F2FE8B55D8484F273F8A92000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Tue, 2019-05-21 at 09:11 +0800, Bibby Hsieh wrote:
> According to the cmdq hardware design, the subsys is u8,
> the offset is u16 and the event id is u16.
> This patch changes the type of subsys, offset and event id
> to the correct type.

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-cmdq-helper.c | 10 +++++-----
>  include/linux/soc/mediatek/mtk-cmdq.h  | 10 +++++-----
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> index 082b8978651e..7aa0517ff2f3 100644
> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -136,7 +136,7 @@ static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
>  	return 0;
>  }
>  
> -int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value)
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value)
>  {
>  	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
>  		    (subsys << CMDQ_SUBSYS_SHIFT);
> @@ -145,8 +145,8 @@ int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_write);
>  
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
> -			u32 offset, u32 value, u32 mask)
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
> +			u16 offset, u32 value, u32 mask)
>  {
>  	u32 offset_mask = offset;
>  	int err = 0;
> @@ -161,7 +161,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
>  }
>  EXPORT_SYMBOL(cmdq_pkt_write_mask);
>  
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
>  {
>  	u32 arg_b;
>  
> @@ -181,7 +181,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
>  }
>  EXPORT_SYMBOL(cmdq_pkt_wfe);
>  
> -int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event)
>  {
>  	if (event >= CMDQ_MAX_EVENT)
>  		return -EINVAL;
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> index 39d813dde4b4..9618debb9ceb 100644
> --- a/include/linux/soc/mediatek/mtk-cmdq.h
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -66,7 +66,7 @@ void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value);
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32 value);
>  
>  /**
>   * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
> @@ -78,8 +78,8 @@ int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 subsys, u32 offset, u32 value);
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
> -			u32 offset, u32 value, u32 mask);
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u8 subsys,
> +			u16 offset, u32 value, u32 mask);
>  
>  /**
>   * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
> @@ -88,7 +88,7 @@ int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 subsys,
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event);
>  
>  /**
>   * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
> @@ -97,7 +97,7 @@ int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
>   *
>   * Return: 0 for success; else the error code is returned
>   */
> -int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u16 event);
>  
>  /**
>   * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ


