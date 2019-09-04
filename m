Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0E8C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77ADE22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 20:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfIDUjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 16:39:39 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]:39359 "EHLO
        mail-qk1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbfIDUjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 16:39:39 -0400
Received: by mail-qk1-f179.google.com with SMTP id 4so21013837qki.6;
        Wed, 04 Sep 2019 13:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uq0zv2UkiJLjMjjKeNFbujc9fQrnyLYzOUVctKFpAkM=;
        b=iuvxy1wxRP48ngZ7I7YvRlbWxwBNdYmdIR0jGJOhFmPWVmsKVmdj9xd8XkH2XBCdzT
         gevlx8mRfMe8RPpiPyXv4ExSNaD/XB3fsmSkAW7AMph17ICv4dvX9LoGKcEaF2l9NnHg
         ZpKsLGEPHQHwX+qK7v6DxtLNJLB0tnewlRzLDaQ3kPxLAciXFDcy8vZo6y0B5e03EwgU
         D3UFad1Vxv97/sv50ByXjLYAgg+VhNXcMtH4PDgkEmBJtoLO2hlOW8lURkGYcppBxXqS
         xiy1zXqe3Pmp8IspHkHGVhdW5f1L988MjcrYevaqmdDlJvV0GdTlxGq4oZMrK8LsqEtK
         Zwbg==
X-Gm-Message-State: APjAAAXdTc7ZQQk+0Mz/O7gUK10aWos5Zx77SLIOZieZF1XkQs6jDlbn
        U9UVD1PZTDzyCVIR9xuopc/t28WHFcrP4a5XiDc=
X-Google-Smtp-Source: APXvYqz8lBuhlOPSvE0tDe5CevBPyAHsWAlq05grbhyPia69P41xYFoLaGo8IrpgS8oFCmKZsll/AUJSZYswal64Qho=
X-Received: by 2002:a37:4fcf:: with SMTP id d198mr41439228qkb.394.1567629578540;
 Wed, 04 Sep 2019 13:39:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190904175002.10487-1-krzk@kernel.org> <20190904175002.10487-5-krzk@kernel.org>
In-Reply-To: <20190904175002.10487-5-krzk@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 4 Sep 2019 22:39:22 +0200
Message-ID: <CAK8P3a3GKUXWoJvSj_g=Dqv=RZfpFP7vsTBCPC_ts6S5BBTBkA@mail.gmail.com>
Subject: Re: [GIT PULL 4/5] ARM: samsung: mach for v5.4, second (replacing previous)
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
> Samsung mach/soc changes for v5.4
>
> 1. Minor fixup in plat and mach code (S3C platforms),
> 2. Enable exynos-chipid driver to provide SoC related information,
> 3. Extend the patterns for Samsung maintainer entries to cover all
>    important files.

Pulled into arm/soc, thanks!

        Arnd
