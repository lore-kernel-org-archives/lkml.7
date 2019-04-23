Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8F1C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBCA620693
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="W7AUply7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbfDWQET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:04:19 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:57412 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfDWQET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 12:04:19 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5C6EC5F;
        Tue, 23 Apr 2019 18:04:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1556035457;
        bh=MjUNEwG856RnflNeQple/5Knib6hOK5fXKIASzS1MUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7AUply7vAMj3q79wV2BubvTB882NmjaUnnuFbnkzPlDSWq7pxsQt9KkHmOS0ZaXF
         60gHqOsAO5UGaN0/SOYlRm5wtrKSMTZmfIDTSsTL+ZyG3xN749v0kHVBbfCQCVTY/F
         6ljESyY5eLyLyhjeUYoPvoYvTFZMXkhV6LxKRxKE=
Date:   Tue, 23 Apr 2019 19:04:07 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: normalize Laurent Pinchart's email address
Message-ID: <20190423160407.GK16111@pendragon.ideasonboard.com>
References: <20190413093522.14738-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190413093522.14738-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Thank you for the patch.

On Sat, Apr 13, 2019 at 11:35:22AM +0200, Lukas Bulwahn wrote:
> MAINTAINERS contains lower-case and upper-case variants of
> Laurent Pinchart's email address.
> 
> Only keep the lower-case variant in MAINTAINERS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Should this patch go through the drm-misc tree ?

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b486b9e5d73c..dc329b6524d8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1097,7 +1097,7 @@ F:	Documentation/perf/xgene-pmu.txt
>  F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
>  
>  APTINA CAMERA SENSOR PLL
> -M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> +M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/i2c/aptina-pll.*
> @@ -5126,7 +5126,7 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  DRM DRIVERS FOR BRIDGE CHIPS
>  M:	Andrzej Hajda <a.hajda@samsung.com>
> -R:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> +R:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>  S:	Maintained
>  T:	git git://anongit.freedesktop.org/drm/drm-misc
>  F:	drivers/gpu/drm/bridge/

-- 
Regards,

Laurent Pinchart
