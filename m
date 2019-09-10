Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BC9C49ED8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846CC21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 14:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbfIJOQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 10:16:03 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:48755 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfIJOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 10:16:03 -0400
Received: from localhost (unknown [148.69.85.38])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 9604424001D;
        Tue, 10 Sep 2019 14:16:00 +0000 (UTC)
Date:   Tue, 10 Sep 2019 16:15:57 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: meson: mark PM functions as __maybe_unused
Message-ID: <20190910141557.GU21254@piout.net>
References: <20190906152438.1533833-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906152438.1533833-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2019 17:24:29+0200, Arnd Bergmann wrote:
> The meson_vrtc_set_wakeup_time() function is only used by
> the PM functions and causes a warning when they are disabled:
> 
> drivers/rtc/rtc-meson-vrtc.c:32:13: error: unused function 'meson_vrtc_set_wakeup_time' [-Werror,-Wunused-function]
> 
> Remove the #ifdef around the callers and add a __maybe_unused
> annotation as a more reliable way to avoid these warnings.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-meson-vrtc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
