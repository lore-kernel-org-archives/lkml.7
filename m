Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBFC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807B424D3E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfFDIAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:00:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35899 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfFDIAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:00:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id i21so4185198ljj.3;
        Tue, 04 Jun 2019 01:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0nzKAfA25Nd/B5b94/lEffHmOkj3bNdRwQPedDI7ZE=;
        b=OI/PEGCG0AW9iBzeH4rrpP65/tY/38N/Je3OZbYMqonc+zG3X3g4NtbmU5KUJERQcj
         JOGmW/GRK6VVJ6FN4jgzN0r4F3B/4rL8+gbUnTnhQQGByo6lIk2qun9ZA6N6+hTRz6fn
         k6rWz3FuOTJribtuNNGd/mLz1AZlndbHL1vL6dxkXqDaBrRNMfBna2Z5UqjaTp5kTRoA
         viB+BNzbacpVRyULXkwQKLrOrAwp8dyTTBLk1pLv9iKuBMqkg3SEhfg+bTVipIqFp4ki
         wJPALzZGS0T1lzy6fXbkPBAS8x0AVDFRHfWWe6EgzNDG8zzn1bq5biwzZNdKNG7svRwx
         QFtw==
X-Gm-Message-State: APjAAAVzKPFvBQ0RvFK7b2hNRShG83Kr9IshtD5O+6SxspmS+7MpmxjG
        Xtb0fbGyOwc4y3M3bC236yhaTfOTWQMB0yHyW2Q=
X-Google-Smtp-Source: APXvYqyoBaVAxOjrtV2Ji+hWa5waNuOxjEdz1mUYrMwlgc6CSvMY+lU2zMT8JWn9CFnYIjBvKQS+A9XR8Ls2/8HbLK0=
X-Received: by 2002:a2e:960e:: with SMTP id v14mr16250077ljh.31.1559635201102;
 Tue, 04 Jun 2019 01:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <1559635002-20533-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635002-20533-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 09:59:49 +0200
Message-ID: <CAMuHMdWkuhJ+Y+RTu=TK0CN4xKDQ0hRDY-FJc3EKRvJwz8f5rQ@mail.gmail.com>
Subject: Re: [PATCH] ia64: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:56 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
