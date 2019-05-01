Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DA5C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE75B21670
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 11:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="etriUdbK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="A0TexfoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfEAL4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 07:56:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:52522 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfEAL4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 07:56:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6D62660A0A; Wed,  1 May 2019 11:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556711783;
        bh=SH+iBymOwJgn65YiYpdig2ngBAsVv4AI1dnrt+DJDCo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=etriUdbKNbr4MktYuhM1kLYp/rsMcxOd5ZpPD3kOroGmRxqRrlRV7FGZGtKuATPsG
         EGHN3i/zvbyTVo4pKWEx0focnS3hRB4DA+11oWECz/xZv0bBb78DmbPrhQqmOE6orc
         +MhjQXC0tcrCrzrIcGer9jBbxVe5YCUn/U/6lleQ=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 621FE60240;
        Wed,  1 May 2019 11:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556711782;
        bh=SH+iBymOwJgn65YiYpdig2ngBAsVv4AI1dnrt+DJDCo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=A0TexfoKmLho9EFuES3KMEY8MDxzVJRSDdZQcVQVKhJRicy9sWWCUOpwLT1NeVEEH
         6oHIqRAQjRGfHNBHNnGTcb/TFietcMafa3egAMSoeuQUezMRhTe5l75uX7YrmWZm/r
         4AIMWtQxQnfY3z/4JEa5fRYZqFlMGbA/qUM3fKcg=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 621FE60240
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH][next] ASoC: SOF: Intel: fix spelling mistake
 "incompatble" -> "incompatible"
To:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190501102308.30390-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <21cd03b5-c5be-dc93-cabb-980def737f87@codeaurora.org>
Date:   Wed, 1 May 2019 17:26:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501102308.30390-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/1/2019 3:53 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a hda_dsp_rom_msg message, fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   sound/soc/sof/intel/hda.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
> index b8fc19790f3b..84baf275b467 100644
> --- a/sound/soc/sof/intel/hda.c
> +++ b/sound/soc/sof/intel/hda.c
> @@ -54,7 +54,7 @@ static const struct hda_dsp_msg_code hda_dsp_rom_msg[] = {
>   	{HDA_DSP_ROM_L2_CACHE_ERROR, "error: L2 cache error"},
>   	{HDA_DSP_ROM_LOAD_OFFSET_TO_SMALL, "error: load offset too small"},
>   	{HDA_DSP_ROM_API_PTR_INVALID, "error: API ptr invalid"},
> -	{HDA_DSP_ROM_BASEFW_INCOMPAT, "error: base fw incompatble"},
> +	{HDA_DSP_ROM_BASEFW_INCOMPAT, "error: base fw incompatible"},
>   	{HDA_DSP_ROM_UNHANDLED_INTERRUPT, "error: unhandled interrupt"},
>   	{HDA_DSP_ROM_MEMORY_HOLE_ECC, "error: ECC memory hole"},
>   	{HDA_DSP_ROM_KERNEL_EXCEPTION, "error: kernel exception"},
