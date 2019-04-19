Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF0CC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5C9205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbfDSS7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:59:09 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:36280 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbfDSS7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:59:08 -0400
Received: from relay2-d.mail.gandi.net (unknown [217.70.183.194])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 58DD23A8D4F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 08:47:10 +0000 (UTC)
X-Originating-IP: 90.88.160.238
Received: from aptenodytes (aaubervilliers-681-1-42-238.w90-88.abo.wanadoo.fr [90.88.160.238])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 1E37840006;
        Fri, 19 Apr 2019 08:47:08 +0000 (UTC)
Message-ID: <0fbe7f70c8fcadec96e807c207cfc21671418515.camel@bootlin.com>
Subject: Re: [PATCH 1/4] drm/v3d: Fix debugfs reads of MMU regs.
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Eric Anholt <eric@anholt.net>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        david.emett@broadcom.com, thomas.spurden@broadcom.com
Date:   Fri, 19 Apr 2019 10:47:08 +0200
In-Reply-To: <20190419001014.23579-1-eric@anholt.net>
References: <20190419001014.23579-1-eric@anholt.net>
Organization: Bootlin
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2019-04-18 at 17:10 -0700, Eric Anholt wrote:
> They're in the hub, not the individual cores.

Although I don't have docs to check, looks sane:

Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/gpu/drm/v3d/v3d_debugfs.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/v3d/v3d_debugfs.c b/drivers/gpu/drm/v3d/v3d_debugfs.c
> index a2dc4262955e..356a8acfa72d 100644
> --- a/drivers/gpu/drm/v3d/v3d_debugfs.c
> +++ b/drivers/gpu/drm/v3d/v3d_debugfs.c
> @@ -26,6 +26,10 @@ static const struct v3d_reg_def v3d_hub_reg_defs[] = {
>  	REGDEF(V3D_HUB_IDENT3),
>  	REGDEF(V3D_HUB_INT_STS),
>  	REGDEF(V3D_HUB_INT_MSK_STS),
> +
> +	REGDEF(V3D_MMU_CTL),
> +	REGDEF(V3D_MMU_VIO_ADDR),
> +	REGDEF(V3D_MMU_VIO_ID),
>  };
>  
>  static const struct v3d_reg_def v3d_gca_reg_defs[] = {
> @@ -50,9 +54,6 @@ static const struct v3d_reg_def v3d_core_reg_defs[] = {
>  	REGDEF(V3D_PTB_BPCA),
>  	REGDEF(V3D_PTB_BPCS),
>  
> -	REGDEF(V3D_MMU_CTL),
> -	REGDEF(V3D_MMU_VIO_ADDR),
> -
>  	REGDEF(V3D_GMP_STATUS),
>  	REGDEF(V3D_GMP_CFG),
>  	REGDEF(V3D_GMP_VIO_ADDR),
-- 
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

