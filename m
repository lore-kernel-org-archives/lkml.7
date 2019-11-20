Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B3FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11DF3224B2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 14:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfKTOPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 09:15:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:55596 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731594AbfKTOPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 09:15:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 06:15:42 -0800
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="200728666"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 06:15:39 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm: Fix Kconfig indentation
In-Reply-To: <20191120133640.11659-1-krzk@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191120133640.11659-1-krzk@kernel.org>
Date:   Wed, 20 Nov 2019 16:15:36 +0200
Message-ID: <874kyyy6pj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/gpu/drm/Kconfig | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 1168351267fd..ad1b6ecd2e08 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -94,18 +94,18 @@ config DRM_KMS_FB_HELPER
>  	  FBDEV helpers for KMS drivers.
>  
>  config DRM_DEBUG_DP_MST_TOPOLOGY_REFS
> -        bool "Enable refcount backtrace history in the DP MST helpers"
> -        select STACKDEPOT
> -        depends on DRM_KMS_HELPER
> -        depends on DEBUG_KERNEL
> -        depends on EXPERT
> -        help
> -          Enables debug tracing for topology refs in DRM's DP MST helpers. A
> -          history of each topology reference/dereference will be printed to the
> -          kernel log once a port or branch device's topology refcount reaches 0.
> -
> -          This has the potential to use a lot of memory and print some very
> -          large kernel messages. If in doubt, say "N".
> +	bool "Enable refcount backtrace history in the DP MST helpers"
> +	select STACKDEPOT
> +	depends on DRM_KMS_HELPER
> +	depends on DEBUG_KERNEL
> +	depends on EXPERT
> +	help
> +	  Enables debug tracing for topology refs in DRM's DP MST helpers. A
> +	  history of each topology reference/dereference will be printed to the
> +	  kernel log once a port or branch device's topology refcount reaches 0.
> +
> +	  This has the potential to use a lot of memory and print some very
> +	  large kernel messages. If in doubt, say "N".
>  
>  config DRM_FBDEV_EMULATION
>  	bool "Enable legacy fbdev support for your modesetting driver"
> @@ -234,8 +234,8 @@ config DRM_RADEON
>  	tristate "ATI Radeon"
>  	depends on DRM && PCI && MMU
>  	select FW_LOADER
> -        select DRM_KMS_HELPER
> -        select DRM_TTM
> +	select DRM_KMS_HELPER
> +	select DRM_TTM
>  	select POWER_SUPPLY
>  	select HWMON
>  	select BACKLIGHT_CLASS_DEVICE
> @@ -294,7 +294,7 @@ config DRM_VKMS
>  	  If M is selected the module will be called vkms.
>  
>  config DRM_ATI_PCIGART
> -        bool
> +	bool

This hunk is gone in drm-misc.

Other than that,

Reviewed-by: Jani Nikula <jani.nikula@intel.com>



>  
>  source "drivers/gpu/drm/exynos/Kconfig"

-- 
Jani Nikula, Intel Open Source Graphics Center
