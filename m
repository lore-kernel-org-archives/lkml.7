Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F40C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:45:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB3F2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbfDXJpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:45:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40722 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbfDXJpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:45:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4DCAA78;
        Wed, 24 Apr 2019 02:45:14 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E4023F5AF;
        Wed, 24 Apr 2019 02:45:14 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id A267A68240D; Wed, 24 Apr 2019 10:45:12 +0100 (BST)
Date:   Wed, 24 Apr 2019 10:45:12 +0100
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "airlied@linux.ie" <airlied@linux.ie>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/komeda: Mark the local functions as static
Message-ID: <20190424094512.GY15144@e110455-lin.cambridge.arm.com>
References: <20190424055108.19390-1-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424055108.19390-1-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:51:45AM +0100, james qian wang (Arm Technology China) wrote:
> Fix the kbuild test rebot reported warnings:
> - symbol was not declared. Should it be static?
> - missing braces around initializer
> 
> Depends on:
> - https://patchwork.freedesktop.org/series/58976/
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> ---
>  .../gpu/drm/arm/display/komeda/d71/d71_component.c    |  9 +++++----
>  drivers/gpu/drm/arm/display/komeda/komeda_crtc.c      |  4 ++--
>  drivers/gpu/drm/arm/display/komeda/komeda_dev.c       |  4 +++-
>  drivers/gpu/drm/arm/display/komeda/komeda_drv.c       |  2 +-
>  drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c  |  2 +-
>  .../drm/arm/display/komeda/komeda_pipeline_state.c    | 11 ++++++-----
>  drivers/gpu/drm/arm/display/komeda/komeda_plane.c     | 10 ++++++----
>  7 files changed, 24 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> index c56cfc2de147..031e5f305a3c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> +++ b/drivers/gpu/drm/arm/display/komeda/d71/d71_component.c
> @@ -391,7 +391,7 @@ static void d71_compiz_dump(struct komeda_component *c, struct seq_file *sf)
>  	seq_printf(sf, "CU_USER_HIGH:\t\t0x%X\n", v[1]);
>  }
>  
> -struct komeda_component_funcs d71_compiz_funcs = {
> +static struct komeda_component_funcs d71_compiz_funcs = {
>  	.update		= d71_compiz_update,
>  	.disable	= d71_component_disable,
>  	.dump_register	= d71_compiz_dump,
> @@ -467,7 +467,7 @@ static void d71_improc_dump(struct komeda_component *c, struct seq_file *sf)
>  		seq_printf(sf, "IPS_RGB_YUV_COEFF%u:\t0x%X\n", i, v[i]);
>  }
>  
> -struct komeda_component_funcs d71_improc_funcs = {
> +static struct komeda_component_funcs d71_improc_funcs = {
>  	.update		= d71_improc_update,
>  	.disable	= d71_component_disable,
>  	.dump_register	= d71_improc_dump,
> @@ -543,7 +543,8 @@ static void d71_timing_ctrlr_update(struct komeda_component *c,
>  	malidp_write32(reg, BLK_CONTROL, value);
>  }
>  
> -void d71_timing_ctrlr_dump(struct komeda_component *c, struct seq_file *sf)
> +static void d71_timing_ctrlr_dump(struct komeda_component *c,
> +				  struct seq_file *sf)
>  {
>  	u32 v[8], i;
>  
> @@ -579,7 +580,7 @@ void d71_timing_ctrlr_dump(struct komeda_component *c, struct seq_file *sf)
>  	seq_printf(sf, "BS_USER:\t\t0x%X\n", v[4]);
>  }
>  
> -struct komeda_component_funcs d71_timing_ctrlr_funcs = {
> +static struct komeda_component_funcs d71_timing_ctrlr_funcs = {
>  	.update		= d71_timing_ctrlr_update,
>  	.disable	= d71_timing_ctrlr_disable,
>  	.dump_register	= d71_timing_ctrlr_dump,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index d335fec1b727..62fad59f5a6a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -52,7 +52,7 @@ komeda_crtc_atomic_check(struct drm_crtc *crtc,
>  	return 0;
>  }
>  
> -u32 komeda_calc_mclk(struct komeda_crtc_state *kcrtc_st)
> +static u32 komeda_calc_mclk(struct komeda_crtc_state *kcrtc_st)
>  {
>  	unsigned long mclk = kcrtc_st->base.adjusted_mode.clock * 1000;
>  
> @@ -350,7 +350,7 @@ static bool komeda_crtc_mode_fixup(struct drm_crtc *crtc,
>  	return true;
>  }
>  
> -struct drm_crtc_helper_funcs komeda_crtc_helper_funcs = {
> +static struct drm_crtc_helper_funcs komeda_crtc_helper_funcs = {
>  	.atomic_check	= komeda_crtc_atomic_check,
>  	.atomic_flush	= komeda_crtc_atomic_flush,
>  	.atomic_enable	= komeda_crtc_atomic_enable,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 9d6c31cca875..2075f4ac7078 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -73,9 +73,11 @@ config_id_show(struct device *dev, struct device_attribute *attr, char *buf)
>  {
>  	struct komeda_dev *mdev = dev_to_mdev(dev);
>  	struct komeda_pipeline *pipe = mdev->pipelines[0];
> -	union komeda_config_id config_id = {0,};
> +	union komeda_config_id config_id;
>  	int i;
>  
> +	config_id.value = 0;
> +
>  	config_id.max_line_sz = pipe->layers[0]->hsize_in.end;
>  	config_id.n_pipelines = mdev->n_pipelines;
>  	config_id.n_scalers = pipe->n_scalers;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index 0285fd37a016..cfa5068d9d1e 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -127,7 +127,7 @@ static const struct komeda_product_data komeda_products[] = {
>  	},
>  };
>  
> -const struct of_device_id komeda_of_match[] = {
> +static const struct of_device_id komeda_of_match[] = {
>  	{ .compatible = "arm,mali-d71", .data = &komeda_products[MALI_D71], },
>  	{},
>  };
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> index 07398efc40f5..c379439c6194 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> @@ -62,7 +62,7 @@ void komeda_pipeline_destroy(struct komeda_dev *mdev,
>  	devm_kfree(mdev->dev, pipe);
>  }
>  
> -struct komeda_component **
> +static struct komeda_component **
>  komeda_pipeline_get_component_pos(struct komeda_pipeline *pipe, int id)
>  {
>  	struct komeda_dev *mdev = pipe->mdev;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> index ae1c3773c4ef..36570d7dad61 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline_state.c
> @@ -20,7 +20,7 @@ static inline bool is_switching_user(void *old, void *new)
>  	return old != new;
>  }
>  
> -struct komeda_pipeline_state *
> +static struct komeda_pipeline_state *
>  komeda_pipeline_get_state(struct komeda_pipeline *pipe,
>  			  struct drm_atomic_state *state)
>  {
> @@ -45,7 +45,7 @@ komeda_pipeline_get_old_state(struct komeda_pipeline *pipe,
>  	return NULL;
>  }
>  
> -struct komeda_pipeline_state *
> +static struct komeda_pipeline_state *
>  komeda_pipeline_get_new_state(struct komeda_pipeline *pipe,
>  			      struct drm_atomic_state *state)
>  {
> @@ -58,7 +58,7 @@ komeda_pipeline_get_new_state(struct komeda_pipeline *pipe,
>  }
>  
>  /* Assign pipeline for crtc */
> -struct komeda_pipeline_state *
> +static struct komeda_pipeline_state *
>  komeda_pipeline_get_state_and_set_crtc(struct komeda_pipeline *pipe,
>  				       struct drm_atomic_state *state,
>  				       struct drm_crtc *crtc)
> @@ -505,8 +505,9 @@ int komeda_build_display_data_flow(struct komeda_crtc *kcrtc,
>  	return 0;
>  }
>  
> -void komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
> -					struct komeda_pipeline_state *new)
> +static void
> +komeda_pipeline_unbound_components(struct komeda_pipeline *pipe,
> +				   struct komeda_pipeline_state *new)
>  {
>  	struct drm_atomic_state *drm_st = new->obj.state;
>  	struct komeda_pipeline_state *old = priv_to_pipe_st(pipe->obj.state);
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index 46654f0be73d..07ed0cc1bc44 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -47,8 +47,9 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
>   * RETURNS:
>   * Zero for success or -errno
>   */
> -int komeda_plane_atomic_check(struct drm_plane *plane,
> -			      struct drm_plane_state *state)
> +static int
> +komeda_plane_atomic_check(struct drm_plane *plane,
> +			  struct drm_plane_state *state)
>  {
>  	struct komeda_plane *kplane = to_kplane(plane);
>  	struct komeda_plane_state *kplane_st = to_kplane_st(state);
> @@ -87,8 +88,9 @@ int komeda_plane_atomic_check(struct drm_plane *plane,
>  /* plane doesn't represent a real HW, so there is no HW update for plane.
>   * komeda handles all the HW update in crtc->atomic_flush
>   */
> -void komeda_plane_atomic_update(struct drm_plane *plane,
> -				struct drm_plane_state *old_state)
> +static void
> +komeda_plane_atomic_update(struct drm_plane *plane,
> +			   struct drm_plane_state *old_state)
>  {
>  }
>  
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
