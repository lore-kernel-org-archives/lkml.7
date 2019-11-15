Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20956C43215
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0349920729
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfKOIKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 03:10:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:38599 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfKOIKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 03:10:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id a14so7905375oid.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 00:10:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSr7cTGfOdXAXx7Uwdhh3Oh8e5ZfUnggvdAXALwWrL0=;
        b=uHygN6QJF7BKOzQT7hflLqd8cw1Hxl3BinLraP/bI6Bo63ps5Ek9qo6j1ko0T52sKE
         Zch9uSJMrHnvHqCb2e5Td2eZHk9+JBMzoWSt1XOhb1jUfzoJrgSH7+PnsvN9qDvKF+bG
         tX7/l941y+T2XNUHRQz7kBbd/+1MDfkPHNv0nQlkNQXbEl6zMQHTHVmn49ugJPNMefTR
         v5Ii4ASc0lk5jriVc2FbeBk3VAI9AFrPgXbs5MGRPDXWzKMD8jLPKkBYnso+ZQ1t1jXa
         mGpA3NpvgKgL/4bdrl0mjU2riZrUcJbxl+DkJKh9So0E61SFA3TW+9k5Iixs3puGmKsa
         CZqQ==
X-Gm-Message-State: APjAAAVatmTdFn2nGhb0FJy4OEmoQ1hvk8PbJuLjNcKaJUCgWCTlCyZ+
        Q4BwZZOz6DqUnknXuajyDmAXPHZ+0xQkbQRA493fay3T
X-Google-Smtp-Source: APXvYqxCv94tNtW9fCNSuBgOTtlmJbNbNkU+GuiFOtEtRh3Ty+uWOrYwRpYJHN4jbhP3ZGDBhhh998rC43Zbc/QVybo=
X-Received: by 2002:aca:4ac5:: with SMTP id x188mr6635783oia.148.1573805414147;
 Fri, 15 Nov 2019 00:10:14 -0800 (PST)
MIME-Version: 1.0
References: <20191024153756.31861-1-geert+renesas@glider.be> <20191115061554.532d29e9@collabora.com>
In-Reply-To: <20191115061554.532d29e9@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Nov 2019 09:10:02 +0100
Message-ID: <CAMuHMdWO=8sHn9wrEiuBGes0x_L2=Qkou=aPcHM7Mr9oDS74Qw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Mark linux-i3c mailing list moderated
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-i3c@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Fri, Nov 15, 2019 at 6:16 AM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Thu, 24 Oct 2019 17:37:56 +0200
> Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > The linux-i3c mailing list is moderated for non-subscribers.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Queued to i3c/next. It was actually queued 2 weeks ago but the
> patchwork bot didn't send a notification for that one (one was sent for
> your other patch) and I don't know why.

It did:

-----8<-----------------------------------------------------------------------------------------
Subject: Re: [PATCH] MAINTAINERS: Mark linux-i3c mailing list moderated
From: patchwork-bot+linux-i3c@kernel.org
Message-Id: <157251967150.27046.1691850610457130750.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2019 11:01:11 +0000
References: <20191024153756.31861-1-geert+renesas@glider.be>
In-Reply-To: <20191024153756.31861-1-geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
X-GND-Status: LEGIT
Received-SPF: pass (spool2: domain of kernel.org designates
198.145.29.99 as permitted sender) client-ip=198.145.29.99;
envelope-from=patchwork-bot+linux-i3c@kernel.org;
helo=mail.kernel.org;

Hello:

This patch was applied to i3c/linux.git (refs/heads/i3c/next).

On Thu, 24 Oct 2019 17:37:56 +0200 you wrote:
> The linux-i3c mailing list is moderated for non-subscribers.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Here is a summary with links:
  - MAINTAINERS: Mark linux-i3c mailing list moderated
    https://git.kernel.org/i3c/c/469191c7fcd069a500c2a26c49c9baef9dabf66d

You are awesome, thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
----------------------------------------------------------------------------------------->8-----

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
