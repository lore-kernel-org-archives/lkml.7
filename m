Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED43C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D61F20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 22:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfCBW2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 17:28:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44363 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfCBW2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 17:28:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id d2so1411742qti.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2019 14:28:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9ZqpYNZXcv7HDRBbtnqr+RFMJWYBf8laD5fG36QkA8g=;
        b=SVoOqsSrRIEHXHpwWLvNBjjKtR94xVHG1pVnkw+yg2ZwwLx1Bx5hSo8kLeC8lAC0D3
         UE6gATevpFz/p8ifn70C/wbyxZa0lA/ENrBGVEmZh/Isu3dbGvzNf0zH8zEqwAMlIzDF
         Xp4jmcRRjZcPO/Y661vodBdgbyoW9MY4yRRkBTLGr7ycS/KAsv3G/leqh6JAJU9CJSjw
         MEiw3uT/rwI/CwpVqSaE0XzbvqpSbz4pXqOdWfJMOd3avxAx4+h0X3Rx6e1OFUKTw2cW
         txBaTvgfuCDNq5iC1TXkdEW7jJpUTTumBEzuZi3hO0Hf0fb36dc1OW1HIwXlQn8vNcma
         MLTg==
X-Gm-Message-State: APjAAAV7TiWxx8g3e6lBDP9vgSL2BzYMSsfIsOm8j0vC2kUtiiAmY9g5
        vY2Rlt2plkyuEbKfrnDU5NgDT/6wMLeC/HV2ZfP8r5QA
X-Google-Smtp-Source: APXvYqwEe3AtEXiMyf3Uk+io/gHndTg/voseNQA5z+Rh+dXRvQ4QSop0utEJ1YWk69layfxPdwnIhJ1MU30Y5M8UsEY=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr8986770qve.180.1551565714881;
 Sat, 02 Mar 2019 14:28:34 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 2 Mar 2019 23:28:17 +0100
Message-ID: <CAK8P3a32CEOeUe+WT_p23FoY3V7vkCyMvBfvGmvSC--cuHxkdA@mail.gmail.com>
Subject: [GIT PULL] ARM: SoC fixes for v5.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-soc <arm@kernel.org>, soc@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5908e6b738e3357af42c10e1183753c70a0117a9:

  Linux 5.0-rc8 (2019-02-24 16:46:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 6089e65618dca3fc0e7ccd7a6315de62ebf893a4:

  Merge tag 'qcom-fixes-for-5.0-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux into
arm/fixes (2019-03-01 15:08:16 +0100)

----------------------------------------------------------------
ARM: SoC fixes for v5.0

One more set of simple ARM platform fixes:

 - A boot regression on qualcomm msm8998
 - Gemini display controllers got turned off by accident
 - incorrect reference counting in optee

----------------------------------------------------------------
Andy Gross (1):
      Merge tag 'qcom-fixes-for-5.0-rc3' into fixes-for-5.0-rc8

Arnd Bergmann (2):
      Merge tag 'tee-fix-for-v5.0' of
https://git.linaro.org/people/jens.wiklander/linux-tee into arm/fixes
      Merge tag 'qcom-fixes-for-5.0-rc8' of
git://git.kernel.org/.../agross/linux into arm/fixes

Julia Lawall (1):
      tee: optee: add missing of_node_put after of_device_is_available

Linus Walleij (1):
      ARM: dts: gemini: Re-enable display controller

Marc Gonzalez (1):
      arm64: dts: qcom: msm8998: Extend TZ reserved memory area

 arch/arm/boot/dts/gemini-dlink-dir-685.dts | 2 +-
 arch/arm64/boot/dts/qcom/msm8998.dtsi      | 2 +-
 drivers/tee/optee/core.c                   | 4 +++-
 3 files changed, 5 insertions(+), 3 deletions(-)
