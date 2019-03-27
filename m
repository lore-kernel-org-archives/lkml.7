Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE233C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7B02075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EySExKrA";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="eJuRxSFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfC0N75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:59:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36612 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfC0N74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:59:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2D68360E7A; Wed, 27 Mar 2019 13:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553695195;
        bh=AZ/Wq3KoiERyB/0kV+wfRBHGbweYp8nX9BJAch5CrQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EySExKrAGHHtj21kM3yCG2qhEaRvhkcd94QFglqdp02Z16/IcH3zEqguzkvM7ggkh
         fRewoZMIdv+uNsQZcV73R75MdfPLVO0oiwWnBmsisqcjEp6616YEFl3buKmLuyU2BS
         1NXHJ+8Y3YAYgqoViCjtfbrEjN6NUoNfMMvxP28A=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A3F0160E7A;
        Wed, 27 Mar 2019 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553695192;
        bh=AZ/Wq3KoiERyB/0kV+wfRBHGbweYp8nX9BJAch5CrQk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=eJuRxSFcrD1tQXnkKqm7RGeBykw5j3Ax++adSowCByH8i02yj3t7LtjiR+U7ie3BF
         26uD0IMJuu6QhFAwpPUrcxVQtmI77RzqQiz8LEVhIploNlKWveG9EYPhIK5fK1NVF+
         LJ0VYUFc4cv6/8K2Q91vly4MzShWi/CBiMit13fI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A3F0160E7A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH -next] drm/vmwgfx: Remove set but not used variable
 'fb_offset, fb_depth'
To:     YueHaibing <yuehaibing@huawei.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190323024606.163683-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <171dc8ca-00ff-da5c-c607-89f25dcd0a06@codeaurora.org>
Date:   Wed, 27 Mar 2019 19:29:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190323024606.163683-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/2019 8:16 AM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/vmwgfx/vmwgfx_fb.c: In function 'vmw_fb_init':
> drivers/gpu/drm/vmwgfx/vmwgfx_fb.c:645:29: warning:
>   variable 'fb_offset' set but not used [-Wunused-but-set-variable]
>
> drivers/gpu/drm/vmwgfx/vmwgfx_fb.c:645:19: warning:
>   variable 'fb_depth' set but not used [-Wunused-but-set-variable]
>
> They're not used any more, so can be removed.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/gpu/drm/vmwgfx/vmwgfx_fb.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
> index 2a9112515f46..86efb91f5034 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fb.c
> @@ -642,12 +642,11 @@ int vmw_fb_init(struct vmw_private *vmw_priv)
>   	struct vmw_fb_par *par;
>   	struct fb_info *info;
>   	unsigned fb_width, fb_height;
> -	unsigned fb_bpp, fb_depth, fb_offset, fb_pitch, fb_size;
> +	unsigned fb_bpp, fb_pitch, fb_size;
>   	struct drm_display_mode *init_mode;
>   	int ret;
>   
>   	fb_bpp = 32;
> -	fb_depth = 24;
>   
>   	/* XXX As shouldn't these be as well. */
>   	fb_width = min(vmw_priv->fb_max_width, (unsigned)2048);
> @@ -655,7 +654,6 @@ int vmw_fb_init(struct vmw_private *vmw_priv)
>   
>   	fb_pitch = fb_width * fb_bpp / 8;
>   	fb_size = fb_pitch * fb_height;
> -	fb_offset = vmw_read(vmw_priv, SVGA_REG_FB_OFFSET);
>   
>   	info = framebuffer_alloc(sizeof(*par), device);
>   	if (!info)
>
>
>
