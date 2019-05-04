Return-Path: <SRS0=6aFo=TE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E87EC43219
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2740420859
	for <linux-kernel@archiver.kernel.org>; Sat,  4 May 2019 14:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfEDOis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 May 2019 10:38:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58535 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbfEDOis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 May 2019 10:38:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44xBT15fzxz9s5c;
        Sun,  5 May 2019 00:38:45 +1000 (AEST)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, segher@kernel.crashing.org
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-5.1-7 tag
Date:   Sun, 05 May 2019 00:38:41 +1000
Message-ID: <877eb6xp1q.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Linus,

Please pull one more powerpc fix for 5.1:

The following changes since commit 7a3a4d763837d3aa654cd1059030950410c04d77:

  powerpc/mm_iommu: Allow pinning large regions (2019-04-17 21:36:51 +1000)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-5.1-7

for you to fetch changes up to 12f363511d47f86c49b7766c349989cb33fd61a8:

  powerpc/32s: Fix BATs setting with CONFIG_STRICT_KERNEL_RWX (2019-05-02 15:33:46 +1000)

- ------------------------------------------------------------------
powerpc fixes for 5.1 #7

One regression fix.

Changes we merged to STRICT_KERNEL_RWX on 32-bit were causing crashes under
load on some machines depending on memory layout.

Thanks to:
  Christophe Leroy.

- ------------------------------------------------------------------
Christophe Leroy (1):
      powerpc/32s: Fix BATs setting with CONFIG_STRICT_KERNEL_RWX


 arch/powerpc/mm/ppc_mmu_32.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJczaPFAAoJEFHr6jzI4aWAEsoP+wbm3WGTTSULdF3PbIGEtVbQ
CNrw/LpvNsmAn6210U2ag7Fwd6/hIprIy9wgwbgNiB2kDtMNy6srl1eMlC9npsV4
y43xeJQ0E2+u10eaBNsiwJEYtmNkJMuxCu31zGH/PZ4nTi4hdvaVwUETR725vYli
LICixZ2yr1eL948D3DzWpGigBmGhq1ajBsdXxn2sHxbeqefnFesdrjPR2e2GIj7E
cyHb+7vUATLUVc405yYCyHEU3/cly12LPcsreGe/tPWSJxw8I2BU36lCCXgby62w
E1KlSb4EzFx+lFujK6ICxaflFOtkP+0Xzajq8YU0qrItkGM8DA6yTy4vU99gN1KP
pgNwbaoMQCNJvzk0cIuMZ0RMGKrkRT4y2jW+MhHALMSkyv4HGKqT/N227PMq4U94
nVv41w868b8NnTrN9pLfSR+Gyr/Q7sF8zEVv0eIpbSciB/OTcg0yqAp7V2p0cTBG
pKM/c6glvkrbfEkoRItMpVU0PbckPFjXgTVqI/rvdiAVoEQvi1U4r8Fpu5I28j1d
wuryRhjnGXgkSjBlXkSK+tASWZHcKwhnD1y9KTHtKuLdxJqjDfyX0Dii+FqU5w42
aKeU4VrlrCGX2VnLj7ViH99wzkMogP9oZWZ5bhmOva/boxo1kJ9/vQkxaiXrhVjd
NLBrlVeLtaCjY52+eEJS
=k/X8
-----END PGP SIGNATURE-----
