Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D933C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66FA220830
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbfCYMZ0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:25:26 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52212 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730996AbfCYMZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:25:25 -0400
Received: from [94.134.91.136] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1h8OfJ-0006lc-8k; Mon, 25 Mar 2019 13:25:21 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     mka@chromium.org, ryandcase@chromium.org,
        devicetree@vger.kernel.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alexis Ballier <aballier@gentoo.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: ARM: dts: rockchip: Add rk3288-veyron-jerry rev 10-15
Date:   Mon, 25 Mar 2019 13:25:20 +0100
Message-ID: <22847786.E0k6fS2MZ4@phil>
In-Reply-To: <20190322195924.70448-1-dianders@chromium.org>
References: <20190322195924.70448-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 22. März 2019, 20:59:23 CET schrieb Douglas Anderson:
> As far as I can tell/remember rev10 was originally created to support
> making a SKU of jerry that had a different LCD.  rev11-rev15 were
> added to give some wiggle room for future builds.  Downstream has a
> separate device tree for rev10-rev15 (compared to rev3-rev7) with the
> expectation that differences relating to the LCD would be accounted
> for there but nothing was ever added to the rev10-rev15 making it
> identical to the rev3-rev7 one.
> 
> It's likely nothing actually shipped with rev10-rev15 but they are
> listed in the downstream kernel's device tree and it seems like it
> should add a little safety if we match them here just in case
> something actually shipped with one of these revisions and that device
> will break if we don't claim support.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

applied both for 5.2

Thanks
Heiko


