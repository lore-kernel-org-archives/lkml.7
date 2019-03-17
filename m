Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EDEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7317B2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 16:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="fDI45nXL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbfCQQAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 12:00:36 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45917 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbfCQQAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 12:00:35 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2HG0VtT010517;
        Mon, 18 Mar 2019 01:00:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2HG0VtT010517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552838432;
        bh=KjG9rXEVOQv25Mm/De/M0uUFkmhzT/KcC9AZFThcvNc=;
        h=From:Date:Subject:To:Cc:From;
        b=fDI45nXL92YEbC+iPVrT6+atn7fAdus0XQ1G6TCdzWHVB9M1yKG3sWvVLzxExb8AN
         qMBK2pvAca+YMMj0gpCGmrOFlhTnes+er4/915itZcYLtV9Ve5ZYXjZNw15kNL7PoW
         VjxiSO31uf0yGVej1JNaVvdalUHAye7tFFBBiCb1rGOjlUCKIo/9A3FZ/CHY6QGX9n
         9JQYxNTryEWHG6aIc/XcfgA6sJuP3rU96vbnqK3sVxHonZ0U5FH1+50qrr5/Dbn24Y
         BIWfTH/sCqLNV0K0d1oERHQSh8AW7EyU3UXjme9luvBFwBAEGBaRGdVNI8tje6BD7M
         aJUUk+3WvGsqQ==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id w13so2046389vsc.4;
        Sun, 17 Mar 2019 09:00:32 -0700 (PDT)
X-Gm-Message-State: APjAAAUUWiezexfO5chSW3Z0UrsbWp4XQY/I6rPnrPhQ1UeGmQ5O1tYH
        D0tAX8B3NzS56inRevN/pfwNFQxCasEn8DVG0eE=
X-Google-Smtp-Source: APXvYqyu7uHOTP7zjlhU9jLoS3SVdi+ZnOWsFqHQdpNzYZE8U9/cMt+gm4dk21xQxnfcL2UPNILZDBJHG9a/6ecHiCU=
X-Received: by 2002:a67:f90e:: with SMTP id t14mr7142005vsq.181.1552838430860;
 Sun, 17 Mar 2019 09:00:30 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 18 Mar 2019 00:59:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNATgAf-xiFFtMHYvOR91iNwQbiWaZxZCN-EKPKRpK57XuA@mail.gmail.com>
Message-ID: <CAK7LNATgAf-xiFFtMHYvOR91iNwQbiWaZxZCN-EKPKRpK57XuA@mail.gmail.com>
Subject: [GIT PULL] more Kbuild updates for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are late Kbuild updates for v5.1-rc1
Please pull!



The following changes since commit 5453a3df2a5eb49bc24615d4cf0d66b2aae05e5f:

  Merge tag 'kconfig-v5.1' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
