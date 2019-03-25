Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789B02085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbfCYMaN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:30:13 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52274 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730989AbfCYMaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:30:13 -0400
Received: from [94.134.91.136] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h8Ojz-0006ms-0Z; Mon, 25 Mar 2019 13:30:11 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: rockchip: Add dvs-gpios to rk3288-veyron-jerry
Date:   Mon, 25 Mar 2019 13:30:10 +0100
Message-ID: <2671225.FaCa6N3cA0@phil>
In-Reply-To: <20190322165209.196926-1-dianders@chromium.org>
References: <20190322165209.196926-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. März 2019, 17:52:09 CET schrieb Douglas Anderson:
> When the rk3288-jerry device tree was first submitted we left out the
> dvs-gpios because I pointed out that the property "dvs-gpios" wasn't
> yet supported upstream [1].  Soon after that the property was added in
> commit bad47ad2eef3 ("regulator: rk808: fixed the overshoot when
> adjust voltage").  ...but we forgot to go back and add the property to
> the jerry device tree file.  Let's do so now.
> 
> NOTE: without this patch, jerry is likely still stable (thanks to the
> fallback of making many small jumps in the rk808 regulator code) but
> it'll take quite a bit longer to make voltage transitions.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/CAD=FV=WwFgjzbk9xF5TU_ie6UnHQMyrZ176D4+jJTWWOoaKC2Q@mail.gmail.com/
> 
> Fixes: f3ee390e4ef2 ("ARM: dts: rockchip: add veyron-jerry board")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2

Thanks
Heiko


