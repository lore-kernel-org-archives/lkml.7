Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67727C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3577B2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 13:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfK0NOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 08:14:14 -0500
Received: from mga01.intel.com ([192.55.52.88]:50810 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfK0NON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 08:14:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 05:13:53 -0800
X-IronPort-AV: E=Sophos;i="5.69,249,1571727600"; 
   d="scan'208";a="203069986"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2019 05:13:50 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] drm/vc4: Fix Kconfig indentation
In-Reply-To: <20191121132919.29430-1-krzk@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191121132919.29430-1-krzk@kernel.org>
Date:   Wed, 27 Nov 2019 15:13:47 +0200
Message-ID: <87k17lo41g.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Nov 2019, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
> 	$ sed -e 's/^        /\t/' -i */Kconfig

Btw have you updated checkpatch.pl to try to keep the Kconfigs from
bitrotting back to having different indentation? Or the config tools?

BR,
Jani.


>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/gpu/drm/vc4/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/vc4/Kconfig b/drivers/gpu/drm/vc4/Kconfig
> index 7c2317efd5b7..118e8a426b1a 100644
> --- a/drivers/gpu/drm/vc4/Kconfig
> +++ b/drivers/gpu/drm/vc4/Kconfig
> @@ -22,9 +22,9 @@ config DRM_VC4
>  	  our display setup.
>  
>  config DRM_VC4_HDMI_CEC
> -       bool "Broadcom VC4 HDMI CEC Support"
> -       depends on DRM_VC4
> -       select CEC_CORE
> -       help
> +	bool "Broadcom VC4 HDMI CEC Support"
> +	depends on DRM_VC4
> +	select CEC_CORE
> +	help
>  	  Choose this option if you have a Broadcom VC4 GPU
>  	  and want to use CEC.

-- 
Jani Nikula, Intel Open Source Graphics Center
