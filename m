Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6C7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4403C208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730273AbfIDUif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:38:35 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:42076 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfIDUif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:38:35 -0400
Received: by mail-qk1-f169.google.com with SMTP id f13so20966596qkm.9;
        Wed, 04 Sep 2019 13:38:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nQ+TZt2xAU6ARjfRCiqVZR2trBRpvvDn7We+sIvH1zE=;
        b=guCZC1c2M05CSE/89yIJjIbNd/jmBITex+uFcN1L5nHD7lOs/QGH79CqProkENYsCt
         3HSkZbZBiFk/anM7x1xXnudh7u1Dp/C8oAdTTZZs2Wgh966NYttfyVN6D5/rQWFrs3X2
         aJPIin+nVWC8S3cOi/PxGm/Dg3q/MO7aY/4G1h9s2ARb5+0fm3/7FbDBD9+88LOzZuLk
         H69H8k72MD4R8SPXvdy+WAvNTyNfJL47ocK3W4VqkuZ1TGJlub3rJsDpm8A35r23/G8q
         cstvhe3y1ReRkYl9ML0yqBDULVQE8CmvQ98Spk67yLf+3EFd0AJ/ftiM5SfKFMco8FO7
         OzZQ==
X-Gm-Message-State: APjAAAWcQ+KJDydsF6IO0Nez/V69UABnnnoyvOZfgkDLP39UIu1IrZze
        r4BXnJmUpluDpIl3aB/QsKLsO5gvTnZUUWM1nsg=
X-Google-Smtp-Source: APXvYqx9uD7UtlRyqsCOqQGbbg7AQnv4dWGAqV8gWQixfO/xjWBKsLWBDyCZMABQgbs3kg00uBUNX8YKi+rJXXEYHFs=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr41434701qkb.394.1567629514068;
 Wed, 04 Sep 2019 13:38:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190904175002.10487-1-krzk@kernel.org> <20190904175002.10487-2-krzk@kernel.org>
In-Reply-To: <20190904175002.10487-2-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 22:38:17 +0200
Message-ID: <CAK8P3a0N1C7+_vpAhhmqVv9A+jd4bOXNEgPj_=fdPZTqy-93ng@mail.gmail.com>
Subject: Re: [GIT PULL 1/5] ARM: defconfig: exynos for v5.4
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        SoC Team <soc@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 7:50 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung defconfig changes for v5.4
>
> 1. Enable AHCI platform driver on exynos defconfig for Exynos5250-based
>    Arndale board,
> 2. Make Max77802 PMIC regulator driver a built-in on multi_v7 defconfig
>    as it is essential early during boot.

Pulled into arm/defconfig, thanks!

     Arnd
