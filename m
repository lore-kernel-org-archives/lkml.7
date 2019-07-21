Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FDAC76186
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 02:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A0762183E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 02:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563676690;
	bh=oIEiqY1xwvEFE/GCq2zt35elf3GBQPS3hEr1gwpLbLA=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=kugr8rLbdksNzPbc24rOBSXgeZP4xNODbrVmJW1NvPBRDj2mNFAQsuM4u7/Dk/iE8
	 QtMT4rFEt+88j5e6RT7STkkX1d6mmP2OzMnVebAIBdKnigIwOg4JcZnjpmq6ElSeml
	 dIrDUbcEO9B/So1vbu//yiul+Zi9eGUa4Mnl2Gfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfGUCiJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 22:38:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725996AbfGUCiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 22:38:09 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBA512085A;
        Sun, 21 Jul 2019 02:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563676688;
        bh=oIEiqY1xwvEFE/GCq2zt35elf3GBQPS3hEr1gwpLbLA=;
        h=From:Date:Subject:To:Cc:From;
        b=Kc6LYfK9zSz5Fc0+PttYpDZv/1G8us56pEul1FAqfpn8hcuFdZiVzMN3cpr2r8W+a
         SGAeDbTXj9n3nvBP6cRRfoWhnXLlMITdH107C8IuRFnYqStEjICdWIBblpc2eT2sc4
         x1UUPAP57kfKWtIQW+yt5bZ9vEp7jSqK8j+C+m5s=
Received: by mail-qk1-f177.google.com with SMTP id 201so26147446qkm.9;
        Sat, 20 Jul 2019 19:38:07 -0700 (PDT)
X-Gm-Message-State: APjAAAV/gMTX8uNd5QR6MSjcpgsF9qdt3fzXZE8iVVwc836A33XsaOQZ
        8G9A1km8Ws6mjiSmpQk/AKLdKvzacn6cHpp85A==
X-Google-Smtp-Source: APXvYqx1VkUKcWy/Z+hqTvwe0cgTg5Nvm/xp8bvl68kWSmNACZytAwEORwED1dqoSisKwShKtM1fstHsnPjS/qlB/k4=
X-Received: by 2002:a37:a48e:: with SMTP id n136mr42600319qke.223.1563676687175;
 Sat, 20 Jul 2019 19:38:07 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 20 Jul 2019 20:37:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLTAAT1hEPkxD=BUvmovvA+rdsZdbVfQM6=1m9bvaEysQ@mail.gmail.com>
Message-ID: <CAL_JsqLTAAT1hEPkxD=BUvmovvA+rdsZdbVfQM6=1m9bvaEysQ@mail.gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.3-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT binding fixes for 5.3-rc.

Rob

The following changes since commit abdfd52a295fb5731ab07b5c9013e2e39f4d1cbe:

  Merge tag 'armsoc-defconfig' of
git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2019-07-19
17:27:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-5.3

for you to fetch changes up to e2297f7c3ab3b68dda2ac732b1767212019d3bdf:

  dt-bindings: pinctrl: stm32: Fix missing 'clocks' property in
examples (2019-07-20 20:28:53 -0600)

----------------------------------------------------------------
Devicetree fixes for 5.3:

Fix several warnings/errors in validation of binding schemas.

----------------------------------------------------------------
Rob Herring (7):
      dt-bindings: Ensure child nodes are of type 'object'
      dt-bindings: riscv: Limit cpus schema to only check RiscV 'cpu' nodes
      dt-bindings: pinctrl: aspeed: Fix 'compatible' schema errors
      dt-bindings: pinctrl: aspeed: Fix AST2500 example errors
      dt-bindings: iio: avia-hx711: Fix avdd-supply typo in example
      dt-bindings: iio: ad7124: Fix dtc warnings in example
      dt-bindings: pinctrl: stm32: Fix missing 'clocks' property in examples

 .../bindings/bus/allwinner,sun8i-a23-rsb.yaml      |   1 +
 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |  71 +++++-----
 .../devicetree/bindings/iio/adc/avia-hx711.yaml    |   2 +-
 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |   1 +
 .../devicetree/bindings/mtd/nand-controller.yaml   |   1 +
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |   4 +-
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |   9 +-
 .../bindings/pinctrl/st,stm32-pinctrl.yaml         |   7 +
 Documentation/devicetree/bindings/riscv/cpus.yaml  | 143 +++++++++------------
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   1 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   1 +
 11 files changed, 119 insertions(+), 122 deletions(-)
