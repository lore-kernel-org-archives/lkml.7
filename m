Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3838C48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E4F2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbfFZMlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:41:06 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:35366 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbfFZMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:41:05 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 875BA20042;
        Wed, 26 Jun 2019 14:41:02 +0200 (CEST)
Date:   Wed, 26 Jun 2019 14:41:00 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Robert Chiras <robert.chiras@nxp.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v6 0/2] Add DSI panel driver for Raydium RM67191
Message-ID: <20190626124100.GA7337@ravnborg.org>
References: <1561550907-9733-1-git-send-email-robert.chiras@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561550907-9733-1-git-send-email-robert.chiras@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=scLJrMPQxwMJoNrha8MA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 03:08:25PM +0300, Robert Chiras wrote:
> This patch-set contains the DRM panel driver and dt-bindings documentation
> for the DSI driven panel: Raydium RM67191.
> 
> v6:
> - Collected Reviewed-by from Fabio
> - Removed unused variables (sam)
> 
> v5:
> - Removed unnecessary debug messages (fabio)
> - Handled error case for gpio pin (fabio)
> 
> v4:
> - Changed default_timing structure type from 'struct display_timing' to
>   'struct drm_display_mode' (fabio)
> - Replaced devm_gpiod_get with devm_gpiod_get_optional (fabio)
> - Added power regulators (fabio)
> - Removed pm_ops (fabio)
> 
> v3:
> - Added myself to MAINTAINERS for this driver (sam)
> - Removed display-timings property (fabio)
> - Fixed dt description (sam)
> - Re-arranged calls inside get_modes function (sam)
> - Changed ifdefs with _maybe_unused for suspend/resume functions (sam)
> - Collected Reviewed-by from Sam
> 
> v2:
> - Fixed 'reset-gpio' to 'reset-gpios' property naming (fabio)
> - Changed the state of the reset gpio to active low and fixed how it is
>   handled in driver (fabio)
> - Fixed copyright statement (daniel)
> - Reordered includes (sam)
> - Added defines for panel specific color formats (fabio)
> - Removed unnecessary tests in enable and unprepare (sam)
> - Removed the unnecessary backlight write in enable (sam)
> *** SUBJECT HERE ***
> 
> *** BLURB HERE ***
> 
> Robert Chiras (2):
>   dt-bindings: display: panel: Add support for Raydium RM67191 panel
>   drm/panel: Add support for Raydium RM67191 panel driver

Thanks, patches are applied to drm-misc-next and pushed out.

	Sam
