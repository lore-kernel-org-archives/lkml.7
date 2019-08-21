Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC4BC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3810A233A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbfHUScn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:43 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52306 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbfHUSci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:38 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 94D802699FC;
        Wed, 21 Aug 2019 19:32:36 +0100 (BST)
Date:   Wed, 21 Aug 2019 20:32:33 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 02/11] drm/meson: venc: make drm_display_mode const
Message-ID: <20190821203233.47137f57@collabora.com>
In-Reply-To: <20190820084109.24616-3-narmstrong@baylibre.com>
References: <20190820084109.24616-1-narmstrong@baylibre.com>
        <20190820084109.24616-3-narmstrong@baylibre.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Aug 2019 10:41:00 +0200
Neil Armstrong <narmstrong@baylibre.com> wrote:

> Before switching to bridge funcs, make sure drm_display_mode is passed
> as const to the venc functions.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/meson/meson_venc.c | 2 +-
>  drivers/gpu/drm/meson/meson_venc.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
> index 3d4791798ae0..c8e9840ad450 100644
> --- a/drivers/gpu/drm/meson/meson_venc.c
> +++ b/drivers/gpu/drm/meson/meson_venc.c
> @@ -946,7 +946,7 @@ bool meson_venc_hdmi_venc_repeat(int vic)
>  EXPORT_SYMBOL_GPL(meson_venc_hdmi_venc_repeat);
>  
>  void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
> -			      struct drm_display_mode *mode)
> +			      const struct drm_display_mode *mode)
>  {
>  	union meson_hdmi_venc_mode *vmode = NULL;
>  	union meson_hdmi_venc_mode vmode_dmt;
> diff --git a/drivers/gpu/drm/meson/meson_venc.h b/drivers/gpu/drm/meson/meson_venc.h
> index 576768bdd08d..1abdcbdf51c0 100644
> --- a/drivers/gpu/drm/meson/meson_venc.h
> +++ b/drivers/gpu/drm/meson/meson_venc.h
> @@ -60,7 +60,7 @@ extern struct meson_cvbs_enci_mode meson_cvbs_enci_ntsc;
>  void meson_venci_cvbs_mode_set(struct meson_drm *priv,
>  			       struct meson_cvbs_enci_mode *mode);
>  void meson_venc_hdmi_mode_set(struct meson_drm *priv, int vic,
> -			      struct drm_display_mode *mode);
> +			      const struct drm_display_mode *mode);
>  unsigned int meson_venci_get_field(struct meson_drm *priv);
>  
>  void meson_venc_enable_vsync(struct meson_drm *priv);

