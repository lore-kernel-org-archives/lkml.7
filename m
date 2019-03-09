Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE737C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5F420857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 01:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="GYCEQPdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfCIBce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 20:32:34 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:30375 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfCIBcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 20:32:33 -0500
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x291WBro025833;
        Sat, 9 Mar 2019 10:32:12 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x291WBro025833
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552095132;
        bh=YGC/iRCmDeXofLSJ8OnERxqf3F3rO3tLGXq4l1nhRB4=;
        h=From:Date:Subject:To:Cc:From;
        b=GYCEQPdVGBgx/s3ZlKyqM+V7jnAJeqU6HnPpvv9Po8XsBcqR/vPSY2sJNi5vasleO
         JA5u7Hf1c//6+mIThU6bhxWrx0ZA4Ag0UYaDhd2RQ1gLfHE9t5vjDycU9rQb6TZqsJ
         1XCkEHU8xmTxw0bxDIJ6lX9s7QxNac5zv4jUlxz5T13UOAdZ2JdaNsj/Ci5W+0JKts
         6owK29apOUf2imkTyPdrPABjLnr+l0do+sHHi0iRgRh9FhxKvGcRLy3VckavM7gk9s
         gobHlG5WpOCJkFO738708fiFSKLaC3NI7SrwUPRJfadzWEN6vKyZSQIAGhR4dppT8c
         Qfq6cYMNevnGg==
X-Nifty-SrcIP: [209.85.222.54]
Received: by mail-ua1-f54.google.com with SMTP id s15so12018134uap.6;
        Fri, 08 Mar 2019 17:32:12 -0800 (PST)
X-Gm-Message-State: APjAAAUpyspUd9rJb0UZrWOVn7jvn0K9n+1sMJkbur3YfDdClMzbLXDV
        //LVuIfdZ11pJiYUSs6NB/AA0ph1vD511sJanc8=
X-Google-Smtp-Source: APXvYqwqbbxOniao4ngdh8hs92tGN8k7kR8cFQWN47sqk1cvUhxsODmZ6aV1kcyaFSnTEmGzEtB0b3DBM2DtHFnNj78=
X-Received: by 2002:ab0:2646:: with SMTP id q6mr11456773uao.89.1552095130881;
 Fri, 08 Mar 2019 17:32:10 -0800 (PST)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 9 Mar 2019 10:31:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS2zf1yEmZhTa9h+73hk3ZMHMgBLHhzwS8-zu2fZ+MeAA@mail.gmail.com>
Message-ID: <CAK7LNAS2zf1yEmZhTa9h+73hk3ZMHMgBLHhzwS8-zu2fZ+MeAA@mail.gmail.com>
Subject: [GIT PULL] Kbuild updates for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull Kbuild updates for v5.1


You will see a merge conflict in ./Kbuild

The fixup is available in linux-next.


Thanks!





The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40=
:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-v5.1

for you to fetch changes up to 9250d20e9ecedab6aa331a127fbfc1272383ed72:

  kbuild: remove scripts/basic/% build target (2019-03-05 02:02:44 +0900)

----------------------------------------------------------------
Kbuild updates for v5.1

 - do not generate unneeded top-level built-in.a

 - let git ignore O=3D directory entirely

 - optimize scripts/kallsyms slightly

 - exclude DWARF info from *.s regardless of config options

 - fix GCC toolchain search path for Clang to prepare ld.lld support

 - do not generate modules.order when CONFIG_MODULES is disabled

 - simplify single target rules and remove VPATH for external module build

 - allow to add optional flags to dpkg-buildpackage when building deb-pkg

 - move some compiler option tests from Makefile to Kconfig

 - various Makefile cleanups

----------------------------------------------------------------
Kacper Ko=C5=82odziej (1):
      kbuild: [bin]deb-pkg: add DPKG_FLAGS variable

Luc Van Oostenryck (1):
      kbuild: use -Werror=3Dimplicit-... instead of -Werror-implicit-...

