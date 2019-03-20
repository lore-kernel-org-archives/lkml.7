Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD7DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58F12184E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 09:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCTJNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 05:13:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42785 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfCTJNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 05:13:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id j89so1284255edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 02:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=34etkHC+iTSSePavYS5sRw+5vlfv2pSZEzOlLSh7XjY=;
        b=nq5gapy2aZunylLanQtsXrBUhbCSAjTq6nskOZEuzRhVF7VBMlJsnf8LQz4ReAM2r8
         VCZcagM7kdY6Me6yPhR2yi4S6UbNnUHjMkAPPYCJ0BCCRIPGr0Jd0ZeF/263gBecHi+d
         ZearaJYtcacQNE+27A3mzQOZOvkT6NlHq/6fRBao2JAwhyh/ObIQn4kMZKWM2mCrwik2
         q4FAdytbGtTeMJQdkQQS/P3zGr6wAxVVd7X/wvC+hYMMDKHdcPYjU/gQY6tcCLcBnn4o
         xMdNexdVq7M5A/V1EIco4yhRBFdYXvAEIFoHVuDxXQLiUYAv/AWIyww0h3cRvI0t3fjl
         xrjQ==
X-Gm-Message-State: APjAAAXgxil3kGP1mFm9t02oG2cN+bA0N9Ni8jU+kj0x9VtIS/gFkvir
        OK7T9DYb0DXi+R+PEeL6RWbq2A==
X-Google-Smtp-Source: APXvYqzb/nYdJORa9gKIi+r9nqyMDPIYnAthFIq31Hh6osabqN5vpNTWl46HAF0G4E2UI9vkL1i7OA==
X-Received: by 2002:a50:c01a:: with SMTP id r26mr19320647edb.203.1553073226226;
        Wed, 20 Mar 2019 02:13:46 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id x22sm287916eje.48.2019.03.20.02.13.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 02:13:45 -0700 (PDT)
Subject: Re: [PATCH -next] drm/vboxvideo: Remove unused including
 <linux/version.h>
To:     YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20190320015429.86347-1-yuehaibing@huawei.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9607344f-7312-0ceb-7744-d3084efda16c@redhat.com>
Date:   Wed, 20 Mar 2019 10:13:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190320015429.86347-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20-03-19 02:54, YueHaibing wrote:
> Remove including <linux/version.h> that don't need it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thank you for the patch, it looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

I will pick this up and push it to drm-misc-next

Regards,

Hans

> ---
>   drivers/gpu/drm/vboxvideo/vbox_drv.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/vboxvideo/vbox_drv.h b/drivers/gpu/drm/vboxvideo/vbox_drv.h
> index 6dea8bf5f045..ece31f395540 100644
> --- a/drivers/gpu/drm/vboxvideo/vbox_drv.h
> +++ b/drivers/gpu/drm/vboxvideo/vbox_drv.h
> @@ -14,7 +14,6 @@
>   #include <linux/io.h>
>   #include <linux/irqreturn.h>
>   #include <linux/string.h>
> -#include <linux/version.h>
>   
>   #include <drm/drm_encoder.h>
>   #include <drm/drm_fb_helper.h>
> 
> 
> 
> 
> 
