Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC69C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D7421783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 09:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="l5RsIHa4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389587AbfGRJCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 05:02:52 -0400
Received: from mout.gmx.net ([212.227.15.19]:56717 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbfGRJCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 05:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563440564;
        bh=QBJLKn+dC85PPnBTLMHzTLIGPoRKi6Pjtg7ozwSWChw=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=l5RsIHa4K1su+VlK5d1tdjFI4lbHTeXIhTQEKSKydIoTXS52oG4HJTW2PNAKEgh7K
         dNICnhin/zntO93+vhiaFpp3rub+NrmEyqbAnhd0QAthHNEJ6EafIvJtH/TiWJbDhK
         p2qG0owYaAHMq8hWu8WMp1iUDzKEj5NPuiei3xmM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([193.16.224.40]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Mg4FJ-1i2emH0JGf-00NPoZ; Thu, 18
 Jul 2019 11:02:44 +0200
Date:   Thu, 18 Jul 2019 11:02:41 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.3-rc1
Message-ID: <20190718090241.GA14685@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Provags-ID: V03:K1:aHvyAxHtghpi/zBwhRwKoL7EnfnYdGJGMe0qrMPr3GieWA/TUlg
 hFVHRiN78tPGjPq1rLjPBvANMhxrcsBcU1vSMDbFW4RDhwaQiiOKf1pSHXzo4yQWLkmNH4U
 qNL0YxFn/IsApbFL9FZzkmzOeaSYXEHqDE/2qpJW6wIPUGfCUh4lRQnIa63EKUSf3blS+Lz
 T/lK5teKV5zelm+8WIAkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S7OEbOnUAnE=:2o8XdFrrEv90jkCkZjKVOs
 7AlAuPyhk2HXPhpBwohvboe5jA9CCzXIAFy0WfHQL/wY6SBV5uENtV4Z/8Lrn4YWTLsck3+xL
 e+dU08Xg9VU+/FcqfEwjjXmUvwgkpm9FRSi5UQPbx8mFVMd8b1iJhmpIWTCcm9fER1rDutg1j
 6xdqviHxpMPkLQ0dUbiD2zZKLflXMKOclmj9nnldUkHRPvg6f7GOlOOHRoIw1IftTJQMGtK2v
 kcRcYiyPDHmFLRWMM1WMSZyeC8dw5g1yML0P5XLMtkv4lGSvCmjBzDlwAlS5iT/y3DPzkYdlV
 DyxVX8ZuP8HmQHmCCvYbgr5QVaO9C4HaR0xzSaci2X1tcS+lhNd3zA5LilU6agAGHl6EZQzjU
 SeYKyW6fAYdN4ylVhVC3qev80nTcgHrt3um6IJzB3YrQsQZJkdkLLKMCVzVjBkp8lcMzDhuBn
 RrIZA4qZ+wIiPVzNvFayHq3+AAC74KSkB6qD/EFfXCPu2z4EkqmzNkt6ee6+FgyiUzizc1PSN
 6tL5qYUOdZy06dDoXfV0DPxh4E+xRPBnM8AaFd3Zg/hE2yHW04Qu+7gO9wTJBe3WaW35m4+tH
 JktJkDrlmTPqmqa0KoY3YG9lnBRsCyddGkTSCYAmvCicz4lk3HSpHmk3rPzuL9qH2X2z5QKHC
 zQj/RSgFjN09Krf0fU6EZv36uAbLEfMjzS4jO8SU3/qWRm3gX9+v+Te612tk5hh3WZQSDBOsI
 e28uxzoWrdoebUg6NxnS2SgJKFzyFi5NTxXkHmfemAwCtGiGBEEDBS2Eg/8YjuBDUOvfAk0LU
 9Z5ac15HsPPUN0RpEi0Etq4JnDfWRjfvCyCF3p9dij06/Trpauelhi4ESNA00J7BdobBos8Us
 DU+uTPnKVxRqRvolNJY7oUeby4vB4TuLzCjd3biLFhFX17iYpfiUj4PvWIVALanmezpa8fnB4
 TOVyfpGCAKooBxbe8U9KW3L012ZrSgCv9qGECW14Nu9u3en2dS4Sjav3LxpDF14YC0wNa5mr0
 sXafhjUrriKk9hMk23RnbC4qjwEIF9uHO7pIYD570eqrs5n8ofFkn3U61Yx1uAEMsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few more fixes for the parisc architecture for kernel 5.3-rc1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.3-2

Changes:
- Prevent kernel panics by adding proper checking of register values injected
  via the ptrace interface.
- Wire up the new clone3 syscall.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (4):
      parisc: Fix kernel panic due invalid values in IAOQ0 or IAOQ1
      parisc: Ensure userspace privilege for ptraced processes in regset functions
      parisc: Avoid kernel panic triggered by invalid kprobe
      parisc: Wire up clone3 syscall

 arch/parisc/include/asm/unistd.h        |  1 +
 arch/parisc/kernel/entry.S              |  1 +
 arch/parisc/kernel/kprobes.c            |  3 +++
 arch/parisc/kernel/ptrace.c             | 31 ++++++++++++++++++++-----------
 arch/parisc/kernel/syscalls/syscall.tbl |  2 +-
 5 files changed, 26 insertions(+), 12 deletions(-)
