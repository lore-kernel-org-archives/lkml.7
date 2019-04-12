Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54DAC10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC9920643
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDLLQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:16:50 -0400
Received: from gloria.sntech.de ([185.11.138.130]:38588 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfDLLQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:16:50 -0400
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hEuAp-00054d-Gb; Fri, 12 Apr 2019 13:16:47 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Elaine Zhang <zhangqing@rock-chips.com>, dbasehore@chromium.org,
        amstan@chromium.org, linux-rockchip@lists.infradead.org,
        briannorris@chromium.org, mka@chromium.org, ryandcase@chromium.org,
        Chris Zhong <zyw@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/5] ARM: dts: rockchip: Add DDR retention/poweroff to rk3288-veyron hogs
Date:   Fri, 12 Apr 2019 13:16:46 +0200
Message-ID: <5038829.dT3Rz05rMg@diego>
In-Reply-To: <20190411232157.55125-3-dianders@chromium.org>
References: <20190411232157.55125-1-dianders@chromium.org> <20190411232157.55125-3-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 12. April 2019, 01:21:55 CEST schrieb Douglas Anderson:
> Even though upstream Linux doesn't yet go into deep enough suspend to
> get DDR into self refresh, there is no harm in setting these pins up.
> They'll only actually do something if we go into a deeper suspend but
> leaving them configed always is fine.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied for 5.2

Thanks
Heiko


