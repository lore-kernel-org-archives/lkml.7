Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3562C46477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D46E21841
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 14:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfFOOra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 10:47:30 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45927 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfFOOr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 10:47:28 -0400
Received: by mail-ed1-f67.google.com with SMTP id a14so8159071edv.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 07:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=P6MfxoMR5HxITUtSbXDSCXq1KKx5HwLDb+RtNfB7+Q0=;
        b=iqLHr6ER3pYy/R4aL2mzVaKVC/k7WJCuISj+zSS85n2jCIapPKNgVrIuFKA++M6tXT
         ZArCh9ccqqfwm02cpPON/olTnoNyJJ0v8/TWES/1TldTYqCHfiNfIssbTFs5dp6a1ty6
         OGdh9ykcZolnliwCpo+qco8pqCHCoytZKmGVlX/wEDYLpecIYIuTBL+XDl7Iet8i4nbl
         SAv0D0DE6vJI0WJlnxPdcYf4Sa23tXm7VAcBlXYIRc8bcrvTuYPTHFmuNvEQCevM/sY0
         LKt3XtpAUjIt4Vx/BNQrYyElC3ZrkDrrWci+YJzs2U3QFb5QXdTPsbf3PBPMkYBGF5Sa
         F+dw==
X-Gm-Message-State: APjAAAVbTY8sY64Rl3+VevWo25HPVVa6i9Czzf04WLoOwhloubfFQZqh
        TwB0r48kgMH64mj2tHl8KLp4YmcGlS+ktA==
X-Google-Smtp-Source: APXvYqx60nftjqTZ6Cn/Y/FV4B7vkGtlOBnMaXADaTwJawTvTGPVGe8oDnHKlkHwDjh/pgyxGjx1hg==
X-Received: by 2002:a17:906:2605:: with SMTP id h5mr60226354ejc.178.1560610046527;
        Sat, 15 Jun 2019 07:47:26 -0700 (PDT)
Received: from localhost (134.217.90.212.static.wline.lns.sme.cust.swisscom.ch. [212.90.217.134])
        by smtp.gmail.com with ESMTPSA id e33sm1941896eda.83.2019.06.15.07.47.24
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 07:47:24 -0700 (PDT)
Date:   Sat, 15 Jun 2019 07:47:24 -0700 (PDT)
X-Google-Original-Date: Sat, 15 Jun 2019 07:11:48 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: change the arch/riscv git tree to the new shared tree
In-Reply-To: <20190613070721.8341-1-paul.walmsley@sifive.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-94da1779-349d-4019-92b9-e16a9c1d2890@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jun 2019 00:07:21 PDT (-0700), Paul Walmsley wrote:
> Palmer, with Konstantin's gracious help, set up a shared kernel.org
> git tree for arch/riscv patches going forward.  Change the MAINTAINERS
> file accordingly.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 57f496cff999..290359a46bbe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13476,7 +13476,7 @@ RISC-V ARCHITECTURE
>  M:	Palmer Dabbelt <palmer@sifive.com>
>  M:	Albert Ou <aou@eecs.berkeley.edu>
>  L:	linux-riscv@lists.infradead.org
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git
>  S:	Supported
>  F:	arch/riscv/
>  K:	riscv

Reiewed-by: Palmer Dabbelt <palmer@sifive.com>
