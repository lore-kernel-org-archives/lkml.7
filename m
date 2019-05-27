Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB33C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605E121721
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfE0O1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:27:51 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44739 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfE0O1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:27:50 -0400
Received: by mail-lf1-f67.google.com with SMTP id r15so2749475lfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 07:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lv4/05KV1MJXr8JW8E95cKD+niHNUN/s+/GEdaLT7zk=;
        b=n/eaxXRrrsHvV0f+eStxUj3flr3IujLK6tPrhoHuw3u+PfOzEi6fVOH45bUxaPNIGN
         Pn1vJHSEHN0pX0oEQGJLqII4cSdLSv3tqM6sr4u4ROHo4DZVWenpV153rqU4j+45qx1F
         JWOUyGkStQNZbmMh0oSe2PBlauF7a4qLg03H5M3RwN98+d+0Omvmmq/5QkKFmgOH3Dk0
         qi+coPYSdU3rqFpM/jVtt9bL+fDysXcWzhF2CjJgrK1MNjb5rjjGPHfMYXzi/pfu2EKE
         8AFB54p0Bc+7myd0T/2H4s9UpgDUv8rUIckhJXyEnvMSCNC5DeO+Mznxpx3MLHV9rHdp
         HqXQ==
X-Gm-Message-State: APjAAAUzg1l07TPlybjBaqqFoAU0jCHzU0q1eFSGWQCKOK90S3zHE8uo
        tUYBAuGVIlqQ0aAh3c+dvZzJIWnHGOTPqz0YFao=
X-Google-Smtp-Source: APXvYqyxW8TMFs7m8kO3uZA+ackFyllrVL0q/7RvumaMTRDexubwz+FdZwsjxUXBThgtipi5LQym7ZYu+MRk1cWPjgI=
X-Received: by 2002:a19:c142:: with SMTP id r63mr572576lff.49.1558967269083;
 Mon, 27 May 2019 07:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190527122309.5840-1-geert+renesas@glider.be> <20190527141201.GA1537@gmail.com>
In-Reply-To: <20190527141201.GA1537@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 May 2019 16:27:36 +0200
Message-ID: <CAMuHMdV5TB4DRPuKkczYgCJ7+-yzEbnYp=TQydnK+3qmkPT4Tg@mail.gmail.com>
Subject: Re: [PATCH] [trivial] perf: Spelling s/EACCESS/EACCES/
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Mon, May 27, 2019 at 4:12 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > The correct spelling is EACCES:
> >
> > include/uapi/asm-generic/errno-base.h:#define EACCES 13 /* Permission denied */
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/include/linux/perf_event.h
> > +++ b/include/linux/perf_event.h
> > @@ -289,7 +289,7 @@ struct pmu {
> >        *  -EBUSY      -- @event is for this PMU but PMU temporarily unavailable
> >        *  -EINVAL     -- @event is for this PMU but @event is not valid
> >        *  -EOPNOTSUPP -- @event is for this PMU, @event is valid, but not supported
> > -      *  -EACCESS    -- @event is for this PMU, @event is valid, but no privilidges
> > +      *  -EACCES     -- @event is for this PMU, @event is valid, but no privilidges
> >        *
> >        *  0           -- @event is for this PMU and valid
> >        *
>
>
> Actually, -EACCES got typoed itself and survived due to historic reasons.

Quite possible... Someone pointed out a while ago it is part of POSIX,
hence it cannot be changed.

Probably we can do "#define EACCESS EACCES"?

> I think we can tolerate the 'typo' fixed in documentation, can we?

IMHO we cannot, as e.g. "git grep -w" won't match both.
Do you really want the documentation to differ from the implementation?

> Also, the *far* bigger typo is, in the same line:
>
> s/privilidges
>  /privileges

Thanks, that one didn't show up with "git grep -w EACCESS" ;-)
Will send v2...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
