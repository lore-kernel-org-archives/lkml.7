Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CDFFC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A1CF2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfDLLRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:17:03 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38654 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfDLLRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:17:02 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEuB2-00055D-2j; Fri, 12 Apr 2019 13:17:00 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, dbasehore@chromium.org,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        briannorris@chromium.org, mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] ARM: dts: rockchip: vcc33_ccd off in suspend for rk3288-veyron-chromebook
Date:   Fri, 12 Apr 2019 13:16:59 +0200
Message-ID: <172807795.YDU2us2AVO@diego>
In-Reply-To: <20190411232157.55125-4-dianders@chromium.org>
References: <20190411232157.55125-1-dianders@chromium.org> <20190411232157.55125-4-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. April 2019, 01:21:56 CEST schrieb Douglas Anderson:
> As per my comments when the device tree for rk3288-veyron-chromebook
> first landed:
> 
> > Technically I think vcc33_ccd can be off since we have
> > 'needs-reset-on-resume' down in the EHCI port (this regulator is for
> > the USB webcam that's connected to the EHCI port).
> >
> >  ...but leaving it on for now seems fine until we get suspend/resume
> > more solid.
> 
> It's probably about time to do it right.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/CAD=FV=U37Yx8Mqk75_x05zxonvdc3qRMhqp8TyTDPWGHqSuRqg@mail.gmail.com/
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2

Thanks
Heiko


