Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61FA1C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEEB20863
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 04:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgABEA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 23:00:28 -0500
Received: from mailgw-01.dd24.net ([193.46.215.41]:34700 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgABEA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 23:00:27 -0500
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.26])
        by mailgw-01.dd24.net (Postfix) with ESMTP id CA0145FD57
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jan 2020 04:00:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-01.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-01.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id UtgI8krSE1cV for <linux-kernel@vger.kernel.org>;
        Thu,  2 Jan 2020 04:00:23 +0000 (UTC)
Received: from heisenberg.fritz.box (ppp-88-217-46-247.dynamic.mnet-online.de [88.217.46.247])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jan 2020 04:00:23 +0000 (UTC)
Message-ID: <43b7eef5560ede5ad2973964f68d9e6beba63a91.camel@scientia.net>
Subject: Re: from 5.2->5.3 lets the system run at considerably higher
 temperatures
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-kernel@vger.kernel.org
Date:   Thu, 02 Jan 2020 05:00:22 +0100
In-Reply-To: <d05aba2742ae42783788c954e2a380e7fcb10830.camel@scientia.net>
References: <d05aba2742ae42783788c954e2a380e7fcb10830.camel@scientia.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again.

Just checked with 5.4.6 and the problem as described previously still
exists.

And effectively idle system runs at ~75 °C even when just typing some
text or switching some windows.
Only if doing really absolutely nothing for a long time it may (but not
always) go down to ~65 °C, which is still 5-10°C more than having the
very same system (same software running, etc.) with a 5.2 kernel.

top still shows basically nothing.

I still suspect it could be somehow graphics related:
- when I switch from the desktop environment to the kernel console,
temperatures quickly go to ~60°C (which is more close to what's the
case with 5.2)

- When doing some video playback, temperatures just explode (which
they' don't with 5.2, of course they rise there as well).
So when playing a video like mpv --vo=vaapi, CPU goes quickly to 90°C
an more (and even when stopping playback, it stays at 80°C for
minutes).
Actually, sometimes (but not always) it was much better with --vo=xv.

The CPU is a Intel(R) Core(TM) i7-7600U CPU @ 2.80GHz, with HD Graphics
620 (Kaby Lake GT2).


Thanks,
Chris.



Any ideas on what to do or how to somehow debug this?

Cheers,
Chris.


On Mon, 2019-12-16 at 16:15 +0100, Christoph Anton Mitterer wrote:
> Hey.
> 
> Since I've upgraded from kernel 5.2 to 5.3 my system runs a
> considerably higher temperatures (like 10°C or more).
> This happens even when it's effectively idle (top shows basically
> nothing).
> Downgrading again to 5.2 and high temperatures go away.
> 
> I did some more detailed description here:
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=945055
> but really have no clue where to start debugging.
> 
> It could be that it's somehow graphics related, as when I switch away
> from X/Cinnamon to the virtual console, temperatures decrease
> considerably.
> 
> 
> Anyone else seeing something similar or having some idea how to track
> this down?
> 
> 
> Thanks,
> Chris.

