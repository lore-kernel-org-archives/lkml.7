Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0DAC606AF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E231E20861
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbfGHNOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:14:02 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45016 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbfGHNOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:14:02 -0400
Received: by mail-ot1-f68.google.com with SMTP id b7so16084444otl.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 06:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZBnFtZTozEvkjSCFrFfeI5WdMoWNbcjmPpJ/hHYCK8=;
        b=H0IciqNhT7yTw6g3Nm6Tt48/PR3Oy8A0cI0MvNmB3wrHGoaKjXfo4pGfHAHhIub+5e
         weJx+zddmy3Q07rbl6oRuTk+Zi3G/XAufC5aKBkpQUHjjO2P+doqibz8SC1zaV84rH6A
         u5sNunZQ6lUa/Ps73aHdVT8uB04OX/zkdMsdkzz+N7meYjyAWliDltiaBhwwQjBF09zR
         t8NCO8epgRHC/AfEVBhT1gKyyalLVsILi9CFjQg4UsiUHwETXzp3iKCNtGK5djXPTSyF
         FHQlJb5e6GxQ77uba0QlKWo2/S+gSC5S5Ns33c3/FqsXD7i9glv7ReKGAJPK0TS1Wk6S
         Z7dw==
X-Gm-Message-State: APjAAAU0/IbspncuTvqor2EPIAe/pKMshwQpWM0PPjUQcY+5RBTnQYNJ
        tY3rCxJHlpCmBnrRyIJZWvt9zwYgykZ6OfaIZuE=
X-Google-Smtp-Source: APXvYqzzSz/Bgqz/+zfpH+v7d6E2Z07x7++jIeupn4hy3Mu+Jrsbq7On7Yy1h7QcUvj3bULrerepixTzzBuI3bLyUiI=
X-Received: by 2002:a05:6830:210f:: with SMTP id i15mr14393725otc.250.1562591641895;
 Mon, 08 Jul 2019 06:14:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190704115532.15679-1-andriy.shevchenko@linux.intel.com> <20190708130159.whefdhz4d65exdns@pathway.suse.cz>
In-Reply-To: <20190708130159.whefdhz4d65exdns@pathway.suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jul 2019 15:13:50 +0200
Message-ID: <CAMuHMdWLT-BKKv9X=7-0d_AbxR+gdbhZZhMxGhrvJ6A2TpeLbg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kernel.h: Update comment about simple_strto<foo>() functions
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mans Rullgard <mans@mansr.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Mon, Jul 8, 2019 at 3:02 PM Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2019-07-04 14:55:31, Andy Shevchenko wrote:
> > There were discussions in the past about use cases for
> > simple_strto<foo>() functions and, in some rare cases,
> > they have a benefit over kstrto<foo>() ones.
> >
> > Update a comment to reduce confusion about special use cases.
> >
> > Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > - update comment based on Geert's input
> >  include/linux/kernel.h | 17 ++++++++++++-----
> >  1 file changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 0c9bc231107f..63663c44933d 100644
> > --- a/include/linux/kernel.h
> > +++ b/include/linux/kernel.h
> > @@ -332,8 +332,7 @@ int __must_check kstrtoll(const char *s, unsigned int base, long long *res);
> >   * @res: Where to write the result of the conversion on success.
> >   *
> >   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> > - * Used as a replacement for the obsolete simple_strtoull. Return code must
> > - * be checked.
> > + * Used as a replacement for the simple_strtoull. Return code must be checked.
> >  */
> >  static inline int __must_check kstrtoul(const char *s, unsigned int base, unsigned long *res)
> >  {
> > @@ -361,8 +360,7 @@ static inline int __must_check kstrtoul(const char *s, unsigned int base, unsign
> >   * @res: Where to write the result of the conversion on success.
> >   *
> >   * Returns 0 on success, -ERANGE on overflow and -EINVAL on parsing error.
> > - * Used as a replacement for the obsolete simple_strtoull. Return code must
> > - * be checked.
> > + * Used as a replacement for the simple_strtoull. Return code must be checked.
> >   */
> >  static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
> >  {
> > @@ -438,7 +436,16 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
> >       return kstrtoint_from_user(s, count, base, res);
> >  }
> >
> > -/* Obsolete, do not use.  Use kstrto<foo> instead */
> > +/*
> > + * Use kstrto<foo> instead.
> > + *
> > + * NOTE: The simple_strto<foo> does not check for overflow and,
> > + *    depending on the input, may give interesting results.
>
> I am a bit confused whether the interesting results are caused
> by the buffer overflow or if there is another reason.

Which buffer overflow?
> If it is because of the overflow, I would remove the 2nd line. I guess
> that anyone knows what a buffer overflow might cause.

AFAIK, the overflow is a numerical overflow.

The "interesting result" is that the function keeps parsing until it finds
a character that doesn't fit in the range of expected characters, according
to the specified numerical base, but further ignoring character class.
But that's really what you want, when you want to parse things like
10x50 or 10:50.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
