Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16014C282E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74BA2081C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 21:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558731695;
	bh=CFg7XvU9v0lnRjzs+tGDUprgJfAZafgtXU+wVAo1RXg=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=M8WBB/HdX1lGTsubKXzE6eZ5M6PlDSeifXPeXjIxO+za6HBbm7UsR7iugIJit4hJX
	 jRvuFJguSlatYf55XPaCD7vBi/rB98kVX0nX/Jlg7crEQZDg3p0DRY3go1OE8otCE7
	 MX6LUB+8Mbjsx7UUFEQjthftftYXDgILWkwT9Uqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404215AbfEXVBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 17:01:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391775AbfEXVBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 17:01:34 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1435D21848;
        Fri, 24 May 2019 21:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558731693;
        bh=CFg7XvU9v0lnRjzs+tGDUprgJfAZafgtXU+wVAo1RXg=;
        h=From:Date:Subject:To:Cc:From;
        b=01XDmDDflKM0ZAXnpGXenKFx11nBA7t1oh/qqaVBGt7diVR9MGNRs+TfvbQdKBFXy
         ywQcSb7ytediejVewpRI42hmMLvVYifw3rGMMwOBcD7kBf/cVU/nUwHlaDXEMOnwXJ
         4+TLEkFuqooCD9uaznNJ4V6k3SVh+E4cUUp7+hkc=
Received: by mail-qk1-f175.google.com with SMTP id w25so9469258qkj.11;
        Fri, 24 May 2019 14:01:33 -0700 (PDT)
X-Gm-Message-State: APjAAAW6LsYzVT0U/K6hbDdl3q/PryBddqa4p7wexZEVBXKyxdqaWnpx
        PZQhl0CcOnNMHp2i38vGnUQkikS+NAn3Lk8XRQ==
X-Google-Smtp-Source: APXvYqwEUhcqw9pXlIHiVbMcQAt3k3SQXCATeSGD3gWhAOsmGcLw4ozfuPqUWMMZs4CpKB1KJFfQeQAcYrdD5TVb8ZY=
X-Received: by 2002:a37:358:: with SMTP id 85mr78983951qkd.174.1558731692319;
 Fri, 24 May 2019 14:01:32 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 24 May 2019 16:01:21 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKUbPziR3dHi15K-uZUH_D-GtodV_LVqw+EhEGLeZZZHA@mail.gmail.com>
Message-ID: <CAL_JsqKUbPziR3dHi15K-uZUH_D-GtodV_LVqw+EhEGLeZZZHA@mail.gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.2-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull.

Rob


The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-5.2

for you to fetch changes up to 852d095d16a6298834839f441593f59d58a31978:

  checkpatch.pl: Update DT vendor prefix check (2019-05-22 14:54:49 -0500)

----------------------------------------------------------------
Devicetree fixes for 5.2:

- Update checkpatch.pl to use DT vendor-prefixes.yaml

- Fix DT binding references to files converted to DT schema

- Clean-up Arm CPU binding examples to match schema

- Add Sifive block versioning scheme documentation

- Pass binding directory base to validation tools for reference lookups

----------------------------------------------------------------
Kamal Dasu (1):
      dt: bindings: mtd: replace references to nand.txt with
nand-controller.yaml

Mauro Carvalho Chehab (1):
      dt: fix refs that were renamed to json with the same file name

Paul Walmsley (1):
      dt-bindings: sifive: describe sifive-blocks versioning

Rob Herring (3):
      dt-bindings: Pass binding directory to validation tools
      dt-bindings: interrupt-controller: arm,gic: Fix schema errors in example
      checkpatch.pl: Update DT vendor prefix check

Robin Murphy (1):
      dt-bindings: arm: Clean up CPU binding examples

 Documentation/devicetree/bindings/Makefile         |  2 +-
 Documentation/devicetree/bindings/arm/arm-boards   |  4 +--
 .../devicetree/bindings/arm/cpu-capacity.txt       | 12 +++----
 .../devicetree/bindings/arm/omap/crossbar.txt      |  2 +-
 .../bindings/clock/samsung,s5pv210-clock.txt       |  2 +-
 .../bindings/interrupt-controller/arm,gic.yaml     | 24 +++++++-------
 .../marvell,odmi-controller.txt                    |  2 +-
 .../devicetree/bindings/leds/irled/spi-ir-led.txt  |  2 +-
 .../devicetree/bindings/mtd/amlogic,meson-nand.txt |  2 +-
 .../devicetree/bindings/mtd/brcm,brcmnand.txt      |  6 ++--
 .../devicetree/bindings/mtd/denali-nand.txt        |  6 ++--
 .../devicetree/bindings/mtd/fsmc-nand.txt          |  6 ++--
 .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 +-
 .../devicetree/bindings/mtd/hisi504-nand.txt       |  2 +-
 .../devicetree/bindings/mtd/marvell-nand.txt       | 14 ++++----
 Documentation/devicetree/bindings/mtd/mxc-nand.txt |  6 ++--
 .../bindings/mtd/nvidia-tegra20-nand.txt           |  6 ++--
 .../devicetree/bindings/mtd/oxnas-nand.txt         |  2 +-
 .../devicetree/bindings/mtd/qcom_nandc.txt         |  4 +--
 .../devicetree/bindings/mtd/samsung-s3c2410.txt    |  6 ++--
 .../devicetree/bindings/mtd/stm32-fmc2-nand.txt    |  6 ++--
 .../devicetree/bindings/mtd/tango-nand.txt         |  2 +-
 .../devicetree/bindings/mtd/vf610-nfc.txt          |  8 ++---
 .../sifive/sifive-blocks-ip-versioning.txt         | 38 ++++++++++++++++++++++
 MAINTAINERS                                        |  4 +--
 scripts/Makefile.lib                               |  2 +-
 scripts/checkpatch.pl                              |  4 +--
 27 files changed, 108 insertions(+), 68 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/sifive/sifive-blocks-ip-versioning.txt
