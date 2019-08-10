Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B02C433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 06:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291CE208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 06:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfHJG7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 02:59:06 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46946 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbfHJG7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 02:59:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id z17so22830794otk.13;
        Fri, 09 Aug 2019 23:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jCiIkAHQv04Yhu2YlExm6Y+RKbCmTgvVHfMoq6E68UA=;
        b=eyIACgnUF8YpkqDIM1zd6v5ND29rfboXy15POXc3Ln9mSIwFRHRJiY63eGjeW1wvbU
         1GfkzlL0+FaeKB+1Dw6mz1cOjbmftelvd+arsmv9qjsn+ju05mCtFlp5qDU+EaAPnv87
         Nw5EhrhUrqVBv0+n77nnzWKjcag9nzMObR8MlTZ+UZ1dIqAd77pyTJ9paZPGMYew3Ntd
         /LppDGUAlfjyUZQAiVBdqHWCxEzdg+m8z3VZ90e2Kxn0z1BkruIHPcokzfCQ0gTza0CT
         4MF6fJTL8ZyUwY5IAZqu98Uero08ytYpbT9bL0iRLHQDPJh7nO6WlxZ3tugnzoLCHtR8
         xvRQ==
X-Gm-Message-State: APjAAAXX2AIWjSwqz4A39hoDIbEt4/n0fxpsSX8BK3lkwrIXcUXQM2Mk
        C846+Qti5Kf4mSBovZKwzO6JXf11GtuOMcyhPW0=
X-Google-Smtp-Source: APXvYqzQL2QVOjIqeka+4Ecte5cpEweDrJl7zSog7SaRU49m2YOMldmuib9eXa77Xvnfs1Wvn5jBdn3tpy7PYudki18=
X-Received: by 2002:a9d:5c11:: with SMTP id o17mr19824177otk.107.1565420344701;
 Fri, 09 Aug 2019 23:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190810052442.GA21354@embeddedor>
In-Reply-To: <20190810052442.GA21354@embeddedor>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 10 Aug 2019 08:58:53 +0200
Message-ID: <CAMuHMdWsu56u_HmwMSTy3N0_uKN0ngi4pmuXoX0y5iU7Y=L=6g@mail.gmail.com>
Subject: Re: [PATCH v2] sh: kernel: disassemble: Mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 7:26 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
> Remove logically dead code and mark switch cases where we are expecting
> to fall through.
>
> Fix the following warnings (Building: defconfig sh):
>
> arch/sh/kernel/disassemble.c:478:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
> arch/sh/kernel/disassemble.c:487:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
> arch/sh/kernel/disassemble.c:496:8: warning: this statement may fall
> through [-Wimplicit-fallthrough=]
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
