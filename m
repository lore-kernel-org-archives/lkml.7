Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465A8C48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B7DE213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 15:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="IUbkxvew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbfFYPWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 11:22:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:64963 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729309AbfFYPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 11:22:46 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x5PFMJsk024772
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 00:22:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x5PFMJsk024772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1561476140;
        bh=I4gn4zhWUu8CS8xq7uHMDWTl3vK+1KN7KiPYqeN5XG4=;
        h=From:Date:Subject:To:Cc:From;
        b=IUbkxvew3coDHXBh1wbNW8DZulxXDMMOC9ub60hnqscwj+VHOAQjk9M6qqzlIHfpU
         M+4qUigtcanahmxyTVa4ODzwHkzmu1d273V7sHpQGtWfbcX1MWjY2XxRzmQHgQzF6l
         GCIcYl/ylkcyTxXjm3P8EGKOraWIElrrMNt3d7ujNPizRBYABz/4LWrT2VdCTn1DFb
         YjPiizwRj46lCNS+1vRN63XY9Qlu7LDMI138BjWmGHJFTpCSZYuJHL32ow9X4RJnnR
         HeLVGonywzEdigD7MZxzGzV9ggFHlv/fixRv9QH+ZJ2q91Kqo9//4rvgifawv53itL
         XSGP5b7mVnKlA==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id j26so11154734vsn.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 08:22:19 -0700 (PDT)
X-Gm-Message-State: APjAAAWKfeshD8sG57nMyi1x9sFhy3yxC03f2QQKNYPPao+lppEbJudQ
        DvVr9iRxNMUoamEUAcOZgZqDRo6hnm89fWAsBik=
X-Google-Smtp-Source: APXvYqwWtj7ZIxvvgGhAtUAx2CLtVniyMTTW+OkeTFlWaM/0Lwm1ata1J+FSKX2nmJVuupuYCeIa5nm9RLoFWJql2Ws=
X-Received: by 2002:a67:d46:: with SMTP id 67mr1416351vsn.181.1561476138869;
 Tue, 25 Jun 2019 08:22:18 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 26 Jun 2019 00:21:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQKmSUkXtJOOcr1q8b_yTU_NRcgCvDAo8aZ+CkOXGTWNA@mail.gmail.com>
Message-ID: <CAK7LNAQKmSUkXtJOOcr1q8b_yTU_NRcgCvDAo8aZ+CkOXGTWNA@mail.gmail.com>
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates for v5.3
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm-soc <arm@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Olof,

Please pull UniPhier DT updates (64bit) for the v5.3 MW.

Thanks.


The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v5.3

for you to fetch changes up to aa38571246c6ac279ebebd141157297bcb959d76:

  arm64: dts: uniphier: add reserved-memory for secure memory
(2019-06-26 00:08:47 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v5.3

- Migrate to the new binding for the Denali NAND controller

- Use reserved-memory node instead of /memreserve/ for the
  secure memory area

----------------------------------------------------------------
Masahiro Yamada (2):
      arm64: dts: uniphier: update to new Denali NAND binding
      arm64: dts: uniphier: add reserved-memory for secure memory

 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts |  4 ++++
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 15 +++++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 15 +++++++++++++--
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    |  4 ++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       | 15 +++++++++++++--
 5 files changed, 47 insertions(+), 6 deletions(-)


-- 
Best Regards
Masahiro Yamada
