Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE7FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3932082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XrgrrrNS";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VzgOvhkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfC0Oxg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:53:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55438 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbfC0Oxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:53:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B44C06086B; Wed, 27 Mar 2019 14:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553698414;
        bh=6WnBNayeeZLx1mFcFPsAZtJLBEMLezkgwdJQ2lTtxZY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XrgrrrNS3mKQQH+hUeArgnEFv9sb3HZb3JpuL2ixVDeKjQVaVp3rP6MXRybi/gZMr
         6uonhJ0v0wWMWFGV5Sj8WtKAi+RjQnzOYHeoz/GrYdtR2344WLWdKBoiMmp/oxLFwb
         8EaqOaNTPpma2ENWpdsuLwZ8BlJRIj1SNNVItfM8=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D97E61418;
        Wed, 27 Mar 2019 14:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553698410;
        bh=6WnBNayeeZLx1mFcFPsAZtJLBEMLezkgwdJQ2lTtxZY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VzgOvhkxMd65aB5h+stryroZx1RJdfKvvIpuuB4aAXBULaVB4pu+X/awrItzLju8U
         aYRVzxSF/GgfDeUmq4H7fiOov2NijFGBZy39WDhZijkjdF21sV/NZhxuzQiTGW5LIg
         RJ/mnMvBMQW0l5KHhDK2QICFdUSaiao7oBhpt/tk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D97E61418
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 -next] ASoC: simple-card-utils: remove set but not used
 variable 'dai_name'
To:     YueHaibing <yuehaibing@huawei.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190323020838.107533-1-yuehaibing@huawei.com>
 <20190325031740.164364-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <4611a8ee-4e89-b871-5151-588bd639a47d@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:23:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325031740.164364-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 8:47 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
> sound/soc/generic/simple-card-utils.c:164:18: warning:
>   parameter 'dai_name' set but not used [-Wunused-but-set-parameter]
>
> It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add
> asoc_simple_debug_info()"), so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
> v2: fix patch title
> ---
>   sound/soc/generic/simple-card-utils.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
> index 4ed68348f939..db1458a19985 100644
> --- a/sound/soc/generic/simple-card-utils.c
> +++ b/sound/soc/generic/simple-card-utils.c
> @@ -173,10 +173,8 @@ int asoc_simple_parse_clk(struct device *dev,
>   	 * see
>   	 *	soc-core.c :: snd_soc_init_multicodec()
>   	 */
> -	if (dlc) {
> +	if (dlc)
>   		dai_of_node	= dlc->of_node;
> -		dai_name	= dlc->dai_name;
> -	}
>   
>   	/*
>   	 * Parse dai->sysclk come from "clocks = <&xxx>"
>
>
>
