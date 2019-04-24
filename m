Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FFC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7842089F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfDXKCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:02:20 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:40930 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDXKCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:02:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9247A78;
        Wed, 24 Apr 2019 03:02:19 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 921113F5AF;
        Wed, 24 Apr 2019 03:02:19 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id CD37E68240F; Wed, 24 Apr 2019 11:02:17 +0100 (BST)
Date:   Wed, 24 Apr 2019 11:02:17 +0100
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
Subject: Re: [PATCH v2] drm/komeda: Fixed warning: Function parameter or
 member not described
Message-ID: <20190424100217.GZ15144@e110455-lin.cambridge.arm.com>
References: <20190424054741.19213-1-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190424054741.19213-1-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 06:48:11AM +0100, james qian wang (Arm Technology China) wrote:
> From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
> 
> Fixed the warnings: Function parameter or member 'xxx' not described
> when make htmldocs
> 
> This patch depends on:
> - https://patchwork.freedesktop.org/series/54448/
> - https://patchwork.freedesktop.org/series/54449/
> - https://patchwork.freedesktop.org/series/54450/
> 
> v2: Rebase and add reporter
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 14 ++++--
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   | 16 +++++--
>  .../arm/display/komeda/komeda_framebuffer.h   |  9 +++-
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   | 18 ++++++--
>  .../drm/arm/display/komeda/komeda_pipeline.h  | 43 ++++++++++++++-----
>  .../gpu/drm/arm/display/komeda/komeda_plane.c |  8 ++++
>  6 files changed, 85 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> index 053b1e3e74be..d335fec1b727 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
> @@ -18,9 +18,17 @@
>  #include "komeda_dev.h"
>  #include "komeda_kms.h"
>  
> -/* crtc_atomic_check is the final check stage, so beside build a display data
> - * pipeline according the crtc_state, but still needs to release/disable the
> - * unclaimed pipeline resources.
> +/**
> + * komeda_crtc_atomic_check - build display output data flow
> + * @crtc: DRM crtc
> + * @state: the crtc state object
> + *
> + * crtc_atomic_check is the final check stage, so beside build a display data
> + * pipeline according to the crtc_state, but still needs to release or disable
> + * the unclaimed pipeline resources.
> + *
> + * RETURNS:
> + * Zero for success or -errno
>   */
>  static int
>  komeda_crtc_atomic_check(struct drm_crtc *crtc,
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index 0c3e32b596d9..29e03c4e1ffc 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -120,7 +120,7 @@ struct komeda_dev_funcs {
>  		      int master_pipe, u32 active_pipes);
>  };
>  
> -/**
> +/*
>   * DISPLAY_MODE describes how many display been enabled, and which will be
>   * passed to CHIP by &komeda_dev_funcs->change_opmode(), then CHIP can do the
>   * pipeline resources assignment according to this usage hint.
> @@ -145,24 +145,31 @@ enum {
>   * control-abilites of device.
>   */
>  struct komeda_dev {
> +	/** @dev: the base device structure */
>  	struct device *dev;
> +	/** @reg_base: the base address of komeda io space */
>  	u32 __iomem   *reg_base;
>  
> +	/** @chip: the basic chip information */
>  	struct komeda_chip_info chip;
>  	/** @fmt_tbl: initialized by &komeda_dev_funcs->init_format_table */
>  	struct komeda_format_caps_table fmt_tbl;
>  	/** @pclk: APB clock for register access */
>  	struct clk *pclk;
> -	/** @mck: HW main engine clk */
> +	/** @mclk: HW main engine clk */
>  	struct clk *mclk;
>  
>  	/** @irq: irq number */
>  	int irq;
>  
> -	struct mutex lock; /* used to protect dpmode */
> -	u32 dpmode; /* current display mode */
> +	/** @lock: used to protect dpmode */
> +	struct mutex lock;
> +	/** @dpmode: current display mode */
> +	u32 dpmode;
>  
> +	/** @n_pipelines: the number of pipe in @pipelines */
>  	int n_pipelines;
> +	/** @pipelines: the komeda pipelines */
>  	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
>  
>  	/** @funcs: chip funcs to access to HW */
> @@ -175,6 +182,7 @@ struct komeda_dev {
>  	 */
>  	void *chip_data;
>  
> +	/** @debugfs_root: root directory of komeda debugfs */
>  	struct dentry *debugfs_root;
>  };
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> index 0de2e4a2afd2..ea2fe190c1e3 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_framebuffer.h
> @@ -10,11 +10,16 @@
>  #include <drm/drm_framebuffer.h>
>  #include "komeda_format_caps.h"
>  
> -/** struct komeda_fb - entend drm_framebuffer with komeda attribute */
> +/**
> + * struct komeda_fb - Entending drm_framebuffer with komeda attribute
> + */
>  struct komeda_fb {
>  	/** @base: &drm_framebuffer */
>  	struct drm_framebuffer base;
> -	/* @format_caps: &komeda_format_caps */
> +	/**
> +	 * @format_caps:
> +	 * extends drm_format_info for komeda specific information
> +	 */
>  	const struct komeda_format_caps *format_caps;
>  	/** @aligned_w: aligned frame buffer width */
>  	u32 aligned_w;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> index 7ec571d3c240..ac3d9209b4d9 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_kms.h
> @@ -15,7 +15,9 @@
>  #include <video/videomode.h>
>  #include <video/display_timing.h>
>  
> -/** struct komeda_plane - komeda instance of drm_plane */
> +/**
> + * struct komeda_plane - komeda instance of drm_plane
> + */
>  struct komeda_plane {
>  	/** @base: &drm_plane */
>  	struct drm_plane base;
> @@ -71,11 +73,13 @@ struct komeda_crtc {
>  	 */
>  	struct komeda_pipeline *slave;
>  
> -	/* this flip_done is for tracing the disable */
> +	/** @disable_done: this flip_done is for tracing the disable */
>  	struct completion *disable_done;
>  };
>  
> -/** struct komeda_crtc_state */
> +/**
> + * struct komeda_crtc_state
> + */
>  struct komeda_crtc_state {
>  	/** @base: &drm_crtc_state */
>  	struct drm_crtc_state base;
> @@ -83,7 +87,15 @@ struct komeda_crtc_state {
>  	/* private properties */
>  
>  	/* computed state which are used by validate/check */
> +	/**
> +	 * @affected_pipes:
> +	 * the affected pipelines in once display instance
> +	 */
>  	u32 affected_pipes;
> +	/**
> +	 * @active_pipes:
> +	 * the active pipelines in once display instance
> +	 */
>  	u32 active_pipes;
>  };
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index 233e512319e8..b1f813a349a4 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -90,32 +90,35 @@ struct komeda_component {
>  	u32 __iomem *reg;
>  	/** @id: component id */
>  	u32 id;
> -	/** @hw_ic: component hw id,
> -	 *  which is initialized by chip and used by chip only
> +	/**
> +	 * @hw_id: component hw id,
> +	 * which is initialized by chip and used by chip only
>  	 */
>  	u32 hw_id;
>  
>  	/**
>  	 * @max_active_inputs:
> -	 * @max_active_outpus:
> +	 * @max_active_outputs:
>  	 *
> -	 * maximum number of inputs/outputs that can be active in the same time
> +	 * maximum number of inputs/outputs that can be active at the same time
>  	 * Note:
>  	 * the number isn't the bit number of @supported_inputs or
>  	 * @supported_outputs, but may be less than it, since component may not
>  	 * support enabling all @supported_inputs/outputs at the same time.
>  	 */
>  	u8 max_active_inputs;
> +	/** @max_active_outputs: maximum number of outputs */
>  	u8 max_active_outputs;
>  	/**
>  	 * @supported_inputs:
>  	 * @supported_outputs:
>  	 *
> -	 * bitmask of BIT(component->id) for the supported inputs/outputs
> +	 * bitmask of BIT(component->id) for the supported inputs/outputs,
>  	 * describes the possibilities of how a component is linked into a
>  	 * pipeline.
>  	 */
>  	u32 supported_inputs;
> +	/** @supported_outputs: bitmask of supported output componenet ids */
>  	u32 supported_outputs;
>  
>  	/**
> @@ -134,7 +137,8 @@ struct komeda_component {
>  struct komeda_component_output {
>  	/** @component: indicate which component the data comes from */
>  	struct komeda_component *component;
> -	/** @output_port:
> +	/**
> +	 * @output_port:
>  	 * the output port of the &komeda_component_output.component
>  	 */
>  	u8 output_port;
> @@ -150,11 +154,12 @@ struct komeda_component_output {
>  struct komeda_component_state {
>  	/** @obj: tracking component_state by drm_atomic_state */
>  	struct drm_private_state obj;
> +	/** @component: backpointer to the component */
>  	struct komeda_component *component;
>  	/**
>  	 * @binding_user:
> -	 * currently bound user, the user can be crtc/plane/wb_conn, which is
> -	 * valid decided by @component and @inputs
> +	 * currently bound user, the user can be @crtc, @plane or @wb_conn,
> +	 * which is valid decided by @component and @inputs
>  	 *
>  	 * -  Layer: its user always is plane.
>  	 * -  compiz/improc/timing_ctrlr: the user is crtc.
> @@ -162,20 +167,24 @@ struct komeda_component_state {
>  	 * -  scaler: plane when input is layer, wb_conn if input is compiz.
>  	 */
>  	union {
> +		/** @crtc: backpointer for user crtc */
>  		struct drm_crtc *crtc;
> +		/** @plane: backpointer for user plane */
>  		struct drm_plane *plane;
> +		/** @wb_conn: backpointer for user wb_connector  */
>  		struct drm_connector *wb_conn;
>  		void *binding_user;
>  	};
> +
>  	/**
>  	 * @active_inputs:
>  	 *
>  	 * active_inputs is bitmask of @inputs index
>  	 *
> -	 * -  active_inputs = changed_active_inputs + unchanged_active_inputs
> -	 * -  affected_inputs = old->active_inputs + new->active_inputs;
> +	 * -  active_inputs = changed_active_inputs | unchanged_active_inputs
> +	 * -  affected_inputs = old->active_inputs | new->active_inputs;
>  	 * -  disabling_inputs = affected_inputs ^ active_inputs;
> -	 * -  changed_inputs = disabling_inputs + changed_active_inputs;
> +	 * -  changed_inputs = disabling_inputs | changed_active_inputs;
>  	 *
>  	 * NOTE:
>  	 * changed_inputs doesn't include all active_input but only
> @@ -183,7 +192,9 @@ struct komeda_component_state {
>  	 * level for dirty update.
>  	 */
>  	u16 active_inputs;
> +	/** @changed_active_inputs: bitmask of the changed @active_inputs */
>  	u16 changed_active_inputs;
> +	/** @affected_inputs: bitmask for affected @inputs */
>  	u16 affected_inputs;
>  	/**
>  	 * @inputs:
> @@ -319,14 +330,23 @@ struct komeda_pipeline {
>  	int id;
>  	/** @avail_comps: available components mask of pipeline */
>  	u32 avail_comps;
> +	/** @n_layers: the number of layer on @layers */
>  	int n_layers;
> +	/** @layers: the pipeline layers */
>  	struct komeda_layer *layers[KOMEDA_PIPELINE_MAX_LAYERS];
> +	/** @n_scalers: the number of scaler on @scalers */
>  	int n_scalers;
> +	/** @scalers: the pipeline scalers */
>  	struct komeda_scaler *scalers[KOMEDA_PIPELINE_MAX_SCALERS];
> +	/** @compiz: compositor */
>  	struct komeda_compiz *compiz;
> +	/** @wb_layer: writeback layer */
>  	struct komeda_layer  *wb_layer;
> +	/** @improc: post image processor */
>  	struct komeda_improc *improc;
> +	/** @ctrlr: timing controller */
>  	struct komeda_timing_ctrlr *ctrlr;
> +	/** @funcs: chip pipeline functions */
>  	struct komeda_pipeline_funcs *funcs; /* private pipeline functions */
>  
>  	/** @of_node: pipeline dt node */
> @@ -347,6 +367,7 @@ struct komeda_pipeline {
>  struct komeda_pipeline_state {
>  	/** @obj: tracking pipeline_state by drm_atomic_state */
>  	struct drm_private_state obj;
> +	/** @pipe: backpointer to the pipeline */
>  	struct komeda_pipeline *pipe;
>  	/** @crtc: currently bound crtc */
>  	struct drm_crtc *crtc;
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> index ffcd3d08b5d3..46654f0be73d 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_plane.c
> @@ -39,6 +39,14 @@ komeda_plane_init_data_flow(struct drm_plane_state *st,
>  	return 0;
>  }
>  
> +/**
> + * komeda_plane_atomic_check - build input data flow
> + * @plane: DRM plane
> + * @state: the plane state object
> + *
> + * RETURNS:
> + * Zero for success or -errno
> + */
>  int komeda_plane_atomic_check(struct drm_plane *plane,
>  			      struct drm_plane_state *state)
>  {
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
