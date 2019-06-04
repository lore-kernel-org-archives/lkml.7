Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED0CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56DB024D3E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 07:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfFDH7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 03:59:37 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40386 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfFDH7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 03:59:37 -0400
Received: by mail-lj1-f196.google.com with SMTP id a21so3526214ljh.7;
        Tue, 04 Jun 2019 00:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0nzKAfA25Nd/B5b94/lEffHmOkj3bNdRwQPedDI7ZE=;
        b=iYsPPhnsC0EJTsHqeeq0mjjcxm9WXPAI/rdF7X6cP16AjIIPs3VSFWSS27cmjrJW5n
         jyWXeJtLvDVLeQDOR8FH7IBenyNSKMoO5vVfrVGJZhjieveJJ/AtZb/XV2F1uPZHn24B
         6gGxSN7OgSD704Gy86J3kNRILn0Glf47KC2K2cQcAunGWMHd3eaJJBj4+j02lQe56jq/
         /Q0HIVlhu7/QE1tHWX1X1eqe0NshnMGX+NkkWacdDCpgpEns6iPpgkpOJM1YkjRWPjiH
         g2fcxv0xXDer1TcdSOfDadzFlKlVOF+Tl9o1gY1sPTa1XCLjWQe8fnrIZBzeHJJn137L
         ekaQ==
X-Gm-Message-State: APjAAAWOVHXXyaDM+A9eWxNBu+pa6+KiuEE92DmoFGkZgjf22PcvKw/x
        UUV4dpXUk7oL3qC6NpeM/8Qhv7mTA5Plo+2JAFz4rg==
X-Google-Smtp-Source: APXvYqzyrjK66udRCjVrFtHeJQc9LooEJGHnCm5cn7phdyFg8MU2Z7Z0IJKhJVKh9a9iL2ykJCk01AUjQnJwzYRKzgI=
X-Received: by 2002:a2e:2b8d:: with SMTP id r13mr3487195ljr.145.1559635174859;
 Tue, 04 Jun 2019 00:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <1559634980-20463-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1559634980-20463-1-git-send-email-krzk@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 09:59:22 +0200
Message-ID: <CAMuHMdU9hW1N_DDbFiBjWW0bnRnT46820bqvNg4iWvy2Ho35yg@mail.gmail.com>
Subject: Re: [PATCH] sh: configs: Remove useless UEVENT_HELPER_PATH
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
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
