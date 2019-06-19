Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B366C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0B1521734
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfFSS1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:27:46 -0400
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:45050 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbfFSS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:27:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7531D100E806B;
        Wed, 19 Jun 2019 18:27:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boats69_7da522d121463
X-Filterd-Recvd-Size: 1956
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Jun 2019 18:27:43 +0000 (UTC)
Message-ID: <d4b42858366e50f92b133ceb6399e9f16a7cef88.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Date:   Wed, 19 Jun 2019 11:27:42 -0700
In-Reply-To: <20190619181844.57696-1-ndesaulniers@google.com>
References: <20190619181844.57696-1-ndesaulniers@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-19 at 11:18 -0700, Nick Desaulniers wrote:
> Add keyword support so that our mailing list gets cc'ed for clang/llvm
> patches.

You'd also possibly get cc'd on patches that merely mention
clang or llvm like any change to clang-format.  It could be
many files that aren't interesting.

$ git grep -i -w -P --name-only '(?i:clang|llvm)' | wc -l
134

> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -3940,6 +3940,14 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>  S:	Maintained
>  F:	.clang-format
>  
> +CLANG/LLVM BUILD SUPPORT
> +L: clang-built-linux@googlegroups.com
> +W: https://clangbuiltlinux.github.io/
> +B: https://github.com/ClangBuiltLinux/linux/issues
> +C: irc://chat.freenode.net/clangbuiltlinux
> +S: Supported
> +K: \b(?i:clang|llvm)\b
> +

Please use a single tab after each : like below

CLANG/LLVM BUILD SUPPORT
L:	clang-built-linux@googlegroups.com
W:	https://clangbuiltlinux.github.io/
B:	https://github.com/ClangBuiltLinux/linux/issues
C:	irc://chat.freenode.net/clangbuiltlinux
S:	Supported
K:	\b(?i:clang|llvm)\b


