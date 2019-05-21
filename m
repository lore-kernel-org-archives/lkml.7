Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7693BC072B5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A735217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 20:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZoN3w9z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfEUUlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 16:41:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44684 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfEUUkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 16:40:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id c5so8953081pll.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VmjDYig5cOfeJzpmuRnE4YbNJQ8zuwD2EO9PKFuRqCg=;
        b=ZoN3w9z3uD8ECaFrH1mWGfcXbdL2H57DFbX418kzrKyjv83IjiPRGWXJIdemvMzk9r
         LkE+onb3hP+uPA5KQMc/BtXm2bk4ZHMT06ZG/59w5HqfIarSuJfbz0UD9W7TdgNSiHIB
         CYqGb7kaaeQyzZXVIZwccQCYkLZ3uUPQ5JHHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VmjDYig5cOfeJzpmuRnE4YbNJQ8zuwD2EO9PKFuRqCg=;
        b=OWqosuM2a9TqEuXbgAIM2yk7wHujpOws51ve+/11BmOFBqANLyRuJnHG8a5sgGNWef
         aONgRQ6asZUXJKaIDyYpZ5rfD+L7ty8rz1ohKG1VfWHPyMagBtFkQNEOYBOrxZ6Xq1PN
         phqlE21VwmGr0Pr70K8APX2CRWsH6nJ+deA2jDaM3vDYSZxIJnVpQtCzl7YcPjM2DY+N
         Hov0OxSiZXLK3aq8P+TYmuU2wbXoMmGMCQbsvqBFKfSO9lRRVIHQ1QRqSpRRnIV9TYZa
         H83GGBpPFjtSDYN/PLdsZzg6RfRZQCbdpNZiy5qOWvbbI0pQG2Hph7m1H1Du53UCfiGA
         h88w==
X-Gm-Message-State: APjAAAV+yya0DcZRL5cGl27vkJYB3WP4bccaQ2TBmp0qdajRbgHv+O1Q
        0zSllfVN7crsy5v0aDUApliuzQ==
X-Google-Smtp-Source: APXvYqzcoa60DP1BCRfYNNgykS/fRPS1E7bZ8Eb21n8ia+/CEeccKQvQRrIXVo4G+UKTFG8KapwAEg==
X-Received: by 2002:a17:902:e7:: with SMTP id a94mr60595135pla.182.1558471239758;
        Tue, 21 May 2019 13:40:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c76sm41508742pfc.43.2019.05.21.13.40.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 May 2019 13:40:39 -0700 (PDT)
Date:   Tue, 21 May 2019 13:40:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>
Cc:     mcgrof@kernel.org, linux-kernel@vger.kernel.org,
        Weitao Hou <houweitaoo@gmail.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] kernel: fix typos and some coding style in comments
Message-ID: <201905211338.D073AB64@keescook>
References: <20190521050937.4370-1-houweitaoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190521050937.4370-1-houweitaoo@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 01:09:37PM +0800, Weitao Hou wrote:
> fix lenght to length
> 
> Signed-off-by: Weitao Hou <houweitaoo@gmail.com>

Acked-by: Kees Cook <keescook@chromium.org>

I've aimed this at akpm... Colin, who normally takes your spelling
fix patches? (It looks like your split them up normally? That seems
silly here...)

-Kees

> ---
> Changes in v3:
> - fix all other same typos with git grep
> ---
>  .../devicetree/bindings/usb/s3c2410-usb.txt    |  2 +-
>  .../wireless/mediatek/mt76/mt76x02_usb_core.c  |  2 +-
>  kernel/sysctl.c                                | 18 +++++++++---------
>  sound/soc/qcom/qdsp6/q6asm.c                   |  2 +-
>  4 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
> index e45b38ce2986..26c85afd0b53 100644
> --- a/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
> +++ b/Documentation/devicetree/bindings/usb/s3c2410-usb.txt
> @@ -4,7 +4,7 @@ OHCI
>  
>  Required properties:
>   - compatible: should be "samsung,s3c2410-ohci" for USB host controller
> - - reg: address and lenght of the controller memory mapped region
> + - reg: address and length of the controller memory mapped region
>   - interrupts: interrupt number for the USB OHCI controller
>   - clocks: Should reference the bus and host clocks
>   - clock-names: Should contain two strings
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> index 6b89f7eab26c..e0f5e6202a27 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> @@ -53,7 +53,7 @@ int mt76x02u_skb_dma_info(struct sk_buff *skb, int port, u32 flags)
>  	pad = round_up(skb->len, 4) + 4 - skb->len;
>  
>  	/* First packet of a A-MSDU burst keeps track of the whole burst
> -	 * length, need to update lenght of it and the last packet.
> +	 * length, need to update length of it and the last packet.
>  	 */
>  	skb_walk_frags(skb, iter) {
>  		last = iter;
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
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 4f85cb19a309..e8141a33a55e 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -1194,7 +1194,7 @@ EXPORT_SYMBOL_GPL(q6asm_open_read);
>   * q6asm_write_async() - non blocking write
>   *
>   * @ac: audio client pointer
> - * @len: lenght in bytes
> + * @len: length in bytes
>   * @msw_ts: timestamp msw
>   * @lsw_ts: timestamp lsw
>   * @wflags: flags associated with write
> -- 
> 2.18.0
> 

-- 
Kees Cook
