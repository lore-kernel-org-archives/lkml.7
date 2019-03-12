Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0D75C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F0AB2083D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="OJbdjZSa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbfCLQjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:39:53 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:38168 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfCLQjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:39:53 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x2CGde52021085;
        Wed, 13 Mar 2019 01:39:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x2CGde52021085
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552408781;
        bh=6BpOhEUIH5KArzx7rFWrfV5TzefUihAmIXd76d/S7wk=;
        h=From:Date:Subject:To:Cc:From;
        b=OJbdjZSab7Sn5BlEvaSl0dSjLeS55NEJvoAA1eTcY2LQ+URhDXJH6f8HXT/xNxL0L
         FQRQlDyGiXnttT1lpUosZLNkjLpj7DDCKpPygOHvi0o2lW1GOHhZwkc5BVFedd0761
         nX3+jxq+FpHybVjbDsxgJW1egVCTwzNrNHVvp9Ab8bZHpvFqsbbLuxbvfIuKF+wIsK
         kt1HCEZOcdN9eKfm2L1VL/dctfScqnDEs3hHfQo5p9WGbkgtQbti4Va7axD/CXmV3I
         JnkcG+Pwz+0bGj3gE/1xdOlEslIDWQma+KV4uCcBRdUTHplGxRJUAYFbfOyB1vEDyp
         i12XYgXYrNQGg==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id z18so1987299vso.7;
        Tue, 12 Mar 2019 09:39:41 -0700 (PDT)
X-Gm-Message-State: APjAAAXlhmdlRcKAOR5Uhr3G72fMJEajBXW2hPL30ruOXmPpnJb0kR0k
        Q8jIga02BV35V/oa/f2W6JcgQyh8rEwqapEi1uU=
X-Google-Smtp-Source: APXvYqy6Au8Rn8sq3Zv4JMFYBtc24KXXlbKkPLqjFg+7QePTZ1GepA32D+APh4dAr1G6hzs2moNXBoeONIxwGsIWqlg=
X-Received: by 2002:a67:ea05:: with SMTP id g5mr2938729vso.179.1552408780228;
 Tue, 12 Mar 2019 09:39:40 -0700 (PDT)
MIME-Version: 1.0
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 13 Mar 2019 01:39:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNASa-XsGj9ESee+RF4SMQxpxD49oKz9C86etYQV2gQPxDQ@mail.gmail.com>
Message-ID: <CAK7LNASa-XsGj9ESee+RF4SMQxpxD49oKz9C86etYQV2gQPxDQ@mail.gmail.com>
Subject: [GIT PULL] Kconfig updates for v5.1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


Please pull Kconfig updates for v5.1.

Thanks.



The following changes since commit f17b5f06cb92ef2250513a1e154c47b78df07d40:

  Linux 5.0-rc4 (2019-01-27 15:18:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
tags/kconfig-v5.1

for you to fetch changes up to 8741908b3e29d35a33eeab6de60175958db8e54b:

  kconfig: fix 'Save As' menu of xconfig (2019-03-12 02:50:24 +0900)

----------------------------------------------------------------
Kconfig updates for v5.1

 - rename lexer and parse files

 - fix 'Save as' menu of xconfig

----------------------------------------------------------------
Masahiro Yamada (3):
      kconfig: rename zconf.l to lexer.l
      kconfig: rename zconf.y to parser.y
      kconfig: fix 'Save As' menu of xconfig

 scripts/kconfig/Makefile              |  9 ++++----
 scripts/kconfig/expr.h                |  2 +-
 scripts/kconfig/{zconf.l => lexer.l}  |  2 +-
 scripts/kconfig/lkc.h                 |  2 +-
 scripts/kconfig/{zconf.y => parser.y} |  0
 scripts/kconfig/qconf.cc              | 42 +++++++++++++++++++++++++++++------
 scripts/kconfig/qconf.h               |  1 +
 7 files changed, 44 insertions(+), 14 deletions(-)
 rename scripts/kconfig/{zconf.l => lexer.l} (99%)
 rename scripts/kconfig/{zconf.y => parser.y} (100%)


-- 
Best Regards
Masahiro Yamada
