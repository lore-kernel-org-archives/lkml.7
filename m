Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49A13C28EB3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CF520868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 10:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfFFK3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 06:29:07 -0400
Received: from gloria.sntech.de ([185.11.138.130]:37434 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbfFFK3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 06:29:07 -0400
Received: from we0305.dip.tu-dresden.de ([141.76.177.49] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hYpdY-0003d7-6L; Thu, 06 Jun 2019 12:28:48 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Sandy Huang <hjc@rock-chips.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-rockchip@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>, mka@chromium.org,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] ARM: dts: rockchip: Switch to builtin HDMI DDC bus on rk3288-veyron
Date:   Thu, 06 Jun 2019 12:28:47 +0200
Message-ID: <1843069.a0lnjFrhvD@phil>
In-Reply-To: <20190502225336.206885-3-dianders@chromium.org>
References: <20190502225336.206885-1-dianders@chromium.org> <20190502225336.206885-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 3. Mai 2019, 00:53:34 CEST schrieb Douglas Anderson:
> Downstream Chrome OS kernels use the builtin DDC bus from dw_hdmi on
> veyron.  This is the only way to get them to negotiate HDCP.
> 
> Although HDCP isn't currently all supported upstream, it still seems
> like it makes sense to use dw_hdmi's builtin I2C.  Maybe eventually we
> can get HDCP negotiation working.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied patches 3 to 5 for 5.3

Thanks
Heiko


