Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7C8C742A8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D66B2084B
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 06:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfGLGHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 02:07:49 -0400
Received: from asavdk4.altibox.net ([109.247.116.15]:34504 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfGLGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:07:48 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id C2829803AE;
        Fri, 12 Jul 2019 08:07:43 +0200 (CEST)
Date:   Fri, 12 Jul 2019 08:07:37 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        mka@chromium.org, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v6 0/3] drm/panel: simple: Add mode support to devicetree
Message-ID: <20190712060737.GA9569@ravnborg.org>
References: <20190711203455.125667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711203455.125667-1-dianders@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8
        a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=O475EGwODiYbJdBmdVwA:9
        a=CjuIK1q_8ugA:10 a=PO69wPE_V6wA:10 a=Vxmtnl_E_bksehYqCbjh:22
        a=AjGcO6oz07-iQ99wixmX:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug.

On Thu, Jul 11, 2019 at 01:34:52PM -0700, Douglas Anderson wrote:
> I'm reviving Sean Paul's old patchset to get mode support in device
> tree.  The cover letter for his v3 is at:
> https://lists.freedesktop.org/archives/dri-devel/2018-February/165162.html
> 
> v6 of this patch is just a repost of the 3 DRM patches in v5 rebased
> atop drm-misc.  A few notes:
> - I've dropped the bindings patch.  Commit 821a1f7171ae ("dt-bindings:
>   display: Convert common panel bindings to DT schema") has landed and
>   Rob H said [1] that when that landed the bindings were implicitly
>   supported.
> - Since the bindings patch was dropped I am assuming that Heiko
>   can just pick up the .dts patches from the v5 series.  I
>   double-checked with him and he confirmed this is fine.  Thus I
>   have left the device tree patches out of this version.
> 
> There were some coding style discussions on v5 of the path but it's
> been agreed that we can land this series as-is and after it lands we
> can address the minor style issues.
> 
> [1] https://lkml.kernel.org/r/CAL_JsqJGtUTpJL+SDEKi09aDT4yDzY4x9KwYmz08NaZcn=nHfA@mail.gmail.com
> 
> Changes in v6:
> - Rebased to drm-misc next
> - Added tags
...

Thanks for your patience with this.
Applied to drm-misc-next and pushed out.

	Sam
