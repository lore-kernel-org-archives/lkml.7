Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACC5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74312133D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbfDAQ6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:58:06 -0400
Received: from muru.com ([72.249.23.125]:43778 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728007AbfDAQ6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:58:06 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 85A2880C0;
        Mon,  1 Apr 2019 16:58:19 +0000 (UTC)
Date:   Mon, 1 Apr 2019 09:58:02 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [BUG/PATCH 1/4] DTS: GTA04: SPI / gpiolib: work around a
 regression that unhides a broken legacy handler, which makes the gta04
 display inoperable
Message-ID: <20190401165802.GI49658@atomide.com>
References: <cover.1554026842.git.hns@goldelico.com>
 <e8d784f7fb06fd3a6a92bc730f919352c4ad4411.1554026842.git.hns@goldelico.com>
 <20190401164617.GH49658@atomide.com>
 <06C7464E-FAF2-4AA6-9FF4-629E9C97F86A@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06C7464E-FAF2-4AA6-9FF4-629E9C97F86A@goldelico.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190401 16:57]:
> > Am 01.04.2019 um 18:46 schrieb Tony Lindgren <tony@atomide.com>:
> > So what's the plan with this fix? Add this for v5.2-rc cycle,
> > then revert it later? I'd probably go directly for the proper
> > fix if possible.
> 
> Well, I learned just some minutes ago that a new patch for gpiolib
> came through 5.1-rc3 which does fix this.
> 
> It seems to check for "cs-gpios" and then disable the legacy handling.
> 
> This means that we do not need to patch the DTS at all.

OK good to hear, thanks for the update.

Regards,

Tony
