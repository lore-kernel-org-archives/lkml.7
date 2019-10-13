Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114E6C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 21:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36C5207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 21:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfJMV5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 17:57:54 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50526 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbfJMV5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 17:57:54 -0400
Received: from i59f7e0c5.versanet.de ([89.247.224.197] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iJlry-0004uB-PY; Sun, 13 Oct 2019 23:57:43 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: include rockchip_drm_drv.h
Date:   Sun, 13 Oct 2019 23:57:36 +0200
Message-ID: <12674451.zEyZYcXUJe@phil>
In-Reply-To: <20191009132134.18384-1-ben.dooks@codethink.co.uk>
References: <20191009132134.18384-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 9. Oktober 2019, 15:21:34 CEST schrieb Ben Dooks:
> Include rockchip_drm_drv.h for definition of vop_platform_driver
> to avoid the following sparse warning:
> 
> drivers/gpu/drm/rockchip/rockchip_vop_reg.c:982:24: warning: symbol 'vop_platform_driver' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

applied to drm-misc-next

Thanks
Heiko


