Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A32C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E5920661
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 20:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbfK0UIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:08:12 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:37469 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbfK0UIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 15:08:11 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mpkwn-1i27IC25qX-00q8gd for <linux-kernel@vger.kernel.org>; Wed, 27 Nov
 2019 21:08:09 +0100
Received: by mail-qk1-f169.google.com with SMTP id i3so20670209qkk.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 12:08:09 -0800 (PST)
X-Gm-Message-State: APjAAAV5B6IJBQK5RVR/7yJ8e9Dx/f7HM/rqyLW5pb3Sp4dBnv7M/Qp7
        MvJDN5+MrGUMvcv1SI4QSKjo15XY7XlojMMABEo=
X-Google-Smtp-Source: APXvYqzcNVu3fO7i91gjwNcaV9OF6/CKyEXKbuREUw8EBcDiWjAHIfMXmGLuY9AakmO3RmUhj9WPcvhX6uYtvNag4BQ=
X-Received: by 2002:ae9:eb12:: with SMTP id b18mr6203027qkg.3.1574885288247;
 Wed, 27 Nov 2019 12:08:08 -0800 (PST)
MIME-Version: 1.0
References: <18FA40DC4B7A9742B8E58FC4CDA67429AFC83C55@dggeml526-mbx.china.huawei.com>
 <201911271013.38BA7015C6@keescook>
In-Reply-To: <201911271013.38BA7015C6@keescook>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 27 Nov 2019 21:07:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2ijLz0mtW5j9VamuQLdCOyLsr_wTVysi=X_XZyMGAOGw@mail.gmail.com>
Message-ID: <CAK8P3a2ijLz0mtW5j9VamuQLdCOyLsr_wTVysi=X_XZyMGAOGw@mail.gmail.com>
Subject: Re: Questions about "security functions" and "suppression of
 compilation alarms".
To:     Kees Cook <keescook@chromium.org>
Cc:     "Shiyunming (Seth, RTOS)" <shiyunming@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lizi (D)" <lizi4@huawei.com>, "Sunke (SK)" <sunke09@huawei.com>,
        Jiangyangyang <jiangyangyang@huawei.com>,
        Linzichang <linzichang@huawei.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:2Mr9STVhy77E1htWKy5pWHXKngXpsFEyHBejfLP9n/xdtPb6zLZ
 L7Uxr4uL15WCPs3mSU0tlZMDYGhfg9UfS02/7eeuvWilrC/qhNVwCDju9q13AMeexwBusOJ
 mFQRxA//ADoRYXC0C6L6+lEWCkVCin1Zp/QplRXMO67XrsQ48kv0CP4w1do1ntz28q5bGwh
 A0hXTYsxspzgaxuZ+Yw/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iJBkHJtNarE=:tTwk4p6+q8h6N3mSvcJyrO
 11Z0WCSps+XuvpYL7n2VzGX83s3w72GeLoAZmuogYYFu/8qZLcPGpzsaAb9HEWebDN7R+/PTG
 CXu2W9mK9uIZ3o/Lt9ROykxoGE9krUu1Ti723oL2/8s1v5gkTKScUBojWcBEg/8n8LWoQBmOk
 iCSuraLbzEKMQGyxk5j/eS3iiPaTLBM2HQeKeMNsrMETFR7O96Gwngv+tzcEhu4es872NrHfv
 +kW3JHACuMkV/FNhFrZ/WalfDdcoswYErmErCjfagbsiAZgjUJ0tpaIe6gzyI0KsYiQ2XLVx/
 9k0FcMwP2O5hgRF7GRzV+mJwIWi5hyCuShOFatDBJOF1wXqDm8jsllLgD7C+Jh65YtyHNF9T0
 Uq1P8V/wmzYjnoRV0Yz/TydImVYPp974Yv0yHNzZrdeDpuQYrtSIKeeSXvOOzB0v7MI3UDK7y
 3d4euyd1xDpiEKgM3qBi8kKBQ8kzbNqzZAZ6G+rRXjHXyXf71U57lq2yaOIpXFhmvGEFGxv0m
 ZYRfTkl4TcnfCwhXhOysdAupONqWeb88gcQpiETEDbdnykMStAJg6pHzRf/YhKIV0THj92gWj
 duXrxgZvUj4hUorEYGIzqzZyyHxEfz+jcBMavPxZQJpZD4SQ67IeWCKROsGDyMJ/4jGXl8zXR
 bb2J0vRJNl005J/I7vGmdkZcN/S+zfWdtd4wVKx25hTbnYfAECURdNo8317LihJNlKsFYwfW3
 UpZqGNpZ/E95C/74yWpdysrRAmnJyYyWGFrZsxft4B/8cpQMTYEUdCYWa66POAZjrYKtxLVqM
 zUCRqXJzKD2wIIQ1Nfna5Fh/L1rlwj4Adx7tgRvQRPbXPtxF9+skZstDIs22d9TrcV3Bftb1Z
 bJypb5Rs44YShU04cgtg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2019 at 8:01 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Nov 27, 2019 at 01:11:50PM +0000, Shiyunming (Seth, RTOS) wrote:
