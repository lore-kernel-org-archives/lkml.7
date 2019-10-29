Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D76CA9EC0
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81B8A20862
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 03:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfJ2DIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 23:08:44 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5214 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730831AbfJ2DIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 23:08:44 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id DBB8282521340221D7FA;
        Tue, 29 Oct 2019 11:08:40 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.218) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 29 Oct 2019
 11:08:32 +0800
Message-ID: <5DB7AD30.60007@huawei.com>
Date:   Tue, 29 Oct 2019 11:08:32 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     zhong jiang <zhongjiang@huawei.com>
CC:     <bardliao@realtek.com>, <oder_chiou@realtek.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: rt5677: Make rt5677_spi_pcm_page static
References: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1571919319-4205-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.218]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping.
On 2019/10/24 20:15, zhong jiang wrote:
> The GCC complains the following warning.
>
> sound/soc/codecs/rt5677-spi.c:365:13: warning: symbol 'rt5677_spi_pcm_page' was not declared. Should it be static?
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  sound/soc/codecs/rt5677-spi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/rt5677-spi.c b/sound/soc/codecs/rt5677-spi.c
> index 36c02d2..b412371 100644
> --- a/sound/soc/codecs/rt5677-spi.c
> +++ b/sound/soc/codecs/rt5677-spi.c
> @@ -362,7 +362,7 @@ static void rt5677_spi_copy_work(struct work_struct *work)
>  	mutex_unlock(&rt5677_dsp->dma_lock);
>  }
>  
> -struct page *rt5677_spi_pcm_page(
> +static struct page *rt5677_spi_pcm_page(
>  		struct snd_soc_component *component,
>  		struct snd_pcm_substream *substream,
>  		unsigned long offset)


