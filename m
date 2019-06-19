Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDE9C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A78CA21537
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 19:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="bk5Reg+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730384AbfFSTRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 15:17:49 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35211 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729988AbfFSTRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:17:48 -0400
Received: by mail-wm1-f68.google.com with SMTP id c6so664393wml.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Mjc4e9qXJ2nnNgq6HpuUlvVMyhFQupHDeveJmwGSTcc=;
        b=bk5Reg+Tthnhuz/BFDqUvGGkLX/O+aNMKLbqPXFoEq614Ueu2vs0mVT94CjtYpBgF6
         4IZ+j+POJGIjD5PFd5bcIhXOXI3wz0HGjzQpBMi1hYiaP7OAl6X3MN5khPHjzbIJ24xJ
         DF0BQhQT55rH2gekkP1hPxve0qr/rKyHYv8zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Mjc4e9qXJ2nnNgq6HpuUlvVMyhFQupHDeveJmwGSTcc=;
        b=jZqn47+lDA+FEGH9+l15cXF4nYWQ12e+dVqdNHiYbA0FqDVdAuzll5kMcRKiPJ0HtX
         TqevNBXVl+uDzR9mbvgzUPWO0JXclnRK46rdudAk308N3H2q2LybbnR7np2kD+pO7FxM
         rIXQM+swsbQ5nESdSUsAONEVp0UDvLowleUjQmMCWBwbHSAWXjlK64lwmEikyqlyTM3q
         jivoH9cCc+Low2PnDCKzhw0f3uuRcmdm18JUaQM1dQ1rMBLr79Ocd7/LTpKTeaesC/zN
         4TlLSSFL7GAw2WaypYP+h0+W0+N3IYKThzI/2HXS4NbQmMbpAYn3ltqT99FziHuSwM8c
         pKmA==
X-Gm-Message-State: APjAAAXdO4Fp0Mc8O4YXHAZsO9rAMcroH53m3sV3YT8UBJQO9xvtO05Z
        2/b/T21QxG67IUPCbYZeUxNH/g==
X-Google-Smtp-Source: APXvYqzjDBaaBwQLbZ12fbh5cDsg0VP4n9phLBdvM5LvhkrKdtb16ZvLJpYvr4tRLgPKdxd0vjrNKA==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr3284154wmg.155.1560971866975;
        Wed, 19 Jun 2019 12:17:46 -0700 (PDT)
Received: from gmail.com ([95.149.160.61])
        by smtp.gmail.com with ESMTPSA id s63sm2392244wme.17.2019.06.19.12.17.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 12:17:46 -0700 (PDT)
Date:   Wed, 19 Jun 2019 20:16:05 +0100
From:   Louis Taylor <louis@kragniz.eu>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, clang-built-linux@googlegroups.com,
        joe@perches.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add CLANG/LLVM BUILD SUPPORT info
Message-ID: <20190619191605.GA5837@gmail.com>
References: <20190619181844.57696-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619181844.57696-1-ndesaulniers@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19, 2019 at 11:18:44AM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> Add keyword support so that our mailing list gets cc'ed for clang/llvm
> patches. We're pretty active on our mailing list so far as code review.
> There are numerous Googlers like myself that are paid to support
> building the Linux kernel with Clang and LLVM.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Thanks for Joe Perches for help on the syntax for the case insensitive
> syntax.
> 
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ef58d9a881ee..fa798cc48e34 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3940,6 +3940,14 @@ M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>  S:	Maintained
>  F:	.clang-format
>  
> +CLANG/LLVM BUILD SUPPORT
> +L: clang-built-linux@googlegroups.com

I think this should have "(moderated for non-subscribers)" added.

Cheers,
Louis