Masahiro Yamada (36):
      kbuild: skip 'addtree' and 'flags' magic for external module build
      kbuild: remove top-level built-in.a
      kbuild: merge KBUILD_VMLINUX_{INIT,MAIN} into KBUILD_VMLINUX_OBJS
      kbuild: simplify rules of data compression with size appending
      s390: make built-in.a not directly depend on *.o.chkbss files
      kbuild: add real-prereqs shorthand for $(filter-out FORCE,$^)
      kbuild: remove unnecessary in-subshell execution
      kbuild: remove meaningless prepare2 target
      kallsyms: add static qualifiers where missing
      kallsyms: remove unneeded memset() calls
      kallsyms: include <asm/bitsperlong.h> instead of <asm/types.h>
      kbuild: Disable extra debugging info in .s output
      kbuild: pkg: use -f $(srctree)/Makefile to recurse to top Makefile
      kbuild: generate modules.order only when CONFIG_MODULES=3Dy
      kbuild: set KBUILD_MODULES=3D1 all the time for single target %/
      kbuild: turn '/' into an alias of './'
      scripts/gdb: delay generation of gdb constants.py
      kbuild: remove unimportant comments from ./Kbuild
      scripts/gdb: do not descend into scripts/gdb from scripts
      kbuild: create symlink to vmlinux-gdb.py in scripts_gdb target
      scripts/gdb: refactor rules for symlink creation
      kbuild: hardcode genksyms path and remove GENKSYMS variable
      kbuild: refactor cc-cross-prefix implementation
      kbuild: compute false-positive -Wmaybe-uninitialized cases in Kconfig
      kbuild: move tools_silent to a more relevant place
      kbuild: make -r/-R effective in top Makefile for old Make versions
      kbuild: remove empty rules for makefiles
      kbuild: simplify single target rules
      kbuild: invoke syncconfig if include/config/auto.conf.cmd is missing
      kbuild: move ".config not found!" message from Kconfig to Makefile
      kbuild: move -gsplit-dwarf, -gdwarf-4 option tests to Kconfig
      kbuild: remove commented-out INITRD_COMPRESS
      kbuild: update comment block of scripts/clang-version.sh
      kbuild: remove cc-version macro
      kbuild: clean up scripts/gcc-version.sh
      kbuild: remove scripts/basic/% build target

Nick Desaulniers (1):
      kbuild: clang: choose GCC_TOOLCHAIN_DIR not on LD

Vladimir Kondratiev (1):
      kbuild: gitignore output directory

 Documentation/devicetree/bindings/Makefile |   2 +-
 Documentation/kbuild/kbuild.txt            |  15 ++--
 Documentation/kbuild/makefiles.txt         |  26 +------
 Documentation/kbuild/modules.txt           |   2 +-
 Kbuild                                     |  25 +------
 Makefile                                   | 219
++++++++++++++++++++++++++----------------------------
 arch/mips/boot/Makefile                    |   2 +-
 arch/powerpc/boot/Makefile                 |   2 +-
 arch/s390/boot/Makefile                    |   6 +-
 arch/s390/boot/compressed/Makefile         |   4 +-
 arch/s390/scripts/Makefile.chkbss          |  25 +++----
 arch/x86/realmode/rm/Makefile              |   3 +-
 init/Kconfig                               |  19 ++++-
 kernel/trace/Kconfig                       |   1 +
 lib/Kconfig.debug                          |   2 +
 scripts/Kbuild.include                     |  21 +++---
 scripts/Kconfig.include                    |   2 +-
 scripts/Makefile                           |   3 +-
 scripts/Makefile.build                     |  29 ++++----
 scripts/Makefile.host                      |   6 +-
 scripts/Makefile.lib                       |  42 +++++------
 scripts/Makefile.modpost                   |   2 +-
 scripts/clang-version.sh                   |  10 +--
 scripts/gcc-version.sh                     |  27 ++-----
 scripts/gdb/linux/Makefile                 |  25 ++++---
 scripts/kallsyms.c                         |  13 ++--
 scripts/kconfig/conf.c                     |  13 ----
 scripts/link-vmlinux.sh                    |  46 +++---------
 scripts/mkcompile_h                        |   4 +-
 scripts/package/Makefile                   |   8 +-
 scripts/package/builddeb                   |  10 +--
 scripts/package/buildtar                   |   2 +-
 scripts/package/mkdebian                   |   6 +-
 33 files changed, 262 insertions(+), 360 deletions(-)


--=20
Best Regards
Masahiro Yamada
