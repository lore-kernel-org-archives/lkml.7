Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F74C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2542B2454D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfFDIhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:37:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43857 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbfFDIhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:37:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id j29so1866224lfk.10;
        Tue, 04 Jun 2019 01:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9Nt6qozBUK6drcpof1+TwMEXL9WmUd9V+VggpiZn+A=;
        b=b4t7+vEPm6PyZobMBTmOmavH1qaqFNhNaBRfCMWIPZTWJKaAusuid15TRfclF4McCW
         cMh6/aYtWY73HFJtk6O5dXx3pEmoSs7286hlfbtLztQ1yLhL9xBlymsf+kDwUPB1VahY
         6BJUQtXdHd/yBvuOV7H9XmY2nHGPBQ+2HDZdhopHf8b7DXXgRZPsnY641VWOxOqTcCqh
         4YuTSVEHpMNg/em6k2FtsUiOWOVY1eC9PswIt0lvIsYHYuHnSoySG1PFBSfqf9Gu/vX3
         PgUm06CU3f4hdL3mVP6Zh7/S6ETGVbBw+O2lTGWBNKST7/K2RXJgJTG3Sg1spjsagjTo
         i7yA==
X-Gm-Message-State: APjAAAVpX8nQv3jYiCWvwy7fFdzz8FgvAIWbzjbrckG2uIQ6O5m49t8e
        sq+PixXQkV/fAOZKcjNvFH3bFvJipAvUxekyHfg=
X-Google-Smtp-Source: APXvYqw93iUlXYu8dPqQcx+f3tfXZ72Q5ZS8GVxBMq0ItikCpS0IsuP0YnKL3t97ZoLH9sUbcmA4K/rRcZzJe16lhLU=
X-Received: by 2002:ac2:5467:: with SMTP id e7mr15738576lfn.23.1559637424910;
 Tue, 04 Jun 2019 01:37:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190520143647.2503-1-narmstrong@baylibre.com> <CAPDyKFoOHnYiYogjogRr=7PBjqHOseDDS6L0eirTo7Y+F449ow@mail.gmail.com>
In-Reply-To: <CAPDyKFoOHnYiYogjogRr=7PBjqHOseDDS6L0eirTo7Y+F449ow@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jun 2019 10:36:53 +0200
Message-ID: <CAMuHMdWHnyTWMToXU_DSezwYs_Lkxj+v0BC8PKXHZgX=e1N3ww@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: meson: update with SPDX Licence identifier
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf, Neil,

On Tue, May 28, 2019 at 10:53 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Mon, 20 May 2019 at 16:36, Neil Armstrong <narmstrong@baylibre.com> wrote:
> > Update the SPDX Licence identifier for the Amlogic MMC drivers.
> >
> > Neil Armstrong (2):
> >   mmc: meson-gx-mmc: update with SPDX Licence identifier
> >   mmc: meson-mx-sdio: update with SPDX Licence identifier
> >
> >  drivers/mmc/host/meson-gx-mmc.c  | 15 +--------------
> >  drivers/mmc/host/meson-mx-sdio.c |  6 +-----
> >  2 files changed, 2 insertions(+), 19 deletions(-)
>
> Applied for next, thanks!

Please note this conflicts with commit 2874c5fd28426836 ("treewide:
Replace GPLv2 boilerplate/reference with SPDX - rule 152") upstream,
which added (different) tags.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
