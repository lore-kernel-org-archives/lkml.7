Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85604C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5684220675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfCFPZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:25:29 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:38253 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfCFPZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:25:28 -0500
Received: by mail-qt1-f179.google.com with SMTP id s1so13227351qte.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:25:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gGCwgMKP6vt58kbX5XtRQWiKQmeKhonse8Ecu4U1gxo=;
        b=Gf42nMuk5xbMIwu4ZVsartYeD6lHUBSSW11Dj5+Xh9CN+CYLMtZZeucIqqDdDkb22/
         OcZgeQXhIhaPaGffN+G6t3CENSsP+KFzMN254p5neEXRjBv0mmA8s6ORAESnZC6QojpL
         tudgPSrghSDykSThEinPhfZbWpCEA1hRrecJwH6o88kvzpc4ybroltPSdNyS8GBLzd6P
         DA0Q/izM7gVVvMrycO6LButvGTouXv0sXlLH7Ozp2UtT2ktmfneM7wraNsP9ct9UsMOy
         PxjclsAsPPiAcJdTPghx1dq2BQ4lsY1V7D7jcpnkXHUdafMaqydu2YRVXa3/piUUxuon
         njbg==
X-Gm-Message-State: APjAAAUKMZF+JB9ylWSS134c6ID+qrOMHR3CkmOH/3NvkUPZb57iN0Aa
        /uXcRPLuSn/5/2EzCODhQIMh5A7U7lT3QlF1A2I=
X-Google-Smtp-Source: APXvYqz8gx2NIEAH/HGCJwYvRtE32vm3rhvvxEX0Ypu4F9xUKcydAS6/YpYOHE81OYK4gtJyDZNagHDc5IaE7pJbdao=
X-Received: by 2002:ac8:2bcf:: with SMTP id n15mr5889343qtn.96.1551885927690;
 Wed, 06 Mar 2019 07:25:27 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:25:11 +0100
Message-ID: <CAK8P3a1mnNrpf5moqi4x9BaTNpE9ZUgs-VBjXoG7=AxENwYtbQ@mail.gmail.com>
Subject: [GIT PULL 0/6] ARM: SoC changes for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

There are six arm-soc branches this time, including one branch
for two newly added SoC families (Socionext Milbeaut
and Bitmain BM18xx), and one 'late' branch that I ended
up sending together with the rest because I felt confident
enough about it after the extra week past -rc8.

The release feels a little smaller than normal this time, though
there are still a total of 767 non-merge commits in it, pulled
from exactly 100 downstream branches.

Contributors with the most commits this time were

     57 Bartosz Golaszewski
     29 Fabrizio Castro
     28 Chen-Yu Tsai
     23 Vladimir Zapolskiy
     20 Joseph Lo
     18 Manivannan Sadhasivam
     18 Biju Das
     17 Martin Blumenstingl
     16 Thierry Reding
     16 Stefan Wahren
     16 Jerome Brunet
     15 Linus Walleij
     12 Miquel Raynal
     12 Anson Huang
     11 Bjorn Andersson
     10 Rajendra Nayak
     10 Lucas Stach
     10 Geert Uytterhoeven

All the usual platforms are active (renesas, sunxi, imx, omap,
qcom, rockchips, mediatek), but I'm also happy to see more
updates on some platforms that have seen less activity in the
past (davinci, tegra and samsung-s5p).

      Arnd
