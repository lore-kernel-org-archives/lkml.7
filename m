Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088E9CA9ECE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1B3E20650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 10:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfJaKwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:52:14 -0400
Received: from gloria.sntech.de ([185.11.138.130]:35596 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfJaKwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 06:52:14 -0400
Received: from dhcp-159-84-61-180.univ-lyon2.fr ([159.84.61.180] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iQ83B-0004dd-3J; Thu, 31 Oct 2019 11:51:33 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Cheng-Yi Chiang <cychiang@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 5/6] ARM: dts: rockchip: Add HDMI support to rk3288-veyron-analog-audio
Date:   Thu, 31 Oct 2019 11:51:31 +0100
Message-ID: <6246654.jvjegRjDd5@phil>
In-Reply-To: <20191028071930.145899-6-cychiang@chromium.org>
References: <20191028071930.145899-1-cychiang@chromium.org> <20191028071930.145899-6-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 28. Oktober 2019, 08:19:29 CET schrieb Cheng-Yi Chiang:
> All boards using rk3288-veyron-analog-audio.dtsi have HDMI audio.
> Specify the support of HDMI audio on machine driver using
> rockchip,hdmi-codec property so machine driver creates HDMI audio device.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>

applied for 5.5

Thanks
Heiko


