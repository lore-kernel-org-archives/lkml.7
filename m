Return-Path: <SRS0=y5Xy=UI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07EDC28EBD
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B331620868
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Jun 2019 09:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbfFIJTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 05:19:43 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46659 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbfFIJTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 05:19:42 -0400
Received: by mail-lf1-f65.google.com with SMTP id z15so1892132lfh.13;
        Sun, 09 Jun 2019 02:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tm1kUkU8K0xP+6qbFcyeQd6hDSnbqz5Xinvig3WgCVk=;
        b=tgmF/+F8MayA//Guy9XStbdA6BocwtPRn5ozoX8XchLUePohMIpuYrxOUaxST54EQl
         6nqCBmmXX0iUzBFsf0j/NPwOEgo42RcY8cOPuwfXzWsbV3xXxgyOPQNiJYrdk+/ZlFBl
         OLi3ImGC7QD5B0xANqAX606a1VNMeqTok4ENK9Sj17HgZibK/wvr/oIuMd3/sQWF5FgS
         dSEUskRgqXbFboQ9fC9a9z+cMX7PlCsaSQNzM5FnivT9hmaz9gXTTvzwSGyOBgbvw07M
         OsVzZpJcJr7+1knhoK0c/xuG26CavyeqcdIHy+YNCK4qkac9HolfFUdVIz3hNyNfM54C
         WXdg==
X-Gm-Message-State: APjAAAU77NaJf99SeYyMoD7EKt3zF55NQyYZzCee0kYyVQ+xIkHz/KSa
        F6mMFGkCxZvx19chKsVFFc/YUX8rNGQfI7ATU4k=
X-Google-Smtp-Source: APXvYqxnnYV8kl5R90oD40qadn5h+TZeP7RkBZTi+rdt/dFdy/gyUH8r8MQ2aYrIT1EQJA6MQAqc14471W+iVtoVwcY=
X-Received: by 2002:ac2:546a:: with SMTP id e10mr31848175lfn.75.1560071980695;
 Sun, 09 Jun 2019 02:19:40 -0700 (PDT)
MIME-Version: 1.0
References: <ff457774d46d96e8fe56b45409aba39d87a8672a.1559933665.git.mchehab+samsung@kernel.org>
 <4948a096397bb86cebf489b8ac4f623797257fe7.1559933665.git.mchehab+samsung@kernel.org>
In-Reply-To: <4948a096397bb86cebf489b8ac4f623797257fe7.1559933665.git.mchehab+samsung@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 9 Jun 2019 11:19:28 +0200
Message-ID: <CAMuHMdVnBP-CJ5S0+D_H4RedkHV5m8m8wGXy-PRzaFk0JWdW8Q@mail.gmail.com>
Subject: Re: [PATCH v3 15/20] docs: move protection-keys.rst to the core-api book
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Fri, Jun 7, 2019 at 9:38 PM Mauro Carvalho Chehab
<mchehab+samsung@kernel.org> wrote:
> This document is used by multiple architectures:

Indeed it is...

>
>         $ echo $(git grep -l  pkey_mprotect arch|cut -d'/' -f 2|sort|uniq)
>         alpha arm arm64 ia64 m68k microblaze mips parisc powerpc s390 sh sparc x86 xtensa

... but not because we now have a unified space for new syscall numbers ;-)

$ git grep -w ARCH_HAS_PKEYS -- "*Kconf*"
arch/powerpc/Kconfig:   select ARCH_HAS_PKEYS
arch/x86/Kconfig:       select ARCH_HAS_PKEYS
mm/Kconfig:config ARCH_HAS_PKEYS

I.e. limited to x86 and powerpc.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
