Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A92C47404
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 02:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7158F2067B
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 02:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbfJLCOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 22:14:42 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:38721 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728602AbfJLCOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 22:14:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C5D5C837F24C;
        Sat, 12 Oct 2019 02:14:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: toad72_4533592a26929
X-Filterd-Recvd-Size: 2596
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Oct 2019 02:14:35 +0000 (UTC)
Message-ID: <01e7fa29d34f210348355c4a507a714e086e7a30.camel@perches.com>
Subject: Re: [PATCH 0/4] treewide: Add 'fallthrough' pseudo-keyword
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-sctp@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Date:   Fri, 11 Oct 2019 19:14:33 -0700
In-Reply-To: <CAHk-=wi1T1m-su8zK5LeESoz_Pgf1-4hnjr516NiDLNyb4USug@mail.gmail.com>
References: <cover.1570292505.git.joe@perches.com>
         <CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com>
         <9fe980f7e28242c2835ffae34914c5f68e8268a7.camel@perches.com>
         <CAHk-=wi1T1m-su8zK5LeESoz_Pgf1-4hnjr516NiDLNyb4USug@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-10-11 at 10:46 -0700, Linus Torvalds wrote:
> On Fri, Oct 11, 2019 at 10:43 AM Joe Perches <joe@perches.com> wrote:
> > Shouldn't a conversion script be public somewhere?
> 
> I feel the ones that might want to do the conversion on their own are
> the ones that don't necessarily trust the script.
> 
> But I don't even know if anybody does want to, I just feel it's an option.

What's the harm in keeping the script in the
tree until it's no longer needed?


