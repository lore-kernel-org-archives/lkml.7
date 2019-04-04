Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17102C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D699F20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="B2sVN7tf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Wx3ksDZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbfDDIAc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:00:32 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49222 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfDDIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:00:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id A2787609F3; Thu,  4 Apr 2019 08:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554364830;
        bh=W60EX6vvczQ3Z28QwYOBQA5+gthdAwwEEu91yYkHIFI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=B2sVN7tfCH6B5UYt+TYIRV8VaXxRpU54e1210st1oxyRG25M1rYgOi7uQjR13RXMw
         r18V4LOEridnV/U8RkoAZv07okJnbGrScnHk5GARyjj0OLev/X6GWWtmmR5PRG6kVn
         d3wFExSlG/1C9Pel3Y2timjLhA/iCfkhNEIiZnSM=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3568607C6;
        Thu,  4 Apr 2019 08:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554364828;
        bh=W60EX6vvczQ3Z28QwYOBQA5+gthdAwwEEu91yYkHIFI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Wx3ksDZ5YS3b4IVNqilF63njqNVExw5lP1J1qF4Y+KZyt/HRjxlwsUetbxNbuYNGY
         dIjCMW5ow+pvkYDl8JU2qg8n7tczBiD8cVCxPCrTnA5nX7Pk0pRGJRBp8KhMWZQs+X
         f4ngu3UdhviBfSFMfOAFRzh3spUvaWuLxqSOAGcc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E3568607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][next] ASoC: sprd: Fix spelling mistake "faied" ->
 "failed"
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190404075603.11680-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c2339d07-4b8b-070c-6741-0bd2a9b34aeb@codeaurora.org>
Date:   Thu, 4 Apr 2019 13:30:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190404075603.11680-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/4/2019 1:26 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There are two identical spelling mistakes in dev_err messages. Fix them.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   sound/soc/sprd/sprd-pcm-compress.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
> index dc84257cffc2..e008525a6cb3 100644
> --- a/sound/soc/sprd/sprd-pcm-compress.c
> +++ b/sound/soc/sprd/sprd-pcm-compress.c
> @@ -282,13 +282,13 @@ static int sprd_platform_compr_set_params(struct snd_compr_stream *cstream,
>   	 */
>   	ret = sprd_platform_compr_dma_config(cstream, params, 1);
>   	if (ret) {
> -		dev_err(dev, "faied to config stage 1 DMA: %d\n", ret);
> +		dev_err(dev, "failed to config stage 1 DMA: %d\n", ret);
>   		return ret;
>   	}
>   
>   	ret = sprd_platform_compr_dma_config(cstream, params, 0);
>   	if (ret) {
> -		dev_err(dev, "faied to config stage 0 DMA: %d\n", ret);
> +		dev_err(dev, "failed to config stage 0 DMA: %d\n", ret);
>   		goto config_err;
>   	}
>   
