Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D38C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874682067C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 00:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730042AbfDZAmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 20:42:32 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:34354 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfDZAmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 20:42:31 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-5-198-nat.elisa-mobile.fi [85.76.5.198])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 55250200B8;
        Fri, 26 Apr 2019 03:42:29 +0300 (EEST)
Date:   Fri, 26 Apr 2019 03:42:29 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Arnaud Patard <arnaud.patard@rtp-net.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: xgifb: delete the driver
Message-ID: <20190426004229.GC21072@darkstar.musicnaut.iki.fi>
References: <20190118100828.GA5143@kroah.com>
 <20190118112028.GG3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118112028.GG3271@phenom.ffwll.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 18, 2019 at 12:20:28PM +0100, Daniel Vetter wrote:
> On Fri, Jan 18, 2019 at 11:08:28AM +0100, Greg Kroah-Hartman wrote:
> > There has not been any real work done on cleaning this driver up and
> > getting it out of the staging tree in years.  Also, no new fb drivers
> > are being added to the tree, so it should be converted into a drm driver
> > as well.
> > 
> > Due to the lack of interest in this codebase, just drop it.
> > 
> > Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> > Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Reported-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Because of this I just lost fb/display on two of my computers...

So I guess to reintroduce the support for this HW I need to write a new
DRM driver and no staging work anymore. Which of the current DRM drivers
would be best to be used as a template/example for a new driver?

A.
