Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DAC43215
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C115020659
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 14:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfKROTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:19:51 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:48379 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfKROTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 09:19:51 -0500
Received: from localhost (unknown [92.184.107.65])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 69F4F200018;
        Mon, 18 Nov 2019 14:19:47 +0000 (UTC)
Date:   Mon, 18 Nov 2019 15:19:46 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] rtc: tps65910: allow using RTC without alarm interrupt
Message-ID: <20191118141946.GG3632@piout.net>
References: <20191114195941.GL3572@piout.net>
 <20191116203748.27166-1-andrej.skvortzov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191116203748.27166-1-andrej.skvortzov@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2019 23:37:48+0300, Andrey Skvortsov wrote:
> If tps65910 INT1 pin (IRQ output) is not wired to any IRQ controller,
> then it can't be used as system wakeup/alarm source,
> but it is still possible to read/write time from/to RTC.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
> 
> v1 -> v2:
>  - add detailed commit description
>  - remove error message about failed IRQ request
> 
>  drivers/rtc/rtc-tps65910.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
