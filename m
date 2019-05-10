Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F40C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E945C216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 16:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O+jQdwjF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbfEJQub (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 12:50:31 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52261 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfEJQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 12:50:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190510165027euoutp0197bfbd610260f5460199889ea23ab0fd~dYGPDyYFU0960509605euoutp01x
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 16:50:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190510165027euoutp0197bfbd610260f5460199889ea23ab0fd~dYGPDyYFU0960509605euoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1557507027;
        bh=M00kmSw/Gjb/9JS1d1yaQ80m8qXk7E3VMw05ekoJvW4=;
        h=From:Subject:To:Cc:Date:References:From;
        b=O+jQdwjFy3Whb8nP1PIi7rm4zEZwHGQfyRJdAOgDgLpV5kA007lW0mJnWYGhuM4V0
         CFiAu9nDL5GtLD9MSnWQ8rkyHRzzg9eJGXOORW2A4d4fa1TsWpKirTGX/YRpBgvmDS
         HeC3v6xUldAmSXEMhCAMEwkr7Rfb7fP3s++l8xv4=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190510165026eucas1p1c49236aa4a00c36ffe1bebe20447871a~dYGNzBdz_2727827278eucas1p1h;
        Fri, 10 May 2019 16:50:26 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 80.CB.04325.2DBA5DC5; Fri, 10
        May 2019 17:50:26 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190510165025eucas1p1158b6d87dde378cd9986a6e89125acf1~dYGMqV-yB0097300973eucas1p1h;
        Fri, 10 May 2019 16:50:25 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190510165024eusmtrp1ffd293aeac6b968393a5898372d84375~dYGMcXqIp1963819638eusmtrp1P;
        Fri, 10 May 2019 16:50:24 +0000 (GMT)
X-AuditID: cbfec7f5-b75ff700000010e5-a3-5cd5abd2b2b6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 98.5C.04146.0DBA5DC5; Fri, 10
        May 2019 17:50:24 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190510165024eusmtip2e038734b439881a516b20048c96f31a1~dYGL4MMVW2496324963eusmtip2c;
        Fri, 10 May 2019 16:50:24 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [GIT PULL] fbdev changes for v5.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-ID: <32ceb3b0-0bce-a585-8843-36e851b2a1aa@samsung.com>
Date:   Fri, 10 May 2019 18:50:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduznOd1Lq6/GGOx5x2xx5et7NosTfR9Y
        LS7vmsNm8ajvLbsDi8eJGb9ZPO53H2fy+LxJLoA5issmJTUnsyy1SN8ugSvj9+d1jAVvbSt6
        dl9ga2C8rNvFyMkhIWAicWnrbPYuRi4OIYEVjBIn9yxhhXC+MEo8f3cFKvOZUWLDj4/MMC1v
        O/4xQySWM0q87D8A1fKWUeLguWtgVWwCVhIT21cxgtjCAloS076tZgGxRQSMJD6/uMIKYjML
        JEh8ufkZrJ5XwE7i15F7YPUsAqoSv7d3MXUxcnCICkRI9J9RhygRlDg58wkLRKu8xPa3c8CO
        kBB4ziYx69BBVojrXCS27F0AZQtLvDq+hR3ClpE4PbmHBaJhHaPE344XUN3bGSWWT/7HBlFl
        LXH4+EVWkM3MApoS63fpQ4QdJea/nsAIEpYQ4JO48VYQ4gg+iUnbpjNDhHklOtqEIKrVJDYs
        28AGs7Zr50powHlI3Nu/jgnEFhKIlTjwayf7BEaFWUhem4XktVkINyxgZF7FKJ5aWpybnlps
        nJdarlecmFtcmpeul5yfu4kRmDpO/zv+dQfjvj9JhxgFOBiVeHgFkq/GCLEmlhVX5h5ilOBg
        VhLhLdK5EiPEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQQHpiSWp2ampBahFMlomDU6qB
        MWcT6zTJBzmec9r8m1S97Q3lZ6p9FAruLr988k/MWqcGi+d/hWe81fOsOuB2YXVSna213mq/
        7YuiQzocTL1nmLHYRctyxN0tf+YUUzZRdHKrM2O31JQFx+PqrPSZQmpL90+Z6r/pj40gQ0PN
        sWarycEPet7sUZp1/p1r6K+ZnGkLtaoUFAqVWIozEg21mIuKEwHBsOYkGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsVy+t/xe7oXVl+NMTiyztTiytf3bBYn+j6w
        WlzeNYfN4lHfW3YHFo8TM36zeNzvPs7k8XmTXABzlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWe
        kYmlnqGxeayVkamSvp1NSmpOZllqkb5dgl7G78/rGAve2lb07L7A1sB4WbeLkZNDQsBE4m3H
        P+YuRi4OIYGljBLPetewdzFyACVkJI6vL4OoEZb4c62LDaLmNaPEllcvmUASbAJWEhPbVzGC
        2MICWhLTvq1mAbFFBIwkPr+4wgpiMwskSGy6P5UNxOYVsJP4deQeWD2LgKrE7+1dYHNEBSIk
        bj3sYIGoEZQ4OfMJC0SvusSfeZeYIWx5ie1v5zBPYOSfhaRsFpKyWUjKFjAyr2IUSS0tzk3P
        LTbUK07MLS7NS9dLzs/dxAgM8G3Hfm7ewXhpY/AhRgEORiUeXoHkqzFCrIllxZW5hxglOJiV
        RHiLdK7ECPGmJFZWpRblxxeV5qQWH2I0BTp8IrOUaHI+MPrySuINTQ3NLSwNzY3Njc0slMR5
        OwQOxggJpCeWpGanphakFsH0MXFwSjUwKqZbTT68eHv3unlMl66+nh6vuS1S/vEJ23MBS94a
        +LG+X2E//9ipy5d152j4ZXO+jN8bmfIkYqXCoU8RJ8Sanjk8utXIyrfjUrSsxIabe0u/TTm/
        Ldo8LDaxY31mdfW75rl7g36HyEi1i0znYE9pCnTd9tdsW/nttX8vpql9+1Pyx0pA/n6sjxJL
        cUaioRZzUXEiAEK4jKqGAgAA
X-CMS-MailID: 20190510165025eucas1p1158b6d87dde378cd9986a6e89125acf1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190510165025eucas1p1158b6d87dde378cd9986a6e89125acf1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190510165025eucas1p1158b6d87dde378cd9986a6e89125acf1
References: <CGME20190510165025eucas1p1158b6d87dde378cd9986a6e89125acf1@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please pull fbdev changes for v5.2. They are:
- 4 small fixes for fb core
- updates for udlfb, sm712fb, macfb and atafb drivers
- redundant code removals from amba-clcd and atmel_lcdfb drivers
- minor fixes/cleanups for other fb drivers

Please see the signed tag description for details.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the git repository at:

  https://github.com/bzolnier/linux.git tags/fbdev-v5.2

for you to fetch changes up to d4a5611743a6f5d126f8cbfdbf29e12fd8d1b73f:

  video: fbdev: Use dev_get_drvdata() (2019-05-06 15:57:47 +0200)

----------------------------------------------------------------
fbdev changes for v5.2:

- fix regression in fbcon logo handling on 'quiet' boots (Andreas Schwab)

- fix divide-by-zero error in fb_var_to_videomode() (Shile Zhang)

- fix 'WARNING in __alloc_pages_nodemask' bug (Jiufei Xue)

- list all PCI memory BARs as conflicting apertures (Gerd Hoffmann)

- update udlfb driver - fix sleeping inside spinlock, add mutex around
  rendering calls and remove redundant code (Mikulas Patocka)

- update sm712fb driver - fix SM720 support related issues (Yifeng Li)

- update macfb driver - fix DAFB colour table pointer initialization and
  remove redundant code (Finn Thain)

- update atafb driver - fix kexec support, use dev_*() calls instead of
  printk() and remove obsolete module support (Geert Uytterhoeven)

- add support to mxsfb driver for skipping display initialization for
  flicker-free display takeover from bootloader (Melchior Franz)

- remove Versatile and Nomadik board families support from amba-clcd
  driver as they are handled by DRM driver nowadays (Linus Walleij)

- remove no longer needed AVR and platform_data support from atmel_lcdfb
  driver (Alexandre Belloni)

- misc fixes (Colin Ian King, Julia Lawall, Gustavo A. R. Silva, Aditya
  Pakki, Kangjie Lu, YueHaibing)

- misc cleanups (Enrico Weigelt, Kefeng Wang)

----------------------------------------------------------------
Aditya Pakki (1):
      omapfb: Fix potential NULL pointer dereference in kmalloc

Alexandre Belloni (1):
      video: fbdev: atmel_lcdfb: drop AVR and platform_data support

Andreas Schwab (1):
      fbcon: Don't reset logo_shown when logo is currently shown

Bartlomiej Zolnierkiewicz (1):
      Merge tag 'v5.1-rc3' of https://git.kernel.org/.../torvalds/linux into fbdev-for-next

Colin Ian King (2):
      video: fbdev: vesafb: fix indentation issue
      video: fbdev: savage: fix indentation issue

Enrico Weigelt, metux IT consult (1):
      drivers: video: fbdev: Kconfig: pedantic cleanups

Finn Thain (3):
      video/macfb: Remove redundant code
      video/macfb: Call fb_invert_cmaps()
      video/macfb: Always initialize DAFB colour table pointer register

Geert Uytterhoeven (4):
      fbdev: atafb: Stop printing virtual screen_base
      fbdev: atafb: Remove obsolete module support
      fbdev: atafb: Fix broken frame buffer after kexec
      fbdev: atafb: Modernize printing of kernel messages

Gerd Hoffmann (1):
      fbdev: list all pci memory bars as conflicting apertures

Gustavo A. R. Silva (1):
      xen, fbfront: mark expected switch fall-through

Jiufei Xue (1):
      fbdev: fix WARNING in __alloc_pages_nodemask bug

Julia Lawall (1):
      omapfb: add missing of_node_put after of_device_is_available

Kangjie Lu (2):
      video: hgafb: fix potential NULL pointer dereference
      video: imsttfb: fix potential NULL pointer dereferences

Kefeng Wang (1):
      video: fbdev: Use dev_get_drvdata()

Linus Walleij (1):
      video: amba-clcd: Decomission Versatile and Nomadik

Melchior Franz (1):
      fbdev: mxsfb: implement FB_PRE_INIT_FB option

Mikulas Patocka (3):
      udlfb: delete the unused parameter for dlfb_handle_damage
      udlfb: fix sleeping inside spinlock
      udlfb: introduce a rendering mutex

Shile Zhang (1):
      fbdev: fix divide error in fb_var_to_videomode

Yifeng Li (9):
      fbdev: sm712fb: fix white screen of death on reboot, don't set CR3B-CR3F
      fbdev: sm712fb: fix brightness control on reboot, don't set SR30
      fbdev: sm712fb: fix VRAM detection, don't set SR70/71/74/75
      fbdev: sm712fb: fix boot screen glitch when sm712fb replaces VGA
      fbdev: sm712fb: fix crashes during framebuffer writes by correctly mapping VRAM
      fbdev: sm712fb: fix crashes and garbled display during DPMS modesetting
      fbdev: sm712fb: fix support for 1024x768-16 mode
      fbdev: sm712fb: use 1024x768 by default on non-MIPS, fix garbled display
      fbdev: sm712fb: fix memory frequency by avoiding a switch/case fallthrough

YueHaibing (3):
      video: fbdev: pvr2fb: remove set but not used variable 'size'
      video: fbdev: mxsfb: remove set but not used variable 'line_count'
      video: fbdev: atmel_lcdfb: remove set but not used variable 'pdata'

 drivers/video/fbdev/Kconfig                        | 304 ++++++-----
 drivers/video/fbdev/Makefile                       |   2 -
 drivers/video/fbdev/amba-clcd-nomadik.c            | 251 ---------
 drivers/video/fbdev/amba-clcd-nomadik.h            |  24 -
 drivers/video/fbdev/amba-clcd-versatile.c          | 567 ---------------------
 drivers/video/fbdev/amba-clcd-versatile.h          |  17 -
 drivers/video/fbdev/amba-clcd.c                    |  98 +---
 drivers/video/fbdev/atafb.c                        |  67 ++-
 drivers/video/fbdev/atafb_iplan2p2.c               |  23 -
 drivers/video/fbdev/atafb_iplan2p4.c               |  23 -
 drivers/video/fbdev/atafb_iplan2p8.c               |  23 -
 drivers/video/fbdev/atafb_mfb.c                    |  23 -
 drivers/video/fbdev/atmel_lcdfb.c                  | 116 +----
 drivers/video/fbdev/core/fbcmap.c                  |   2 +
 drivers/video/fbdev/core/fbcon.c                   |   2 +-
 drivers/video/fbdev/core/fbmem.c                   |  29 +-
 drivers/video/fbdev/core/modedb.c                  |   3 +
 drivers/video/fbdev/hgafb.c                        |   2 +
 drivers/video/fbdev/imsttfb.c                      |   5 +
 drivers/video/fbdev/macfb.c                        |  29 +-
 drivers/video/fbdev/mmp/Kconfig                    |   6 +-
 drivers/video/fbdev/mxsfb.c                        |  14 +-
 drivers/video/fbdev/nuc900fb.c                     |   2 +-
 drivers/video/fbdev/omap/Kconfig                   |  20 +-
 drivers/video/fbdev/omap2/omapfb/Kconfig           |  18 +-
 drivers/video/fbdev/omap2/omapfb/displays/Kconfig  |  40 +-
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig       |   6 +-
 .../fbdev/omap2/omapfb/dss/omapdss-boot-init.c     |   6 +-
 drivers/video/fbdev/pvr2fb.c                       |   2 -
 drivers/video/fbdev/s3c2410fb.c                    |   2 +-
 drivers/video/fbdev/savage/savagefb_driver.c       |   6 +-
 drivers/video/fbdev/sm712.h                        |  12 +-
 drivers/video/fbdev/sm712fb.c                      | 243 +++++++--
 drivers/video/fbdev/udlfb.c                        | 114 ++++-
 drivers/video/fbdev/uvesafb.c                      |  16 +-
 drivers/video/fbdev/vesafb.c                       |   4 +-
 drivers/video/fbdev/xen-fbfront.c                  |   2 +-
 include/linux/amba/clcd.h                          |  31 --
 include/video/udlfb.h                              |   7 +
 39 files changed, 608 insertions(+), 1553 deletions(-)
 delete mode 100644 drivers/video/fbdev/amba-clcd-nomadik.c
 delete mode 100644 drivers/video/fbdev/amba-clcd-nomadik.h
 delete mode 100644 drivers/video/fbdev/amba-clcd-versatile.c
 delete mode 100644 drivers/video/fbdev/amba-clcd-versatile.h
