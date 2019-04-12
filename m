Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA6EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9794320643
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfDLLRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:17:15 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38732 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfDLLRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:17:15 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEuBE-00055u-GS; Fri, 12 Apr 2019 13:17:12 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, dbasehore@chromium.org,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        briannorris@chromium.org, mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/5] ARM: dts: rockchip: vdd_gpu off in suspend for rk3288-veyron
Date:   Fri, 12 Apr 2019 13:17:11 +0200
Message-ID: <14421258.VxKPzeiCPd@diego>
In-Reply-To: <20190411232157.55125-5-dianders@chromium.org>
References: <20190411232157.55125-1-dianders@chromium.org> <20190411232157.55125-5-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. April 2019, 01:21:57 CEST schrieb Douglas Anderson:
> At some point long long ago the downstream GPU driver would crash if
> we turned the GPU off during suspend.  For some context you can see:
> 
> https://chromium-review.googlesource.com/#/c/215780/5..6/arch/arm/boot/dts/rk3288-pinky-rev2.dts
> 
> At some point in time not too long after that got fixed.
> 
> It's unclear why the GPU is left enabled during suspend on the
> mainline kernel.  Everything seems fine if I turn this off, so let's
> do it.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2

Thanks
Heiko


