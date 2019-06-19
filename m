Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47632C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25DB421721
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbfFSSKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:10:52 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:56895 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726175AbfFSSKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:10:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 311F7837F27D;
        Wed, 19 Jun 2019 18:10:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: way23_7b66ca55ffa0b
X-Filterd-Recvd-Size: 2550
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Jun 2019 18:10:47 +0000 (UTC)
Message-ID: <6bb0ac7f70a12a4bb9cb6238b4e50e23674bde43.camel@perches.com>
Subject: Re: [PATCH] net/ipv4: fib_trie: Avoid cryptic ternary expressions
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nathan Huckleberry <nhuck@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Date:   Wed, 19 Jun 2019 11:10:46 -0700
In-Reply-To: <CAKwvOdkJCt7Du01e3LreLdpREPuZXWYnUad6WzqwO_o4i0yk7A@mail.gmail.com>
References: <20190618211440.54179-1-mka@chromium.org>
         <20190618230420.GA84107@archlinux-epyc>
         <CAKwvOd=i2qsEO90cHn-Zvgd7vbhK5Z4RH89gJGy=Cjzbi9QRMA@mail.gmail.com>
         <f22006fedb0204ad05858609bc9d3ed0abc6078e.camel@perches.com>
         <CAKwvOdkJCt7Du01e3LreLdpREPuZXWYnUad6WzqwO_o4i0yk7A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-19 at 10:41 -0700, Nick Desaulniers wrote:
> On Wed, Jun 19, 2019 at 2:36 AM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2019-06-18 at 16:23 -0700, Nick Desaulniers wrote:
> > > As a side note, I'm going to try to see if MAINTAINERS and
> > > scripts/get_maintainers.pl supports regexes on the commit messages in
> > > order to cc our mailing list
> > 
> > Neither.  Why should either?
> 
> Looks like `K:` is exactly what I'm looking for.

Using K: for commit message content isn't the intended
use, but if it works for you, fine by me.

> Joe, how does:
> https://github.com/ClangBuiltLinux/linux/commit/a0a64b8d65c4e7e033f49e48cc610d6e4002927e
> look?

You might consider using

K:	\b(?i:clang|llvm)\b

to get case insensitive matches.

> Is there a maintainer for MAINTAINERS or do I just send the
> patch to Linus?

Generally MAINTAINER patches go via Andrew Morton or
indirectly along with other changes via a pull request
to Linus.



