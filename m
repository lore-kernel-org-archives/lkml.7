Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E33EC433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 11:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC64206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 11:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHDLtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 07:49:49 -0400
Received: from ozlabs.org ([203.11.71.1]:56769 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfHDLts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 07:49:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 461fMX0rVhz9sN6;
        Sun,  4 Aug 2019 21:49:43 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     aneesh.kumar@linux.ibm.com, christian@brauner.io,
        christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, santosh@fossix.org,
        sfr@canb.auug.org.au
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-3 tag
Date:   Sun, 04 Aug 2019 21:49:44 +1000
Message-ID: <87a7cpw3on.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull some more powerpc fixes for 5.3:

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.3-3

for you to fetch changes up to d7e23b887f67178c4f840781be7a6aa6aeb52ab1:

  powerpc/kasan: fix early boot failure on PPC32 (2019-07-31 22:02:52 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.3 #3

Wire up the new clone3 syscall.

A fix for the PAPR SCM nvdimm driver, to fix a crash when firmware gives us a
device that's attached to a non-online NUMA node.

A fix for a boot failure on 32-bit with KASAN enabled.

Three fixes for implicit fall through warnings, some of which are errors for us
due to -Werror.

Thanks to:
  Aneesh Kumar K.V, Christophe Leroy, Kees Cook, Santosh Sivaraj, Stephen
  Rothwell.

- ------------------------------------------------------------------
Aneesh Kumar K.V (1):
      powerpc/nvdimm: Pick nearby online node if the device node is not online

Christophe Leroy (1):
      powerpc/kasan: fix early boot failure on PPC32

Michael Ellerman (2):
      powerpc: Wire up clone3 syscall
      powerpc/spe: Mark expected switch fall-throughs

Santosh Sivaraj (1):
      powerpc/kvm: Fall through switch case explicitly

Stephen Rothwell (1):
      drivers/macintosh/smu.c: Mark expected switch fall-through


 arch/powerpc/include/asm/unistd.h         |  1 +
 arch/powerpc/kernel/align.c               |  4 ++++
 arch/powerpc/kernel/entry_32.S            |  8 ++++++++
 arch/powerpc/kernel/entry_64.S            |  5 +++++
 arch/powerpc/kernel/syscalls/syscall.tbl  |  2 +-
 arch/powerpc/kvm/book3s_32_mmu.c          |  1 +
 arch/powerpc/mm/kasan/kasan_init_32.c     |  7 +++++--
 arch/powerpc/platforms/pseries/papr_scm.c | 29 +++++++++++++++++++++++++++--
 drivers/macintosh/smu.c                   |  1 +
 9 files changed, 53 insertions(+), 5 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJFGtCPCthwEv2Y/bUevqPMjhpYAFAl1GxcEACgkQUevqPMjh
pYDXVQ//Wg2vXgrCxc9Gk65Sspu1oLwgBOl8zsM7u/McOXBUeBC3o8pUMwh1N5MB
IbSffD6UlK3GNEcIfVGWb7OeaqEZjRL3uUtJMUJQIEkK8MnflE60H9n5jrKMApV7
zRTQfU2mL/wObXeASgdUIhCgiTlkaZJcse9ATIKOtDpYy2Xm7ahAyImfqet39Ea0
9OetR48YuZzEPzzuESFAFslawFLRLIYSpviBYeFO85+uuoULu2ylpts1c5XyOH38
bUfRyvEJvvPEmYgmmqnw3R6NqPQwCc6+VkEbIZ6kv67vfXQbrTG7uN/HOjm9ksFf
/2Q/hXl2ZfwM+SO2lhhDPWFkJuWyBrutoxumkVE1dlD8B5D71qWpCxlPOVbwF8tB
S5b+8pq1mrrwQmsPoYa46WtvuEbuKI0vZqqx27ZSzGE40FwQcEbJhDRTEmsXuh+D
n3395ddQclj5zfsxU/gk+bmdT03F8crT+OPZxYKYZlUDgk/+6rYvghm7EC0dK3h7
/5sIpl5oWVMEUqpjdfeWPbdnF8b5M2xHFJXBUTJcHNA2gZzarUp0KuSPxBt2suu6
NhXZ19Ja2vaHwI2NZvKCdd543PzP6NG8GHRrMyiMnGWC88Fm4r5/FBd2g80ShQ2p
WuXj98tye3dbPTPzbkQM24g4WNsrQcc7uhKveRwnimWEgcPATPI=
=nPN5
-----END PGP SIGNATURE-----
