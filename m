Return-Path: <SRS0=daYT=YG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0556C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 20:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C6320679
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Oct 2019 20:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfJMUZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Oct 2019 16:25:37 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50178 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfJMUZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Oct 2019 16:25:37 -0400
Received: from i59f7e23a.versanet.de ([89.247.226.58] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iJkQY-0004d0-4f; Sun, 13 Oct 2019 22:25:18 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org,
        Sandy Huang <hjc@rock-chips.com>, kernel@collabora.com,
        Sean Paul <seanpaul@chromium.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] ARM: dts: rockchip: Add RK3288 VOP gamma LUT address
Date:   Sun, 13 Oct 2019 22:25:06 +0200
Message-ID: <10075567.55hLz0bBqu@phil>
In-Reply-To: <20191010194351.17940-4-ezequiel@collabora.com>
References: <20191010194351.17940-1-ezequiel@collabora.com> <20191010194351.17940-4-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 10. Oktober 2019, 21:43:51 CEST schrieb Ezequiel Garcia:
> RK3288 SoC VOPs have optional support Gamma LUT setting,
> which requires specifying the Gamma LUT address in the devicetree.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

applied for 5.5

Thanks
Heiko


