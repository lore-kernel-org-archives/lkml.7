Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10142C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A112087C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 14:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Pg47Pfne";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="IO2AZz6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbfC0Orn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 10:47:43 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfC0Orm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 10:47:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D53B761112; Wed, 27 Mar 2019 14:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553698061;
        bh=fhtb43R3oc+3c8T5J+o3P7q35SsRMxhavQBMvJmNqxM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Pg47PfneHLXWjcTQx++ruQGTCn9v1QImT9o+0HNU3eLLQa9qgoYccQ4/KAtaP4H89
         GNqiMuhAhzgxmLtw0S0yDyLU4vfnmiPJNmV0AW9gIH9n54N24kaOSm7u+R8kmPO+El
         24cMwFFhYH/NheDb69+a23MasLi0sZjWK8rOlZEY=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3B6960DB2;
        Wed, 27 Mar 2019 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553698060;
        bh=fhtb43R3oc+3c8T5J+o3P7q35SsRMxhavQBMvJmNqxM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=IO2AZz6gHc+96JUmyZQ9GAo4lSo1D5nv4iEkeU80lZg9JVTBf3DUeUCbzx+awC5vw
         GXPDjvd0mbRFKdINHvew48oeaq4X4K5SBdUjXmwWIV+bQfPBIMpBMzACnGW35S7hEw
         UPyrVVRVPqst2wAUXOQT3Zdgli1GoknrcSBi0yrE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3B6960DB2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2 -next] drm/virtio: remove set but not used variable
 'vgdev'
To:     YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190320020308.12745-1-yuehaibing@huawei.com>
 <20190325092631.152060-1-yuehaibing@huawei.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <17e9a0c2-63dd-ac97-49c6-aa70b5c8d221@codeaurora.org>
Date:   Wed, 27 Mar 2019 20:17:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190325092631.152060-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/25/2019 2:56 PM, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_init_mem_type':
> drivers/gpu/drm/virtio/virtgpu_ttm.c:117:28: warning:
>   variable 'vgdev' set but not used [-Wunused-but-set-variable]
>
> drivers/gpu/drm/virtio/virtgpu_ttm.c: In function 'virtio_gpu_bo_swap_notify':
> drivers/gpu/drm/virtio/virtgpu_ttm.c:300:28: warning:
>   variable 'vgdev' set but not used [-Wunused-but-set-variable]
>
> It is never used since introduction in dc5698e80cf7 ("Add virtio gpu driver.")
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
> v2: fix patch prefix
> ---
>   drivers/gpu/drm/virtio/virtgpu_ttm.c | 6 ------
>   1 file changed, 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_ttm.c b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> index d6225ba20b30..eb007c2569d8 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_ttm.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_ttm.c
> @@ -114,10 +114,6 @@ static const struct ttm_mem_type_manager_func virtio_gpu_bo_manager_func = {
>   static int virtio_gpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
>   				    struct ttm_mem_type_manager *man)
>   {
> -	struct virtio_gpu_device *vgdev;
> -
> -	vgdev = virtio_gpu_get_vgdev(bdev);
> -
>   	switch (type) {
>   	case TTM_PL_SYSTEM:
>   		/* System memory */
> @@ -297,10 +293,8 @@ static void virtio_gpu_bo_move_notify(struct ttm_buffer_object *tbo,
>   static void virtio_gpu_bo_swap_notify(struct ttm_buffer_object *tbo)
>   {
>   	struct virtio_gpu_object *bo;
> -	struct virtio_gpu_device *vgdev;
>   
>   	bo = container_of(tbo, struct virtio_gpu_object, tbo);
> -	vgdev = (struct virtio_gpu_device *)bo->gem_base.dev->dev_private;
>   
>   	if (bo->pages)
>   		virtio_gpu_object_free_sg_table(bo);
>
>
>
