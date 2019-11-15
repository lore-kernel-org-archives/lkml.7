Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10A0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C8B020732
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:54:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfKOIy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:54:28 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35478 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:54:28 -0500
Received: by mail-ot1-f65.google.com with SMTP id c14so415308oth.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:54:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xXAIHX2Tl2rPR9tSIWbBGJFZ8rTfCs0FskSAJ4Ev+rs=;
        b=B+xi3/LEkVd7NPwBiiUPa2Lwa8maXGUFBTb+VF9Z+HqD1x5OqiRT+iDFRdmrItw5dP
         jHlR9BYteBPZyjbTloYASQtYuO/v6FsNSU8NEegaltC8uk5716ZuwbOpXfWSd6cvMYoD
         jIpx7CM9YnirMM9R5SnMcglHY7wh74QxKmNBWscemW/ag54+cP9Ddcycd22RHhEZouOa
         2FuWYgxWUIk7ne6y8gWP7QQ/W9QaJMnCmH2nbF4D7aN4AXPnhWLtxZRGJhbfAFn5GwXI
         M/MTATgH3+I8/v/2xkemhlZu/V8olAXpo2kuSKtwASqduWeX0hd7rRB3zDoT1PJSg4qO
         uaBA==
X-Gm-Message-State: APjAAAW1JD+sSrS3WT5CIQPyF7YFOZjVvtFULav/LzHRrr9m0AOXqFhX
        E2AKn+V/XhMmoqnvBFpHgYhN+KRloIVPX6Ztop7sUq3l
X-Google-Smtp-Source: APXvYqyrQa5IxPsi3G7rS21hAK95+jhiYLA+S1aXs4vPX3QHlvXrVWf1Du1CX8vCc3Xf7tA+IQXdPThfCc6L3uJSoDg=
X-Received: by 2002:a9d:5511:: with SMTP id l17mr2306903oth.145.1573808066972;
 Fri, 15 Nov 2019 00:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20191024153756.31861-1-geert+renesas@glider.be>
 <20191115061554.532d29e9@collabora.com> <CAMuHMdWO=8sHn9wrEiuBGes0x_L2=Qkou=aPcHM7Mr9oDS74Qw@mail.gmail.com>
 <20191115094010.31acadf6@collabora.com>
In-Reply-To: <20191115094010.31acadf6@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Nov 2019 09:54:15 +0100
Message-ID: <CAMuHMdVvycHZv6g-vem7Mu4fqVc9FBx2xrdER85Sjb+vVW0=sA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Mark linux-i3c mailing list moderated
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Fri, Nov 15, 2019 at 9:40 AM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Fri, 15 Nov 2019 09:10:02 +0100
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> > Hi Boris,
> >
> > On Fri, Nov 15, 2019 at 6:16 AM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > > On Thu, 24 Oct 2019 17:37:56 +0200
> > > Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > > > The linux-i3c mailing list is moderated for non-subscribers.
> > > >
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > >
> > > Queued to i3c/next. It was actually queued 2 weeks ago but the
> > > patchwork bot didn't send a notification for that one (one was sent for
> > > your other patch) and I don't know why.
> >
> > It did:
>
> Ok, perfect then. Looks like sometimes it doesn't work, but for this
> patch I did receive a notification too (it was one notification for both
> of your patches and I thought I was receiving one per patch).

It is one per patch, I did receive the other one, too:

Subject: Re: [PATCH trivial] i3c: Spelling s/dicovered/discovered/
From: patchwork-bot+linux-i3c@kernel.org
Message-Id: <157251967168.27046.5733392327207757366.git-patchwork-notify@kernel.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
