Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E142C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CC0206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556520804;
	bh=/8s3r5X+mra2HHJHmmBGYYEEnP8VSjNF/uGBLudyStM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sk/QLBox1XPH/gFRCdLbxTtPOJSxdHgGcs51C4CZHzjkUK9hvWFYuck1n22kaxu8P
	 WGeMEiQ+3jIoTPcgpsJDHJ9R2Mm2Vagu6Io6Wxp50ShLLkZb7viSr/PreRU8bDWWTo
	 hixLWjre6lV/qJKez2ENbZ4f1vdUFnIDFwAVJOWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbfD2GxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727208AbfD2GxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:53:23 -0400
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF2DB206BF;
        Mon, 29 Apr 2019 06:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556520802;
        bh=/8s3r5X+mra2HHJHmmBGYYEEnP8VSjNF/uGBLudyStM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Zoya90rKN0PHZexbyvZL9PtDtk+DylIduUidCxWViXejlQv8m3j4uR9GYRTYN6d1k
         8p9P9qB0u+aLdiHCTIEnQLDkgXLrLOaeSAjiO1oBlYzjzfoBEL0+vRNAnGOXAU2z4f
         H3s9nQR4Ll8wtrP0JKdV1UkOQVrEKlU2WQ/KFr90=
Received: by mail-lf1-f44.google.com with SMTP id h5so7107832lfm.1;
        Sun, 28 Apr 2019 23:53:21 -0700 (PDT)
X-Gm-Message-State: APjAAAWk2hrEnmocLNCsjvvXjlVLVXnLV48rodclcgQhP2JeVmIPxgod
        T6lJo+AfN/Oz5eIG7H2+FPfFOV4js5bwpicD3To=
X-Google-Smtp-Source: APXvYqzNqMoLoFyXW1X6g3hv/YfTO7wryk7yF+B9HqpjcYIXKneyEULTZE0XAlyk9wlJ1OYKn0th3it5W/vg18auv2E=
X-Received: by 2002:a19:c301:: with SMTP id t1mr30532924lff.167.1556520800288;
 Sun, 28 Apr 2019 23:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190414154805.10188-1-krzk@kernel.org> <20190414154805.10188-3-krzk@kernel.org>
In-Reply-To: <20190414154805.10188-3-krzk@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 29 Apr 2019 08:53:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfzV0wn0a-4xvy1B0fR=X4VvpqNmtqwRGFhFdCMH3OpHA@mail.gmail.com>
Message-ID: <CAJKOXPfzV0wn0a-4xvy1B0fR=X4VvpqNmtqwRGFhFdCMH3OpHA@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: samsung: Changes for v5.2
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org
Cc:     Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Apr 2019 at 17:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
>
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
>
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.2
>
> for you to fetch changes up to 7676e667c841375b41d9438b559756141aa93d0e:
>
>   ARM: s3c64xx: Tidy up handling of regulator GPIO lookups (2019-04-14 12:53:03 +0200)
>
> ----------------------------------------------------------------
> Samsung mach/soc changes for v5.2
>
> 1. Cleanup in mach code.
> 2. Add necessary fixes for Suspend to RAM on Exynos5422 boards (tested
>    with Odroid XU3/XU4/HC1 family).  Finally this brings a working S2R
>    on these Odroid boards (still other drivers might have some issues
>    but mach code seems to be finished).
> 3. Require MCPM for Exynos542x boards because otherwise not all of cores
>    will come online.
> 4. GPIO regulator cleanup on S3C6410 Craig.

Hi Olof and Arnd,

I see you pulled in DTS and DTS64 pull request. I think this one here
is still pending.

Best regards,
Krzysztof

>
> ----------------------------------------------------------------
> Charles Keepax (1):
>       ARM: s3c64xx: Tidy up handling of regulator GPIO lookups
>
> Joonyoung Shim (1):
>       ARM: exynos: Add CPU state management for Exynos542x under secure firmware
>
> Marek Szyprowski (5):
>       ARM: exynos: Move Exynos542x CPU state reset to pm_prepare()
>       ARM: exynos: Add Exynos SMC values for secure memory write
>       ARM: exynos: Fix undefined instruction during Exynos5422 resume
>       ARM: exynos: Fix infinite loops on CPU powerup failure
>       ARM: exynos: Set MCPM as mandatory for Exynos542x/5800 SoCs
>
> Wen Yang (1):
>       ARM: exynos: Fix a leaked reference by adding missing of_node_put
>
>  arch/arm/configs/exynos_defconfig            |  1 -
>  arch/arm/configs/multi_v7_defconfig          |  1 -
>  arch/arm/mach-exynos/Kconfig                 | 12 ++-----
>  arch/arm/mach-exynos/Makefile                |  2 +-
>  arch/arm/mach-exynos/common.h                |  1 +
>  arch/arm/mach-exynos/exynos.c                |  3 ++
>  arch/arm/mach-exynos/firmware.c              |  1 +
>  arch/arm/mach-exynos/mcpm-exynos.c           | 13 +++++++-
>  arch/arm/mach-exynos/platsmp.c               |  9 ++++-
>  arch/arm/mach-exynos/smc.h                   |  7 ++++
>  arch/arm/mach-exynos/suspend.c               | 49 ++++++++++++++++++++++++----
>  arch/arm/mach-s3c64xx/mach-crag6410-module.c | 14 ++++++--
>  12 files changed, 89 insertions(+), 24 deletions(-)
