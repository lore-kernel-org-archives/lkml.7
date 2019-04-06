Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03B1C282DC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 20:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDBAB213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 20:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="K+g93NPK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfDFU3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 16:29:43 -0400
Received: from mout.gmx.net ([212.227.15.18]:44353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbfDFU3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 16:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1554582575;
        bh=8+mAOo41uNk3mEATcwKv8mqQuT8MAJmge8ZPaitATpg=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=K+g93NPKelUG9Klv3XjETJqo+JRhebgIYVScwf5+dckOZ8NEIlM0dkAPya+Hw9wOl
         sf2VYSLxxHju6Xzgde6/zUeFGf30zhDUkNCJEgTIHEXN2/zVkF24Q4CfkMwV5bN48K
         wI6Es7f708nH0AjsPN1/uwKwBkk0voULuPJzi7i0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.dellerweb.de ([92.116.164.5]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MUZKF-1hM39o0plr-00RG1v; Sat, 06
 Apr 2019 22:29:35 +0200
Date:   Sat, 6 Apr 2019 22:29:32 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.1
Message-ID: <20190406202932.GA24886@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Provags-ID: V03:K1:Lpa2szCi48j53YVJnnvHKQWo9TT/wnM9ZpXn63e67+G/8JvG55l
 k8q7mcd7qSaw3WbHIFIT0MLoEzlY8H6A1mtSqNzrVN1x8/aWJEShk2/VGs54Ms+6LF/sXap
 vy55EkBiHyAv9M2XFiansO1fAH4x3F4biRSao4otFinNorBgwzAunSLZy2fH8sahyLDNFzJ
 DCS5DK0AJWX3ze1pXpvIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MEnLMBQKkQ0=:Eik9t6M1lRQEr6yYPlaGk0
 7Sibmm+TJRIvAvJsLlZPYl6lJtt/TQiGJYMETA9x7HtwnhQJZjsWPEGD1RU51wkInQgzIxPFI
 jm9RES1zrj9XwosGaI1B193z0JW2BH9yGZRBFX22Q+WmtmoClEctsitDrtqKk+xNiW6i665v0
 nVZYjyfJUrAsoBCfxvZO/XqaM6mtbooq4wQYPbCUUmP1tSXsrggId2XA7EnK4HssDu6H4B+E/
 aar4LBmnmVd+BKACe9F7has+fYBmo2dRWAf0RBrYXmarPdWnjTEnPDhXwtioUbNSR9GC4xXrA
 E27MQY7RAKJ1b1beA5CbwygOkPyIeBuCQ8zCxmlJb72PAU4YyoaAXFNlUAa++63sXuZ7u5rcX
 +aLuXjA/xylm/wfRZ1Ap72VOjtkrJej1GRdQl5NrkJ43CZgJbH0jmIL8RVVh0uju8IeOTj1bk
 7VLnvbrO4QqFxpqQhQ+kqPj9S7o+dce9E9wSRlrbty/vq8wOXwRXYp4I3Ve6NXYYY6W2gQtSE
 SKB0Nrx4x65+bxXQYt2GoeStzWoXVnN3weESpcolzEv5XbcDEu7TcdzkyBRGcpdGPUOHGgFLh
 n6aHprLFkQQjyjS3ig7PZa61OYj1x9ia7DEDjRzNFGK5bGSk0D/iBxS5IoRG1/bjuSE7WPWFz
 sjLrKfa4sJuOTv/6+IyOzYJT3dO9CzYvSYO8v4dFWNruD1OnHmeRRZu9U7dIq3Fqpm/4sy0qM
 3hmNpsAS6sqm/eTQe6eNu0o7MNIbKG/qtecN81QHKm7J3/1ERfk6ogbL5VA5gcmkQbXng2LuM
 nbt+v9w8grH+5o14xgZ/5NbRvXh2hiVKS/GSVMKu0MJ90a0jrWaD2LrMqYC8heLMqJTo2DS8d
 iCPsboAiEAdx9goPqYsmbIAzHfXT99IWzFI0YYuK2pgeaYQd0xvcoQ8wu8yjFm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull four small parisc architecture fixes for kernel 5.1 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.1-2

A 32-bit boot regression fix introduced in the merge window, a QEMU detection
fix and two fixes by Sven regarding ptrace & kprobes.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (2):
      Revert: parisc: Use F_EXTEND() macro in iosapic code
      parisc: Detect QEMU earlier in boot process

Sven Schnelle (2):
      parisc: regs_return_value() should return gpr28
      parisc: also set iaoq_b in instruction_pointer_set()

 arch/parisc/include/asm/ptrace.h | 5 +++--
 arch/parisc/kernel/process.c     | 6 ------
 arch/parisc/kernel/setup.c       | 3 +++
 drivers/parisc/iosapic.c         | 6 +++++-
 4 files changed, 11 insertions(+), 9 deletions(-)
