Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C84AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A332087C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCMO1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:27:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32974 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfCMO1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:27:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id i8so2254556wrm.0;
        Wed, 13 Mar 2019 07:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=znaRMaKImjKU7n+2sOr5kCFEkGn8Lfh8iIcumM4oMEk=;
        b=TCMcu2T1DCeXGBQ77YLb6kEJZHeyQZ9vXkrH1ewD9n0rGDC1BlrjGJ34uVzxsvCim3
         JndogAZmSwSjhqFEA5OSBUba1t1abhHXQK+8Eku9GnW0rJC9yztV4wCPIcgkRcHnEhgT
         M1V5p/lbG4OMuNBh69fA/tAG2HISdEH9on4JdI0VVz66LzcCuf5mPj92T517F1wmMW9h
         AVOSZbxhRAFvCjyXjza2weTE/KmmPmzfaDFL9bOlrOEGW4/n49LMHHdFsELBN0IufZCE
         0TB2xUfyvoW/4+IbO7g75y/KlZ1ClXWRelyJqIlMm8u8ql3RuoaRvXJsY3SHb71hvIgL
         4jrg==
X-Gm-Message-State: APjAAAUuRIAhtGHnuU5DCkc0kxYo6OGebLYcP1Dvy57QOys20NoyFvFs
        ogR44Kmnc0rFXqvAwPwDRfk=
X-Google-Smtp-Source: APXvYqxx9Dfeq65gU26pkdXAS+24+HNqsgNi6ACDfHY6q2T1SE+/x3h7/wAQIZp9PDLCkYJmaehe+w==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr5716405wrv.83.1552487261256;
        Wed, 13 Mar 2019 07:27:41 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id h17sm11003526wrq.93.2019.03.13.07.27.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2019 07:27:40 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, mpfj@newflow.co.uk,
        cquast@hanoverdisplays.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] ARM: dts: am335x: Replace numeric pinmux address with macro defines
Date:   Wed, 13 Mar 2019 15:27:22 +0100
Message-Id: <20190313142724.27446-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset replaces the register offsets for am335x with macro defines.
The values are extraced from the "AM335x SitaraTM Processors Technical
Reference Manual".

Updated AM33XX_IOPAD to take three instead of two parameters, to make
future changes to #pinctrl-cells easier.

Christina Quast (2):
  ARM: dts: am335x: Replace numeric pinmux address with macro defines
  ARM: dts: am335x: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-baltos-ir2110.dts    |  16 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts    |  38 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts    |  42 +--
 arch/arm/boot/dts/am335x-baltos-leds.dtsi     |   6 +-
 arch/arm/boot/dts/am335x-baltos.dtsi          | 140 ++++-----
 arch/arm/boot/dts/am335x-base0033.dts         |  48 +--
 arch/arm/boot/dts/am335x-bone-common.dtsi     | 116 +++----
 .../arm/boot/dts/am335x-boneblack-common.dtsi |  54 ++--
 .../boot/dts/am335x-boneblack-wireless.dts    |  28 +-
 arch/arm/boot/dts/am335x-boneblue.dts         | 104 +++----
 .../arm/boot/dts/am335x-bonegreen-common.dtsi |   4 +-
 .../boot/dts/am335x-bonegreen-wireless.dts    |  28 +-
 arch/arm/boot/dts/am335x-chiliboard.dts       |  66 ++--
 arch/arm/boot/dts/am335x-chilisom.dtsi        |  34 +-
 arch/arm/boot/dts/am335x-cm-t335.dts          | 154 ++++-----
 arch/arm/boot/dts/am335x-evm.dts              | 234 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts            | 292 +++++++++---------
 arch/arm/boot/dts/am335x-icev2.dts            | 116 +++----
 arch/arm/boot/dts/am335x-igep0033.dtsi        |  40 +--
 arch/arm/boot/dts/am335x-lxm.dts              | 120 +++----
 .../boot/dts/am335x-moxa-uc-2100-common.dtsi  |  42 +--
 arch/arm/boot/dts/am335x-moxa-uc-2101.dts     |  24 +-
 .../arm/boot/dts/am335x-moxa-uc-8100-me-t.dts | 116 +++----
 arch/arm/boot/dts/am335x-nano.dts             | 140 ++++-----
 arch/arm/boot/dts/am335x-osd3358-sm-red.dts   | 168 +++++-----
 arch/arm/boot/dts/am335x-osd335x-common.dtsi  |   4 +-
 arch/arm/boot/dts/am335x-pcm-953.dtsi         |  74 ++---
 arch/arm/boot/dts/am335x-pdu001.dts           | 170 +++++-----
 arch/arm/boot/dts/am335x-pepper.dts           | 200 ++++++------
 arch/arm/boot/dts/am335x-phycore-som.dtsi     |  60 ++--
 arch/arm/boot/dts/am335x-pocketbeagle.dts     |  56 ++--
 arch/arm/boot/dts/am335x-sancloud-bbe.dts     |  62 ++--
 arch/arm/boot/dts/am335x-sbc-t335.dts         | 112 +++----
 arch/arm/boot/dts/am335x-shc.dts              | 224 +++++++-------
 arch/arm/boot/dts/am335x-sl50.dts             | 208 ++++++-------
 arch/arm/boot/dts/am335x-wega.dtsi            |  68 ++--
 arch/arm/boot/dts/am33xx.dtsi                 |   1 +
 include/dt-bindings/pinctrl/am335x.h          | 236 ++++++++++++++
 include/dt-bindings/pinctrl/omap.h            |   2 +-
 39 files changed, 1942 insertions(+), 1705 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/am335x.h

-- 
2.20.1

