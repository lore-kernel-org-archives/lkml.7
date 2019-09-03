Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D724EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63E12377F
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbfICRV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:21:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38792 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfICRV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:21:57 -0400
Received: by mail-qk1-f195.google.com with SMTP id x5so2616724qkh.5;
        Tue, 03 Sep 2019 10:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+yX6K+GSfFVsEprEqhk1LVFi55m2T9zHs0bHG7G6LzQ=;
        b=TMACJii65YjZZYZlzdL3cUCpobfuqWbw084WcoNBjPKkXiL1ftiyOHgKIrRyMfpSBi
         ZoaeGSmCRSYGE+tWNGFkCVgpTH+kcW+W7FID74gB43CIBN0TNtTuGKUj3azI1XJUpQgl
         +agNm2sydUCb437ShKoY23Eng4JyjvNG/tXgvPZCwlIw4biEbQzB0xJ6Say0dBZuqMYX
         vvbjuiFmk6W5c+Y1LqZgNuKHZrzuP8tCHnXrkFZAElMsqUgvbYUHotSQFyOJy8hTH1XF
         LJmsb25Po7/dhc7Dr5aHj0111CKsZjTB5iMffEjxwYXhKCm2c5MSERcl4Asua3PqpMsi
         Y72A==
X-Gm-Message-State: APjAAAUYlW2KnqKaUNWwxHY6pzWw81drlNdvx+GkJ8qFv8e614ZMpRWF
        u0WRQiByzvxRecE7nZt9q7DxZSTdtIU6Rs467Y2zMgVU
X-Google-Smtp-Source: APXvYqwtVaqFxj0uX5/gAyatD0C+Cv5WnzBDBxUeYKcBYyKebRJANZCfhlV3+7wKIyuDzZrhDolFX0Yg4QMPMSMw5Hg=
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr34490800qka.3.1567531316765;
 Tue, 03 Sep 2019 10:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190816163042.6604-1-krzk@kernel.org> <CAJKOXPcgZ2_ofZyAeTSxALkALaP-SFNfvNmNPYSPyLzuhpGZ0w@mail.gmail.com>
 <20190822183519.GA23735@kozik-lap>
In-Reply-To: <20190822183519.GA23735@kozik-lap>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 19:21:40 +0200
Message-ID: <CAK8P3a1_Qw=OB31yOCrpPs8Ys+=9tt4Pnyd=3+2JGzRXJV1KAw@mail.gmail.com>
Subject: Re: [GIT PULL 1/3] soc: samsung: Exynos for v5.4
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 22, 2019 at 8:35 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, Aug 21, 2019 at 09:51:09AM +0200, Krzysztof Kozlowski wrote:
> > On Fri, 16 Aug 2019 at 18:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:
> > >
> > >   Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-5.4
> > >
> > > for you to fetch changes up to 40d8aff614f71ab3cab20785b4f213e3802d4e87:
> > >
> > >   soc: samsung: chipid: Convert exynos-chipid driver to use the regmap API (2019-08-15 20:25:25 +0200)
> > >
> > > ----------------------------------------------------------------
> > > Samsung soc drivers changes for v5.4
> > >
> > > Add Exynos Chipid driver for identification of product IDs and SoC
> > > revisions.  The driver also exposes chipid regmap, later to be used by
> > > Exynos Adaptive Supply Voltage driver (adjusting voltages to different
> > > revisions of same SoC).
> >
> > It turns out that it brings troubles (code is executed on every
> > platform polluting logs because it is an initcall, not a driver) so
> > Sylwester (submitter) asked to skip the submission.
> >
> > Please ignore the pull request.
>
> I talked with Sylwester and Bartlomiej who contributed the chipid driver
> and they provided small incremental fixes. The driver is still useful
> and in the future it will be expanded towards AVS. Therefore please pull
> it or optionally wait a week and I will send incremental pull request
> with fixes.

Pulled into arm/drivers for now.

I have drafted a related patch recently, regarding the related
arch/arm/plat-samsung/cpu.c file. This is part of a longer series
I'm working on, see https://pastebin.com/ZqeU3Mth for the
current version of this patch. The observation is that mach-exynos
is almost completely independent of plat-samsung these days, and my
patch removes the last obstacle from separating the two. I have
another set of patches to do the same for mach-s5pv210 (which shares
half of its pm.c with plat-samsung, but nothing else).

       Arnd
