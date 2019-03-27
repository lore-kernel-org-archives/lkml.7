Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C2C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B7A20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oZnh9iZ8";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W1p15+q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbfC0Odb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:33:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52496 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfC0Odb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:33:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 798A0608CC; Wed, 27 Mar 2019 14:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553697210;
        bh=Ggt5UMJOqguGT6AUU3Wlpjed3uDm3e8ciOwSKAu/p6o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oZnh9iZ8HTcLQ06wGJD9avuT/tQLhIab7ydofj6uTdURzCMHpnxFCUSSB1VqaAtRv
         7gwJqYwgsPHQtJXhtV5YTXasb51VPDp55gxQdvSINI7R08Ei5sTaatELNcpXcJ82ja
         Q5/I++HygvBkGPBb+LGheJPeBKzxJ4M3cTGwyPsY=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5ED466079C;
        Wed, 27 Mar 2019 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553697209;
        bh=Ggt5UMJOqguGT6AUU3Wlpjed3uDm3e8ciOwSKAu/p6o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W1p15+q8J1XTG1xadQ3xfmKi19Fmksa0fNbnr2oLOH8XXQQjj9PdPyzFzYDQQ+pAe
         7duaNvZm7mfACgaCebYaT/kjLCM3otjGyBhfQPQh6SZzr22Kk9VVdiV51l2bHs+yAp
         sO0lnEOllZkb98RAuyPCq0ZNKHzxgQTA20gm5Wco=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5ED466079C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v3] ASoC: sirf-audio: Remove redundant of_match_node call
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Barry Song <baohua@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        linux-arm-kernel@lists.infradead.org
References: <20190322220031.13773-1-pakki001@umn.edu>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <7273b5c0-2308-54b2-6bd5-6ad11292f8ea@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:03:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190322220031.13773-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2019 3:30 AM, Aditya Pakki wrote:
> Unlike other drivers probe method, of_match_node return value
> is not used or checked. This patch removes the redundant code.

Instead could be written like "Use of `of_match_node` is redundant in 
sirf-audio-codec driver probe. Remove it."

>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh


>
> ---
> v2: Move the signed by above the version change log
> v1: A check is unnecessary as match is never used.
> ---
>   sound/soc/codecs/sirf-audio-codec.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
> index e424499a8450..e0af21050078 100644
> --- a/sound/soc/codecs/sirf-audio-codec.c
> +++ b/sound/soc/codecs/sirf-audio-codec.c
> @@ -461,9 +461,6 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
>   	struct sirf_audio_codec *sirf_audio_codec;
>   	void __iomem *base;
>   	struct resource *mem_res;
> -	const struct of_device_id *match;
> -
> -	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
>   
>   	sirf_audio_codec = devm_kzalloc(&pdev->dev,
>   		sizeof(struct sirf_audio_codec), GFP_KERNEL);
