Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A28C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F3321734
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgABH4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:56:50 -0500
Received: from mga02.intel.com ([134.134.136.20]:2039 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727663AbgABH4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:56:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 23:56:49 -0800
X-IronPort-AV: E=Sophos;i="5.69,386,1571727600"; 
   d="scan'208";a="214081987"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Jan 2020 23:56:47 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Ma Feng <mafeng.ma@huawei.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/i915: use true,false for bool variable in i915_debugfs.c
In-Reply-To: <1577175170-93230-1-git-send-email-mafeng.ma@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <1577175170-93230-1-git-send-email-mafeng.ma@huawei.com>
Date:   Thu, 02 Jan 2020 09:56:44 +0200
Message-ID: <87k16auw8z.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Dec 2019, Ma Feng <mafeng.ma@huawei.com> wrote:
> Fixes coccicheck warning:
>
> drivers/gpu/drm/i915/i915_debugfs.c:3078:4-36: WARNING: Assignment of 0/1 to bool variable
> drivers/gpu/drm/i915/i915_debugfs.c:3078:4-36: WARNING: Assignment of 0/1 to bool variable
> drivers/gpu/drm/i915/i915_debugfs.c:3080:4-36: WARNING: Assignment of 0/1 to bool variable
> drivers/gpu/drm/i915/i915_debugfs.c:3080:4-36: WARNING: Assignment of 0/1 to bool variable
>

Thanks for the patches, but please resend either as a proper threaded
series or unthreaded single patches. Patchwork did not recognize this,
and failed to queue tests.

Sorry for the inconvenience.

BR,
Jani.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ma Feng <mafeng.ma@huawei.com>
> ---
>  drivers/gpu/drm/i915/i915_debugfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
> index d28468e..4ead86a 100644
> --- a/drivers/gpu/drm/i915/i915_debugfs.c
> +++ b/drivers/gpu/drm/i915/i915_debugfs.c
> @@ -3075,9 +3075,9 @@ static ssize_t i915_displayport_test_active_write(struct file *file,
>  			 * testing code, only accept an actual value of 1 here
>  			 */
>  			if (val == 1)
> -				intel_dp->compliance.test_active = 1;
> +				intel_dp->compliance.test_active = true;
>  			else
> -				intel_dp->compliance.test_active = 0;
> +				intel_dp->compliance.test_active = false;
>  		}
>  	}
>  	drm_connector_list_iter_end(&conn_iter);
> --
> 2.6.2
>

-- 
Jani Nikula, Intel Open Source Graphics Center
