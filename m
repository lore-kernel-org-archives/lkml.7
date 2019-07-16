Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779BDC76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDE920693
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 13:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fpond.eu header.i=@fpond.eu header.b="gzjz7PnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbfGPNYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 09:24:32 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([81.169.146.169]:33272 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGPNYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 09:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1563283469;
        s=strato-dkim-0002; d=fpond.eu;
        h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Vbkrp6w7m4D6pHF3/AKyST3n0EHCDNA9AqE+moGYREY=;
        b=gzjz7PnKJCwPNyS3onMlyFrexdC+kKgtwyNcVptNh7PY25uuL2naIBp6noDqoXoHPk
        5vsQibyyNIKFnZKLCgUu+tqpvlG/3arrx7t5fFJpuQEMeLFv5t7h/6aFEDYBcLdUMKyu
        PT4wB2iBA2P83tKCldixyYn5C6PLatzI6x2K4Zi14Z288mENZUJHxpeM4X9GiIoUJL5m
        7QQOHXkiVTV6CJ8N4I/8F3KKIF3jOEesH/IHK3kZ+xlMUdfiOL4q5odq6GSI9ZAFY+rG
        07C+u65AwidsP3y10unOWZna1blAY/Jp7RbqixBw0sIuJ8YbW4+u0xPPc/kBt3nDowYe
        HPtg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmt2bYDnKIKaws6YXTsc4="
X-RZG-CLASS-ID: mo00
Received: from oxapp06-01.back.ox.d0m.de
        by smtp-ox.front (RZmta 44.24 AUTH)
        with ESMTPSA id h0a328v6GDITcPy
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 16 Jul 2019 15:18:29 +0200 (CEST)
Date:   Tue, 16 Jul 2019 15:18:29 +0200 (CEST)
From:   Ulrich Hecht <uli@fpond.eu>
To:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com,
        kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     koji.matsuoka.xm@renesas.com, muroya@ksk.co.jp,
        VenkataRajesh.Kalakodima@in.bosch.com,
        Harsha.ManjulaMallikarjun@in.bosch.com,
        linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <1992958141.61517.1563283109549@webmail.strato.com>
In-Reply-To: <20190706140746.29132-16-jacopo+renesas@jmondi.org>
References: <20190706140746.29132-1-jacopo+renesas@jmondi.org>
 <20190706140746.29132-16-jacopo+renesas@jmondi.org>
Subject: Re: [PATCH v2 15/19] drm: rcar-du: Claim CMM support for Gen3 SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev59
X-Originating-IP: 85.212.152.154
X-Originating-Client: open-xchange-appsuite
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On July 6, 2019 at 4:07 PM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> 
> 
> Add CMM to the list of supported features for Gen3 SoCs that provide it:
> - R8A7795
> - R8A7796
> - R8A77965
> - R8A7799x
> 
> Leave R8A77970 out as V3M and V3H are the only Gen3 SoCs that do not
> support CMM.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 12 ++++++++----
>  drivers/gpu/drm/rcar-du/rcar_du_drv.h |  1 +
>  2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> index 75ab17af13a9..1e69cfa11798 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -247,7 +247,8 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
>  	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
>  		  | RCAR_DU_FEATURE_VSP1_SOURCE
>  		  | RCAR_DU_FEATURE_INTERLACED
> -		  | RCAR_DU_FEATURE_TVM_SYNC,
> +		  | RCAR_DU_FEATURE_TVM_SYNC
> +		  | RCAR_DU_FEATURE_CMM,
>  	.channels_mask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
>  	.routes = {
>  		/*
> @@ -280,7 +281,8 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
>  	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
>  		  | RCAR_DU_FEATURE_VSP1_SOURCE
>  		  | RCAR_DU_FEATURE_INTERLACED
> -		  | RCAR_DU_FEATURE_TVM_SYNC,
> +		  | RCAR_DU_FEATURE_TVM_SYNC
> +		  | RCAR_DU_FEATURE_CMM,
>  	.channels_mask = BIT(2) | BIT(1) | BIT(0),
>  	.routes = {
>  		/*
> @@ -309,7 +311,8 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
>  	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
>  		  | RCAR_DU_FEATURE_VSP1_SOURCE
>  		  | RCAR_DU_FEATURE_INTERLACED
> -		  | RCAR_DU_FEATURE_TVM_SYNC,
> +		  | RCAR_DU_FEATURE_TVM_SYNC
> +		  | RCAR_DU_FEATURE_CMM,
>  	.channels_mask = BIT(3) | BIT(1) | BIT(0),
>  	.routes = {
>  		/*
> @@ -357,7 +360,8 @@ static const struct rcar_du_device_info rcar_du_r8a77970_info = {
>  static const struct rcar_du_device_info rcar_du_r8a7799x_info = {
>  	.gen = 3,
>  	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
> -		  | RCAR_DU_FEATURE_VSP1_SOURCE,
> +		  | RCAR_DU_FEATURE_VSP1_SOURCE
> +		  | RCAR_DU_FEATURE_CMM,
>  	.channels_mask = BIT(1) | BIT(0),
>  	.routes = {
>  		/*
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.h b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> index 1327cd0df90a..a00dccc447aa 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.h
> @@ -28,6 +28,7 @@ struct rcar_du_encoder;
>  #define RCAR_DU_FEATURE_VSP1_SOURCE	BIT(1)	/* Has inputs from VSP1 */
>  #define RCAR_DU_FEATURE_INTERLACED	BIT(2)	/* HW supports interlaced */
>  #define RCAR_DU_FEATURE_TVM_SYNC	BIT(3)	/* Has TV switch/sync modes */
> +#define RCAR_DU_FEATURE_CMM		BIT(4)	/* Has CMM */
>  
>  #define RCAR_DU_QUIRK_ALIGN_128B	BIT(0)	/* Align pitches to 128 bytes */
>  
> -- 
> 2.21.0
>

Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>

CU
Uli
