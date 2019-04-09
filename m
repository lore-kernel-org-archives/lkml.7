Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FACC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959E22084C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 16:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfDIQEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 12:04:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45673 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfDIQEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 12:04:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so21573887wra.12;
        Tue, 09 Apr 2019 09:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vmDoNMyPgA26vzMM6EEMkS7HR+nK0YjPKKXUgV+vytc=;
        b=cw8bm++Bk2gftiLop1JSNQDA2bvmR5tAM5JEcYwZ61x6Dy0p/eQQ9c8ThIVi3YAJKw
         fyXt0vDJ1v2GU8ZmGW2eN0abzPUZYch+LWWEKzStbFvIoUyQEGFQRJcBnWIujSGhiSmK
         Fa8loPbIUMP/KyndBU9f5+ec3prjLzPv2BRKYaw4T8cGFGlZt3rRm8d7+rEAjyFTnTpQ
         lMa4lyl0V6ltSS1CyMEG+czkBRxt/gi83/ohs9MwI+z19QtPgFnOYT8lb6SGhMEhsQi9
         4SkD7K1bCILzaXykWNKHg+lQ+6+N57/DfZY/nfjLjt5A2zoHWUAerOPERsjOg5DLiCvk
         6LXg==
X-Gm-Message-State: APjAAAUYFw8yEW9+sQ9C2Ahk/4S4eUu6vyZ9N3+L86WG0Lk+Gve05kyE
        jk5xTWwLVP1hbs0YaJSpcc8=
X-Google-Smtp-Source: APXvYqyOTJo79KrWowZ+9yq5DBSPkpHrf7hiu6MFfSov9KU18ICZs9dJwcnIlDMkqBGymrE4C+ABKg==
X-Received: by 2002:a5d:54c4:: with SMTP id x4mr23032719wrv.296.1554825859147;
        Tue, 09 Apr 2019 09:04:19 -0700 (PDT)
Received: from localhost ([90.85.130.193])
        by smtp.gmail.com with ESMTPSA id z84sm28742453wmg.24.2019.04.09.09.04.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:04:18 -0700 (PDT)
From:   Christina Quast <cquast@hanoverdisplays.com>
To:     tony@atomide.com
Cc:     Christina Quast <cquast@hanoverdisplays.com>,
        Benoit Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] ARM: dts: am335x: Replace numeric pinmux address w. macro for more boards
Date:   Tue,  9 Apr 2019 18:03:31 +0200
Message-Id: <20190409160346.25599-1-cquast@hanoverdisplays.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depends on the following patch set:
[PATCH v2 0/6] ARM: dts: am335x: Replace numeric pinmux address with macro defines

Replace the numeric pinmux address with the macro defines for an additional 15 boards.

Christina Quast (15):
  ARM: dts: am335x: baltos-ir2110: Replaced register offsets with
    defines
  ARM: dts: am335x: baltos-ir3220: Replaced register offsets with
    defines
  ARM: dts: am335x: baltos-ir5221: Replaced register offsets with
    defines
  ARM: dts: am335x: baltos-leds: Replaced register offsets with defines
  ARM: dts: am335x: baltos: Replaced register offsets with defines
  ARM: dts: am335x: base0033: Replaced register offsets with defines
  ARM: dts: am335x: bonegreen-wireless: Replaced register offsets with
    defines
  ARM: dts: am335x: boneblue: Replaced register offsets with defines
  ARM: dts: am335x: bonegreen-common: Replaced register offsets with
    defines
  ARM: dts: am335x: chiliboard: Replaced register offsets with defines
  ARM: dts: am335x: chilisom: Replaced register offsets with defines
  ARM: dts: am335x: cm-t335: Replaced register offsets with defines
  ARM: dts: am335x: evm: Replaced register offsets with defines
  ARM: dts: am335x: evmsk: Replaced register offsets with defines
  ARM: dts: am335x: icev2: Replaced register offsets with defines

 arch/arm/boot/dts/am335x-baltos-ir2110.dts    |  16 +-
 arch/arm/boot/dts/am335x-baltos-ir3220.dts    |  36 +--
 arch/arm/boot/dts/am335x-baltos-ir5221.dts    |  40 +--
 arch/arm/boot/dts/am335x-baltos-leds.dtsi     |   6 +-
 arch/arm/boot/dts/am335x-baltos.dtsi          | 140 ++++-----
 arch/arm/boot/dts/am335x-base0033.dts         |  48 +--
 arch/arm/boot/dts/am335x-boneblue.dts         | 104 +++----
 .../arm/boot/dts/am335x-bonegreen-common.dtsi |   4 +-
 .../boot/dts/am335x-bonegreen-wireless.dts    |  28 +-
 arch/arm/boot/dts/am335x-chiliboard.dts       |  66 ++--
 arch/arm/boot/dts/am335x-chilisom.dtsi        |  32 +-
 arch/arm/boot/dts/am335x-cm-t335.dts          | 190 +++++-------
 arch/arm/boot/dts/am335x-evm.dts              | 234 +++++++-------
 arch/arm/boot/dts/am335x-evmsk.dts            | 292 +++++++++---------
 arch/arm/boot/dts/am335x-icev2.dts            | 116 +++----
 15 files changed, 658 insertions(+), 694 deletions(-)

-- 
2.20.1

