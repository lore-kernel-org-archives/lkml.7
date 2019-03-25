Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8928FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 627CE2063F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 11:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfCYLKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 07:10:40 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45530 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfCYLKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 07:10:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EA2C15AB;
        Mon, 25 Mar 2019 04:10:40 -0700 (PDT)
Received: from [10.1.196.69] (e112269-lin.cambridge.arm.com [10.1.196.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E78C3F575;
        Mon, 25 Mar 2019 04:10:38 -0700 (PDT)
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
From:   Steven Price <steven.price@arm.com>
Message-ID: <31ca2c4d-668d-9448-bb67-516d1a45b6a7@arm.com>
Date:   Mon, 25 Mar 2019 11:10:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190322220031.13773-1-pakki001@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2019 22:00, Aditya Pakki wrote:
> Unlike other drivers probe method, of_match_node return value
> is not used or checked. This patch removes the redundant code.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Reviewed-by: Steven Price <steven.price@arm.com>

> 
> ---
> v2: Move the signed by above the version change log
> v1: A check is unnecessary as match is never used.
> ---
>  sound/soc/codecs/sirf-audio-codec.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/codecs/sirf-audio-codec.c b/sound/soc/codecs/sirf-audio-codec.c
> index e424499a8450..e0af21050078 100644
> --- a/sound/soc/codecs/sirf-audio-codec.c
> +++ b/sound/soc/codecs/sirf-audio-codec.c
> @@ -461,9 +461,6 @@ static int sirf_audio_codec_driver_probe(struct platform_device *pdev)
>  	struct sirf_audio_codec *sirf_audio_codec;
>  	void __iomem *base;
>  	struct resource *mem_res;
> -	const struct of_device_id *match;
> -
> -	match = of_match_node(sirf_audio_codec_of_match, pdev->dev.of_node);
>  
>  	sirf_audio_codec = devm_kzalloc(&pdev->dev,
>  		sizeof(struct sirf_audio_codec), GFP_KERNEL);
> 

