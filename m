Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4325EC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE04218AC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553407937;
	bh=xKxRousZcNNZ2Pnt8GUEV/q4+VkoAUa8z8n6sxNcm5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=K4iuCXcsaAF4rEGy0EOlMrgyz/lDijfGKVzM67P3ixfN2XaCdVdMZPJuFQzB7PL2y
	 uyf+1TXdVUnYLaTH2wrVu2QBxW4ETKrzTvEhW+PS2VUgKl5VtBjxEdTHfbSW5lWBwo
	 uT/S8AfVmPiXoRlffT3eFWUD9klcxrgkU6OHyjKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbfCXGMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 02:12:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfCXGMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 02:12:15 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2542521741;
        Sun, 24 Mar 2019 06:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553407934;
        bh=xKxRousZcNNZ2Pnt8GUEV/q4+VkoAUa8z8n6sxNcm5c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Citd8i/W4hcU8ekT3m4wimlrGuSCR1FtyL2MVOCW/E6wogQLDpqEDYJCibpUdMECH
         prOZ3Nr4nX5K8BBPBwiw7yyW4LxDX1yhAPuXtnBFvXg1xRE9+s1SHrtA7Fw3tWD2P4
         /dj7IvdNYcXDQe686xWQk9R4mVd6xZeHJghCDdoE=
Date:   Sun, 24 Mar 2019 14:12:08 +0800
From:   Guo Ren <guoren@kernel.org>
To:     jagdsh.linux@gmail.com
Cc:     paul.burton@mips.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch:csky:mm/fault.c : Remove duplicate header
Message-ID: <20190324061208.GB10487@guoren-Inspiron-7460>
References: <1553342117-29968-1-git-send-email-jagdsh.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553342117-29968-1-git-send-email-jagdsh.linux@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Approved, thx.

On Sat, Mar 23, 2019 at 05:25:17PM +0530, jagdsh.linux@gmail.com wrote:
> From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> 
> Remove duplicate header which is included twice.
> 
> Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
> ---
>  arch/csky/mm/fault.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> index d6f4b66..e1725f8 100644
> --- a/arch/csky/mm/fault.c
> +++ b/arch/csky/mm/fault.c
> @@ -15,7 +15,6 @@
>  #include <linux/smp.h>
>  #include <linux/version.h>
>  #include <linux/vt_kern.h>
> -#include <linux/kernel.h>
>  #include <linux/extable.h>
>  #include <linux/uaccess.h>
>  
> -- 
> 1.8.3.1
> 
