Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B2FC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08272148D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 03:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="I9flOMnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfDXDvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 23:51:50 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:17750 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbfDXDvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 23:51:50 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x3O3pdiE007519;
        Wed, 24 Apr 2019 12:51:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x3O3pdiE007519
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556077900;
        bh=+HJeyNjpRgp8bYTWk5WH+vdNtyBYFFKDuTqCkYj2rOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I9flOMnKO8pgKJJkcxBLsmLGmMCqAPSIu6sDfKL25hH/EH78HUDoo5MhpPNWGFtyv
         tL77IXBxrZr26prgwiw+IeMlAUoxsFywNE+X/Im+8ZSl5o1pVXD5UvjiTCS2UJNgYJ
         UMjqfsaJ6XZ5Z4DJV680zpKQQjvRW3Xc+Npi4EH/gLHEyxaEPE1xpEupqj40I2HfIZ
         df9AnlCCMLHh+5G/z8XlRfCdXet1m9nWT2lv5oEB4Wh2+Nyi2ihd7WBxuGPI4GhskW
         E8hgurkX1f6o7kpHbNqYlykTn+OU55iE8jlLo3gIYeCuMSylBeSJnRNtUTAoExzUdd
         Nneo9ZICBHOqg==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id s2so9580254vsi.5;
        Tue, 23 Apr 2019 20:51:40 -0700 (PDT)
X-Gm-Message-State: APjAAAXnwWQXC9MXMWOGO4/Y4dXydQ8qFd2EdrpgxejYJLEAwRE7hXw3
        I6GSRQdv/fKx/iQePNAe53EPizCLnZA0l5g5uFs=
X-Google-Smtp-Source: APXvYqxsUTFBYv/TA0s3DojNe8ro2oiPdhhm/v2+YG0pTgOTFckcQuADD8qLwY2G50volvs+Fg4rSj1y8P6isyQVvWc=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr16408997vsc.54.1556077899016;
 Tue, 23 Apr 2019 20:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190423212741.12219-1-ndesaulniers@google.com>
In-Reply-To: <20190423212741.12219-1-ndesaulniers@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 24 Apr 2019 12:51:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS9zy92MZQ7qj3xQtS+MeYr2cVsrekcBv8yVG6Qu0Fzkw@mail.gmail.com>
Message-ID: <CAK7LNAS9zy92MZQ7qj3xQtS+MeYr2cVsrekcBv8yVG6Qu0Fzkw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: drop support for cc-ldoption
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        clang-built-linux@googlegroups.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 6:27 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> If you want to see if your linker supports a certain flag, then ask the
> linker directly with ld-option (not the compiler with cc-ldoption).
> Checking for linker flag support is an antipattern that complicates the
> usage of various linkers other than bfd via -fuse-ld={bfd|gold|lld}.
>
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> This should probably wait until all of the call sites have been cleaned
> up.

Indeed.
Please remind me if I forget to apply this.


> Masahiro sent them for arm and arm64, while I sent cleanups for all
> the rest.

Thanks. I did not even notice cc-ldoption were checking
quite old flags.




>
>
>  Documentation/kbuild/makefiles.txt | 14 --------------
>  scripts/Kbuild.include             |  5 -----
>  2 files changed, 19 deletions(-)
>
> diff --git a/Documentation/kbuild/makefiles.txt b/Documentation/kbuild/makefiles.txt
> index 03c065855eaf..d65ad5746f94 100644
> --- a/Documentation/kbuild/makefiles.txt
> +++ b/Documentation/kbuild/makefiles.txt
> @@ -437,20 +437,6 @@ more details, with real examples.
>         The second argument is optional, and if supplied will be used
>         if first argument is not supported.
>
> -    cc-ldoption
> -       cc-ldoption is used to check if $(CC) when used to link object files
> -       supports the given option.  An optional second option may be
> -       specified if first option are not supported.
> -
> -       Example:
> -               #arch/x86/kernel/Makefile
> -               vsyscall-flags += $(call cc-ldoption, -Wl$(comma)--hash-style=sysv)
> -
> -       In the above example, vsyscall-flags will be assigned the option
> -       -Wl$(comma)--hash-style=sysv if it is supported by $(CC).
> -       The second argument is optional, and if supplied will be used
> -       if first argument is not supported.
> -
>      as-instr
>         as-instr checks if the assembler reports a specific instruction
>         and then outputs either option1 or option2
> diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
> index 7484b9d8272f..fbfb37d1bcc8 100644
> --- a/scripts/Kbuild.include
> +++ b/scripts/Kbuild.include
> @@ -138,11 +138,6 @@ cc-disable-warning = $(call try-run,\
>  # Usage:  EXTRA_CFLAGS += $(call cc-ifversion, -lt, 0402, -O1)
>  cc-ifversion = $(shell [ $(CONFIG_GCC_VERSION)0 $(1) $(2)000 ] && echo $(3) || echo $(4))
>
> -# cc-ldoption
> -# Usage: ldflags += $(call cc-ldoption, -Wl$(comma)--hash-style=both)
> -cc-ldoption = $(call try-run,\
> -       $(CC) $(1) $(KBUILD_CPPFLAGS) $(CC_OPTION_CFLAGS) -nostdlib -x c /dev/null -o "$$TMP",$(1),$(2))
> -
>  # ld-option
>  # Usage: KBUILD_LDFLAGS += $(call ld-option, -X, -Y)
>  ld-option = $(call try-run, $(LD) $(KBUILD_LDFLAGS) $(1) -v,$(1),$(2),$(3))
> --
> 2.21.0.593.g511ec345e18-goog
>


-- 
Best Regards
Masahiro Yamada
