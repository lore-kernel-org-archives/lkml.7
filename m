Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F834C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B3B24D45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfFDIB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:01:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43318 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfFDIB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:01:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id j29so1784931lfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RoNWrIjH+E7/bSiZkpKchET/gQgnLxVGmbQQCHz5kr0=;
        b=jJcrOeYoipLNsC9MmemKocRCLLRzkAd5kKq7jQKaA6nVWDr1vylW0S0pv1c2ZpcamM
         g0Rlc02hfcEzAEIohwJx5/JJWIq/Bj0IMKK6O3JcT82KqxfsGMqgZYtsONf8E4lXHlqm
         hrf1NKrErnO9qFBpJMjmRkmvx1Lvm4131LJr/q+KSHYEBo1/EdKaga8+CPl5anVqEyY/
         g23TvxaEQroR9lX7HR8YE1B7YADraKNro9QHyQ3vZt+6ZCL3jvYvv907zMkyMzrKNrEc
         63am7JwH5zCQa/UhqdWQwXbUF5rDaHin/4Se2NMUMFVTsbUHwg/HcsZfV/o8xA6RF/jf
         1iPw==
X-Gm-Message-State: APjAAAWRvcYlXWjifzBaghU9GGIE/HVuuGADLrBzIPWCTbEyNvPKlnvz
        hlzW4z/J33tqpe4ENfbYwTLRl5aAznjJI5Yi1v8=
X-Google-Smtp-Source: APXvYqyZUeZ7KHNXoKdeeJzkEG9PfXx1xtb7SMLcI01Tjx1TH432of8WYTv0XPJ90daVuhCZ/rLtVnkacIL/EvYFPSw=
X-Received: by 2002:ac2:546a:: with SMTP id e10mr16052712lfn.75.1559635284767;
 Tue, 04 Jun 2019 01:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <1559635193-21151-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635193-21151-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 10:01:12 +0200
Message-ID: <CAMuHMdWXv6X0Omvy0TdDackohOKoA3zm-xMbsNzDsRce30gncw@mail.gmail.com>
Subject: Re: [PATCH] um: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 10:00 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
