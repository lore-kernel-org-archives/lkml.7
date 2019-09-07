Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3053AC43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012FE208C3
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567879433;
	bh=e5FUBJ9aytqsJuJLqp+Yls1/TrENiOHMX5NzwQhFO7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gJfyEamjVr+DKfL1q6gsTsFLO0Rx6D1vZBB2yL7vKtRz0V9uLVOdSzjMUE+xIYZCs
	 3fjjt1ZP1FDLpIwHDjViKkDe0tYxYSkFAMCvz7U2T5B0s7OjPNmUtd6Wro6jRKGec3
	 WDI4Cl/dih+v9E/OhFakhPPgu5PsSTa2O6L6L96g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393525AbfIGSCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfIGSCx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:02:53 -0400
Received: from localhost (unknown [80.251.162.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EA1A208C3;
        Sat,  7 Sep 2019 18:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567879373;
        bh=e5FUBJ9aytqsJuJLqp+Yls1/TrENiOHMX5NzwQhFO7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibYSHyes2qb80Szjxhjkb5JReauwPH6cQt2elVIQRBIHbbXw833R80uH3+i73yPV5
         HlVmBMsiTZ1ARvW7YUcI/pkbeJPBVwEBBH3KUNVxTMqqGg6yxL12qH2z7dEUdXF/lS
         X4SRi1WvALZO6H/7taCyAK45LMBqq27x+pHSTtjo=
Date:   Sat, 7 Sep 2019 19:02:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sandro Volery <sandro@volery.com>
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
Message-ID: <20190907180250.GA20602@kroah.com>
References: <20190907174232.GA20070@kroah.com>
 <E460500C-317E-459B-BBFE-98EEA1B4620D@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E460500C-317E-459B-BBFE-98EEA1B4620D@volery.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 07:49:43PM +0200, Sandro Volery wrote:
> 
> 
> 
> 
> > On 7 Sep 2019, at 19:42, Greg KH <gregkh@linuxfoundation.org> wrote:
> > 
> > ﻿On Sat, Sep 07, 2019 at 07:35:42PM +0200, Sandro Volery wrote:
> >> 
> >> 
> >>>>>> On 7 Sep 2019, at 19:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> >>>>> ﻿On Sat, Sep 07, 2019 at 07:23:59PM +0200, Sandro Volery wrote:
> >>>>> Dear Greg,
> >>>>> I am pretty sure the issue was, that I did too many things at once. However, all the things I did are related to spaces / tabs, maybe that still works?
> >>> 
> >>> <snip>
> >>> 
> >>> For some reason you sent this only to me, which is a bit rude to
> >>> everyone else on the mailing list.  I'll be glad to respond if you
> >>> resend it to everyone.
> >> 
> >> I'm sorry, newbie here. I thought it'd be better to not annoy everyone with responses but learning things everyday I guess :)
> > 
> > No problem, but you should also line-wrap your emails :)
> 
> I've just been told that before, I'll try to change 
> those settings asap.
> 
> > 
> >> I am pretty sure the issue with my patch was that there was too many changes, however all of them were spaces and tabs related, so I think this could be fine?
> > 
> > As the bot said, break it out into "one patch per logical change", and
> > "fix all whitespace issues" is not "one logical change".
> 
> So a logical change would be if I make one patch
> to replace all spaces with tabs and a separate
> patch to add a space before the : ?

Yes, that would be good.  Make it a patch series please.

thanks,

greg k-h
