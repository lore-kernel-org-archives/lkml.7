Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77688C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 06:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551ED20835
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 06:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfJFGfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 02:35:48 -0400
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:33599 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726171AbfJFGfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 02:35:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A0577182CED2A;
        Sun,  6 Oct 2019 06:35:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: price21_6c2dfa516272e
X-Filterd-Recvd-Size: 3059
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun,  6 Oct 2019 06:35:43 +0000 (UTC)
Message-ID: <52794b248ba13e88ab4c30c9b6ea55a7be30df5d.camel@perches.com>
Subject: Re: [PATCH 4/4] scripts/cvt_style.pl: Tool to reformat sources in
 various ways
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Pavel Machek <pavel@ucw.cz>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Sat, 05 Oct 2019 23:35:42 -0700
In-Reply-To: <CANiq72nwDgMgXNczW=JRANzH72=f0ukwVoPaud1d7J4YQLQX=w@mail.gmail.com>
References: <cover.1570292505.git.joe@perches.com>
         <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
         <CANiq72nwDgMgXNczW=JRANzH72=f0ukwVoPaud1d7J4YQLQX=w@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-10-05 at 19:31 +0200, Miguel Ojeda wrote:
> Hi Joe,

Hello.

> On Sat, Oct 5, 2019 at 6:47 PM Joe Perches <joe@perches.com> wrote:
[]
> > As for the commit itself: while I am sure this tool is very useful
> (and certainly you put a *lot* of effort into this tool), I don't see
> how it is related to the fallthrough remapping (at least the
> non-fallthrough parts).

It's not particularly related.

It's a 10 year old script that I just extended because it's
convenient for me.

I think I first posted it in 2011, but I started it as a
complement to checkpatch in 2010.

https://lwn.net/Articles/380161/

Doing the regexes for the fallthrough conversions took me
a couple hours.

> Also, we should consider whether we want more tools like this now or
> simply put the efforts into moving to clang-format.

I think clang-format could not do this sort of conversion.
Nor could coccinelle or checkpatch.

Anyway, it's not really necessary for this particular patch
to be applied, but it's a convenient way to show the script
has the capability to do fallthrough comment conversions.

I think it does conversions fairly reasonably but likely
some files could not compile without adding an #include
like:

#include <linux/compiler.h>


