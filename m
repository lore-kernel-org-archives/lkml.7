Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EFAC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 01:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5234A20730
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 01:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfKRBBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 20:01:33 -0500
Received: from gloria.sntech.de ([185.11.138.130]:40318 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfKRBBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 20:01:33 -0500
Received: from ip5f5a6266.dynamic.kabel-deutschland.de ([95.90.98.102] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iWVPq-0003i0-4Y; Mon, 18 Nov 2019 02:01:18 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        robh+dt@kernel.org, mark.rutland@arm.com, shawn.lin@rock-chips.com,
        devicetree@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>,
        linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Vicente Bergas <vicencb@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-rockchip@lists.infradead.org,
        Tony Xie <tony.xie@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Randy Li <ayaka@soulik.info>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: Re: arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
Date:   Mon, 18 Nov 2019 02:01:16 +0100
Message-ID: <14740383.9LiiEhnQET@phil>
In-Reply-To: <367bf78a-f079-f0b4-68fe-52c86823c174@fivetechno.de>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com> <20190301153348.29870-2-christoph.muellner@theobroma-systems.com> <367bf78a-f079-f0b4-68fe-52c86823c174@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 11. November 2019, 10:51:04 CET schrieb Markus Reichl:
> Working with rootfs on two 128GB mmcs on rk3399-roc-pc.
> 
> One (mmc name 128G72, one screw hole) works fine in HS400 mode.
> Other (mmc name DJNB4R, firefly on pcb, two screw holes) gets lots of
> mmc1: "running CQE recovery", even hangs with damaged fs,
> when running under heavy load, e.g. compiling kernel.
> Both run fine with HS200.
> 
> Disabling CQ with patch mmc: core: Add MMC Command Queue Support kernel parameter [0] did not help.
> [0] https://gitlab.com/ayufan-repos/rock64/linux-mainline-kernel/commit/54e264154b87dfe32a8359b2726e2d5611adbaf3
> 
> Therefore I propose to disable HS400 mode on roc-pc for now.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

applied for 5.6 (or maybe still 5.5)

Thanks
Heiko


