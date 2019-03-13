Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D970C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC17120449
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 21:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McgXS+q8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfCMVaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 17:30:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33215 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbfCMVaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 17:30:06 -0400
Received: by mail-wm1-f65.google.com with SMTP id c13so5379379wmb.0;
        Wed, 13 Mar 2019 14:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dJaPA/VuWzFSqkisKsra8OM6zqRpNE/SQLr+qH7rf1w=;
        b=McgXS+q8ddHDusDENa0AlTBgY0hvm3TjjuG+6gykko3AlxrYOLvE0qyd/EiKav3k+b
         7tB/t+GdrrkQC+mVe1xGpvbmR31LS5g9eUVEyIZr2hGsvix20+fLj3Kme0qxYtH/Wc7M
         cny61wtXinrp88XsucJRxfm8goVMqVnWBPhy7S9fY0GSap1GQwSFgNaETnis2Ps202y3
         c0q9LnX7y7wnhXLuvEpJl64TlXa3o8WNKFf/UzC6ovJcIv+ZgBDBVwpq93PfCbhmrXc0
         ZWcMsYCEyxIk4W4QA3BfbiPMjIWk8nFlVDJXrCHFfl1NQJ7r9sBNdSiX5S84aXZjddZm
         Xs1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dJaPA/VuWzFSqkisKsra8OM6zqRpNE/SQLr+qH7rf1w=;
        b=Ns2IeDavatYfXrH9jQ0X3bN4IbvNQ6yOsi+zu+43Tpq79h8oRrAvlRe7D99bA7QuBs
         DDVXEG4mKrb7FBjg4TUSrhNxspzWdhFto81qysR0LpV+5BhsdFwgYlTOSqsBw2b0hDiR
         8nE5wSiKkFD2gcNGzKKfcUa/ooUc6EKiwww9B79HrkL6FRltp/y/YgFZibbUHe4oJlPH
         wVCPAoD9iy6Gq8RPvO+z0P3EAtI2e4VAfc7QGMq2d89wSpHnSiLDFYFuHqMj064t4uJQ
         Kau4f5JE/wS9UiENxDK5otcnls7HF9ZkQ/HZ4VPu4xyDtapUxZw9gdrWOtR5IjnrTcnJ
         3oIQ==
X-Gm-Message-State: APjAAAVxxwpOo7OMqL8AMq1p3lXCtL2erQLt3L8O5Ic0x4ud7AckdbFH
        f3V2W+beqsXuXo6Vf5Qp5NlNkEwsOR4kbw==
X-Google-Smtp-Source: APXvYqxxvWeQjqHhIqM0ekpYOWxIlqL3GD+o5lTrMWRLjSgK2bV2yeQxVmgd4WBnzh0JJSWISKH8Ig==
X-Received: by 2002:a1c:234d:: with SMTP id j74mr148931wmj.130.1552512602804;
        Wed, 13 Mar 2019 14:30:02 -0700 (PDT)
Received: from [192.168.1.221] ([62.68.22.49])
        by smtp.gmail.com with ESMTPSA id t69sm309298wmt.16.2019.03.13.14.30.01
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 14:30:02 -0700 (PDT)
Subject: Re: [PATCH] arch: arm: Kconfig: pedantic formatting
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     andrew@aj.id.au, hsweeten@visionengravers.com, kaloz@openwrt.org,
        khalasa@piap.pl, lkundrak@v3.sk, aaro.koskinen@iki.fi,
        tony@atomide.com, baohua@kernel.org, kgene@kernel.org,
        krzk@kernel.org, linux@prisktech.co.nz, mcuos.com@gmail.com,
        matthias.bgg@gmail.com, linux-omap@vger.kernel.org
References: <1552312598-25574-1-git-send-email-info@metux.net>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <9f6201c2-b62f-ac5d-a24b-a51da1b5e900@gmail.com>
Date:   Wed, 13 Mar 2019 22:28:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1552312598-25574-1-git-send-email-info@metux.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 11/03/2019 14:56, Enrico Weigelt, metux IT consult wrote:
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
> 
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  arch/arm/Kconfig              | 24 +++++++++++-----------
>  arch/arm/mach-aspeed/Kconfig  | 10 ++++-----
>  arch/arm/mach-ep93xx/Kconfig  |  8 ++++----
>  arch/arm/mach-hisi/Kconfig    | 14 ++++++-------
>  arch/arm/mach-ixp4xx/Kconfig  | 32 ++++++++++++++---------------
>  arch/arm/mach-mmp/Kconfig     |  2 +-
>  arch/arm/mach-omap1/Kconfig   | 36 ++++++++++++++++----------------
>  arch/arm/mach-omap2/Kconfig   | 12 +++++------
>  arch/arm/mach-prima2/Kconfig  |  6 +++---
>  arch/arm/mach-s3c24xx/Kconfig | 32 ++++++++++++++---------------
>  arch/arm/mach-s3c64xx/Kconfig | 16 +++++++--------
>  arch/arm/mach-sa1100/Kconfig  |  4 ++--
>  arch/arm/mach-vt8500/Kconfig  |  6 +++---
>  arch/arm/mach-w90x900/Kconfig |  6 +++---
>  arch/arm/mm/Kconfig           | 48 +++++++++++++++++++++----------------------
>  arch/arm/plat-samsung/Kconfig | 26 +++++++++++------------
>  16 files changed, 140 insertions(+), 142 deletions(-)
> 

[...]

> diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
> index c095236..597ea24 100644
> --- a/arch/arm/mach-ep93xx/Kconfig
> +++ b/arch/arm/mach-ep93xx/Kconfig
> @@ -125,10 +125,10 @@ config MACH_MICRO9S
>  	  Contec Micro9-Slim board.
>  
>  config MACH_SIM_ONE
> -        bool "Support Simplemachines Sim.One board"
> -        help
> -          Say 'Y' here if you want your kernel to support the
> -          Simplemachines Sim.One board.
> +	bool "Support Simplemachines Sim.One board"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Simplemachines Sim.One board.
>  
>  config MACH_SNAPPER_CL15
>  	bool "Support Bluewater Systems Snapper CL15 Module"

For EP93xx part:
Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

It makes no sense to split the patch, one of the ARM maintainers
shall decide on this patch anyway. In my personal opinion such a patch
makes little sense if it's not tree-wide.

--
Regards,
Alexander.
