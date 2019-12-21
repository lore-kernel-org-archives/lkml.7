Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF6CC3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF7421927
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 14:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OpgTtrM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfLUOfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 09:35:54 -0500
Received: from mout.gmx.net ([212.227.15.15]:37113 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbfLUOfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 09:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576938943;
        bh=Tkb7joQstLAGu2IIOjJB8aYKaEv/nA6o+B4sSnBN9Ek=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=OpgTtrM2VMRAP/h12Fd71+07VYgZ9FrN1W/yWnNwC5lhjJRVyKnR/9LiaRk1q+D5A
         fW6lDbRbxl03Dz+jkn7+atRU/+5bzlQM2jB0zQf0eIvwJvpkbLTjAUjdqmpnsScf2h
         ZPtAf5HjFdFUHYBeruRg+qeLVEU2etSB2Mi5f1mk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.169.139]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1iDvZv0vVA-00UpMa; Sat, 21
 Dec 2019 15:35:43 +0100
Date:   Sat, 21 Dec 2019 15:35:39 +0100
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Cc:     Sven Schnelle <svens@stackframe.org>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.5-rc3
Message-ID: <20191221143539.GA29263@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:Eu1VqnZExhaM2p9mJ3lDYG25ZhP7zssG8jpDj9wAueBi1ee/QLB
 4lvX2upPhcCbllIu5iJDIdYYzrqBKqPcLehSHwk0pVT8+lUrlDqh2l5YN0pMqVOwMypdsuQ
 0/rb/odisXFnxcbvkQA6NIoZQefF/JgHW/R99dXoHpobZR7Fb91gWr8SdauG6NxUJEZ3eMY
 gyaoUxiT+5R0fbjNTPjDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VH+g+yyVafM=:BjCvHx8x0S+GnR/jjf+R2t
 AQD4e6O2YCPkkt2Lr2G+Y8R1gyiteNeQrTEobHf64U4AWhCwTknhJ/WStqedmPDv371BZGNFF
 3+wr4K89RIQlKuSkcdNMWt1XONlILUUechwyCIvcLys5b1BSDkR9SLox1bfQA6Yuk+5kJZgrI
 mQk59cmKywS7cTMTyN4Z5gaI5awtWg6836hVTE8071xRnGRKtjelwzm+K6cOmq6DzXpc8gXci
 LTW6ekHk2duvQiT17aBCUZj9JGorOG3h+pkwpknm6kTpPaNSZCawq+q6GRg0syFzgnBdWJDql
 pg2NQvZbfJGk/Fhu1z+5jQEM7g8V6xaHNHkp999DuzCBlf5Q9H3WTnnROc+g6pNgPIqXH10CH
 bNPr65twNX5j27RTInvfkwhi5VwaTqaN//H4ZTfKk1dwg42C+waJ7w1xYYTmvnMkyKFf228jj
 DYbRyifWaPuNiBDmabgYxUcqvQHw1I8s7glPjYy+RU2bUmVGJv4rLDeluzuaXHvVu1DJVS8bV
 97XQsCsoxpPrHkxtW7ApnRTQFILzwg6OWy6isI4FhAUQ9rQYWP4E6A8fY8P1aWk1AKsf8UpnI
 s0owKydFVNPQ59pzP227lgZQ3hTWwuuYC0DfJwA9l0TEA2TfxZUQECL8bvEJJ7OyKuHzS9okU
 OQE5jBEvihLFcback0PwDxQHzayl/uVWko8YxI9b/B7MQGtFekE4H4qlluuNvSFyr/xGgbA1S
 LnWNp40wkNM9Ln1azKKmlVUDvYbNZPJ+akiDDm16yxgKkcbqSMPl3wNrvDUDhfyKy4x1FiwTO
 zKijr1AIROP+aYpxXoiGK6YQTLGth9XnRhpF5wsKyP12mdQwaAk3uVqsIGUYrUbGK1CyuY7Gz
 urh9KKvkOJSgQLQQ4tBKZTpUOdKXCMofT+2VIeXlotd8XnXYgIB2NG+nCAk3J159O5CHk5Qn8
 NEjzBFyWJQPKIZyjilVQD4WVt9MDRR7OqisIKCvuFXNmJWmhswNTB3DPoQto1PtlKJ2URkeD2
 qttSy98sdVFcvfidLbtDoxpHmeJDOgIBI/5YJGJJQDFE6v43OG3pR67iL14BSUiM+n64fx4ou
 L5AcvPwzWWndKQtFUH7z6r/E515rjNjnxk2JUsSSo5QyXIp3hQUQchwEvrB75hJEGlm2Ji+BD
 vjN1xl9U/lJiWXPS/g3BYoep1AOx7GsT0EoD09d7aB8Unsm9sM+XreASDXwPyOkRiIt7vOXAh
 6ui6sCE7CppXRAykUsAelOH1r1c8WAaUGpsWVPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few small fixes for the parisc architecture for kernel 5.5-rc3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.5-2

Two build error fixes, one for the soft_offline_page() parameter change and one
for a specific KEXEC/KEXEC_FILE configuration, as well as a compiler and a
linker warning fix.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (2):
      parisc: soft_offline_page() now takes the pfn
      parisc: Fix compiler warnings in debug_core.c

Sven Schnelle (2):
      parisc: fix compilation when KEXEC=n and KEXEC_FILE=y
      parisc: add missing __init annotation

 arch/parisc/include/asm/cmpxchg.h | 10 ++++++++--
 arch/parisc/include/asm/kexec.h   |  4 ----
 arch/parisc/kernel/Makefile       |  2 +-
 arch/parisc/kernel/drivers.c      |  2 +-
 arch/parisc/kernel/pdt.c          |  3 +--
 5 files changed, 11 insertions(+), 10 deletions(-)
