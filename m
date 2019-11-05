Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B50C5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7041214B2
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 17:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390496AbfKERSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 12:18:33 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:43293 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389659AbfKERSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 12:18:33 -0500
X-Originating-IP: 92.137.17.54
Received: from localhost (alyon-657-1-975-54.w92-137.abo.wanadoo.fr [92.137.17.54])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 932D31C0007;
        Tue,  5 Nov 2019 17:18:28 +0000 (UTC)
Date:   Tue, 5 Nov 2019 18:18:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rtc: brcmstb-waketimer: add missed
 clk_disable_unprepare
Message-ID: <20191105171827.GE8309@piout.net>
References: <20191105160043.20018-1-hslester96@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105160043.20018-1-hslester96@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2019 00:00:43+0800, Chuhong Yuan wrote:
> This driver forgets to disable and unprepare clock when remove.
> Add a call to clk_disable_unprepare to fix it.
> 
> Fixes: c4f07ecee22e ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
> ---
> Changes in v2:
>   - Remove the check for timer->clk and add fixes tag.
> 
>  drivers/rtc/rtc-brcmstb-waketimer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
