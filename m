Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E0AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABCAE20811
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="iEdbAOGQ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T3rAJPdt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfC1GlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:41:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55976 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfC1GlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:41:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E704D6083E; Thu, 28 Mar 2019 06:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553755279;
        bh=IC6IRSLJuhP5c7AQ82KGK3UbIX06Udh44Tr2fWtrr9g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iEdbAOGQrb7hlXnlSWNd9/M1P5wXwOpeJG0Z0PJ2qBTKxVzqveIjhHst+l/cS/Jjj
         nYXNTyk3f4YmHMuFCDA/bw2jy0EWgV3OX4tSDXIu0QyDzAH5EcuU6/6/ydRc7nEEZf
         u5CfbYXPyMu172PqtZzJixLmwnex/vesShzsfTZA=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3D84B60779;
        Thu, 28 Mar 2019 06:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553755278;
        bh=IC6IRSLJuhP5c7AQ82KGK3UbIX06Udh44Tr2fWtrr9g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=T3rAJPdtUhUOe1SQtMhhSvuiFsTXnjcDMi+XYrHt651e7+7fRGx95I/gzo7+7g+bW
         XXBciMzUN0u4Ayc76WQIE00J/ux47KiSAYGdE8Ni0vaYlfv3cB0AhGIGZmOkkmAppe
         sHnYlaVAvsX1Eu18kNK2rwjTLwZ4hRMcss/esnps=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D84B60779
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] gpu:drm: Remove duplicate headers
To:     jagdsh.linux@gmail.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org
References: <1553721116-37832-1-git-send-email-jagdsh.linux@gmail.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <260ed384-f963-b1d0-67ae-b574a683a987@codeaurora.org>
Date:   Thu, 28 Mar 2019 12:11:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1553721116-37832-1-git-send-email-jagdsh.linux@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 2:41 AM, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
>
> Remove duplicate headers which are included twice.
>
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
>   drivers/gpu/drm/bridge/panel.c       | 1 -
>   drivers/gpu/drm/i915/intel_display.c | 7 -------
>   2 files changed, 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 38eeaf8..eb9567d 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -15,7 +15,6 @@
>   #include <drm/drm_encoder.h>
>   #include <drm/drm_modeset_helper_vtables.h>
>   #include <drm/drm_probe_helper.h>
> -#include <drm/drm_panel.h>
>   
>   struct panel_bridge {
>   	struct drm_bridge bridge;
> diff --git a/drivers/gpu/drm/i915/intel_display.c b/drivers/gpu/drm/i915/intel_display.c
> index ccb6163..1166342 100644
> --- a/drivers/gpu/drm/i915/intel_display.c
> +++ b/drivers/gpu/drm/i915/intel_display.c
> @@ -51,14 +51,7 @@
>   #include "intel_dsi.h"
>   #include "intel_frontbuffer.h"
>   
> -#include "intel_drv.h"
> -#include "intel_dsi.h"
> -#include "intel_frontbuffer.h"
> -
> -#include "i915_drv.h"
> -#include "i915_gem_clflush.h"
>   #include "i915_reset.h"
> -#include "i915_trace.h"
>   
>   /* Primary plane formats for gen <= 3 */
>   static const u32 i8xx_primary_formats[] = {
