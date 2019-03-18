Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818DDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51ECD20863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 18:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfCRSE6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 14:04:58 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52844 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfCRSE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 14:04:58 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h5wcy-0001dE-6D; Mon, 18 Mar 2019 19:04:48 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Jonas Karlman <jonas@kwiboo.se>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/rockchip: vop: reset scale mode when win is disabled
Date:   Mon, 18 Mar 2019 19:04:47 +0100
Message-ID: <3050762.S3h3RRttz1@diego>
In-Reply-To: <AM3PR03MB0966DE3E19BACE07328CD637AC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com>
References: <AM3PR03MB0966DE3E19BACE07328CD637AC7D0@AM3PR03MB0966.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

Am Mittwoch, 20. Februar 2019, 23:40:06 CET schrieb Jonas Karlman:
> NV12 framebuffers produced by the VPU shows distorted on RK3288
> after win has been disabled when scaling is active.
> 
> This issue can be reproduced using a 1080p modeset by:
> - Scale a 1280x720 NV12 framebuffer to 1920x1080 on win0
> - Disable win0
> - Display a 1920x1080 NV12 framebuffer without scaling on win0
> - Output will now show the framebuffer distorted
> 
> And by:
> - Scale a 1280x720 NV12 framebuffer to 1920x1080
> - Change to a 720p modeset (win gets disabled and scaling reset to none)
> - Output will now show the framebuffer distorted
> 
> Fix this by setting scale mode to none when win is disabled.
> 
> Fixes: 4c156c21c794 ("drm/rockchip: vop: support plane scale")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

applied to drm-misc-fixes - sorry it took so long to test and apply.

Thanks
Heiko


