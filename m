Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1046C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFA902077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556389001;
	bh=Bvv8AHyd01QGESOywGHEPTGmwlGGuwugwtUlEgzo4ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=wmpTR3vUMbb6KbJKm4xMWkWEeUlrYg2QZWcc2EB/iCGl76Doh1DQVNfIi6oscANFt
	 F5iY6cNwrQyucDwPHj5zZD9cBXHZZcvENRHepGlAH22RrQxS1wv2QxBgGsxtDs2XpU
	 0YuJJs1hcIaht+ntFEvRa0a6YB92JrfYRJjwi9Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbfD0SQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:16:40 -0400
Received: from casper.infradead.org ([85.118.1.10]:51520 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfD0SQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:16:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RojP188D4T/SyJqZZWtabJ0LdyYtVRK1tXHxpyPzXqk=; b=OYg/wIoiKwcm3tJ6ldmh1wx82R
        HoTYh2lOQ0ag/AbtvreZOPe27RI6EZjLEc18Li9hXhVnnk3A6es07D6ynXVfaewYlsC68k+VVYY2t
        hYoAaUxracIZf1YvvMdpaP7n0iNKpUl8BToRKOHlRNLNYntnLfb07KQbdAFKjQRLJAFPR4+15v8rV
        17Hfz7tgboUcSGFOHR1x0ZbCxU89BpTml/g+Dn0XVZ/KI/xf/rh4h0iU8mEEDAOXrFFtqV1uDWqVd
        AyNbtfdrBIjUiBltUVgAeEp+xO35snL2gRFDy2RLxwemtyaaZl8+BYlp0jq/MdbZ9Lv+35KIY6++7
        WS7yzbog==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKRsH-0004Ds-NO; Sat, 27 Apr 2019 18:16:34 +0000
Date:   Sat, 27 Apr 2019 15:16:28 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/27] Documentation: x86: convert orc-unwinder.txt to
 reST
Message-ID: <20190427151628.219bdf08@coco.lan>
In-Reply-To: <20190426153150.21228-19-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-19-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:41 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

> ---
>  Documentation/x86/index.rst                   |  1 +
>  .../{orc-unwinder.txt => orc-unwinder.rst}    | 27 ++++++++++---------
>  2 files changed, 16 insertions(+), 12 deletions(-)
>  rename Documentation/x86/{orc-unwinder.txt => orc-unwinder.rst} (93%)
> 
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 4e9fa2b046df..c41c17906b6d 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -14,6 +14,7 @@ Linux x86 Support
>     kernel-stacks
>     entry_64
>     earlyprintk
> +   orc-unwinder
>     zero-page
>     tlb
>     mtrr
> diff --git a/Documentation/x86/orc-unwinder.txt b/Documentation/x86/orc-unwinder.rst
> similarity index 93%
> rename from Documentation/x86/orc-unwinder.txt
> rename to Documentation/x86/orc-unwinder.rst
> index cd4b29be29af..d811576c1f3e 100644
> --- a/Documentation/x86/orc-unwinder.txt
> +++ b/Documentation/x86/orc-unwinder.rst
> @@ -1,8 +1,11 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============
>  ORC unwinder
>  ============
>  
>  Overview
> ---------
> +========
>  
>  The kernel CONFIG_UNWINDER_ORC option enables the ORC unwinder, which is
>  similar in concept to a DWARF unwinder.  The difference is that the
> @@ -23,12 +26,12 @@ correlate instruction addresses with their stack states at run time.
>  
>  
>  ORC vs frame pointers
> ----------------------
> +=====================
>  
>  With frame pointers enabled, GCC adds instrumentation code to every
>  function in the kernel.  The kernel's .text size increases by about
>  3.2%, resulting in a broad kernel-wide slowdown.  Measurements by Mel
> -Gorman [1] have shown a slowdown of 5-10% for some workloads.
> +Gorman [1]_ have shown a slowdown of 5-10% for some workloads.
>  
>  In contrast, the ORC unwinder has no effect on text size or runtime
>  performance, because the debuginfo is out of band.  So if you disable
> @@ -55,7 +58,7 @@ depending on the kernel config.
>  
>  
>  ORC vs DWARF
> -------------
> +============
>  
>  ORC debuginfo's advantage over DWARF itself is that it's much simpler.
>  It gets rid of the complex DWARF CFI state machine and also gets rid of
> @@ -65,7 +68,7 @@ mission critical oops code.
>  
>  The simpler debuginfo format also enables the unwinder to be much faster
>  than DWARF, which is important for perf and lockdep.  In a basic
> -performance test by Jiri Slaby [2], the ORC unwinder was about 20x
> +performance test by Jiri Slaby [2]_, the ORC unwinder was about 20x
>  faster than an out-of-tree DWARF unwinder.  (Note: That measurement was
>  taken before some performance tweaks were added, which doubled
>  performance, so the speedup over DWARF may be closer to 40x.)
> @@ -85,7 +88,7 @@ still be able to control the format, e.g. no complex state machines.
>  
>  
>  ORC unwind table generation
> ----------------------------
> +===========================
>  
>  The ORC data is generated by objtool.  With the existing compile-time
>  stack metadata validation feature, objtool already follows all code
> @@ -133,7 +136,7 @@ objtool follows GCC code quite well.
>  
>  
>  Unwinder implementation details
> --------------------------------
> +===============================
>  
>  Objtool generates the ORC data by integrating with the compile-time
>  stack metadata validation feature, which is described in detail in
> @@ -154,7 +157,7 @@ subset of the table needs to be searched.
>  
>  
>  Etymology
> ----------
> +=========
>  
>  Orcs, fearsome creatures of medieval folklore, are the Dwarves' natural
>  enemies.  Similarly, the ORC unwinder was created in opposition to the
> @@ -162,7 +165,7 @@ complexity and slowness of DWARF.
>  
>  "Although Orcs rarely consider multiple solutions to a problem, they do
>  excel at getting things done because they are creatures of action, not
> -thought." [3]  Similarly, unlike the esoteric DWARF unwinder, the
> +thought." [3]_  Similarly, unlike the esoteric DWARF unwinder, the
>  veracious ORC unwinder wastes no time or siloconic effort decoding
>  variable-length zero-extended unsigned-integer byte-coded
>  state-machine-based debug information entries.
> @@ -174,6 +177,6 @@ brutal, unyielding efficiency.
>  ORC stands for Oops Rewind Capability.
>  
>  
> -[1] https://lkml.kernel.org/r/20170602104048.jkkzssljsompjdwy@suse.de
> -[2] https://lkml.kernel.org/r/d2ca5435-6386-29b8-db87-7f227c2b713a@suse.cz
> -[3] http://dustin.wikidot.com/half-orcs-and-orcs
> +.. [1] https://lkml.kernel.org/r/20170602104048.jkkzssljsompjdwy@suse.de
> +.. [2] https://lkml.kernel.org/r/d2ca5435-6386-29b8-db87-7f227c2b713a@suse.cz
> +.. [3] http://dustin.wikidot.com/half-orcs-and-orcs



Thanks,
Mauro