> Each of these needs to be handled on a case-by-case basis. Kernel builds
> are expected to build without warnings, so before a new compiler flag
> can be added to the global build, all the instances need to be
> addressed. (Flags are regularly turned off because they are enabled by
> default in newer compiler versions but this causes too many warnings.)
> See the "W=1", "W=2", etc build options for enabling these:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/Makefile.extrawarn
>
> Once all instances of a warning are eliminated, these warnings can be
> moved to the top-level Makefile. Arnd Bergmann does a lot of this work
> and might be able to speak more coherently about this. :) For example,
> here is enabling of -Wmaybe-uninitialized back in the v4.10 kernel:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4324cb23f4569edcf76e637cdb3c1dfe8e8a85e4

Incidentally, I've worked on changing the way we handle warnings over
the past week, going through all ~700 warning options supported by
either clang or gcc to figure out how many instances we get and if
we are missing any important ones.

https://pastebin.com/wqG9QgHj has a list of the warnings that exist,
when they got added and how many I saw. I'll post this as proper
patches when I have integrated this into the build system better.

> Speaking specifically to your list:
>
> -Wformat-security
>   This has tons of false positives, and likely requires fixing the
>   compiler.

the only warning I see here is "warning: format not a string literal and
no format arguments", this seems useful at the W=1 or W=2
level, but I can't even think of how to change the compiler to
turn this on by default.

> -Wpointer-sign
>   Lots of things in the kernel pass pointers around in weird ways. This
>   is disabled to allow normal operation (which, combined with
>   -fwrapv-pointer and -fwrapv via -fno-strict-overflow) means signed
>   things and pointers behave without "undefined behavior". A lot of work
>   would be needed all over the kernel to enable this warning (and part
>   of that would be incrementally removing unexpected overflows of both
>   unsigned and signed arithmetic).

I have the suspicion that this would actually find some serious bugs,
but I also share your view that this is near-impossible to fix
throughout the kernel.

My experiments show around 3000 files that cause this warning,
though fixing the ones in shared header files would get us closer
to enabling it at W=1. Most of the output from this seems to be from
two header files.

> -Wframe-address
>   __builtin_frame_address() gets used in "safe" places on the
>   architectures where the limitations are understood, so adding this
>   warning doesn't gain anything because it's already rare and gets
>   some scrutiny.

This one could be enabled by default and then disabled locally
in functions that are known to be safe.

> -Wmaybe-uninitialized
>   And linked above, this is enabled by default since v4.10.
>
> -Wformat-overflow
>   See https://git.kernel.org/linus/bd664f6b3e376a8ef4990f87d08271cc2d01ba9a
>   for details. Eliminating these warnings (there were 1500) needs to
>   happen before they can be turned back on. Any help here is very
>   welcome!

In the current kernel, I see only around 100 files that produce this warning,
so this one is definitely in reach.

> Warnings seen from newly introduced code get fixed very quickly, yes.
> Problems that were already existing and are surfaced by new warnings
> tend to get less direct attention by maintainers since it creates a
> large amount of work where it is hard to measure the benefit. However,
> people contributing changes in these areas tend to be very well received.
> For example, Gustavo A. R. Silva did a huge amount of work to enable
> -Wimplicit-fallthrough: https://lwn.net/Articles/794944/

With the patch series I'm working on, we will be able to control the warning
level (W=1, W=12 etc) per file and per subsystem, which I hope should make
it easier to attack some of the hard problems by fixing a whole class
of warnings one subsystem at a time.

     Arnd
