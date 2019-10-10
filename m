Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587C6C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB5D206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 23:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfJJXqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 19:46:34 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34436 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbfJJXqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 19:46:33 -0400
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iIi8a-0007dV-Is; Fri, 11 Oct 2019 01:46:28 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Nickey Yang <nickey.yang@rock-chips.com>
Cc:     hjc@rock-chips.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, seanpaul@chromium.org,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH 1/1] drm/rockchip: vop: add the definition of dclk_pol
Date:   Fri, 11 Oct 2019 01:46:28 +0200
Message-ID: <6985432.6H6HJzKCHW@diego>
In-Reply-To: <20191010034452.20260-2-nickey.yang@rock-chips.com>
References: <20191010034452.20260-1-nickey.yang@rock-chips.com> <20191010034452.20260-2-nickey.yang@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 10. Oktober 2019, 05:44:52 CEST schrieb Nickey Yang:
> Some VOP's (such as px30) dclk_pol bit is at the last.
> So it is necessary to distinguish dclk_pol and pin_pol.
> 
> Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>

on
- px30 with dsi ... fixing the display issue I had
- rk3328 with hdmi
- rk3288 with edp
- rk3399 with edp

Tested-by: Heiko Stuebner <heiko@sntech.de>


