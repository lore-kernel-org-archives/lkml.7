Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35AC4C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041F220578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 12:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oxW5omhH";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="MoPgbp/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfEOM0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 08:26:48 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42918 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEOM0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 08:26:47 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 22E636072E; Wed, 15 May 2019 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557923207;
        bh=Jq8r59j8L9cuyE+iEkCCfN3oZ7FkZj2PtazceDgQIjs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oxW5omhHHyz7C9XvHRLXNw5dodUZ1FGR3SDDAHbzIJKj69TEsCuwCuMHEGRRbidUb
         CUOWf9faIeT0AQAccSZ7dMzPTahYJiUB/x7YuaCjaO/ydYZM9j8n6k6FubPJ8uZj9z
         0JvL4BuxqD+LREygXFYvQRobAgfA+W5EAS59ZADc=
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4DF336072E;
        Wed, 15 May 2019 12:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557923206;
        bh=Jq8r59j8L9cuyE+iEkCCfN3oZ7FkZj2PtazceDgQIjs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MoPgbp/Xauv8laEhwNTlkhgZ2bVtQ1U1SDf8IfsQqY4VSnd2bSnTWIriAbPiMcu76
         Ycm+5nIoOdpmSiqxx4RE6/feZYh8xgI++0BVVMCFl5oLbuHKYkyMwCFXbNkPxVokLa
         pYJpINMcVfPd1N/SbBZv3QTsV0W3Efs1ckc6aIQ0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4DF336072E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] drm/nouveau/bios/init: fix spelling mistake "CONDITON" ->
 "CONDITION"
To:     Colin King <colin.king@canonical.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190514205701.5750-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <c214275e-912b-9cec-d0c1-4eadd07a100e@codeaurora.org>
Date:   Wed, 15 May 2019 17:56:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514205701.5750-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/15/2019 2:27 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> There is a spelling mistake in a warning message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh

> ---
>   drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> index ec0e9f7224b5..3f4f27d191ae 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c
> @@ -834,7 +834,7 @@ init_generic_condition(struct nvbios_init *init)
>   		init_exec_set(init, false);
>   		break;
>   	default:
> -		warn("INIT_GENERIC_CONDITON: unknown 0x%02x\n", cond);
> +		warn("INIT_GENERIC_CONDITION: unknown 0x%02x\n", cond);
>   		init->offset += size;
>   		break;
>   	}
