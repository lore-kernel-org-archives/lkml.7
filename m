Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F3C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A94E21897
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 17:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbfICRcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 13:32:48 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:43392 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbfICRcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 13:32:48 -0400
Received: by mail-qt1-f175.google.com with SMTP id l22so8675704qtp.10;
        Tue, 03 Sep 2019 10:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vgjm2gNxQwoJZ8v0bniiaqPHu8QBdyk+Apmy2AFV2l4=;
        b=mnpH9A+wo4+d0QCiKZyQS3pzhLE0G0H7uxzVC1uveIhsg0yFDk6n1SdByvR97YhKAl
         dWLbAEkUw9+EuIay+WpxUhDcL1naUboXtDm0t9W9SJL9MSucyyjaZ+O8SJXHKEnZd4WX
         ASmMzUAjqEl+0h4yDSBxtLY0vBpf4nMbJ+twPJGqopXeCyAAi3CiUKq1sNdM3Ru3JitC
         VpkCqinM6qMmfuvoDrCNPu1ScPGFaSS3WAzF2BWLQh3F5nJ7rqp7MeTIEqz9iVDCQ1Lw
         VC9FVvJw6R/Vt5DL8HJXC968ri7bXXdjkOZNFJymJsYY1OQX9rhhNbJCrn5ZDAi/m8m5
         49JQ==
X-Gm-Message-State: APjAAAUpfpBVe9E8hU/7k291U1XT1ixF/FN3/SvNHew7VNZvb8N9qToI
        LnqVrQEAP5WTcxXhd0z05jmVJzogIiIcmtxq+kwViA==
X-Google-Smtp-Source: APXvYqyVRUIJPIQEHx95xhwPjnvSTza+9sTHKmCNkiM1M8D9DvwWC/dFC/I4zoquypk9wQ0vA4TbG60cCWZR89wfsHQ=
X-Received: by 2002:ac8:6b1a:: with SMTP id w26mr11188688qts.304.1567531967226;
 Tue, 03 Sep 2019 10:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190816163042.6604-1-krzk@kernel.org> <20190816163042.6604-3-krzk@kernel.org>
 <CAJKOXPfdvzvomUfmxhGf0qjEQH3K8TADCneo9SM6m50k4b=Gyw@mail.gmail.com>
In-Reply-To: <CAJKOXPfdvzvomUfmxhGf0qjEQH3K8TADCneo9SM6m50k4b=Gyw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 3 Sep 2019 19:32:31 +0200
Message-ID: <CAK8P3a0sa8WgcNnL8jusYKFr22FqGnut4kRKM-1QcB8G+ygnMg@mail.gmail.com>
Subject: Re: [GIT PULL 2/3] ARM: samsung: mach for v5.4
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
> > Linus Walleij (1):
> >       ARM: samsung: Include GPIO driver header
> >
> > Pankaj Dubey (1):
> >       ARM: exynos: Enable exynos-chipid driver
>
> This last patch should be dropped so I will rework the pull request
> and send later v2. Please ignore it for now.

I don't see the v2 yet. Are you still planning to send it?

        Arnd
