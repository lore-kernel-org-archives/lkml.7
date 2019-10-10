Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9828DC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61536208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 20:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfJJUsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 16:48:43 -0400
Received: from smtprelay0058.hostedemail.com ([216.40.44.58]:38196 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbfJJUsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 16:48:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 88169781C;
        Thu, 10 Oct 2019 20:48:41 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dolls38_4b7237beba646
X-Filterd-Recvd-Size: 2857
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Oct 2019 20:48:38 +0000 (UTC)
Message-ID: <4b2ed594c5054138562c80cc94dee8b5398c9064.camel@perches.com>
Subject: Re: [PATCH 4/4] scripts/cvt_style.pl: Tool to reformat sources in
 various ways
From:   Joe Perches <joe@perches.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
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
Date:   Thu, 10 Oct 2019 13:48:37 -0700
In-Reply-To: <201910101338.59F36A33@keescook>
References: <cover.1570292505.git.joe@perches.com>
         <4a904777303fbaea75fe0875b7984c33824f4b68.1570292505.git.joe@perches.com>
         <CANiq72nwDgMgXNczW=JRANzH72=f0ukwVoPaud1d7J4YQLQX=w@mail.gmail.com>
         <52794b248ba13e88ab4c30c9b6ea55a7be30df5d.camel@perches.com>
         <201910101338.59F36A33@keescook>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-10-10 at 13:39 -0700, Kees Cook wrote:
> On Sat, Oct 05, 2019 at 11:35:42PM -0700, Joe Perches wrote:
[]
> > I think clang-format could not do this sort of conversion.
> > Nor could coccinelle or checkpatch.
> > 
> > Anyway, it's not really necessary for this particular patch
> > to be applied, but it's a convenient way to show the script
> > has the capability to do fallthrough comment conversions.
> > 
> > I think it does conversions fairly reasonably but likely
> > some files could not compile without adding an #include
> > like:
> > 
> > #include <linux/compiler.h>
> 
> I think this is a nice tool to add -- at the very least it serves as
> infrastructure for future similar conversions. And small cleanups can be
> generated from it for people looking to clean up subsystems, etc.

Another similar tool that used checkpatch and also compile
tested and created git commits was reformat_with_checkpatch

https://lore.kernel.org/lkml/1405128087.6751.12.camel@joe-AO725/


