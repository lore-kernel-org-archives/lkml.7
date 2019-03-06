Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294DDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F367020684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 19:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730895AbfCFTuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 14:50:14 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35607 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfCFTuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 14:50:13 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so14317681qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 11:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocFvprpYC/VZZTASz1bNDBxxVvAStEX8EGV+wmmvxCU=;
        b=dMDWN4JNjHJQd8V8z8qWMNkD4aHMJteLo7V1MQibpxP+VtLgwfeDXewKiTvp/bmx0Q
         c4lRzszibEFzVTSDqTENgaLu0OnjvXjEp5/gVWgXTOO5NH2bWdkQMT3XuuyjNPG+T55E
         6WdazZP88q7PPxTKEgJLFPl9Ii1vfhAP/i+r/EGyJ/fR6VGtVXIFYSDM/26N1SSmEwux
         nf7D+erFN4Xp7MHMhuKK26vX8EKeQg26j3fgKy6Za7vB4Kj6REKclXf0ZlLGDpZBKcR6
         mwNFKxEMYiiSQ7vvzxhktPNE4UcPSRmh8kXR2Mu72TBNphTVFgPlPsgxLMECbryRVpDr
         Y1HQ==
X-Gm-Message-State: APjAAAUt+pVQFFlzpv0Q8wxUC+phznSw0L3E/vPnZ38fBXDfI8u+qiRe
        Pwd4ieWPDQ6GUu0hdqKaZ8VHLz8O8KL/zL4nTWU=
X-Google-Smtp-Source: APXvYqxCv3SACJJthGi0f+tN1g3N0/2G/efwR7eMGu8e3iMfYq0ljfrcESP2xVET3EluGuaxy8HJ/WPJLWJjQePUTQ8=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr7032944qtb.319.1551901812932;
 Wed, 06 Mar 2019 11:50:12 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
 <CAK8P3a1k3y0ZHLxGNBoynF+tpej9PVQUT7PgP1RLCuXWonKmHg@mail.gmail.com> <CAHk-=wgzU7hcH+6oabXn-WDtCxvJhmG1Wopx0KLFo-o8ySPbHw@mail.gmail.com>
In-Reply-To: <CAHk-=wgzU7hcH+6oabXn-WDtCxvJhmG1Wopx0KLFo-o8ySPbHw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 20:49:53 +0100
Message-ID: <CAK8P3a1mxzdRqdaVs7D4rx342CoNjdN1kNaZ3bhas1HegYUdNg@mail.gmail.com>
Subject: Re: [GIT PULL 4/6] ARM: SoC defconfig updates for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 7:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Another small side note on these pull requests:
>
> On Wed, Mar 6, 2019 at 7:35 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> >  arch/arm/configs/lpc32xx_defconfig    | 65
> > +++++++++++++++++++++++++++++++----------------------------------
>
> You have a lot of these kinds of line-wrapped diffstat lines.
>
> The reason is *probably* that you've just cut-and-pasted from your
> (very wide) terminal where you ran your scripts into the email.
>
> Becaue if you run "git diff --stat" normally in a germinal, it will
> take the terminal width into account.
>
> If you run it in a script to a file or pipe, it will default width of
> 80 columns.
>
> You could make your scripts just do "--stat=80" to do that, but you
> might also consider using "xsel" to avoid the cutting-and-selecting
> part, and just do
>
>     my-release-script | xsel
>
> to select the output of the script, and then paste it with your mouse...

I used to do that (with xclip), but something changed recently in gmail
that broke pasting the output, which now gets horribly reformatted
unless I copy from the terminal.

I now tried without sucess to set the diff.statGraphWidth git-config
variable. I'll probably just use "git request-pull ... |cat" in the future.
I've done that in the past, but had not realized that I'm currently
causing the bad line breaks.

       Arnd
