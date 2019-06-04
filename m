Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427D4C28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA4624D44
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfFDIBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:01:11 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36011 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbfFDIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:01:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id i21so4188354ljj.3;
        Tue, 04 Jun 2019 01:01:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvFaMGVaktx6XKkqQeK7fvOreSNIgCtTOvEyHkLilfU=;
        b=DAb7HhVvVZXE7KmaOg63b5oZ3xfDHo3PHX8yNQrI36YjlYr9XySitHPZIpDFkeXhxT
         BNFYlijKk/lvgjKqdkmSvN8rPKbDLQj2GD57ewoHqu+/WcgIQ+zntFvmTHbrqOo4uJH3
         6BawJPNXhGKEm4qW2zKF1RNDd6P7OKKXCANGNQmANcTHkc+jFJLBIq4hr6r/vZqW2H2o
         ev6PFKRkPATvQqd3zNromvM+hy88EHKYbWesIJ87U01UCtzfv4CbZLkzY+XHiJxX5lDg
         THYMuA7HTIaLIll+wdpuDu9qvTLjyfJvWK761EpgH+appuc8or/tPEpfS3DGsABapHyl
         9N1w==
X-Gm-Message-State: APjAAAXsYcnhc5E/8ieOYsgAZJ9+w2kxEcWefqM0IDv0QTaGgX2UPfMY
        d4mn25j1hskOnVeDZ5HnzLWTsX8ft6kTaPfkFrEyUQok
X-Google-Smtp-Source: APXvYqzdKDfUrdD2yLUySgCqLbrKLPjcc3QTgMFqln86lXM7PL5KME2KFi2ut8N2lB5NlBCCEusCB8gbB7d/u3/+cHc=
X-Received: by 2002:a2e:9255:: with SMTP id v21mr9188077ljg.178.1559635268569;
 Tue, 04 Jun 2019 01:01:08 -0700 (PDT)
MIME-Version: 1.0
References: <1559635137-20900-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635137-20900-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 10:00:55 +0200
Message-ID: <CAMuHMdX04Y2n8v641bv5P+P0oeRfO7arOft_6dk6w0wQF1yzew@mail.gmail.com>
Subject: Re: [PATCH] s390: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:59 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Remove the CONFIG_UEVENT_HELPER_PATH because:
> 1. It is disabled since commit 1be01d4a5714 ("driver: base: Disable
>    CONFIG_UEVENT_HELPER by default") as its dependency (UEVENT_HELPER) was
>    made default to 'n',
> 2. It is not recommended (help message: "This should not be used today
>    [...] creates a high system load") and was kept only for ancient
>    userland,
> 3. Certain userland specifically requests it to be disabled (systemd
>    README: "Legacy hotplug slows down the system and confuses udev").
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
