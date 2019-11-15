Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AD7C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D81720733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 13:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfKONBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 08:01:25 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:45817 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbfKONBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 08:01:24 -0500
X-Originating-IP: 90.66.177.178
Received: from localhost (lfbn-1-2888-178.w90-66.abo.wanadoo.fr [90.66.177.178])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 55AB2FF805;
        Fri, 15 Nov 2019 13:01:21 +0000 (UTC)
Date:   Fri, 15 Nov 2019 14:01:21 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH] rtc: fsl-ftm-alarm: remove select FSL_RCPM and default y
 from Kconfig
Message-ID: <20191115130121.GS3572@piout.net>
References: <1573252856-11759-1-git-send-email-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573252856-11759-1-git-send-email-leoyang.li@nxp.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2019 16:40:56-0600, Li Yang wrote:
> The Flextimer alarm is primarily used as a wakeup source for system
> power management.  But it shouldn't select the power management driver
> as they don't really have dependency of each other.
> 
> Also remove the default y as it is not a critical feature for the
> systems.
> 
> Signed-off-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/rtc/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
