Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6279C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B439820674
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 12:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbfICMm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 08:42:56 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:33136 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbfICMm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 08:42:56 -0400
Received: by mail-qt1-f170.google.com with SMTP id r5so14413304qtd.0;
        Tue, 03 Sep 2019 05:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LjGO+oUxhZvmZfNDhv28dAl2/ZZJXmLVYGmjLAI6tU8=;
        b=GeVpkkMwA8XgBzslTEFOhg5E+IxRrQcQFMIMEkdOwoP6T/gBlbyjSqjKq/U6Y7bqNB
         zDBrjB1M8VYiGdR0XzfA63BjKbi6bEF9APJp6P5ctE9MiYh3vruU4vtQbjWCBnZE3CBy
         G6ow2hXYwIkvhipbnz+7RgteKZKigZiBdPyXfhPPVRR+oCxQjutYBwzEQ/41WC4yjt/6
         Gw/wrQGOR+HTSgsz/iGWDZVk3ciKi+L4uIr7PpXVMCpNHb2gPnEAd6MgH5sjRXPgXNWW
         kCnZWJHi1TMw0+WW/zpmGBHBosxaiS2wgvModvOmKprAuejEDXddHgcLZeEPTIitcEQj
         QctA==
X-Gm-Message-State: APjAAAWqT8GdU27rdeXLsxZYATazi9ON7IbdrenJ0gcTeVBt9yDXN9mw
        9bCuFCM0uv1sA2p2U/IEb5M/vLSLdtDBj0uVBqY=
X-Google-Smtp-Source: APXvYqz/RjqtxAdND8OwqAOI6N7IRdIdxkC5cn5hWSHGzEd9UlyPn9MWNX54H+S4BXK9wirBn0TXv39BZMO0i5a9dgM=
X-Received: by 2002:a0c:e74b:: with SMTP id g11mr21379063qvn.62.1567514575190;
 Tue, 03 Sep 2019 05:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190816163042.6604-1-krzk@kernel.org> <20190816163042.6604-2-krzk@kernel.org>
 <CAJKOXPf6qpGDNxKpUJ+Eby8NS+BhrypA4xy_m1s4GHFA55Q9PQ@mail.gmail.com>
In-Reply-To: <CAJKOXPf6qpGDNxKpUJ+Eby8NS+BhrypA4xy_m1s4GHFA55Q9PQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 14:42:39 +0200
Message-ID: <CAK8P3a3cCE-KJxoQLE5qNd5Rg=Z3Bus05FQf92DqCAHS+EFhzQ@mail.gmail.com>
Subject: Re: [GIT PULL 3/3] ARM: dts: exynos: DT for v5.4
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

On Wed, Aug 21, 2019 at 9:52 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Fri, 16 Aug 2019 at 18:30, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > ----------------------------------------------------------------
> > Samsung DTS ARM changes for v5.4
> >
> > 1. Add AHCI to Exynos5250,
> > 2. Add camera and GPU power domains to Exynos5422,
> > 3. Minor cleanup.
>
> Just a reminder - this one pull request is good to go. No changes needed.

Thanks for the reminder. There was a bit of delay because of my
vacation. Pulled now into arm/dt.

     Arnd
