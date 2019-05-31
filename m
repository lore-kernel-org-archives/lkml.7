Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DA9C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3319D26513
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 07:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfEaHhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 03:37:38 -0400
Received: from mga11.intel.com ([192.55.52.93]:41428 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfEaHhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 03:37:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 May 2019 00:37:38 -0700
X-ExtLoop1: 1
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2019 00:37:34 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 12/22] gpu: i915.rst: Fix references to renamed files
In-Reply-To: <5ecde05364284f6845b651297fd9ce8225af2bcd.1559171394.git.mchehab+samsung@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <cover.1559171394.git.mchehab+samsung@kernel.org> <5ecde05364284f6845b651297fd9ce8225af2bcd.1559171394.git.mchehab+samsung@kernel.org>
Date:   Fri, 31 May 2019 10:40:44 +0300
Message-ID: <87ftov3wcj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 May 2019, Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function Hardware workarounds ./drivers/gpu/drm/i915/intel_workarounds.c' failed with return code 1
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -function Logical Rings, Logical Ring Contexts and Execlists ./drivers/gpu/drm/i915/intel_lrc.c' failed with return code 1
> WARNING: kernel-doc './scripts/kernel-doc -rst -enable-lineno -internal ./drivers/gpu/drm/i915/intel_lrc.c' failed with return code 2
>
> Fixes: 112ed2d31a46 ("drm/i915: Move GraphicsTechnology files under gt/")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---
>  Documentation/gpu/i915.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index 055df45596c1..38fefeb99bba 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -61,7 +61,7 @@ Intel GVT-g Host Support(vGPU device model)
>  Workarounds
>  -----------
>  
> -.. kernel-doc:: drivers/gpu/drm/i915/intel_workarounds.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gt/selftest_workarounds.c
>     :doc: Hardware workarounds

Thanks for the patch. The basename should remain the same here.

I can pick up the updated version via drm-intel.

BR,
Jani.


>  
>  Display Hardware Handling
> @@ -379,10 +379,10 @@ User Batchbuffer Execution
>  Logical Rings, Logical Ring Contexts and Execlists
>  --------------------------------------------------
>  
> -.. kernel-doc:: drivers/gpu/drm/i915/intel_lrc.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_lrc.c
>     :doc: Logical Rings, Logical Ring Contexts and Execlists
>  
> -.. kernel-doc:: drivers/gpu/drm/i915/intel_lrc.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gt/intel_lrc.c
>     :internal:
>  
>  Global GTT views

-- 
Jani Nikula, Intel Open Source Graphics Center
