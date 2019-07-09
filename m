Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5101CC606D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2954A2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 05:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ivffd6vt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfGIFqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 01:46:43 -0400
Received: from mout.gmx.net ([212.227.15.19]:53329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfGIFqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 01:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562651196;
        bh=joE9GeqsQWrzBQwgXRlkWwo09aacLPPhCLf9GSg+/M8=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=ivffd6vtNBtTScwtrDyKMiaKli+g8N7EMsQoRLmYvLSg2MFFJGl/MZ+2go+Kr6wa+
         IjLCVDcl9NF4wMY8CHihWtRaHQr7u3xYLFsB8hQCQfquz2StA6bANL4hrmi7Ln0wV1
         OnbhL4q0UJ30R6Q16Uj9124NfoZy81iLifXO9xwM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.dellerweb.de ([92.116.158.121]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LfSeH-1iI6tB0IYr-00p3Cv; Tue, 09 Jul 2019 07:46:36 +0200
Date:   Tue, 9 Jul 2019 07:46:32 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture patches for kernel v5.3
Message-ID: <20190709054632.GA14843@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Provags-ID: V03:K1:VIonYAy/xwcpqwB91oMJFKn7kTKiuuCzDbroEXVUs4XqS5MgDcd
 DRvD4yuITLvSmSlxtkTX5fDlpLgJ0OLZiB9LStyzBnM3igQS/ur6EtP70FoYthCOPW84hoQ
 fYUxBn43vJl9L0Ma6t5cYddMWNukj1/+ldg/fwDGHGpJH3NTk6yZSGVWvQCZzWOoYW427tl
 8r3smvCvz9sTlRYaj/7xQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:564hTMAUo+A=:5YbLjwZiwUbQQMrRrTAPQb
 rZS97SxbEm8/CgKHjWn0AxCyZBQJz4IRFZIHU3FP82f4xyzCL5b9N2ZbicpDhtDcsEYS6BS4k
 qZcFzADZOYvMseYcoVvVR6r71Ko0xIX6VJKE+EolXlRJtDfXH/lrFKDmNYOq8XiwAZ9u8yNps
 s71OklrYXe0a8ZXfCGnbunfpE7dGJB72N2Dg7RlMPQ5HBxF/SGObvvdYijf2guVwHMJ/lCAY/
 /+qmWLvbE7Ip4YICEkaQQ9nX5BPLAz0WArV8bESzG+UxrhcB4nwmeUiiaBzLno/GNyRv1LWmO
 Xn5JtyHGWg0UAlvvvRAfzQ8Qg7GUkfMAZ/rtwRWg26qOh4U7ryW3P9eeHrackInp4+oB49dDj
 HU+/fEEI7AODXtU8dAW3/kGuyJWdd+kc/pDd5LKKNWIvHRSB+Jt5e9al6v5N6L6xjR7dWUFLC
 L+Tz4yUdfQP0dX2/Kv5HNIIF54X0hzfE3xtA8l5yjHiG7QQ+5w8qKtaEsOak1BJxcjhFvvxFc
 zORsdAHZsl7deYI56eLcL4S6yJwQb0kbKCt9BBQKdUBjtJR7xk0KCYY5eLQURJeODfqHwP6Eo
 sR81SlqdsEsmLTePexzgeQcmx4eNOwY4aM1PfTwfX8oHY1h47yzsDE88NX5vUXZr17K7nAm3C
 DGZoqYX/CVfq6+FVuRyy+D/IY9xzJr/fOL7xnlBEGaewvvJ+ODNW1xQQIAS/YqBrZlotb231V
 VUyfzlQFBIYr2gtEB7C5kFF1XaJi+I9rwMRy5jy62ZgTrtxBMuGvxt5qlRidFOGjM8tHE9bFq
 WJnCm/C2bKbyzeC+w7BMbn2VLahtSUB1Zw4/EZ5ZBq9RzTlbkC7G3jj7pTT89BlwG8E+OBp9I
 u8xqgGc7NqINZvexqtnNvp1jSekGHNeNxbjuloVKT+PGEIaMS6wDSDPUXG0vyhMfdoR9ho1BZ
 e1kDvYHECZ2lDgabQQVLKRZHxKn22fUlXOputLSgpIECUPtUAMQtpMzmhs6tcFZREu/ehvskL
 QLkoycvWaS0FNBpqhiD1V6nl+gZpbODt5yovHyinSYGpTPtidPwrwunTwvsLZAXTww==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull enhancements for the parisc architecture for kernel 5.3 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git pa=
risc-5.3-1

Dynamic ftrace support by Sven Schnelle and a header guard fix by Denis Ef=
remov.

Thanks,
Helge

=2D---------------------------------------------------------------
Denis Efremov (1):
      parisc: asm: psw.h: missing header guard

Sven Schnelle (6):
      parisc: add support for patching multiple words
      parisc: add spinlock to patch function
      parisc: add WARN_ON() to clear_fixmap
      parisc: use pr_debug() in kernel/module.c
      compiler.h: add CC_USING_PATCHABLE_FUNCTION_ENTRY
      parisc: add dynamic ftrace

 arch/parisc/Kconfig               |   2 +
 arch/parisc/Makefile              |  18 ++++++
 arch/parisc/include/asm/ftrace.h  |  15 ++++-
 arch/parisc/include/asm/patch.h   |   4 +-
 arch/parisc/include/asm/psw.h     |   2 +-
 arch/parisc/kernel/Makefile       |   9 +--
 arch/parisc/kernel/entry.S        |  64 +++++++++++++++++++
 arch/parisc/kernel/ftrace.c       | 129 +++++++++++++++++++++++++++++++++=
++---
 arch/parisc/kernel/module.c       |  64 +++++++++++--------
 arch/parisc/kernel/module.lds     |   7 +++
 arch/parisc/kernel/patch.c        |  88 +++++++++++++++++++++-----
 arch/parisc/kernel/vmlinux.lds.S  |   2 +
 arch/parisc/mm/fixmap.c           |   7 ++-
 include/asm-generic/vmlinux.lds.h |   7 +++
 include/linux/compiler_types.h    |   2 +
 15 files changed, 359 insertions(+), 61 deletions(-)
 create mode 100644 arch/parisc/kernel/module.lds
