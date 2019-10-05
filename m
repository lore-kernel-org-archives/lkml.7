Return-Path: <SRS0=6Pxm=X6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C35C4740A
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 18:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD77A20867
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Oct 2019 18:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VfqqIhLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387706AbfJESK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 14:10:27 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387520AbfJESK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 14:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iECkkIlT8M1PJMXLE502uRX54JzfnDVnuF93zxzrqHo=; b=VfqqIhLrX4wkAqqvMmh9WatRA
        sAYUsIqVxNfEvTdRNWh7xAvKnD/APEQy6P1XVhV2Y2uoJaZEfhUiHrHf6OLGYvVbQ+R2lzgDJnjRr
        fkm/w7JEF7+Z0gdlkpYcsFL48YJiyAPIOAmOCsmgM+3dgevcgau/qyx8XEPA5qeTSUjZhDGmxNPUJ
        oIPyAKADYjjHEWf/LBuzjCpfL3RwwK2noOhzIq07OrarTtKIzCU1Y0VYCBB88Zu4h5T3NwdI8yUVW
        aaGjNK1jfRm5l6AJD3+wj3bHSjc15WpK1+ttFiRN6NjeHTgVMSFtAmTXg4pP2OP78E3+PUVAUsTqa
        AyyT4yCng==;
Received: from [2601:1c0:6280:3f0::9ef4]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGoVb-0003D7-Nf; Sat, 05 Oct 2019 18:10:23 +0000
Subject: Re: [PATCH] drm/amdkfd: add missing void argument to function
 kgd2kfd_init
To:     Colin King <colin.king@canonical.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191005175808.32018-1-colin.king@canonical.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7677a8bc-cc5a-eb03-c7d4-b1a27330126f@infradead.org>
Date:   Sat, 5 Oct 2019 11:10:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191005175808.32018-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/19 10:58 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Function kgd2kfd_init is missing a void argument, add it
> to clean up the non-ANSI function declaration.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

sparse reports 2 such warnings in amdgpu:

../drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_module.c:85:18: warning: non-ANSI function declaration of function 'kgd2kfd_init'
../drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c:168:60: warning: non-ANSI function declaration of function 'amdgpu_amdkfd_gfx_10_0_get_functions'

Thanks.

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_module.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> index 986ff52d5750..f4b7f7e6c40e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
> @@ -82,7 +82,7 @@ static void kfd_exit(void)
>  	kfd_chardev_exit();
>  }
>  
> -int kgd2kfd_init()
> +int kgd2kfd_init(void)
>  {
>  	return kfd_init();
>  }
> 


-- 
~Randy
