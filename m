Return-Path: <SRS0=9eWV=U5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09DDEC5B57E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06C72089C
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Jun 2019 08:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfF3INp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 04:13:45 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:38453 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfF3INp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 04:13:45 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 58E1320065;
        Sun, 30 Jun 2019 10:13:41 +0200 (CEST)
Date:   Sun, 30 Jun 2019 10:13:39 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Peter Rosin <peda@axentia.se>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: add Sam Ravnborg for drm/atmel_hlcdc
Message-ID: <20190630081339.GA5081@ravnborg.org>
References: <20190627211643.GA19853@ravnborg.org>
 <20190628081256.230165ae@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628081256.230165ae@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8
        a=VwQbUJbxAAAA:8 a=QX4gbG5DAAAA:8 a=XYAwZIGsAAAA:8 a=P-IC7800AAAA:8
        a=8yOQY8BCjKLv2Cdm4xAA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=AjGcO6oz07-iQ99wixmX:22 a=AbAUZ8qAyYyZVLSsDulk:22
        a=E8ToXWR_bxluHZ7gmE-Z:22 a=d3PnA9EDa4IxuAV0gXij:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 08:12:56AM +0200, Boris Brezillon wrote:
> On Thu, 27 Jun 2019 23:16:43 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > I have agreed with Boris Brezillon that we will share the
> > maintainer role for the drm/atmel_hlcdc driver.
> > Nicolas Ferre from Microchip has donated a few boards that
> > allows me to test things - thanks!
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Boris Brezillon <bbrezillon@kernel.org>
> 
> Acked-by: Boris Brezillon <boris.brezillon@collabora.com>
> 
> > Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
> > Cc: Peter Rosin <peda@axentia.se>

Thanks.
Pushed to drm-misc-next with yours and Nicolas' ack.

	Sam
