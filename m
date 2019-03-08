Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A837C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A0F20857
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552077481;
	bh=2t2aIwGuT40TLh6+9S/gE/ID3dubUpl8ANeVVLEO22g=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=JiEEaSvD/+LY+4+190/TozyzokoA6+7e7vnKY/AnCHdgRXEbXK8WlO4M+gXEb/vmi
	 de8tel/6j71q4PyfC25WuG86M06IXAlYmhL+i42QQXklxclf4ReEcrUTQDhxTuKOWj
	 Mi8s6oNxunBxglr8iX0mStCWA2RjApN6/vo1TpfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfCHUiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbfCHUiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:38:00 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FBF92085A;
        Fri,  8 Mar 2019 20:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552077478;
        bh=2t2aIwGuT40TLh6+9S/gE/ID3dubUpl8ANeVVLEO22g=;
        h=From:Date:Subject:To:Cc:From;
        b=o6m55VR/Fj1I4FuGUU4EZjprYBZNId5KppfVKbCmtIcbFYRl4kGpY1vgZ8S6dQGFM
         neKZ4G2Ghyx7ijadNxES1beUPZLd3uibNGTlLc4AHFbrF3naRYaxv2jTTc2MIIgUlT
         XNHsuhQfP8cAtlTKDxNxKQLwWTleni4V2EDc0LxE=
Received: by mail-qt1-f178.google.com with SMTP id z39so22749400qtz.0;
        Fri, 08 Mar 2019 12:37:58 -0800 (PST)
X-Gm-Message-State: APjAAAVJTKtD8cDdPKZy8jJEoIPipyyAZNxZ0q+h9hwDzpAB/Agx3fJi
        ud87mCqHmzwBAv9udjMtv+hTv/GhCewLOLQGCQ==
X-Google-Smtp-Source: APXvYqzLWiwMxjtd3RxVxrIuogrnslTC3CxOdGBdIP6QRDtd6lcfNxeoj+8x3ML25oZpWI67NQsPGqSFPjz9ASxTjT0=
X-Received: by 2002:ac8:2a39:: with SMTP id k54mr16476268qtk.26.1552077477831;
 Fri, 08 Mar 2019 12:37:57 -0800 (PST)
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 8 Mar 2019 14:37:47 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkW7OYJEaONK3Uh9Ly0iXaaOMpwKPgP8EpdBCc9i3UJA@mail.gmail.com>
Message-ID: <CAL_JsqLkW7OYJEaONK3Uh9Ly0iXaaOMpwKPgP8EpdBCc9i3UJA@mail.gmail.com>
Subject: [GIT PULL] Devicetree for 5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for 5.1.

Rob

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-for-5.1

for you to fetch changes up to 935665c1a117f34662549f01e1c9bc5ea7132556:

  of: unittest: unflatten device tree on UML when testing (2019-02-28
11:50:10 -0600)

----------------------------------------------------------------
Devicetree updates for v5.1:

- Fix a unittest failure on UML. Preparation for converting to
  kunit test framework.

- Add annotations to dtx_diff output

- Fix unittest reporting of expected error

- Move DMA configuration for virtual devices into the driver that
  needs it (s5p-mfc)

- Vendor prefixes for feiyang and techstar

- Convert ARM GIC, GICv3, and L2x0 to DT schema

- Add r8a7778/9 HSCIF serial bindings

----------------------------------------------------------------
Akinobu Mita (1):
      dt-bindings: display: add missing semicolon in example

Brendan Higgins (1):
      of: unittest: unflatten device tree on UML when testing

Christoph Hellwig (1):
      of: mark early_init_dt_alloc_reserved_memory_arch static

Frank Rowand (3):
      of: unittest: remove report of expected error
      of: unittest: add caution to function header comment
      of: add dtc annotations functionality to dtx_diff

Jagan Teki (2):
      dt-bindings: Add vendor prefix for techstar
      dt-bindings: Add vendor prefix for feiyang

Rob Herring (3):
      dt-bindings: arm: l2x0: Convert L2 cache to json-schema
      dt-bindings: interrupt-controller: Convert ARM GIC to json-schema
      dt-bindings: interrupt-controller: Convert ARM GICv3 to json-schema

Robin Murphy (1):
      media: s5p-mfc: Fix memdev DMA configuration

Ulrich Hecht (1):
      dt-bindings: serial: sh-sci: Document r8a7778/9 HSCIF bindings

 Documentation/devicetree/bindings/arm/l2c2x0.txt   | 114 ---------
 Documentation/devicetree/bindings/arm/l2c2x0.yaml  | 248 ++++++++++++++++++
 .../bindings/display/sitronix,st7735r.txt          |   2 +-
 .../bindings/interrupt-controller/arm,gic-v3.txt   | 175 -------------
 .../bindings/interrupt-controller/arm,gic-v3.yaml  | 279 +++++++++++++++++++++
 .../bindings/interrupt-controller/arm,gic.txt      | 171 -------------
 .../bindings/interrupt-controller/arm,gic.yaml     | 223 ++++++++++++++++
 .../bindings/serial/renesas,sci-serial.txt         |   2 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 drivers/media/platform/s5p-mfc/s5p_mfc.c           |   7 +
 drivers/of/of_reserved_mem.c                       |   6 +-
 drivers/of/unittest.c                              |  15 +-
 include/linux/of_reserved_mem.h                    |   7 -
 scripts/dtc/dtx_diff                               |  13 +-
 14 files changed, 788 insertions(+), 476 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/l2c2x0.txt
 create mode 100644 Documentation/devicetree/bindings/arm/l2c2x0.yaml
 delete mode 100644
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
 create mode 100644
Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.yaml
 delete mode 100644
Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
 create mode 100644
Documentation/devicetree/bindings/interrupt-controller/arm,gic.yaml
