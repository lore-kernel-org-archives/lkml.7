Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C07C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5062073B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 13:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbfLJNeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 08:34:04 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:37603 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJNeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 08:34:04 -0500
X-Originating-IP: 90.182.112.136
Received: from localhost (136.112.broadband15.iol.cz [90.182.112.136])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id B67AC40011;
        Tue, 10 Dec 2019 13:34:01 +0000 (UTC)
Date:   Tue, 10 Dec 2019 14:33:52 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] rtc: sun6i: Add support for RTC clocks on R40
Message-ID: <20191210133352.GM1463890@piout.net>
References: <20191205085054.6049-1-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205085054.6049-1-wens@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2019 16:50:54+0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> When support for the R40 in the rtc-sun6i driver was split out for a
> separate compatible string, only the RTC half was covered, and not the
> clock half. Unfortunately this results in the whole driver not working,
> as the RTC half expects the clock half to have been initialized.
> 
> Add support for the clock part as well. The clock part is like the H3,
> but does not need to export the internal oscillator, nor does it have
> a gateable LOSC external output.
> 
> This fixes issues with WiFi and Bluetooth not working on the BPI M2U.
> 
> Fixes: d6624cc75021 ("rtc: sun6i: Add R40 compatible")
> Cc: <stable@vger.kernel.org> # 5.3.x
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Please merge this for fixes.
> 
> ---
>  drivers/rtc/rtc-sun6i.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
