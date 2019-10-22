Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334D8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD4B20684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388328AbfJVIQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:16:57 -0400
Received: from mga11.intel.com ([192.55.52.93]:65139 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387928AbfJVIQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:16:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 01:16:56 -0700
X-IronPort-AV: E=Sophos;i="5.67,326,1566889200"; 
   d="scan'208";a="191387159"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Oct 2019 01:16:53 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <treding@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH] drm/scdc: Fix typo in bit definition of SCDC_STATUS_FLAGS
In-Reply-To: <20191016123342.19119-1-patrik.r.jakobsson@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191016123342.19119-1-patrik.r.jakobsson@gmail.com>
Date:   Tue, 22 Oct 2019 11:16:51 +0300
Message-ID: <87lftdfb4c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2019, Patrik Jakobsson <patrik.r.jakobsson@gmail.com> wrote:
> Fix typo where bits got compared (x < y) instead of shifted (x << y).

Fixes: 3ad33ae2bc80 ("drm: Add SCDC helpers")
Cc: Thierry Reding <treding@nvidia.com>

> Signed-off-by: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
> ---
>  include/drm/drm_scdc_helper.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/drm/drm_scdc_helper.h b/include/drm/drm_scdc_helper.h
> index f92eb2094d6b..6a483533aae4 100644
> --- a/include/drm/drm_scdc_helper.h
> +++ b/include/drm/drm_scdc_helper.h
> @@ -50,9 +50,9 @@
>  #define  SCDC_READ_REQUEST_ENABLE (1 << 0)
>  
>  #define SCDC_STATUS_FLAGS_0 0x40
> -#define  SCDC_CH2_LOCK (1 < 3)
> -#define  SCDC_CH1_LOCK (1 < 2)
> -#define  SCDC_CH0_LOCK (1 < 1)
> +#define  SCDC_CH2_LOCK (1 << 3)
> +#define  SCDC_CH1_LOCK (1 << 2)
> +#define  SCDC_CH0_LOCK (1 << 1)
>  #define  SCDC_CH_LOCK_MASK (SCDC_CH2_LOCK | SCDC_CH1_LOCK | SCDC_CH0_LOCK)
>  #define  SCDC_CLOCK_DETECT (1 << 0)

-- 
Jani Nikula, Intel Open Source Graphics Center
