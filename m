Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD4C072A4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 01:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632D92087B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 01:56:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aDGV5YuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfESB4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 21:56:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43400 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbfESB4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 21:56:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id t22so5060929pgi.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 18:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+kj4OJTopW4rotB8qihKVkdclA94Kw2w9hND/ZASmD4=;
        b=aDGV5YuWdqbIJilBO0WAM7gcfKLGH5t9gO/0KJVJ47LOMrp1HdMMS6jlrxipv7HfJD
         3lCFORRxYNin9JkiebhDNWTH4fM2d0xnjPrAZ29NlQyaz52fXr7/d4uy5D0jVIVt0q7M
         z3F+hS80VGUNPrsZWXwO1nfcpijgFKG2ERmZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+kj4OJTopW4rotB8qihKVkdclA94Kw2w9hND/ZASmD4=;
        b=TNJXmUMKe5KcOHMSm8uS3bwtadJU0o11Ecb5hbuiZ3V4VMvUAaXmNjWaUciNvF7s7f
         Hhr3UkwfExyXhJ6uXfyjzoxU63+hIPZgpgSyvKOidQjG0GaNjC/U7FtyxYm0eFVkUPZW
         Qp322Ktae4fz1uO9tnp1ZSnCFcFMo9pZmPj37nBk8uiWuf3jOCQB3dUW00zLTwUKdbJt
         Yi1N+qXKEfVmxV5/yeWriDgRxHJzX/UNlTHocDF6ZkohkSSrVs+vZZQoiHkHizKpCKOH
         I9GT1xj7atbiobzxLCp2xRkwSi8AbHhKmxyEgFn8ptazOcUcLdw3pfVcQ22PNPmm3slR
         Z8Pg==
X-Gm-Message-State: APjAAAXc7r1K+hPgkIOljGp7Q98KIscoyreqyI489dQvBNek2YCM91TD
        jtDZhfXbtGXT0SFxxFfdXUwyKQ==
X-Google-Smtp-Source: APXvYqxPCwPSZydCQNb24+pWdRNYEyp8uXWZRnLGTAIxluddIHLpHn7S4Gzf1USIDt211iw0hLpNTQ==
X-Received: by 2002:a63:7146:: with SMTP id b6mr62397520pgn.426.1558230982600;
        Sat, 18 May 2019 18:56:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u66sm15405640pfb.76.2019.05.18.18.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 18:56:21 -0700 (PDT)
Date:   Sat, 18 May 2019 18:56:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] kernel: fix typos and some coding style in comments
Message-ID: <201905181855.91DE502D@keescook>
References: <20190518101628.14633-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518101628.14633-1-houweitaoo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 06:16:28PM +0800, Weitao Hou wrote:
> fix lenght to length

Can you please fix all the instances of this in the tree?

$ git grep lenght | grep -v spelling.txt
Documentation/devicetree/bindings/usb/s3c2410-usb.txt: - reg: address and lenght of the controller memory mapped region
drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c:   * length, need to update lenght of it and the last packet.
kernel/sysctl.c: *      passed the max lenght will be ignored. Multiple writes will append
sound/soc/qcom/qdsp6/q6asm.c: * @len: lenght in bytes

> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
>  kernel/sysctl.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 943c89178e3d..0736a1d580df 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -187,17 +187,17 @@ extern int no_unaligned_warning;
>   * enum sysctl_writes_mode - supported sysctl write modes
>   *
>   * @SYSCTL_WRITES_LEGACY: each write syscall must fully contain the sysctl value
> - * 	to be written, and multiple writes on the same sysctl file descriptor
> - * 	will rewrite the sysctl value, regardless of file position. No warning
> - * 	is issued when the initial position is not 0.
> + * to be written, and multiple writes on the same sysctl file descriptor
> + * will rewrite the sysctl value, regardless of file position. No warning
> + * is issued when the initial position is not 0.
>   * @SYSCTL_WRITES_WARN: same as above but warn when the initial file position is
> - * 	not 0.
> + * not 0.
>   * @SYSCTL_WRITES_STRICT: writes to numeric sysctl entries must always be at
> - * 	file position 0 and the value must be fully contained in the buffer
> - * 	sent to the write syscall. If dealing with strings respect the file
> - * 	position, but restrict this to the max length of the buffer, anything
> - * 	passed the max lenght will be ignored. Multiple writes will append
> - * 	to the buffer.
> + * file position 0 and the value must be fully contained in the buffer
> + * sent to the write syscall. If dealing with strings respect the file
> + * position, but restrict this to the max length of the buffer, anything
> + * passed the max length will be ignored. Multiple writes will append
> + * to the buffer.

Also, why the reflow? It looks like these should stay indented...

>   *
>   * These write modes control how current file position affects the behavior of
>   * updating sysctl values through the proc interface on each write.
> -- 
> 2.18.0
> 

Besides that, thanks for noticing and sending a patch!

-- 
Kees Cook
