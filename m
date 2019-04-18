Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08453C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDD5214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eIJiU2XB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mg9i2xFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390032AbfDRTCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:02:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48924 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfDRTCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:02:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 724C56134E; Thu, 18 Apr 2019 19:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555614140;
        bh=5C2NoRUdgUyK0ClXvZsv5dQRzF3l0RkvTI0ytG6923k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eIJiU2XBABB96EYV7DGT6fkoxpkP1rPcpPNJ3ZdKYkGGszp43Q7SKbSYIX90JixhC
         1yQZgmgo0mMV/WolgJddSHeb+AGKW5wM6VC3laXep5CMWnw9X6AUL8UrJXIc9Qgv8h
         574DzXXBnimJZRIM79WMlXvlqOggTxNKEpZ3at2k=
Received: from [10.79.161.32] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5B2861230;
        Thu, 18 Apr 2019 19:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1555614139;
        bh=5C2NoRUdgUyK0ClXvZsv5dQRzF3l0RkvTI0ytG6923k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Mg9i2xFynC9GFz+oSWDosWT88wEXcF37p4xorJ/eoPYP1KV4JY3BLWRMhSdF6OSKZ
         DD6RHm5gnjBBgME/V/SO/CXck78irxFj8BZrfpcBcuYdXBgY978EDm7iNoyc9uoNBd
         521gdTjsQYbaj64AXLD4Nx149FEhGv4FV+z/ZlAM=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5B2861230
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drm/nouveau/fb/ramgk104: fix spelling mistake
 "sucessfully" -> "successfully"
To:     Colin King <colin.king@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190418165345.20909-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <e979e0ac-62e7-1b5e-6542-2db3debebb32@codeaurora.org>
Date:   Fri, 19 Apr 2019 00:32:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190418165345.20909-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/18/2019 10:23 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a nvkm_debug message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh
> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> index 8bcb7e79a0cb..456aed1f2a02 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramgk104.c
> @@ -1070,7 +1070,7 @@ gk104_ram_calc_xits(struct gk104_ram *ram, struct nvkm_ram_data *next)
>   			nvkm_error(subdev, "unable to calc plls\n");
>   			return -EINVAL;
>   		}
> -		nvkm_debug(subdev, "sucessfully calced PLLs for clock %i kHz"
> +		nvkm_debug(subdev, "successfully calced PLLs for clock %i kHz"
>   				" (refclock: %i kHz)\n", next->freq, ret);
>   	} else {
>   		/* calculate refpll coefficients */
