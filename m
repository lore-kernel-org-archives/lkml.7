Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EE4C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2433205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388214AbfDRGmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:42:20 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58622 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbfDRGmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:42:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id A4962280AFE
Subject: Re: [PATCH -next] drm/panfrost: Make panfrost_gem_free_object()
 static
To:     Steven Price <steven.price@arm.com>,
        Yue Haibing <yuehaibing@huawei.com>, robh@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20190416150051.34092-1-yuehaibing@huawei.com>
 <7c9d75dd-ec67-4491-ca0c-79743211f308@arm.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <9fc55e8c-f021-f235-69e3-25e8c82edb99@collabora.com>
Date:   Thu, 18 Apr 2019 08:42:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7c9d75dd-ec67-4491-ca0c-79743211f308@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both patches are:

Reviewed-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Thanks!

On 4/17/19 4:51 PM, Steven Price wrote:
> On 16/04/2019 16:00, Yue Haibing wrote:
>> From: YueHaibing <yuehaibing@huawei.com>
>>
>> Fix sparse warning:
>>
>> drivers/gpu/drm/panfrost/panfrost_gem.c:17:6:
>>   warning: symbol 'panfrost_gem_free_object' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Although while we're fixing sparse warnings, there's a few more in Panfrost:
> 
> -----8<-------
>  From 8aaf778262744cfbebb9b7f274ead9ba600526b0 Mon Sep 17 00:00:00 2001
> From: Steven Price <steven.price@arm.com>
> Date: Wed, 17 Apr 2019 15:47:49 +0100
> Subject: [PATCH] drm/panfrost: Add missing include
> 
> Fix sparse warnings:
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:133:5:
>   warning: symbol 'panfrost_devfreq_init' was not declared. Should it be static?
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:168:6:
>   warning: symbol 'panfrost_devfreq_resume' was not declared. Should it be static?
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:182:6:
>   warning: symbol 'panfrost_devfreq_suspend' was not declared. Should it be static?
> drivers/gpu/drm/panfrost/panfrost_devfreq.c:212:6:
>   warning: symbol 'panfrost_devfreq_record_transition' was not declared. Should it be static?
> 
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> index a8121ae67ee3..238bd1d89d43 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> @@ -7,6 +7,7 @@
>   #include <linux/regulator/consumer.h>
>   
>   #include "panfrost_device.h"
> +#include "panfrost_devfreq.h"
>   #include "panfrost_features.h"
>   #include "panfrost_issues.h"
>   #include "panfrost_gpu.h"
> 
