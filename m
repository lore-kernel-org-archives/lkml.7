Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1042C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C7120840
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 23:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vTJpuy2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfEGXxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 19:53:39 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41508 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfEGXxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 19:53:39 -0400
Received: by mail-qk1-f194.google.com with SMTP id g190so2294938qkf.8;
        Tue, 07 May 2019 16:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=L9nRO3OgbdwWHjpA53OGHSskgjyPngc9dG49IKBY4s8=;
        b=vTJpuy2L0mthe8AZrxCFw86oXl90wDb1O4uiusl0sgPs7i/9hNuUO0e17PCQdq7yXI
         /6uTb9AZwryczTXsngtDpjFE1xfoPT9gcnXRIlX2HB1cLWEyoeTyDTjfsxF78/9i7YhF
         x/caNvI3SI0B0FFf9ockbracdxqZOsVBhfIfw0VMcZTtUsPLoI7It1db3NCBM3bePMbu
         2/gjrHBMoxTUC9plnHnfr0tRqS43Dd70GuOhDQ5VSmF8UxWx8nqKTqio4hms9j0e/FTQ
         BwmTZDy9c744KyY17Kcv1XmwoJTRFUNsgi28oLk9VIcvcnYPsMiv6F62a4k47vrk+DWQ
         i4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=L9nRO3OgbdwWHjpA53OGHSskgjyPngc9dG49IKBY4s8=;
        b=iv9rcYeBPHsiPjnix6/8peegV7970tpvwpyo+bdRmbiSzl8+m9ATux/68dhoJxQW3V
         1RCZrZrR3ZNL3slRhVwfV8oULakaSEpukhvlqqnGvO2/lbh1k1H8U9Dt3FbKqm3aG7ZA
         3k7+sfD8xeDLIE2lKLT4ol4tvkicHyTUbsfI64Uiob2kKEJSm5k03mkyVnbA1zf5rO6y
         bs+OqiplyJmlBRNJrc0Mmmv+J9aaGiDnSBkETNazHNFgd87u7D2t32HReqHsyOZc5g88
         qt7AuhgkDG8JPse/1ciVA/UaimjRG29DpFI+kg8iVFE9dlM/27+xOVEgXDLMcpw3vT/x
         F2aw==
X-Gm-Message-State: APjAAAX616nNrUCzJE6LXV56V1Uce0Iph/fY5RIa2G1wcu1RN6bnoe6v
        zBBTptgBvhzI7siRnHAmZA2o0ByQBH+/6MgPZA==
X-Google-Smtp-Source: APXvYqwUXfRBlgrdgLcam1zsZokuXJb39dZQPVnWZCQ0UVRVsiQChPicGxt3MPa4j8J3lX+/FZDRQYVtvmcfihr7mPs=
X-Received: by 2002:a37:4a12:: with SMTP id x18mr26452247qka.184.1557273217300;
 Tue, 07 May 2019 16:53:37 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Tue, 7 May 2019 18:53:25 -0500
Message-ID: <CAL_JsqJ8YqaiNwj715B=5r39RzuXLn1inhAQ044j8d-L0vYLZA@mail.gmail.com>
Subject: [GIT PULL] Devicetree for 5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for 5.2.

Rob

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00=
:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-for-5.2

for you to fetch changes up to 2a656cb5a4a3473c5fc6bf4fddc3560ceed53220:

  of: unittest: Remove error printing on OOM (2019-05-02 16:38:59 -0500)

----------------------------------------------------------------
Devicetree for 5.2:

- Fix possible memory leak in reserved-memory failure case

- Support for DMA parent bus which are not a parent node

- Clang -Wunsequenced fix

- Remove some unnecessary prints on memory alloc failures

- Various printk msg and comment fixes

- Update DT schema tools repository location

- Convert simple-framebuffer binding to DT schema

- Bindings for isl68137 and ir38064 trivial devices

- New documentation on binding do's and don't's for binding writers to
  ignore

----------------------------------------------------------------
Chris Packham (1):
      of: use correct function prototype for of_overlay_fdt_apply()

Christian Lamparter (1):
      dt-bindings: pinctrl: fix bias-pull,up typo

