Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A459C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B72C218B0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbfDXQjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:39:12 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:59707 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbfDXQjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:39:11 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 87C59200A9;
        Wed, 24 Apr 2019 18:39:09 +0200 (CEST)
Date:   Wed, 24 Apr 2019 18:39:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Chen Feng <puck.chen@hisilicon.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xinliang Liu <z.liuxinliang@hisilicon.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        Rongrong Zou <zourongrong@gmail.com>
Subject: Re: [PATCH 02/25] drm: kirin: Remove HISI_KIRIN_DW_DSI config option
Message-ID: <20190424163908.GB20110@ravnborg.org>
References: <1556061656-1733-1-git-send-email-john.stultz@linaro.org>
 <1556061656-1733-3-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556061656-1733-3-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=BTeA3XvPAAAA:8
        a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=KKAkSRfTAAAA:8 a=lDplpNyqA4p3idxBvDsA:9
        a=CjuIK1q_8ugA:10 a=tafbbOV3vt1XuEhzTjGK:22 a=Vxmtnl_E_bksehYqCbjh:22
        a=cvBusfyB2V15izCimMoJ:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John.

On Tue, Apr 23, 2019 at 04:20:33PM -0700, John Stultz wrote:
> The CONFIG_HISI_KIRIN_DW_DSI option is only used w/ kirin
> driver, so cut out the middleman and condense the config
> logic down.
> 
> Cc: Xinliang Liu <z.liuxinliang@hisilicon.com>
> Cc: Rongrong Zou <zourongrong@gmail.com>
> Cc: Xinwei Kong <kong.kongxinwei@hisilicon.com>
> Cc: Chen Feng <puck.chen@hisilicon.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel <dri-devel@lists.freedesktop.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/gpu/drm/hisilicon/kirin/Kconfig  | 10 +---------
>  drivers/gpu/drm/hisilicon/kirin/Makefile |  4 ++--
>  2 files changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hisilicon/kirin/Kconfig b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> index 499f644..6ef7906 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/Kconfig
> +++ b/drivers/gpu/drm/hisilicon/kirin/Kconfig
> @@ -4,16 +4,8 @@ config DRM_HISI_KIRIN
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_CMA_HELPER
> -	select HISI_KIRIN_DW_DSI
> +	select DRM_MIPI_DSI
>  	help
>  	  Choose this option if you have a hisilicon Kirin chipsets(hi6220).
>  	  If M is selected the module will be called kirin-drm.
>  
> -config HISI_KIRIN_DW_DSI
> -	tristate "HiSilicon Kirin specific extensions for Synopsys DW MIPI DSI"
> -	depends on DRM_HISI_KIRIN
> -	select DRM_MIPI_DSI
> -	help
> -	 This selects support for HiSilicon Kirin SoC specific extensions for
> -	 the Synopsys DesignWare DSI driver. If you want to enable MIPI DSI on
> -	 hi6220 based SoC, you should selet this option.

Nice simplification. We are now down to two very small Kconfig files.
Consider to merge them into one Kconfig file in the top-level dir.

	Sam


> diff --git a/drivers/gpu/drm/hisilicon/kirin/Makefile b/drivers/gpu/drm/hisilicon/kirin/Makefile
> index cdf6158..3585327 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/Makefile
> +++ b/drivers/gpu/drm/hisilicon/kirin/Makefile
> @@ -1,6 +1,6 @@
>  kirin-drm-y := kirin_drm_drv.o \
> -	       kirin_drm_ade.o
> +	       kirin_drm_ade.o \
> +	       dw_drm_dsi.o
>  
>  obj-$(CONFIG_DRM_HISI_KIRIN) += kirin-drm.o
>  
> -obj-$(CONFIG_HISI_KIRIN_DW_DSI) += dw_drm_dsi.o
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
