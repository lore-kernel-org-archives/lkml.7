Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F060BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27FB2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 11:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfFZLA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:00:57 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37408 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZLA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 07:00:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id t76so1591257oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 04:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjcQQqiktiXBUAIFd7nlpxXWyUzxY+DMuLEktEvbc30=;
        b=hTTb45tKYuu6XzvD+F6xq3jEweX9FYE6ANqDGzkHs2I8dcwm8z7kPunAQQ+65eMJqP
         HqNJan3IAwTZ+wSCxc1iRkFY1WkxhhuqV8sU1Dt4eyW/OkrtlX3rDCq92n44fSjCd+NW
         3Kg6AEzPtRBsaFFjFXFJRgodzvSDHb9yrzemU3aYzUR2wIJPAQLdX4baS72/3O/BtEr7
         MCij9xIN1N/ws+FZ0LLXhcGFTBzkMWiQTeSIDl4Ygxhxelpo7fETbR9Kg+mVupJrb9hQ
         p/0t026ZSIFlv9HeB5GQlKx1Czjxb6YkcgAFvTKvRJKXddLB1x753GvIm7Y541+9YHWy
         QD9g==
X-Gm-Message-State: APjAAAUhtmUG80Mnp6l/kIh5RF+9YbuZnoeAhpRLu0bYoXVHO46JX1dP
        0zO3hat9y4z6Hy5MKkhFKE2Ur4KNO4fLM1bRM/U=
X-Google-Smtp-Source: APXvYqw+QzAqVD0/uhi53tE9uoKB3RSL2yacrvje0BgfWpSUun3tJn+/WYo/kC7jlQNrC3QeHXIziGe6uUTy8pqgvCY=
X-Received: by 2002:a05:6808:3c5:: with SMTP id o5mr1377335oie.102.1561546856308;
 Wed, 26 Jun 2019 04:00:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190626093943.49780-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20190626093943.49780-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Jun 2019 13:00:45 +0200
Message-ID: <CAMuHMdWm7ftYNVQfjLdPxvzZQLa6mWQvjE8vGo98-QOGeyjZFQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kernel.h: Update comment about simple_strto<foo>() functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mans Rullgard <mans@mansr.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Jun 26, 2019 at 11:39 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> There were discussions in the past about use cases for
> simple_strto<foo>() functions and in some rare cases they have a benefit
> on kstrto<foo>() ones.

over

> Update a comment to reduce confusing about special use cases.

confusion

> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h

> @@ -437,7 +435,15 @@ static inline int __must_check kstrtos32_from_user(const char __user *s, size_t
>         return kstrtoint_from_user(s, count, base, res);
>  }
>
> -/* Obsolete, do not use.  Use kstrto<foo> instead */
> +/*
> + * Use kstrto<foo> instead.
> + *
> + * NOTE: The simple_strto<foo> does not check for overflow and,
> + *      depending on the input, may give interesting results.
> + *
> + * Use these functions if and only if the code will need in place
> + * conversion and otherwise looks very ugly. Keep in mind above caveat.

What do you mean by "in place conversion"?
The input buffer is const, and not modified by the callee.
Do you mean that these functions do not require NUL termination (just
after the number), and the characters making up the number don't have to
be copied to a separate buffer to make them NUL-terminated?

> + */
>
>  extern unsigned long simple_strtoul(const char *,char **,unsigned int);
>  extern long simple_strtol(const char *,char **,unsigned int);

Yeah, they're still very useful.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
