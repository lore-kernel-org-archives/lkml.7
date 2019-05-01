Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74D9C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 12:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936B020835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 12:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbfEAMQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 08:16:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:60979 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfEAMQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 08:16:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 May 2019 05:16:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,417,1549958400"; 
   d="scan'208";a="169578990"
Received: from sbahirat-mobl1.amr.corp.intel.com (HELO [10.255.231.197]) ([10.255.231.197])
  by fmsmga001.fm.intel.com with ESMTP; 01 May 2019 05:16:18 -0700
Subject: Re: [alsa-devel] [PATCH][next] ASoC: SOF: Intel: fix spelling mistake
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
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7aff79bd-e0d5-a10b-7443-6f27ea1f47c7@linux.intel.com>
Date:   Wed, 1 May 2019 07:16:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501102308.30390-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/19 5:23 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a hda_dsp_rom_msg message, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Thanks for the fix!

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
> 
