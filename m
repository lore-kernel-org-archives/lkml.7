Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC019C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ACB2089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 11:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JB2LLWKm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfJLLh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 07:37:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:50605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfJLLh0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 07:37:26 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46r2qL73D6z9sNx;
        Sat, 12 Oct 2019 22:37:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1570880243;
        bh=NUuYm3QgRCKdiVOv3fj1e5uvi/GpcpUadJPWe6lek+I=;
        h=From:To:Cc:Subject:Date:From;
        b=JB2LLWKmG0jQXJRimuZHaCJ+AiezNrebjfSKMGG/Jd+gOsfJnBKFxoxo5HtflOeg6
         Vxe730yVdFNklLqdy2ofOtnnH9JOteFy+H3SOppZ/U26NtFUwTuf0PmdC3MLm4xZOM
         ZQEiLxjw5eMDTgirf+ctd1Bg2HGC74h1s65hLUkTWnshLBBI10vK+t+f4F/AvruB6P
         4+cy0YzHMh4EAVB9ikz9jxVwYQi3+1EDx77gx2rhAiCjjQ9kR+yKHTtQfjoz7fAPEf
         p1EOPKedK0uIljbWS/OEjZOfIVcChPjiqRgVpPXwbOfqYJZbGZ6yfACKMbabrleOYR
         hu4DiSpeKsajg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     arnd@arndb.de, desnesn@linux.ibm.com, emmanuel.nicolet@gmail.com,
        jniethe5@gmail.com, ldufour@linux.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        sfr@canb.auug.org.au
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.4-3 tag
Date:   Sat, 12 Oct 2019 22:37:15 +1100
Message-ID: <87r23iurdg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.4:

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.4-3

for you to fetch changes up to 2272905a4580f26630f7d652cc33935b59f96d4c:

  spufs: fix a crash in spufs_create_root() (2019-10-11 16:57:41 +1100)

- ------------------------------------------------------------------
powerpc fixes for 5.4 #3

Fix a kernel crash in spufs_create_root() on Cell machines, since the new mount
API went in.

Fix a regression in our KVM code caused by our recent PCR changes.

Avoid a warning message about a failing hypervisor API on systems that don't
have that API.

A couple of minor build fixes.

Thanks to:
  Alexey Kardashevskiy, Alistair Popple, Desnes A. Nunes do Rosario, Emmanuel
  Nicolet, Jordan Niethe, Laurent Dufour, Stephen Rothwell.

- ------------------------------------------------------------------
Desnes A. Nunes do Rosario (1):
      selftests/powerpc: Fix compile error on tlbie_test due to newer gcc

Emmanuel Nicolet (1):
      spufs: fix a crash in spufs_create_root()

Jordan Niethe (1):
      powerpc/kvm: Fix kvmppc_vcore->in_guest value in kvmhv_switch_to_host

Laurent Dufour (1):
      powerpc/pseries: Remove confusing warning message.

Stephen Rothwell (1):
      powerpc/64s/radix: Fix build failure with RADIX_MMU=n


 arch/powerpc/include/asm/book3s/64/tlbflush-radix.h | 4 ++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S             | 1 +
 arch/powerpc/platforms/cell/spufs/inode.c           | 1 +
 arch/powerpc/platforms/pseries/lpar.c               | 3 +++
 tools/testing/selftests/powerpc/mm/tlbie_test.c     | 2 +-
 5 files changed, 10 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl2hsbMACgkQUevqPMjh
pYAvTg//SxycPkVZLln4SzXGj3f8dHyFUJS+796BXAyIS2ylIqRYFTvj9Uqfry/w
leCvU0xgB1LC0FTP2FCB9/q4GluB5uxkM32ziNFDSrPdfhtsV+WM4312ytrQEeLe
838D009gkDgd2NDxg0titW5pAq1oP7iwSilPKzZrb3pejJcHLK+qZ6+2SKefuXRs
Sn3nRT2yBJZqq1ECJjCH+mP/QGndf4sjyHQD43yTIT+SxKrnOWDEOqUCxHduhcYh
R2sof4pv5aC43b85C609D+yUi/VTbeHdrj8dbKHKHXmcDCmyRsYPpSNxd/irmLMr
c5hKbD0Nwu8p/TDv+NcjxA5w6Mf2Jo+btSPxTKErFpFCmbwQeM9OyUmLhpjKcbZl
PW8ArrMRkz0ypRhbDJz0oMp7mHLOWXwy0F8bxm96VoNgM8QpqJVwEh6J1O2DWzJY
Nwfc9nMKKtJNuQGWvpADvylIjbCPAUzl70vlPDEytx6JMu3JS/WwMfqqH4PQrGIs
BUllm98MBY9FrQFAVxnOPvpB16IQbsfKk/Vf1CY4RLYwIDfErA3sHXvnO0UepAtE
HEW/WF3VnRrU3wGdk2mHDVNyEwY7UIm6xp1QEcQDebLAS0bXdRhUmyrG9IBHOLLO
43UGwtlMKMf87ebx+Ps1l8Ih3bpwwFw+YJySMwQdhgF9CQOdXzY=
=2HLb
-----END PGP SIGNATURE-----
