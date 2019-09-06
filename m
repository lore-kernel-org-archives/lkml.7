Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA4DC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1CA2208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393495AbfIFTs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:48:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34655 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfIFTs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:48:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id a13so8543211qtj.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 12:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=yxMUYYTEpdgLLHvSUH5Uh9JMJfdGB0yddxYTqYtuf0E=;
        b=moOcf0JdBWbD6KxLfNXp5DQWDnIHS3Tg5tSVxkMKEBmRWCOqV79Rj6CoTi0FunpjnD
         4Ib7iumNp9uJp0zqImVYrfUpDdCeV6DmxVJ1iuFeySJVQGRviYzhBRP2IhXJCncoPVXF
         4yN9NOAqA9LAkpZxAUO9/hWhWt3M9Uj3A91TpzrjgfgygYg+K9qSx7P4URKdMguJY2UR
         MpNjYjlenOvPVXzKG/0XvvckZkkTiIgVTmVk6pB+JONWJm+MkIVWth4QgtBO/kGuNZYb
         nJBB7ZC34oe6kzT0LCm9hC5//QNm/90gGORTufIlJipc4CL6V/BSWQ7A/Z2zxO4eAYtm
         cCPw==
X-Gm-Message-State: APjAAAV2Lk32pFdyPhnbrJsUwtkZqhEnyNwW+NNfg66WEtyEijf2Uwn2
        ulrLu8w32jWY/n/XIRmDUpuDxJufi7TrFLbt+lE=
X-Google-Smtp-Source: APXvYqyH772GapIqmZBvti+w1T7U/d8foRokKXMGEjzPAsmgsLo8wFjr0ZXbWuzLNUK6j9RWLhfMKqxZnaahHTF4IC4=
X-Received: by 2002:a0c:e0c4:: with SMTP id x4mr6830761qvk.176.1567799305468;
 Fri, 06 Sep 2019 12:48:25 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 6 Sep 2019 21:48:09 +0200
Message-ID: <CAK8P3a0MsTFjqChoz+DLSC8nVnBuvqQdYx6V0SuCybg7MZ79mQ@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for -rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 089cf7f6ecb266b6a4164919a2e69bd2f938374a:

  Linux 5.3-rc7 (2019-09-02 09:57:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 8928e917aeafaf38d65cc5cbc1f11e952dbed062:

  soc: qcom: geni: Provide parameter error checking (2019-09-06 11:08:08 +0200)

----------------------------------------------------------------
ARM: SoC fixes

There are three more fixes for this week:

- The Windows-on-ARM laptops require a workaround to
  prevent crashing at boot from ACPI
- The Renesas "draak" board needs one bugfix for
  the backlight regulator
- Also for Renesas, the "hihope" board accidentally
  had its eMMC turned off in the 5.3 merge window.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (2):
      Merge tag 'renesas-fixes-for-v5.3' of
git://git.kernel.org/.../horms/renesas into arm/fixes
      Merge tag 'renesas-fixes2-for-v5.3' of
git://git.kernel.org/.../horms/renesas into arm/fixes

Fabrizio Castro (1):
      arm64: dts: renesas: hihope-common: Fix eMMC status

Geert Uytterhoeven (1):
      arm64: dts: renesas: r8a77995: draak: Fix backlight regulator name

Lee Jones (1):
      soc: qcom: geni: Provide parameter error checking

 arch/arm64/boot/dts/renesas/hihope-common.dtsi | 1 +
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 6 +++---
 drivers/soc/qcom/qcom-geni-se.c                | 6 ++++++
 3 files changed, 10 insertions(+), 3 deletions(-)
