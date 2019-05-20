Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03B8C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A159420856
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 15:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YZPNJ9rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392286AbfETPmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 11:42:08 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38488 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388878AbfETPmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 11:42:08 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so6889666plb.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 08:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0vmcG8RNx8r27qs4G/uvSxbM38xV4AIXjM9JTTM1N3Q=;
        b=YZPNJ9rSGLx7NaKcAWzN7Sh8J6x54n6erTjGVANbIwkVYsbsRJ9FwZlBXrqq5QUDe3
         kYbCAdaTxP5hmBmFTI6wbjwJrBgVlpDkg6bBkys46ab5uSTvpUKal1d2XXulejw7VyE+
         hziQx0oM2n476jqJkhf7R6QnHEn/CPBoUHOHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0vmcG8RNx8r27qs4G/uvSxbM38xV4AIXjM9JTTM1N3Q=;
        b=XIqpK8QzZmtLjXXjI5Y3AMkKAPOKfIPXnhuX10lcj2406CBChJQ+ro1Xus8hXSKXcc
         LVgqRtFlqD5HBVNNa1UVAewth1qng22ZJFY1wu4uMdIxFdnbA80XjxcWNEwKCfJvra19
         nUMdc0Pux6wUaG+OcerTgE3BK5cXV6CuXSViLnn7+abS6XJB7RArt6tNwDj+72/2iznD
         rqoJlbPYUrKsQtCmmFnTj2cIoN23a0JlpI/vXD4gZ7pITi2CFhsDiK1vaeImZL2pSp2E
         C6ff556gtM8Da2icMOacAfEHmVdjhFeTrXdgQ6yc9efUf4H+D9J2EGHKFnePTEgjXmvx
         XyZg==
X-Gm-Message-State: APjAAAXh8qioy60+WIvlo3En2DxJjZpXeXUMb93yRkLPe7zM0AdTKnoU
        ib01yHP5DGEIX7W3ad1n7zSBFQ==
X-Google-Smtp-Source: APXvYqx9MxJHmbNe1U10Xlc6d40xONeoEjkJKAoJNQoMZAkTkvrWlX6jIuUFqmLh8sQIyWwDEvAsAw==
X-Received: by 2002:a17:902:284a:: with SMTP id e68mr51897631plb.258.1558366927935;
        Mon, 20 May 2019 08:42:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i12sm20224833pgb.61.2019.05.20.08.42.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 08:42:06 -0700 (PDT)
Date:   Mon, 20 May 2019 08:42:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Weitao Hou <houweitaoo@gmail.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] kernel: fix typos and some coding style in comments
Message-ID: <201905200841.8A35A0C@keescook>
References: <20190520023700.8472-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520023700.8472-1-houweitaoo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 10:37:00AM +0800, Weitao Hou wrote:
> fix lenght to length

What about the other instances of this misspelling? (See "git grep
lenght").

-Kees

> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>
> ---
> Changes in v2:
>   - fix space before tab warnings
> ---
>  kernel/sysctl.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 943c89178e3d..f78f725f225e 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -187,17 +187,17 @@ extern int no_unaligned_warning;
>   * enum sysctl_writes_mode - supported sysctl write modes
>   *
>   * @SYSCTL_WRITES_LEGACY: each write syscall must fully contain the sysctl value
> - * 	to be written, and multiple writes on the same sysctl file descriptor
> - * 	will rewrite the sysctl value, regardless of file position. No warning
> - * 	is issued when the initial position is not 0.
> + *	to be written, and multiple writes on the same sysctl file descriptor
> + *	will rewrite the sysctl value, regardless of file position. No warning
> + *	is issued when the initial position is not 0.
>   * @SYSCTL_WRITES_WARN: same as above but warn when the initial file position is
> - * 	not 0.
> + *	not 0.
>   * @SYSCTL_WRITES_STRICT: writes to numeric sysctl entries must always be at
> - * 	file position 0 and the value must be fully contained in the buffer
> - * 	sent to the write syscall. If dealing with strings respect the file
> - * 	position, but restrict this to the max length of the buffer, anything
> - * 	passed the max lenght will be ignored. Multiple writes will append
> - * 	to the buffer.
> + *	file position 0 and the value must be fully contained in the buffer
> + *	sent to the write syscall. If dealing with strings respect the file
> + *	position, but restrict this to the max length of the buffer, anything
> + *	passed the max length will be ignored. Multiple writes will append
> + *	to the buffer.
>   *
>   * These write modes control how current file position affects the behavior of
>   * updating sysctl values through the proc interface on each write.
> -- 
> 2.18.0
> 

-- 
Kees Cook
