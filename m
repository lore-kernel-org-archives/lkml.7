Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2392EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0453320733
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfKOIkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:40:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60016 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:40:15 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3439B291B74;
        Fri, 15 Nov 2019 08:40:14 +0000 (GMT)
Date:   Fri, 15 Nov 2019 09:40:10 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Mark linux-i3c mailing list moderated
Message-ID: <20191115094010.31acadf6@collabora.com>
In-Reply-To: <CAMuHMdWO=8sHn9wrEiuBGes0x_L2=Qkou=aPcHM7Mr9oDS74Qw@mail.gmail.com>
References: <20191024153756.31861-1-geert+renesas@glider.be>
        <20191115061554.532d29e9@collabora.com>
        <CAMuHMdWO=8sHn9wrEiuBGes0x_L2=Qkou=aPcHM7Mr9oDS74Qw@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Nov 2019 09:10:02 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Hi Boris,
> 
> On Fri, Nov 15, 2019 at 6:16 AM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> > On Thu, 24 Oct 2019 17:37:56 +0200
> > Geert Uytterhoeven <geert+renesas@glider.be> wrote:  
> > > The linux-i3c mailing list is moderated for non-subscribers.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>  
> >
> > Queued to i3c/next. It was actually queued 2 weeks ago but the
> > patchwork bot didn't send a notification for that one (one was sent for
> > your other patch) and I don't know why.  
> 
> It did:

Ok, perfect then. Looks like sometimes it doesn't work, but for this
patch I did receive a notification too (it was one notification for both
of your patches and I thought I was receiving one per patch).

> 
> -----8<-----------------------------------------------------------------------------------------
> Subject: Re: [PATCH] MAINTAINERS: Mark linux-i3c mailing list moderated
> From: patchwork-bot+linux-i3c@kernel.org
> Message-Id: <157251967150.27046.1691850610457130750.git-patchwork-notify@kernel.org>
> Date: Thu, 31 Oct 2019 11:01:11 +0000
> References: <20191024153756.31861-1-geert+renesas@glider.be>
> In-Reply-To: <20191024153756.31861-1-geert+renesas@glider.be>
> To: Geert Uytterhoeven <geert+renesas@glider.be>
> X-GND-Status: LEGIT
> Received-SPF: pass (spool2: domain of kernel.org designates
> 198.145.29.99 as permitted sender) client-ip=198.145.29.99;
> envelope-from=patchwork-bot+linux-i3c@kernel.org;
> helo=mail.kernel.org;
> 
> Hello:
> 
> This patch was applied to i3c/linux.git (refs/heads/i3c/next).
> 
> On Thu, 24 Oct 2019 17:37:56 +0200 you wrote:
> > The linux-i3c mailing list is moderated for non-subscribers.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)  
> 
> 
> Here is a summary with links:
>   - MAINTAINERS: Mark linux-i3c mailing list moderated
>     https://git.kernel.org/i3c/c/469191c7fcd069a500c2a26c49c9baef9dabf66d
> 
> You are awesome, thank you!
> 