(2019-03-13 10:06:28 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.1-2

for you to fetch changes up to c71bb9f8666602a22aee9df36a2df35e47edd8cc:

  kconfig: remove stale lxdialog/.gitignore (2019-03-17 15:47:02 +0900)

----------------------------------------------------------------
Kbuild updates for v5.1 (2nd)

 - add more Build-Depends to Debian source package

 - prefix header search paths with $(srctree)/

 - make modpost show verbose section mismatch warnings

 - avoid hard-coded CROSS_COMPILE for h8300

 - fix regression for Debian make-kpkg command

 - add semantic patch to detect missing put_device()

 - fix some warnings of 'make deb-pkg'

 - optimize NOSTDINC_FLAGS evaluation

 - add warnings about redundant generic-y

 - clean up Makefiles and scripts

----------------------------------------------------------------
Arseny Maslennikov (1):
      kbuild: deb-pkg: avoid implicit effects

Douglas Anderson (2):
      kbuild: Make NOSTDINC_FLAGS a simply expanded variable
      Revert "modsign: Abort modules_install when signing fails"

Masahiro Yamada (14):
      libfdt: prefix header search paths with $(srctree)/
      ia64: prefix header search path with $(srctree)/
      modpost: always show verbose warning for section mismatch
      kbuild: move archive command to scripts/Makefile.lib
      h8300: use cc-cross-prefix instead of hardcoding h8300-unknown-linux-
      unicore32: simplify linker script generation for decompressor
      kbuild: source include/config/auto.conf instead of ${KCONFIG_CONFIG}
      kbuild: add workaround for Debian make-kpkg
      kbuild: deb-pkg: add CONFIG_ prefix to kernel config options
      kbuild: deb-pkg: introduce is_enabled and if_enabled_echo to builddeb
      kbuild: pkg: grep include/config/auto.conf instead of $KCONFIG_CONFIG
      kbuild: warn redundant generic-y
      kbuild: force all architectures except um to include mandatory-y
      kconfig: remove stale lxdialog/.gitignore

Riku Voipio (1):
      deb-pkg: generate correct build dependencies

Wen Yang (1):
      coccinelle: semantic code search for missing put_device()

 Documentation/kbuild/makefiles.txt                      |  2 +-
 Makefile                                                | 18 ++++++--
 arch/alpha/include/uapi/asm/Kbuild                      |  2 -
 arch/arc/include/uapi/asm/Kbuild                        |  2 -
 arch/arm/include/asm/Kbuild                             |  1 -
 arch/arm/include/uapi/asm/Kbuild                        |  1 -
 arch/arm64/include/uapi/asm/Kbuild                      |  1 -
 arch/c6x/include/uapi/asm/Kbuild                        |  2 -
 arch/csky/include/uapi/asm/Kbuild                       |  2 -
 arch/h8300/Makefile                                     |  2 +-
 arch/h8300/include/asm/Kbuild                           |  1 -
 arch/h8300/include/uapi/asm/Kbuild                      |  2 -
 arch/hexagon/include/uapi/asm/Kbuild                    |  2 -
 arch/ia64/include/uapi/asm/Kbuild                       |  3 --
 arch/ia64/sn/kernel/Makefile                            |  2 +-
 arch/ia64/sn/kernel/sn2/Makefile                        |  2 -
 arch/ia64/sn/pci/Makefile                               |  2 -
 arch/ia64/sn/pci/pcibr/Makefile                         |  2 +-
 arch/m68k/include/uapi/asm/Kbuild                       |  2 -
 arch/microblaze/include/uapi/asm/Kbuild                 |  2 -
 arch/mips/include/uapi/asm/Kbuild                       |  2 -
 arch/nds32/include/uapi/asm/Kbuild                      |  2 -
 arch/nios2/include/uapi/asm/Kbuild                      |  2 -
 arch/openrisc/include/asm/Kbuild                        |  2 -
 arch/openrisc/include/uapi/asm/Kbuild                   |  2 -
 arch/parisc/include/asm/Kbuild                          |  2 -
 arch/parisc/include/uapi/asm/Kbuild                     |  2 -
 arch/powerpc/include/asm/Kbuild                         |  1 -
 arch/powerpc/include/uapi/asm/Kbuild                    |  2 -
 arch/riscv/include/uapi/asm/Kbuild                      |  1 -
 arch/s390/boot/Makefile                                 |  3 --
 arch/s390/include/asm/Kbuild                            |  1 -
 arch/s390/include/uapi/asm/Kbuild                       |  2 -
 arch/sh/include/uapi/asm/Kbuild                         |  1 -
 arch/sparc/include/uapi/asm/Kbuild                      |  2 -
 arch/unicore32/boot/compressed/Makefile                 |  5 +--
 .../boot/compressed/{vmlinux.lds.in => vmlinux.lds.S}   |  0
 arch/unicore32/include/uapi/asm/Kbuild                  |  2 -
 arch/x86/include/uapi/asm/Kbuild                        |  3 --
 arch/xtensa/include/asm/Kbuild                          |  1 -
 arch/xtensa/include/uapi/asm/Kbuild                     |  3 --
 include/asm-generic/Kbuild                              |  5 +++
 include/uapi/asm-generic/{Kbuild.asm => Kbuild}         |  4 +-
 lib/Makefile                                            |  2 +-
 scripts/Makefile.asm-generic                            | 11 +++++
 scripts/Makefile.build                                  |  6 +--
 scripts/Makefile.lib                                    |  6 +++
 scripts/Makefile.modinst                                |  2 +-
 scripts/Makefile.modpost                                |  1 -
 scripts/adjust_autoksyms.sh                             |  9 +---
 scripts/coccinelle/free/put_device.cocci                | 56
++++++++++++++++++++++++
 scripts/kconfig/lxdialog/.gitignore                     |  4 --
 scripts/link-vmlinux.sh                                 |  9 +---
 scripts/mod/modpost.c                                   | 27 +++---------
 scripts/package/builddeb                                | 32 ++++++++------
 scripts/package/buildtar                                |  2 +-
 scripts/package/mkdebian                                | 39 ++++++++++-------
 57 files changed, 153 insertions(+), 156 deletions(-)
 rename arch/unicore32/boot/compressed/{vmlinux.lds.in => vmlinux.lds.S} (100%)
 create mode 100644 include/asm-generic/Kbuild
 rename include/uapi/asm-generic/{Kbuild.asm => Kbuild} (87%)
 create mode 100644 scripts/coccinelle/free/put_device.cocci
 delete mode 100644 scripts/kconfig/lxdialog/.gitignore


-- 
Best Regards
Masahiro Yamada
