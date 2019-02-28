Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5345C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B03E218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 20:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbfB1UwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 15:52:20 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:59537 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387795AbfB1UwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 15:52:19 -0500
X-Originating-IP: 86.202.231.219
Received: from localhost (lfbn-lyo-1-149-219.w86-202.abo.wanadoo.fr [86.202.231.219])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id DB0EA240002;
        Thu, 28 Feb 2019 20:52:14 +0000 (UTC)
Date:   Thu, 28 Feb 2019 21:52:14 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Claudiu.Beznea@microchip.com, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Nicolas.Ferre@microchip.com, Ludovic.Desroches@microchip.com,
        bbrezillon@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/7] add LCD support for SAM9X60
Message-ID: <20190228205214.GD23094@piout.net>
References: <1551284609-14594-1-git-send-email-claudiu.beznea@microchip.com>
 <20190228182119.GA28318@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228182119.GA28318@ravnborg.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2019 19:21:19+0100, Sam Ravnborg wrote:
> Hi Claudiu
> 
> On Wed, Feb 27, 2019 at 04:24:11PM +0000, Claudiu.Beznea@microchip.com wrote:
> > From: Claudiu Beznea <claudiu.beznea@microchip.com>
> > 
> > Hi,
> > 
> > These patches adds support for SAM9X60's LCD controller.
> Can you elaborate a little more which chips that are relevant.
> To be able to look into the right data-sheet, while reviewing.
> Link to data-sheet would be nice too.
> 

sam9x60 is the chip name (i.e. x is not a wildcard). I don't think the
datasheet is finished/public yet.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
