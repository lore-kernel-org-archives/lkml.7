Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E8FC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98BFD22ADC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcl2TTAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbfFCN7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:59:20 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]:41943 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbfFCN7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:59:20 -0400
Received: by mail-qk1-f181.google.com with SMTP id c11so427488qkk.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Bb1HKGZ1bVlQdxPr1Nk8M2aw3T9H3SkezOiiMpDUgNI=;
        b=pcl2TTAN98O3lBzhUh2HSOEgdblDXObHkAcwCH6mDliInbWcibCBKX0N3DoULVoKA4
         IDDTsO3g3P49+1XMUOCpFqLehXnmp225s1tnFzEE8LfAgNSZZ98JoFz4WrBwWORmrgAq
         Fyge/WZRHv0aDTzccrrUPRF8kDhpMjGVvNXfKsXyx+Rji/T/PQ65W/9G7XHVT1uyaUso
         oQUJa0VOwBz7Zt8BResZIwVbmIGi2lQYqzb07gBxG2UPhpU3WuwEo7NPnp4a3jtFVvmn
         eQJMRWe9QYAFbzqsYuRjrM7rxY+CZ7id1TEWb1HpySypFN8J7Oq4/MkdJDuis+9RFSz8
         71eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Bb1HKGZ1bVlQdxPr1Nk8M2aw3T9H3SkezOiiMpDUgNI=;
        b=VaBvATywJ1K2OpDiIdUySWihUbTYkr770K1h2TQzzPZFWKxDFvFaL9+k43B3c53jK7
         DWzrVyBy6oe6H++eT+cK5UbltaGgK2aGQ6d0OdDzJs82q1LZVL3AbFkOssFTXcZuhUTb
         EXPt0o4/LeYQNbVGJfh5hGtkFfuwLNbkOr48mhN47ZFOVXhs89RXQojL/NvvZdkEpJoR
         /wI+pibAV8hm/Fd8zgHpVt/jaD/qF4xSawm+NhTJP+NF89ES1qXHUd0vnYZrW3sPMM0V
         zFAvJiXYEeI/s1kBRx6tLGD0UBWKGkH1ZDktefDMYAkqqdNyG8GJj64bF0Dvhi0nrWgx
         LY4A==
X-Gm-Message-State: APjAAAUCCPP4elxYcbZXei3ClritzmX3vX8Spzud08sCYmaSxUuchAms
        YboU6g06Tw0iie6d9hWvX8tpKpnKeBt5bHMEN6/M/hu8
X-Google-Smtp-Source: APXvYqwYjlBXGm2xu9wPh6r/v0+2CrMQucF1e/GxfNSA/OB3sx0lBgqDFUkccEPltwmityOVzqfLfqaCfMMB7G7Rns0=
X-Received: by 2002:a05:620a:34d:: with SMTP id t13mr10738702qkm.201.1559570359433;
 Mon, 03 Jun 2019 06:59:19 -0700 (PDT)
MIME-Version: 1.0
From:   Greentime Hu <green.hu@gmail.com>
Date:   Mon, 3 Jun 2019 21:58:42 +0800
Message-ID: <CAEbi=3eRJMkGUT-H=Tts8A+Lju_CuYDbKpP+ofD1GVMM_1P05A@mail.gmail.com>
Subject: [GIT PULL] nds32 patches for 5.2-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
tags/nds32-for-linux-5.2-rc3

for you to fetch changes up to 932296120543149e3397af252e7daee7af37eb05:

  nds32: add new emulations for floating point instruction (2019-05-31
15:23:26 +0800)

----------------------------------------------------------------
nds32 patches for 5.2-rc3

Here is the nds32 patchset based on 5.2-rc1
Contained in here are
1. fix warning for math-emu
2. fix nds32 fpu exception handling
3. fix nds32 fpu emulation implementation

----------------------------------------------------------------
Vincent Chen (3):
      math-emu: Use statement expressions to fix Wshift-count-overflow warning
      nds32: Avoid IEX status being incorrectly modified
      nds32: add new emulations for floating point instruction

 arch/nds32/include/asm/bitfield.h            |  2 +-
 arch/nds32/include/asm/fpu.h                 |  2 +-
 arch/nds32/include/asm/fpuemu.h              | 12 ++++++++++++
 arch/nds32/include/asm/syscalls.h            |  2 +-
 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h | 16 ++++++++++++++++
 arch/nds32/include/uapi/asm/sigcontext.h     | 24 +++++++++++++++++-------
 arch/nds32/include/uapi/asm/udftrap.h        | 13 -------------
 arch/nds32/include/uapi/asm/unistd.h         |  4 ++--
 arch/nds32/kernel/fpu.c                      | 15 ++++++---------
 arch/nds32/kernel/sys_nds32.c                | 26 ++++++++++++++------------
 arch/nds32/math-emu/Makefile                 |  4 +++-
 arch/nds32/math-emu/fd2si.c                  | 30
++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fd2siz.c                 | 30
++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fd2ui.c                  | 30
++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fd2uiz.c                 | 30
++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fpuemu.c                 | 57
+++++++++++++++++++++++++++++++++++++++++++++++++++++----
 arch/nds32/math-emu/fs2si.c                  | 29 +++++++++++++++++++++++++++++
 arch/nds32/math-emu/fs2siz.c                 | 29 +++++++++++++++++++++++++++++
 arch/nds32/math-emu/fs2ui.c                  | 29 +++++++++++++++++++++++++++++
 arch/nds32/math-emu/fs2uiz.c                 | 30
++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fsi2d.c                  | 22 ++++++++++++++++++++++
 arch/nds32/math-emu/fsi2s.c                  | 22 ++++++++++++++++++++++
 arch/nds32/math-emu/fui2d.c                  | 22 ++++++++++++++++++++++
 arch/nds32/math-emu/fui2s.c                  | 22 ++++++++++++++++++++++
 include/math-emu/op-2.h                      | 17 +++++++----------
 include/math-emu/op-common.h                 | 11 ++++++-----
 26 files changed, 464 insertions(+), 66 deletions(-)
 create mode 100644 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h
 delete mode 100644 arch/nds32/include/uapi/asm/udftrap.h
 create mode 100644 arch/nds32/math-emu/fd2si.c
 create mode 100644 arch/nds32/math-emu/fd2siz.c
 create mode 100644 arch/nds32/math-emu/fd2ui.c
 create mode 100644 arch/nds32/math-emu/fd2uiz.c
 create mode 100644 arch/nds32/math-emu/fs2si.c
 create mode 100644 arch/nds32/math-emu/fs2siz.c
 create mode 100644 arch/nds32/math-emu/fs2ui.c
 create mode 100644 arch/nds32/math-emu/fs2uiz.c
 create mode 100644 arch/nds32/math-emu/fsi2d.c
 create mode 100644 arch/nds32/math-emu/fsi2s.c
 create mode 100644 arch/nds32/math-emu/fui2d.c
 create mode 100644 arch/nds32/math-emu/fui2s.c
