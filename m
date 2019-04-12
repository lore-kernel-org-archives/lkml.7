Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1560C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C7721872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 10:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfDLKPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 06:15:00 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:46893 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfDLKPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 06:15:00 -0400
X-Originating-IP: 109.213.223.232
Received: from localhost (alyon-652-1-80-232.w109-213.abo.wanadoo.fr [109.213.223.232])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 1BDE0E0014;
        Fri, 12 Apr 2019 10:14:56 +0000 (UTC)
Date:   Fri, 12 Apr 2019 12:14:56 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc:     Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rtc: ds1685: fix crash caused by referencing wrong
 device struct
Message-ID: <20190412101456.GW3578@piout.net>
References: <20190411143323.20945-1-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411143323.20945-1-tbogendoerfer@suse.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 16:33:21+0200, Thomas Bogendoerfer wrote:
> sysfs entries added by rtc_add_group are called with the rtc device
> as argument and not the underlying device. Fixed by using the dev->parent
> 
> Fixes: cfb74916e2ec ("rtc: ds1685: use rtc_add_group")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  drivers/rtc/rtc-ds1685.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
