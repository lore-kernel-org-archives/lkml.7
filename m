Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B428C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F8621872
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Pc4yYNrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfCOLMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:12:32 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52763 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCOLMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:12:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20190315111230euoutp026240c68c87de3d174a7a5bde85ed9692~MHXLBrtJb2715127151euoutp02a
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 11:12:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20190315111230euoutp026240c68c87de3d174a7a5bde85ed9692~MHXLBrtJb2715127151euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1552648350;
        bh=WVcmpIUQygj/dY8xEZ8fP4ABs2KlXNaICx40zhLw0QA=;
        h=To:Cc:From:Subject:Date:References:From;
        b=Pc4yYNrzSJCF2OOQy3NCIPqpUcqklUTez57ICT6z2f//40iQgL0T8k4oN51o7zs55
         Sg3hry9ZVv/Ij1VNGcI9jtaC45DMgIvABydM2QG0GXlxa2YKvv+JM5fSmseopZG1P1
         27oPGNCHDajZcYyqqz8ySztT1LnlcS16VIS+4kWc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190315111229eucas1p284757a4e47606a0ce532e74de899af7c~MHXKoes5Z1096210962eucas1p25;
        Fri, 15 Mar 2019 11:12:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A2.D2.04441.D988B8C5; Fri, 15
        Mar 2019 11:12:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190315111228eucas1p24628f949b96a13bc3434d36425fa0be0~MHXJoaQ2x1096210962eucas1p24;
        Fri, 15 Mar 2019 11:12:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190315111228eusmtrp129b3bbc25a904d000087e1c56bb1742f~MHXJVFh9y0421704217eusmtrp1e;
        Fri, 15 Mar 2019 11:12:28 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-df-5c8b889dabe3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E7.E5.04284.C988B8C5; Fri, 15
        Mar 2019 11:12:28 +0000 (GMT)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190315111228eusmtip1c8bb503ba7e34160475a9ae9fff566df~MHXJCsiTP0202102021eusmtip1d;
        Fri, 15 Mar 2019 11:12:28 +0000 (GMT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [GIT PULL] fbdev changes for v5.1
Message-ID: <4114bd4f-9c58-a295-c767-47720dcf2c37@samsung.com>
Date:   Fri, 15 Mar 2019 12:12:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduznOd25Hd0xBi/vyVlc+fqezeJE3wdW
        i8u75rBZPOp7y+7A4nFixm8Wj/vdx5k8Pm+SC2CO4rJJSc3JLEst0rdL4MrYeH0RY8ELxYqb
        r06wNjD+kOhi5OSQEDCR+DPnIVMXIxeHkMAKRom+OzOgnC+MEpubFzBCOJ8ZJbZfWsbexcgB
        1vK0ywcivpxRouXKaxYI5z2jxNGl/9lA5ooIGEl8fnGFFcRmFkiQ+HLzMzOIzSZgJTGxfRUj
        yCBhAS2Jq80VIGFeATuJt8e/MoHYLAKqEs2bnoCViApESPSfUYcoEZQ4OfMJC8REeYnmrbOZ
        QdZKCDxnkzhwcz0jxDsuEi3zdrND2MISr45vgbJlJE5P7mGBaFjHKNE6s58FIrGdUeLkBycI
        21ri8PGLrCCLmQU0Jdbv0ocIO0qcvruDGeJ3PokbbwUhbuCTmLRtOlSYV6KjTQiiWk1iw7IN
        bDBbu3auhCrxkOh6qwoSFhKIlXj+YT/7BEaFWUgem4XksVkIJyxgZF7FKJ5aWpybnlpsmJda
        rlecmFtcmpeul5yfu4kRmDJO/zv+aQfj10tJhxgFOBiVeHg3RHbFCLEmlhVX5h5ilOBgVhLh
        fazfHSPEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qBkZ9T
        Xe+f43R9nt/fVtQLVTgu//tD4oPe6ovbRW788s6U9l2f0LByruqhAwZrfjxZ8r+Jx1xbskbu
        anBhUvWixA7Tu3M6FQq4pnHFLzWIPv5tde6H9vZnpSxMxb8looz4b10xyA/exXJoj+ZBrRXz
        T3/REb606Mk1xgIBOcew8+J+J05P2qpzS4mlOCPRUIu5qDgRAPBppNoVAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsVy+t/xu7pzOrpjDH6dELe48vU9m8WJvg+s
        Fpd3zWGzeNT3lt2BxePEjN8sHve7jzN5fN4kF8AcpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFn
        ZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJex8foixoIXihU3X51gbWD8IdHFyMEhIWAi8bTL
        p4uRi0NIYCmjRMfzg2wQcRmJ4+vLuhg5gUxhiT/XuthAbCGBt4wSM8+7g9giAkYSn19cYQWx
        mQUSJDbdnwpWwyZgJTGxfRUjyBhhAS2Jq80VIGFeATuJt8e/MoHYLAKqEs2bnjCC2KICERK3
        HnawQNQISpyc+YQFYqS6xJ95l5ghbHmJ5q2zmScw8s9CUjYLSdksJGULGJlXMYqklhbnpucW
        G+oVJ+YWl+al6yXn525iBIb2tmM/N+9gvLQx+BCjAAejEg/viqCuGCHWxLLiytxDjBIczEoi
        vI/1u2OEeFMSK6tSi/Lji0pzUosPMZoCHT6RWUo0OR8Yd3kl8YamhuYWlobmxubGZhZK4rzn
        DSqjhATSE0tSs1NTC1KLYPqYODilGhgzzMS4DYsSVr0N26UzJ8fuznW1v02PZSd/szt7kG3L
        Xgnfm853xVc+lYpVUOZZpmf9uO21y5XwFt5zScLzGac4fXZ1dF9TpB+6akff4yP/K9+82rS9
        a/rU503XZr+KOH518kzVxEbPvG7pD0c/fSidxpuelyd8I2bS3VO5209M789e7DEza5+rEktx
        RqKhFnNRcSIA+LhmzIMCAAA=
X-CMS-MailID: 20190315111228eucas1p24628f949b96a13bc3434d36425fa0be0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190315111228eucas1p24628f949b96a13bc3434d36425fa0be0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190315111228eucas1p24628f949b96a13bc3434d36425fa0be0
References: <CGME20190315111228eucas1p24628f949b96a13bc3434d36425fa0be0@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v5.1. Just a couple of small fixes and
cleanups (please see the signed tag description for details).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.1

for you to fetch changes up to 9a9f1d1a81a972513636c333e26c542f8aebae55:

  fbdev: mbx: fix a misspelled variable name (2019-03-05 12:36:33 +0100)

----------------------------------------------------------------
fbdev changes for v5.1:

- fix memory access if logo is bigger than the screen (Manfred
  Schlaegl)

- silence fbcon logo on 'quiet' boots (Prarit Bhargava)

- use kvmalloc() for scrollback buffer in fbcon (Konstantin Khorenko)

- misc fixes (Colin Ian King, YueHaibing, Matteo Croce, Mathieu
  Malaterre, Anders Roxell, Arnd Bergmann)

- misc cleanups (Rob Herring, Lubomir Rintel, Greg Kroah-Hartman,
  Jani Nikula, Michal Vokáč)

----------------------------------------------------------------
Anders Roxell (1):
      fbdev: omap2: fix warnings in dss core

Arnd Bergmann (1):
      fbdev: mbx: fix a misspelled variable name

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v5.0-rc5' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next

Colin Ian King (1):
      fbdev/via: fix spelling mistake "Expandsion" -> "Expansion"

Greg Kroah-Hartman (2):
      fbdev: omap2: no need to check return value of debugfs_create functions
      fbdev: mbx: fix up debugfs file creation

Jani Nikula (1):
      video/fbdev: refactor video= cmdline parsing

Konstantin Khorenko (1):
      fbcon: use kvmalloc() for scrollback buffer

Lubomir Rintel (1):
      video: fbdev: geode: remove ifdef OLPC noise

Manfred Schlaegl (1):
      fbdev: fbmem: fix memory access if logo is bigger than the screen

Mathieu Malaterre (1):
      video: offb: annotate implicit fall throughs

Matteo Croce (1):
      omapfb: fix typo

Michal Vokáč (3):
      dt-bindings: display: ssd1307fb: Remove reset-active-low from examples
      video: ssd1307fb: Do not hard code active-low reset sequence
      ARM: dts: imx28-cfa10036: Fix the reset gpio signal polarity

Prarit Bhargava (2):
      printk: Export console_printk
      fbcon: Silence fbcon logo on 'quiet' boots

Rob Herring (1):
      fbdev: Use of_node_name_eq for node name comparisons

YueHaibing (2):
      fbdev: chipsfb: remove set but not used variable 'size'
      video: fbdev: Fix potential NULL pointer dereference

 .../devicetree/bindings/display/ssd1307fb.txt      |  2 --
 arch/arm/boot/dts/imx28-cfa10036.dts               |  3 +-
 drivers/video/fbdev/aty/radeon_pm.c                |  6 ++--
 drivers/video/fbdev/cg14.c                         |  4 +--
 drivers/video/fbdev/cg3.c                          |  2 +-
 drivers/video/fbdev/chipsfb.c                      |  3 +-
 drivers/video/fbdev/core/fb_cmdline.c              | 23 ++++++-------
 drivers/video/fbdev/core/fbcon.c                   | 14 +++++---
 drivers/video/fbdev/core/fbmem.c                   |  3 ++
 drivers/video/fbdev/core/fbmon.c                   |  2 ++
 drivers/video/fbdev/ffb.c                          |  2 +-
 drivers/video/fbdev/geode/gxfb_core.c              | 13 ++-----
 drivers/video/fbdev/geode/lxfb_core.c              | 13 ++-----
 drivers/video/fbdev/imsttfb.c                      |  4 +--
 drivers/video/fbdev/mbx/mbxdebugfs.c               | 40 +++++++---------------
 drivers/video/fbdev/mbx/mbxfb.c                    |  2 +-
 drivers/video/fbdev/offb.c                         |  4 ++-
 drivers/video/fbdev/omap2/omapfb/dss/core.c        | 34 ++++--------------
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c      |  4 +--
 drivers/video/fbdev/omap2/omapfb/dss/dss.h         |  2 +-
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c  |  2 +-
 drivers/video/fbdev/ssd1307fb.c                    |  4 +--
 drivers/video/fbdev/via/viafbdev.c                 |  2 +-
 kernel/printk/printk.c                             |  1 +
 24 files changed, 72 insertions(+), 117 deletions(-)
