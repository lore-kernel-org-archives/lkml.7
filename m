Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BD0C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4251C20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Xzib2lEN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbfDDKQI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:16:08 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:49194 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfDDKQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:16:08 -0400
Received: from pendragon.ideasonboard.com (dfj612yhrgyx302h3jwwy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:ce28:277f:58d7:3ca4])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8043154B;
        Thu,  4 Apr 2019 12:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1554372965;
        bh=8W9GHmw9bPbZKSj5S9vdb+51GOROgSHOwAKvRKFHkn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xzib2lENtHiD9BBXdTc+129XeW11Vn5ehUWUbzQNzmKDBevNjsl0L5xIh/3jzJ99m
         jn3Bw4jhKsRwRTmMo55XOb5I6pAfhXr+ByG+MyxHROhWyywkU3id8WHMxy2WcJ3n/f
         qlAiDUw4A57/lqyyMrKnOADzQKGXrDc67Bto/vak=
Date:   Thu, 4 Apr 2019 13:15:54 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     VenkataRajesh.Kalakodima@in.bosch.com
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Harsha M M <harsha.manjulamallikarjun@in.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [PATCH 3/8] drm: rcar-du: Give a name to clu table samples
Message-ID: <20190404101554.GF5800@pendragon.ideasonboard.com>
References: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
 <1554297284-14009-4-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554297284-14009-4-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalakodima,

Thank you for the patch.

PAtches 3/8, 4/8 and 5/8 modify the new
drivers/gpu/drm/rcar-du/rcar_du_cmm.c a file that was introduced in 1/8.
Please squash them all together, there's no point in adding a driver
with known to be incorrect code to then fix it in other patches.

On Wed, Apr 03, 2019 at 06:44:39PM +0530, VenkataRajesh.Kalakodima@in.bosch.com wrote:
> From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> 
> Replace the hardcoded value of clu table sample count with a
> meaningful name.
> 
> Signed-off-by: Harsha M M <harsha.manjulamallikarjun@in.bosch.com>
> 
> This is the out-of-tree patch for DU CMM driver support from
>     Yocto release v3.6.0. The part of this patch adding CMM support to
>     the new Rcar E3 (R8A77990) SoC was filtered out due to lack of
>     Yocto v3.6.0 (i.e. rcar-3.6.2) kernel updates on staging-414.
> 
>     Link: https://github.com/renesas-rcar/du_cmm/commit/53973b806881ed8f54500b0d42bdc40aaca60476.patch
> 
>     Following is from the patch description:
> 
>     Subject: [PATCH] du_cmm: Release for Yocto v3.6.0
> 
>     This patch made the following correspondence.
> 
>       - R-Car E3(R8A77990) device support.
>       - Fix rewritting of parameter procedure in rcar_du_cmm_postclose
> 
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
>       - Resolved checkpatch errors
>       - Resolved merge conflicts according to latest version
> 
> Signed-off-by: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_cmm.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> index ac613a6e..d380dd9 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_cmm.c
> @@ -75,9 +75,9 @@
>  #include <linux/clk.h>
>  
>  /* #define DEBUG_PROCE_TIME 1 */
> -
> +#define CMM_CLU_SAMPLES 17
>  #define CMM_LUT_NUM 256
> -#define CMM_CLU_NUM (17 * 17 * 17)
> +#define CMM_CLU_NUM (CMM_CLU_SAMPLES * CMM_CLU_SAMPLES * CMM_CLU_SAMPLES)
>  #define CMM_HGO_NUM 64
>  /* rcar_du_drm.h Include */
>  #define LUT_DOUBLE_BUFFER_AUTO		0
> @@ -211,11 +211,11 @@ static inline u32 index_to_clu_data(int index)
>  {
>  	int r, g, b;
>  
> -	r = index % 17;
> -	index /= 17;
> -	g = index % 17;
> -	index /= 17;
> -	b = index % 17;
> +	r = index % CMM_CLU_SAMPLES;
> +	index /= CMM_CLU_SAMPLES;
> +	g = index % CMM_CLU_SAMPLES;
> +	index /= CMM_CLU_SAMPLES;
> +	b = index % CMM_CLU_SAMPLES;
>  
>  	r = (r << 20);
>  	if (r > (255 << 16))
> @@ -630,9 +630,9 @@ static int clu_table_copy(struct rcar_du_cmm *du_cmm)
>  	}
>  
>  	rcar_du_cmm_write(du_cmm, dst_addr, 0);
> -	for (i = 0; i < 17; i++) {
> -		for (j = 0; j < 17; j++) {
> -			for (k = 0; k < 17; k++) {
> +	for (i = 0; i < CMM_CLU_SAMPLES; i++) {
> +		for (j = 0; j < CMM_CLU_SAMPLES; j++) {
> +			for (k = 0; k < CMM_CLU_SAMPLES; k++) {
>  				rcar_du_cmm_write(du_cmm, src_addr,
>  						  (k << 16) | (j << 8) |
>  						  (i << 0));
> @@ -912,9 +912,9 @@ int rcar_du_cmm_pm_suspend(struct rcar_du_crtc *rcrtc)
>  	}
>  
>  	index = 0;
> -	for (i = 0; i < 17; i++) {
> -		for (j = 0; j < 17; j++) {
> -			for (k = 0; k < 17; k++) {
> +	for (i = 0; i < CMM_CLU_SAMPLES; i++) {
> +		for (j = 0; j < CMM_CLU_SAMPLES; j++) {
> +			for (k = 0; k < CMM_CLU_SAMPLES; k++) {
>  				rcar_du_cmm_write(du_cmm, CMM_CLU_ADDR,
>  						  (k << 16) | (j << 8) |
>  						  (i << 0));
> @@ -1014,6 +1014,8 @@ void rcar_du_cmm_postclose(struct drm_device *dev, struct drm_file *file_priv)
>  	for (crtcs_cnt = 0; crtcs_cnt < rcdu->num_crtcs; crtcs_cnt++) {
>  		rcrtc = &rcdu->crtcs[crtcs_cnt];
>  		du_cmm = rcrtc->cmm_handle;
> +		if (!du_cmm)
> +			continue;
>  		if (du_cmm->authority && du_cmm->pid == task_pid_nr(current)) {
>  			du_cmm->authority = false;
>  			du_cmm->pid = 0;

-- 
Regards,

Laurent Pinchart
