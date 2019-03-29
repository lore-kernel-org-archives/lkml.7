Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEEFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488B42183F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Ar+okSlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfC2ONX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:13:23 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:60679 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfC2ONW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:13:22 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2TED7BB021347;
        Fri, 29 Mar 2019 23:13:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2TED7BB021347
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553868788;
        bh=15h+0AhoLSBG3V0gcDzWaxlVdZ0n7X0Fz3lf7fetIOc=;
        h=From:Date:Subject:To:Cc:From;
        b=Ar+okSlmKXpkJ9GSRRzjfg2fjHx1gnXclTlIM32h+fLk7wyas8oOiA5SLJSoIDPcu
         E+88lntweusSQArkLVD6ZgVNAgsITrlzzuYw3fPiri5Xr/2G0K3WoKJCL9joVFmDjz
         C0NrC546BKKTHhrzfwJF/YitS6bbrMSbvN6NpRWz47c/wHnOL4wX9mS4B3G7HHcbvj
         C5S1W49Dns/8AigpJFE6aZtm74dfptm8Rxe/1w800p+EfU8kA/nGzdiOPNIAH53DSS
         G0HMtG+SQVysjAtekyJxSeb5BZfUX2tdZRWfIMq0BPbokccrj051tQraOxnXwfOIwA
         Ygp9QgNWrmN0g==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id p13so700433uaa.11;
        Fri, 29 Mar 2019 07:13:07 -0700 (PDT)
X-Gm-Message-State: APjAAAWPbJGUmosrIPhesmJUsQllG0daFqRncmtb3g8Aomzo6SnHQRFg
        feFVK3dXU2+nAvB3e1sG7CnRoV7BkJA31gQC7MY=
X-Google-Smtp-Source: APXvYqzb6j+P62zsnqCLwQ20FlbW5Tv9ILBGognaMr6kC9aRYJ5SPtQBF6J9Ea4EnUN7EdddkN9lqm+F+jSb1f8TC0I=
X-Received: by 2002:ab0:20c1:: with SMTP id z1mr14695173ual.109.1553868786790;
 Fri, 29 Mar 2019 07:13:06 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 29 Mar 2019 23:12:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNATH0b3ANTYa59b+AqY73LKON0=Xr73NgZGuJbWYgYDSDA@mail.gmail.com>
Message-ID: <CAK7LNATH0b3ANTYa59b+AqY73LKON0=Xr73NgZGuJbWYgYDSDA@mail.gmail.com>
Subject: [GIT PULL] Kbuild fixes for v5.1-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     masahiroy@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some Kbuild fixes.
Thanks.


The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kbuild-fixes-v5.1

for you to fetch changes up to 9c38f1f044080392603c497ecca4d7d09876ff99:

  kconfig/[mn]conf: handle backspace (^H) key (2019-03-29 22:48:01 +0900)

----------------------------------------------------------------
Kbuild fixes for v5.1

 - Remove harmful -Oz option of Clang

 - Get back the original behavior (no recursion for in-tree build)
   for GNU Make 4.x

 - Some minor fixes for coccinelle patches

 - Do not overwrite .gitignore in the output directory in case
   it is version-controlled

 - Fix missed record-mcount bug for dynamic ftrace

 - Fix endianness bug in modversions for relative CRC

 - Cater to '^H' key code in Kconfig ncurses programs

----------------------------------------------------------------
Changbin Du (1):
      kconfig/[mn]conf: handle backspace (^H) key

Fredrik Noring (1):
      kbuild: modversions: Fix relative CRC byte order interpretation

Joe Lawrence (1):
      kbuild: strip whitespace in cmd_record_mcount findstring

Masahiro Yamada (3):
      kbuild: skip sub-make for in-tree build with GNU Make 4.x
      kbuild: skip parsing pre sub-make code for recursion
      kbuild: do not overwrite .gitignore in output directory

Matthias Kaehlcke (1):
      Revert "kbuild: use -Oz instead of -Os when using clang"

Michael Stefaniuc (1):
      scripts: coccinelle: Fix description of badty.cocci

Wen Yang (1):
      coccinelle: put_device: reduce false positives

 Makefile                                 | 43
+++++++++++++++++++++------------------
 scripts/Makefile.build                   |  7 ++-----
 scripts/coccinelle/free/put_device.cocci |  1 +
 scripts/coccinelle/misc/badty.cocci      |  2 +-
 scripts/kconfig/lxdialog/inputbox.c      |  3 ++-
 scripts/kconfig/nconf.c                  |  2 +-
 scripts/kconfig/nconf.gui.c              |  3 ++-
 scripts/mod/modpost.c                    |  2 +-
 8 files changed, 33 insertions(+), 30 deletions(-)


-- 
Best Regards
Masahiro Yamada
