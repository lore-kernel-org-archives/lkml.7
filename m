Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9423FC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56C8820828
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 15:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728985AbfCFPHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:07:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41753 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbfCFPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 10:07:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id y15so6962273qki.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 07:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=WQ2YvDd1LZb2MigqzyjLLb7FhRal6NKdJVZCncYIeqc=;
        b=lrvox8YaUrOf2UyoO9KXGxAv3CRikDaN8wsV72XTCv3wIUZ5qaiTKiTHxPThr/wW+t
         VWGSVtLUuy9zRtBjFh+j36EvPhwUnI8CnTtfcnP4XDl11PEmPdRjBdJ6cbIu1LYX1Zr9
         ceRYCkbUgUZWYgvu5DoU0LKkc5BeBG1gKQxU2/wLv7ZQ4oj/XkeWTbzEmDW+aMbl7VaM
         WBH/gp4ezaTE75vvYaQTQeS8QJ1UcS0JMkJqR2/dtf/jjGc+q0VEqHmV2i0TgjQ/RHIE
         RpT7C98PJ9l9ZijDpL3O527b6Yyso4yncRM7FpeXJEJpOViFFtaqVvXRjIUX6knqgPVm
         fieQ==
X-Gm-Message-State: APjAAAU6n+SLlpBpL+omGSoiH1DS2h5QDtHOGW+KWc9SAJsXk2TWHq9V
        KyKh02L3yfdRy0f2spzAOBxQvAgetxR5Z/xqZBuunh5Z
X-Google-Smtp-Source: APXvYqzzxbJsyifOSGwDVsofzfMP3o/bp666E4Tv1HBqMI+UILZE7qOPK9hWYM7sVisTblVk5twVFwQO1w4y9F1DyP4=
X-Received: by 2002:a37:8dc5:: with SMTP id p188mr5879761qkd.330.1551884860982;
 Wed, 06 Mar 2019 07:07:40 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 6 Mar 2019 16:07:24 +0100
Message-ID: <CAK8P3a2DX1TRubsmrkEckuZCYTGwmfN4KiuvXazJQL9vrUTBKg@mail.gmail.com>
Subject: [GIT PULL] asm-generic changes for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.1

for you to fetch changes up to d724444ab97d2cdf1c4dbfc1ff65d0b18a9631e0:

  asm-generic/page.h: fix typo in #error text requiring a real
asm/page.h (2019-02-22 21:53:25 +0100)

----------------------------------------------------------------
asm-generic changes for v5.1

Only a few small changes this time:

- Michael S. Tsirkin cleans up linux/mman.h
- Mike Rapoport found a typo

I had originally merged another cleanup series for I/O accessors from
Hugo Lefeuvre as well, but dropped it after the discussion of the barrier
semantics and some conflicts. I expect this series to get merged for a
later release though.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Michael S. Tsirkin (3):
      x86/mpx: tweak header name
      drm: tweak header name
      arch: move common mmap flags to linux/mman.h

Mike Rapoport (1):
      asm-generic/page.h: fix typo in #error text requiring a real asm/page.h

 arch/alpha/include/uapi/asm/mman.h     | 4 +---
 arch/mips/include/uapi/asm/mman.h      | 4 +---
 arch/parisc/include/uapi/asm/mman.h    | 4 +---
 arch/x86/mm/mpx.c                      | 2 +-
 arch/xtensa/include/uapi/asm/mman.h    | 4 +---
 include/asm-generic/page.h             | 2 +-
 include/drm/drmP.h                     | 3 +--
 include/uapi/asm-generic/mman-common.h | 4 +---
 include/uapi/linux/mman.h              | 4 ++++
 9 files changed, 12 insertions(+), 19 deletions(-)
