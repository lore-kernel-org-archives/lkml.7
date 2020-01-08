Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D55C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A4320692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 15:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgAHPOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:14:05 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:53111 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgAHPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 10:14:05 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Myevl-1jcDe22sbV-00yvPz for <linux-kernel@vger.kernel.org>; Wed, 08 Jan
 2020 16:14:03 +0100
Received: by mail-qk1-f172.google.com with SMTP id a203so2935490qkc.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 07:14:03 -0800 (PST)
X-Gm-Message-State: APjAAAXV093Vinni+XRya+IgwuvIkPuxM3cfYySZpTH5xux646XEkSXw
        TR2eIVCayteptPRMepG9cDodzwk+NE+2M8W9qSo=
X-Google-Smtp-Source: APXvYqz3CC+B2rmf+STNhEJll7RchhhMWz3hcMNuw3sVJWjAK9HUGtsoGX+yCGR/I2SGoRy4zIP4sz1OpgfEVPBYogA=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr4864685qka.286.1578496442498;
 Wed, 08 Jan 2020 07:14:02 -0800 (PST)
MIME-Version: 1.0
References: <201912301716.xBUHGKTi016375@pmwg-server-01.pmwglab>
 <CAK8P3a1OsiUV5YuwzSJ4CsD8NHJHjedTA4K7xBKK6Q-4kA8t5g@mail.gmail.com> <CAFd5g46YYiC-aeAGumqOMiNZ71h2dGH==F_bdj+pwQ5YOHo3GA@mail.gmail.com>
In-Reply-To: <CAFd5g46YYiC-aeAGumqOMiNZ71h2dGH==F_bdj+pwQ5YOHo3GA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jan 2020 16:13:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0cZQ-8sX=_2Oa_GQeHeMxsQpdJH=zUoeRXyM-7_MmE9g@mail.gmail.com>
Message-ID: <CAK8P3a0cZQ-8sX=_2Oa_GQeHeMxsQpdJH=zUoeRXyM-7_MmE9g@mail.gmail.com>
Subject: Re: kunit stack usage, was: pmwg-ci report v5.5-rc4-147-gc62d43442481
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, PMWG CI <pmwg-ci@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Private Kernel Alias <private-kwg@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:mThdcVCQm/1JBc3ApNozt0Nz9g0tEjIrhQkwMl0t0UEuChZ6JFT
 wwMr/Qw5oJMCUp/ywVRDqR/nDbZT/7W2LpYQ5KPzgQ8iPLUVzY4mtADi27Gdt1K6DHjGFR9
 w1sXwep4v/WqSZ64HxhEx1St0TIkyxS/kzn/Iv1a2xxLeqvtEgJcl4/1KpOs0IkQq5sUYIG
 Gwf+ikg7l+m+aQpoXz5nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f+6xnR9/pXc=:hrwOMtk2JhHyVkbIUjpc6h
 SQJYmD0WnH5TPFbNYgvOPdXNGB5H4WCzha1EIuSOIwuOH2ovbfZsmSJ/XxEnvbpcHFBybVudP
 IzWG79IfzXVLgLVqz1GLhHM3wOQ3Tm3hvC7Q9yVC76ICEQfsVtbt0rHBjPy6/XyrAK6moX91Z
 2RksBOfR2PA6Zx4bZGgsea7QUSt+oa5Ss7FqFYShjoZfhzHNS64n3DlXoyhxvn14e5hqPQT1a
 MKRpIEWOqyb3tLnRK/Qx/ovvUq7Wc9acgPP6m2CLa8dlcKI0b1nUgSV7pqniXarJAP8FSdiP6
 NJFSJYYzBqeNkx5J9Yni45+cTWKt9Fn5gpwkI3l9Nh3vjMIt9ZMaoqhCFRcT95wALhiyNcniV
 6dIiJk3YomUFahwC1dAQIwy7HM68M3SYzjro6PH9dbyg4kOT0R/iRfkFqV99lQbgXj+1uHcHr
 EQ2Mzn/+fUUl1W02tpmfh788JsaepW8Rept7ssKw8p0xqf3QLXbRTrEX7wJYjVS+I2yuhI6ae
 SSXa8n8bg9/djWTzCoDWWHrJvVg8gVKAqichCMtPSM48RqC7H4l1vcZdm6CDdroF7plsZ78Mc
 arYef37ZPWfvb2UFnwSe4q2VEME5ex/zGNcHx52hvWnc6ybKvkuhqM6tCXNgMDOkPkkFIJDGo
 /DEAXCyksN9ovt8UkmRUXQ/QJp04UNt0cNQtbzsZSmQnOkC3ApcRcrKGb+oNlT9Lr2u8/Ihox
 GyvK3qSL34p8U61FDJxOe9thL6zFgQI/Gr0pTK03eDBbKj+33VrgXBYqwwPMWgACs5tTQBww0
 ybbTLnbL4KRgaEynaHJRiqCpxjkmt3hOWqqtr9guVxFHBovVpJTCM4ikgGJZfVnyhAoOt4QBc
 iK/4MllI4GjzKAdBMEGw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 3:41 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
> On Tue, Jan 7, 2020 at 4:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Dec 30, 2019 at 6:16 PM PMWG CI <pmwg-ci@linaro.org> wrote:
> > pe_test_uint_arrays() contains a couple of larger variables, plus 41
> > instances of KUNIT_EXPECT_*() or KUNIT_ASSERT_*(), each one
> > of these adds its own copy of the structure, eventually exceeding
> > the warning limit.
>
> Uh oh, sorry about that.

No worries, I don't think anyone could have foreseen that bug.

> Another idea, the struct just exists to pack up data and ship it off
> to a function which handles the expectation/assertion. Consequently,
> the struct is only used inside the expectation/assertion macro; it is
> not needed before the macro block and is not needed after it. So could
> we maybe make some kind of expectation/assertion union so that we know
> they are all the same size, and then somehow tag the stack allocation
> so that we only ever have one copy in a stack frame? I am not sure if
> that kind of compiler magic exists. I guess one way to accomplish this
> is to make a dummy function in KUnit whose job it is to call the unit
> test function, which allocates the object, and then calls the unit
> test function with a reference to the object allocation; then we could
> just reuse that allocation and we can avoid making a bunch of
> piecemeal heap allocations.
>
> What do people think? Any other ideas?

The idea of annotating it got me thinking about what could be
done to improve the structleak plugin, and that in turn got me on
the right track to a silly but trivial fix for the issue: The only thing
that structleak does here is to initialize the implied padding in
the kunit_binary_assert structure. If there is no padding, it all
works out find and the structures don't get pinned to the stack
because the plugin can simply ignore them.

I tried out this patch and it works:

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index db6a0fca09b4..5b09439fa8ae 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -200,8 +200,9 @@ struct kunit_binary_assert {
        struct kunit_assert assert;
        const char *operation;
        const char *left_text;
-       long long left_value;
        const char *right_text;
+       long __pad;
+       long long left_value;
        long long right_value;
 };

There may also be a problem in 'struct kunit_assert' depending on the
architecture, if there are any on which the 'enum kunit_assert_type'
type is 64 bit wide (which I think is allowed in C, but may not happen
on any toolchain that builds kernels).

      Arnd
