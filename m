Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D43CC31E40
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 23:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96722064A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 23:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyWUA0VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfGMXmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 19:42:07 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39690 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728733AbfGMXmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 19:42:07 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so28130907ioh.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2019 16:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Xg9+KAq8bABDugNLZEIH/iMJUpgv2wNj/umMCDFN6OA=;
        b=FyWUA0VLW/ZPVB5OGW16go0DFytpmAWRUVyEo52hMemUxyZ0JMHDvFpvtQZ2YBtulm
         3uqJadRC+1pg+8EdrhLWkoI9UGisDeLO7ahShTz+js9M2zUdcbRtIAlPlGE82TBJ0dJw
         PpfkBQW7uWDogAZ8GXmBoi2DVMnjqtTIR9rukdhll5sVKspSGa8VVLnJ4ovppAsP3mid
         IyYNF2dCChie83abDaHLD593n+D+q5nQWPlsc8peUoibDRVETsKWL6EfjVlRdw89p5bm
         RzCX3bCbMcoSk6IipO1H9h+kCEVB4wSVMrhxY3QIwKAMI+JxiMjNYBb0yTYPMaQfcEHk
         d20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Xg9+KAq8bABDugNLZEIH/iMJUpgv2wNj/umMCDFN6OA=;
        b=gohe7DYTZgiCBxV8scW5Q3fyaCeicmWAYvgx/LJ8kFIB4KBmeL7zJC/7q7rX0atzHX
         iBmUslka3Cfp9g5aeQ7wuenlqaTkP4DdFV+wvL28w9V+7BEF/OI1zBtNlg9PA5P3RmNt
         ScsiGEUG8OhkcOznK3UQuIqdvgGN2U+bYErLfwrYJDbAnsouHOpmUEGXzLOq3MQ+39+n
         uU1Lz+M63dUHGqxvNCWjkUOln/nNjJrGpuF3NbCyVMz4hYlgqUOOnX9FQccjQJ6PMN/4
         VDvkSGC2C7IpICZAsgOxv9SM8Gk8gWB6w6PYjgwil4qyQB8nmNvwG44BmRe5zjNeW2ry
         ANVQ==
X-Gm-Message-State: APjAAAUG2RQxgzhI/AgpVhuEkQp7IuWKUz3BqRY7HoSHK0OUp3AMFp3D
        JExfj+S6ArZZastoZLr0ihEyKk+IRtCSlTHqVlPkiMNc
X-Google-Smtp-Source: APXvYqyqn7N2j2lxBylpO+u1VcxSnVYdyq3ITclCY9g+i2y1cTyPn0jJpCpu66HrOATrpA/2hHcphckza5dR78amC8M=
X-Received: by 2002:a6b:3b89:: with SMTP id i131mr16969776ioa.33.1563061326127;
 Sat, 13 Jul 2019 16:42:06 -0700 (PDT)
MIME-Version: 1.0
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Sat, 13 Jul 2019 18:41:55 -0500
Message-ID: <CABb+yY2RWBW0054fPLyNMAFX4BQ2FqV2NeAvHe7aHhAuH46dcA@mail.gmail.com>
Subject: [GIT PULL] Mailbox changes for v5.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.linaro.org/landing-teams/working/fujitsu/integration.git
tags/mailbox-v5.3

for you to fetch changes up to 25777e5784a7b417967460d4fcf9660d05a0c320:

  mailbox: handle failed named mailbox channel request (2019-07-11
10:19:00 -0500)

----------------------------------------------------------------
- stm32: race fix by adding a spinlock
- mhu: trim included headers
- omap: add support for K3 SoCs
- imx: Irq disable fix
- bcm: tidy up extracting driver data
- tegra: make resume 'noirq'
- api: fix error handling

----------------------------------------------------------------
Arnaud Pouliquen (1):
      mailbox: stm32_ipcc: add spinlock to fix channels concurrent access

Bitan Biswas (2):
      mailbox: tegra: hsp: add noirq resume
      mailbox: tegra: avoid resume NULL mailboxes

Daniel Baluta (1):
      mailbox: imx: Clear GIEn bit at shutdown

Fuqian Huang (1):
      mailbox: bcm-flexrm-mailbox: using dev_get_drvdata directly

Sudeep Holla (1):
      mailbox: arm_mhu: reorder header inclusion and drop unneeded ones

Suman Anna (2):
      dt-bindings: mailbox: omap: Update bindings for TI K3 SoCs
      mailbox: omap: Add support for TI K3 SoCs

morten petersen (1):
      mailbox: handle failed named mailbox channel request

 .../devicetree/bindings/mailbox/omap-mailbox.txt   | 59 ++++++++++++++++++----
 drivers/mailbox/Kconfig                            |  2 +-
 drivers/mailbox/arm_mhu.c                          | 11 ++--
 drivers/mailbox/bcm-flexrm-mailbox.c               |  6 +--
 drivers/mailbox/imx-mailbox.c                      |  4 +-
 drivers/mailbox/mailbox.c                          |  6 ++-
 drivers/mailbox/omap-mailbox.c                     | 43 +++++++++-------
 drivers/mailbox/stm32-ipcc.c                       | 37 ++++++++++----
 drivers/mailbox/tegra-hsp.c                        | 20 ++++++--
 include/linux/omap-mailbox.h                       |  4 +-
 10 files changed, 134 insertions(+), 58 deletions(-)