Cl=C3=A9ment P=C3=A9ron (1):
      dt-bindings: mfd: axp20x: Add fallback for axp805

Florian Fainelli (1):
      of: Improve of_phandle_iterator_next() error message

Geert Uytterhoeven (2):
      of: irq: Remove WARN_ON() for kzalloc() failure
      of: unittest: Remove error printing on OOM

Jojo Zeng (1):
      of/device.c: fix the wrong comments

Maxime Ripard (6):
      of: property: Document that of_graph_get_endpoint_by_regs needs
of_node_put
      dt-bindings: interconnect: Add a dma interconnect name
      dt-bindings: bus: Add binding for the Allwinner MBUS controller
      of: address: Retrieve a parent through a callback in
__of_translate_address
      of: address: Add support for the parent DMA bus
      dt-bindings: Add schemas for simple-framebuffer

Miquel Raynal (1):
      dt-bindings: connector: Spelling mistake

Patrick Venture (2):
      dt-bindings: Add ir38064 as a trivial device
      dt-bindings: Add isl68137 as a trivial device

Phong Tran (1):
      of: fix clang -Wunsequenced for be32_to_cpu()

Rob Herring (3):
      dt-bindings: Add a guide of do's and don't's for writing bindings
      dt-bindings: Require child nodes type to be 'object'
      dt-bindings: Update schema project location to devicetree.org github =
group

pierre Kuo (1):
      of: reserved_mem: fix reserve memory leak

xiaojiangfeng (1):
      of: del redundant type conversion

 Documentation/devicetree/bindings/arm/cpus.yaml    |   1 +
 .../devicetree/bindings/arm/sunxi/sunxi-mbus.txt   |  36 +++++
 .../bindings/connector/usb-connector.txt           |   2 +-
 .../display/amlogic,simple-framebuffer.txt         |  33 -----
 .../bindings/display/simple-framebuffer-sunxi.txt  |  36 -----
 .../bindings/display/simple-framebuffer.txt        |  91 ------------
 .../bindings/display/simple-framebuffer.yaml       | 160 +++++++++++++++++=
++++
 .../bindings/interconnect/interconnect.txt         |   4 +
 .../bindings/interrupt-controller/arm,gic.yaml     |   1 +
 Documentation/devicetree/bindings/mfd/axp20x.txt   |   1 +
 .../bindings/pinctrl/qcom,apq8064-pinctrl.txt      |   2 +-
 .../bindings/pinctrl/qcom,ipq4019-pinctrl.txt      |   2 +-
 .../bindings/pinctrl/qcom,ipq8064-pinctrl.txt      |   2 +-
 .../bindings/pinctrl/qcom,msm8660-pinctrl.txt      |   2 +-
 .../bindings/pinctrl/qcom,msm8974-pinctrl.txt      |   2 +-
 .../bindings/timer/arm,arch_timer_mmio.yaml        |   1 +
 .../devicetree/bindings/trivial-devices.yaml       |   4 +
 .../devicetree/bindings/writing-bindings.txt       |  60 ++++++++
 Documentation/devicetree/writing-schema.md         |   2 +-
 drivers/of/address.c                               |  40 +++++-
 drivers/of/base.c                                  |   5 +-
 drivers/of/device.c                                |   2 +-
 drivers/of/fdt.c                                   |   2 +-
 drivers/of/irq.c                                   |   2 +-
 drivers/of/of_reserved_mem.c                       |  22 ++-
 drivers/of/property.c                              |   2 +-
 drivers/of/unittest.c                              |  13 +-
 include/linux/of.h                                 |   7 +-
 28 files changed, 341 insertions(+), 196 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sunxi/sunxi-mbus.=
txt
 delete mode 100644
Documentation/devicetree/bindings/display/amlogic,simple-framebuffer.txt
 delete mode 100644
Documentation/devicetree/bindings/display/simple-framebuffer-sunxi.txt
 delete mode 100644
Documentation/devicetree/bindings/display/simple-framebuffer.txt
 create mode 100644
Documentation/devicetree/bindings/display/simple-framebuffer.yaml
 create mode 100644 Documentation/devicetree/bindings/writing-bindings.txt
