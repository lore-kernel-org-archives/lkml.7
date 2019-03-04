Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B529CC10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAB32075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 15:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCDPpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 10:45:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:53344 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbfCDPpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 10:45:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34E22AC3F;
        Mon,  4 Mar 2019 15:45:10 +0000 (UTC)
Date:   Mon, 4 Mar 2019 16:45:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Louis Taylor <louis@kragniz.eu>
Cc:     corbet@lwn.net, geert+renesas@glider.be,
        andriy.shevchenko@linux.intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        ndesaulniers@google.com, jflat@chromium.org
Subject: Re: [PATCH] docs: add extra integer types to printk-formats
Message-ID: <20190304154509.46azg4blwoieqs3c@pathway.suse.cz>
References: <20190303123647.22020-1-louis@kragniz.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303123647.22020-1-louis@kragniz.eu>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2019-03-03 12:36:47, Louis Taylor wrote:
> A few commonly used integer types were absent from this table, so add
> them.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/378
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Louis Taylor <louis@kragniz.eu>
> ---
>  Documentation/core-api/printk-formats.rst | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index a7fae4538946..6f08b1b6240a 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -19,8 +19,16 @@ Integer types
>  		unsigned long		%lu or %lx
>  		long long		%lld or %llx
>  		unsigned long long	%llu or %llx
> +		short int		%hd or %hx
> +		unsigned short int	%hu or %hx
> +		char			%hhd or %hhx
> +		unsigned char		%hhu or %hhx

These should get moved to the beginning of the table to
have all variants sorted by size.

>  		size_t			%zu or %zx
>  		ssize_t			%zd or %zx
> +		s8			%hhd or %hhx
> +		u8			%hhu or %hhx
> +		s16			%hd or %hx
> +		u16			%hu or %hx
>  		s32			%d or %x
>  		u32			%u or %x
>  		s64			%lld or %llx

Let's get it in when people are doing the clean up.

I have fixed the sorting and committed into printk.git,
branch for-5.1, see
https://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git/commit/?h=for-5.1&id=943ca6ad81e5b37bd5d22cbab5ad06dc97fc001c

Best Regards,
Petr
