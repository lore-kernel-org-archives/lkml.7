Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9526C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A869D218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 01:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfCUBps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 21:45:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59804 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727437AbfCUBps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 21:45:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7047EEBC14E034994592;
        Thu, 21 Mar 2019 09:45:46 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.408.0; Thu, 21 Mar 2019
 09:45:43 +0800
Subject: Re: [PATCH -next] ASoC: wm_adsp: Make some variables static
To:     <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <ckeepax@opensource.cirrus.com>, <rf@opensource.cirrus.com>
References: <20190321014314.17960-1-yuehaibing@huawei.com>
CC:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <85d44c6a-896d-43f4-973a-8b275eb52769@huawei.com>
Date:   Thu, 21 Mar 2019 09:45:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190321014314.17960-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pls ignore this, sorry.

On 2019/3/21 9:43, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warnings:
> 
> sound/soc/codecs/wm_adsp.c:309:20: warning: symbol 'wm_adsp1_ops' was not declared. Should it be static?
> sound/soc/codecs/wm_adsp.c:310:20: warning: symbol 'wm_adsp2_ops' was not declared. Should it be static?
> sound/soc/codecs/wm_adsp.c:311:20: warning: symbol 'wm_halo_ops' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/codecs/wm_adsp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
> index 644aaf1..4ed587f 100644
> --- a/sound/soc/codecs/wm_adsp.c
> +++ b/sound/soc/codecs/wm_adsp.c
> @@ -306,9 +306,9 @@
>  #define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
>  #define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
>  
> -struct wm_adsp_ops wm_adsp1_ops;
> -struct wm_adsp_ops wm_adsp2_ops[];
> -struct wm_adsp_ops wm_halo_ops;
> +static struct wm_adsp_ops wm_adsp1_ops;
> +static struct wm_adsp_ops wm_adsp2_ops[];
> +static struct wm_adsp_ops wm_halo_ops;
>  
>  struct wm_adsp_buf {
>  	struct list_head list;
> 

