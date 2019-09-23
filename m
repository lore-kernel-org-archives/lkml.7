Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C5DC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A91B2133F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 01:27:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391167AbfIWB1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 21:27:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44888 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390427AbfIWB1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 21:27:01 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 97764126F67C08ABC820;
        Mon, 23 Sep 2019 09:26:59 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 09:26:53 +0800
Message-ID: <5D881F5C.2070305@huawei.com>
Date:   Mon, 23 Sep 2019 09:26:52 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     zhong jiang <zhongjiang@huawei.com>
CC:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <sean@poorly.run>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/vkms: Fix an undefined reference error in vkms_composer_worker
References: <1569201671-18489-1-git-send-email-zhongjiang@huawei.com>
In-Reply-To: <1569201671-18489-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please ignore the patch,  author is incorrect, will repost.  Thanks

Sincerely,
zhong jiang
On 2019/9/23 9:21, zhong jiang wrote:
> From: YueHaibing <yuehaibing@huawei.com>
>
> I hit the following error when compile the kernel.
>
> drivers/gpu/drm/vkms/vkms_composer.o: In function `vkms_composer_worker':
> vkms_composer.c:(.text+0x5e4): undefined reference to `crc32_le'
> make: *** [vmlinux] Error 1
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/gpu/drm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index e67c194..285d649 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -257,6 +257,7 @@ config DRM_VKMS
>  	tristate "Virtual KMS (EXPERIMENTAL)"
>  	depends on DRM
>  	select DRM_KMS_HELPER
> +	select CRC32
>  	default n
>  	help
>  	  Virtual Kernel Mode-Setting (VKMS) is used for testing or for


