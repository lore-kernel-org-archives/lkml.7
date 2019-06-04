Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A303EC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 792F324D46
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727189AbfFDIAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:00:49 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37361 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfFDIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:00:49 -0400
Received: by mail-lf1-f68.google.com with SMTP id m15so15687099lfh.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:00:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+S/GMN8x4zWq0pCzN3fLKfvLk9nVmjys8Jpf8Arvlr4=;
        b=ZlFa3vRw4/l6LckCvrko5CXbHhzjnaWSegvjNt6pCKQ0kTUz1ZDkhNQvrhufM5iM28
         suYOE1VleqD6lDwnOPEugspzhQY01yCv3BlfQrycN4sxbQecOwI20fbQCAvPVXD93G+p
         tgzDsyMO+px8xItuLJuEaof00AgHZquztw2XEhaw3f0DTaWJXSyf7KgRGbkiTx1wyI9Z
         cpiiuMbfc90ecDXhO9SKJKbqlWSFv6jl+z+RCe1sZ8VooqzST9ccKEinVzmsNJU8Jfi+
         dkbQKL/Rs/ZYkJkRNyz+lZzzM0g+cNQ49NYm25hcMH5HQCnzmZvE9FEERn7dI9Y/oQih
         ZRUw==
X-Gm-Message-State: APjAAAWxHNY3/PaifOKdbzKZ/1uCi/eBxmp6qyYSB26+09MEVAxb+6ZQ
        A0xuKM4ZVlwKL39R/Jf0h5azO7MSvqEgrR0EUDU=
X-Google-Smtp-Source: APXvYqy/E6ec4+gsplh0AVG9scYlmQ/Ahb9nVMcKH1slvYg2jEo/LolpyBaIDzbEm7s17vsHbVfDX/LX69Ke+P4GXyY=
X-Received: by 2002:a19:c142:: with SMTP id r63mr17102812lff.49.1559635246979;
 Tue, 04 Jun 2019 01:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <1559635087-20757-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559635087-20757-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 10:00:35 +0200
Message-ID: <CAMuHMdWUajU6mdvxQBHFOGsHDvc9a9Wq236xhJLQFhetH58_9A@mail.gmail.com>
Subject: Re: [PATCH] nios2: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ley Foon Tan <lftan@altera.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        nios2-dev@lists.rocketboards.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:58 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
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
