Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11100C43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8AB920863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 20:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCCUKW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 15:10:22 -0500
Received: from mga17.intel.com ([192.55.52.151]:15469 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726525AbfCCUKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 15:10:21 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Mar 2019 12:10:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,437,1544515200"; 
   d="scan'208";a="148923767"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga004.fm.intel.com with ESMTP; 03 Mar 2019 12:10:18 -0800
Received: from andy by smile with local (Exim 4.92-RC6)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1h0XRA-0000wE-Kr; Sun, 03 Mar 2019 22:10:16 +0200
Date:   Sun, 3 Mar 2019 22:10:16 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Louis Taylor <louis@kragniz.eu>
Cc:     corbet@lwn.net, pmladek@suse.com, geert+renesas@glider.be,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, ndesaulniers@google.com,
        jflat@chromium.org
Subject: Re: [PATCH] docs: add extra integer types to printk-formats
Message-ID: <20190303201016.GO9224@smile.fi.intel.com>
References: <20190303123647.22020-1-louis@kragniz.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190303123647.22020-1-louis@kragniz.eu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 03, 2019 at 12:36:47PM +0000, Louis Taylor wrote:
> A few commonly used integer types were absent from this table, so add
> them.

I'm not against the patch, but isn't obvious by reading POSIX and / or man
printf(3)?

> Link: https://github.com/ClangBuiltLinux/linux/issues/378

Thanks for the link.

It's interesting to see how compiler type mindset applies to fixing drivers and
hardware related code...

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
>  		size_t			%zu or %zx
>  		ssize_t			%zd or %zx
> +		s8			%hhd or %hhx
> +		u8			%hhu or %hhx
> +		s16			%hd or %hx
> +		u16			%hu or %hx
>  		s32			%d or %x
>  		u32			%u or %x
>  		s64			%lld or %llx
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


