Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DDDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1FB220879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KTz2fyi0";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HW3zDwfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729893AbfCYHmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:42:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59170 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729755AbfCYHmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:42:10 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0CDB9602FC; Mon, 25 Mar 2019 07:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553499729;
        bh=pbTnG9ltVvVEU4phXZHMourowtAz45WwCMSgiC66PM8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KTz2fyi0Bv85YytYo3G0DGZYIZ0agxGmmdjMT/QO8uXtUQf7Kh26SrSfR9DuImGh4
         cxCSEjsyj4KsDqDgh/H4F9B9YN8TBTqJKQaKbkXz+IYOnFts/l4Vxnxk1nkuME4LuO
         NkCpQk6tL7ulLJqOlhReVpMT03EUd7vot/goyDbo=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F30AA602FC;
        Mon, 25 Mar 2019 07:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553499727;
        bh=pbTnG9ltVvVEU4phXZHMourowtAz45WwCMSgiC66PM8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HW3zDwfQiaALz6zP2Bm7696yo+XGHbuDfiADLBN/VnNhyVjr2FEeg4zcqv+kWseRW
         foSpYfBqbXj/i4w+576Am1Z+UcuJ4qm0Gl6LWuqLa8xD+qJIxfn/qNXDsmOPEFyPTA
         e4GQLQD4Sz50ookPgLsHqj0uvJTFzABA0b1le7DU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F30AA602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] ASoC: simple-card-utils: remove set but not used
 variable ''
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
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <6a0c2306-088f-cdbc-0730-60b899611c6f@codeaurora.org>
Date:   Mon, 25 Mar 2019 13:12:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323020838.107533-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2019 7:38 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
> sound/soc/generic/simple-card-utils.c:164:18: warning:
>   parameter 'dai_name' set but not used [-Wunused-but-set-parameter]
>
> It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add


I am not able to find this commit

0580dde59438


> asoc_simple_debug_info()"), so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
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

I don't see any function like `asoc_simple_parse_clk`

but instead this `asoc_simple_card_parse_clk` and there the variable is 
used.

Can you double check latest code base ?

Thanks,
Mukesh


> -	}
>   
>   	/*
>   	 * Parse dai->sysclk come from "clocks = <&xxx>"
>
>
>
>
>
