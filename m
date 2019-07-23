Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26CDC76194
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15062253D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 21:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Or+FMFk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392174AbfGWVnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 17:43:55 -0400
Received: from mout.gmx.net ([212.227.15.15]:42447 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbfGWVnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 17:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563918227;
        bh=n5+c+t7fbAX/WpckUnxzmiF3JNswIKT2Lwt/imiaxOE=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Or+FMFk9q3sDs/od5FEs7Vmo+YbbXJrEdgyhKY0sYXa1nTLb6APRHC8hd/r0JqpZ1
         T7c/YahBD4DpGChjrxSEqcssDb3NgdAGvI3tqKPx3UjZL3cnFoqfAvz76MwLHzjUFu
         mqFzHjcFDWkrwY62Iu7+dml8DXom3Wm2o3TC5YJ0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([87.191.208.243]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lhwgc-1iBZYH0kKY-00n9et; Tue, 23
 Jul 2019 23:43:47 +0200
Date:   Tue, 23 Jul 2019 23:43:44 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.3-rc2
Message-ID: <20190723214344.GA30785@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Provags-ID: V03:K1:yKWTeekTt8mW3vPn+NuzxqgNNJFcy3Dg94bZfx0tECdORfQ5/ha
 NBE2wKgzfMHMaVTjWk4vBJPeZsFq9bSUbOFcBhK2AfQpVmjc2MnEkB7BBPngk9kdK2jbPhL
 h2X+xT9pRXoENd+uQuCdBeyg6CP9g9tsqpQ5TTTlY/2q9C/ztQTRankl7sgCCdACK9yjSkO
 ksDzhuOG3Dfs81PHJ0PwA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iD2Nj8GGyXM=:zUt2E4ns5OvNVhZjzq0hd+
 /yBJDGyL9HeQ2J6KqvvqUOFmNF1SqMU/3jMnMUZI8AoZUaBY0Jw9iZYRBe5ktz5lY4s5NNWRe
 Ve2wt9Bg0bGDIqHxyTvrGdOe+1P9fpT/TgH7jZQI2jeIspZo9NmGhrT8imP7MGk/ssIE366Op
 9JMUFSnapkocv0axho8fic+R5jXP7Nm0SgVognrbUXvqYFhK/VJY0JTMatk1zVJ5DOWHk4uYz
 P5rivqfSm8xUhaHSma4uTnG7dCmGmCB6iw0nJFMSwS52LtaAQkcXaDg0PbYeS04nfsY0kWke0
 p2UbAu70fZ+8XYd91BYNbsT7XFOrdD30wWw0trCRfvEejdpsX87Exwvixfz6ecqO/ieR/Y/zL
 ZqLcPgwnmMNuN2EDr2ZBYRaIi3SmLyGyxQk/VhRcMGarTqy3eONkmSDvI14XEdobcmNimhjrF
 VpO5FyAAIN9f0J5sCFqJVuq+0g4r4X/+FRg/06SSocabLZA2zJYdgyGodOXV0JnqgxaVcolRp
 4cSWcXCD3V8eIDqeN7caXWWMiC2+R3JkDPgeTpkTDiSa1iwjUJolYSFNXwkb+wJRh8Ipao3zX
 wHi01eugy1+jRN65bFxSfswgdoy1qsckphVKnZybGeNh0NQaQjDlqUN1ztvDWUMV+W1JWaMiW
 WbflL2+IvImd8FdJkrd2jEBlU6LIv/tC8Ue9CnQhPsDZuBKWGzogOZbjCYoQcc9UWTKBOVMdg
 1dxQ/+eOhPLf6WyXUpsDsS8QX7/Ag4C3rpdUt8fGnjcbFV5BEnDWQZ+7efzglL/fywtFtK6iT
 Hedo+FbX/CTIbkZzMZBZw/7fm/FUTro/LC9Luq4C7QTrYP4CkfX7AKVqvsIIZxMIrcnXeLzmT
 hSPGhLoce3FWXi+7eR2y0s9UUxhzPrviCbLWZjVFuj8XgxHsGk2XhSKNjhwi7QyZjmQZV/bCd
 q6OtDXZAuqNU5qjaoxTRLdEczRxYRHfNH2wq3sXrmCyFzF4GuvcR4E+WJbHJYOEjZgmy2mxJD
 6WaCx9iFWWq+pxSxH0bz0p4jSAx902Ce1wQp5qT/ozkhWDuq1650OmJINsM/OheumA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two patches for the parisc architecture for kernel 5.3-rc2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.3-3

Changes:
- Fix build issues when kprobes are enabled
- Speed up ITLB/DTLB cache flushes when running on machines with combined TLBs

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Flush ITLB in flush_tlb_all_local() only on split TLB machines

Sven Schnelle (1):
      parisc: add kprobe_fault_handler()

 arch/parisc/include/asm/kprobes.h | 4 ++++
 arch/parisc/kernel/pacache.S      | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)
