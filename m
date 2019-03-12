Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28367C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E982147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 15:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfCLPOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 11:14:50 -0400
Received: from mga03.intel.com ([134.134.136.65]:14262 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbfCLPOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 11:14:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2019 08:14:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,471,1544515200"; 
   d="scan'208";a="133677353"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.174])
  by fmsmga007.fm.intel.com with SMTP; 12 Mar 2019 08:14:44 -0700
Received: by stinkbox (sSMTP sendmail emulation); Tue, 12 Mar 2019 17:14:43 +0200
Date:   Tue, 12 Mar 2019 17:14:43 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v2] gpu: drm: atomic_helper: Fix spelling errors
Message-ID: <20190312151443.GE3888@intel.com>
References: <20190312003307.14116-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190312003307.14116-1-kieran.bingham+renesas@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 12:33:07AM +0000, Kieran Bingham wrote:
> Trivial fixes identified while working on the DRM code.
> 
>   s/artifically/artificially/
>   s/achive/achieve/
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> ---
> 
> v2: - Actually spell achieve correctly!

drm convention is to put this above the --- so that it gets included in
the commit msg.

With that
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>

> 
>  drivers/gpu/drm/drm_atomic_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 540a77a2ade9..2453678d1186 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1752,7 +1752,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
>  	 *
>  	 * NOTE: Commit work has multiple phases, first hardware commit, then
>  	 * cleanup. We want them to overlap, hence need system_unbound_wq to
> -	 * make sure work items don't artifically stall on each another.
> +	 * make sure work items don't artificially stall on each another.
>  	 */
>  
>  	drm_atomic_state_get(state);
> @@ -1786,7 +1786,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit);
>   *
>   * Asynchronous workers need to have sufficient parallelism to be able to run
>   * different atomic commits on different CRTCs in parallel. The simplest way to
> - * achive this is by running them on the &system_unbound_wq work queue. Note
> + * achieve this is by running them on the &system_unbound_wq work queue. Note
>   * that drivers are not required to split up atomic commits and run an
>   * individual commit in parallel - userspace is supposed to do that if it cares.
>   * But it might be beneficial to do that for modesets, since those necessarily
> -- 
> 2.19.1

-- 
Ville Syrjälä
Intel
