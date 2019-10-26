Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7285CA9EB9
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 22:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79DEB2084C
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 22:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572128078;
	bh=qNW2De2nnOaOHLics0z1LOmu66IaMhJRR9mrqaTZchw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=H5Yl4zjUNbJSRwAwQIRThxHZqvK+VAWahoRcCNFg4veplwHWoqiVd7O6MEHRZoEpR
	 h30ljAd8F1PXVdmQKhav9cNZUZdfmYEXbRIb+YHwX2x9bcafKqoW//Ij9MscfruFnJ
	 elAgysw+8aiul2IZasnjI7JtYoj5uD2kulbAhkHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfJZWOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 18:14:07 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40106 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfJZWOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 18:14:06 -0400
Received: by mail-pf1-f196.google.com with SMTP id x127so4090961pfb.7;
        Sat, 26 Oct 2019 15:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bWLBC9U6OtWWaioI2/2fhcDSMynpWQ90v12Q5Y5oedc=;
        b=jS1hpWYxVjgWxlz/zgXacY3mI3Vmsfeg1pEc4/QZvctb1iY+/lS7ODxH03jd2+s+E9
         jpVy0u8TLmHUDnhvbk3TnKNIHe971W5+kyzpUKIZUktg5lFXw6ca+Z8a9G+8GEC0sie/
         D/SWkcKrrgPo3Q97iQYGTpf8M0/i2KXHKVqHvN0Y2PKV+ZupGd88S676eBC2yDyk2DNA
         qKzig4uU/NkYbh34k0idXT9bxT/Du8Zv13roU1e3DLyR/AVQiJ1n/ACh02ryA1ND7Ugp
         fmXzNXu7oUZ0gI9A3x0aDX/vgeh4TNtlczQnPgn0Ow7eMP3c53dIFrRCwOe+aXqCFUKD
         BqvA==
X-Gm-Message-State: APjAAAV9fu7BSK6A7RLwGaE8qcg5juHylQQbuvuTSyYr/Ya5/PWJrP++
        luu4d/LjCgNh2jXJpIMiT/Pp0u9rlvc=
X-Google-Smtp-Source: APXvYqwSnYp0dw2siKPWnZehuE8AefGZHBTsa0i6lp0bVV0oatu+ACGZwN/WbhhAoF976GJ+Fd5h1w==
X-Received: by 2002:aa7:8249:: with SMTP id e9mr12634355pfn.118.1572128045359;
        Sat, 26 Oct 2019 15:14:05 -0700 (PDT)
Received: from localhost ([2601:646:8a00:9810:9d6:9cca:ff8c:efe0])
        by smtp.gmail.com with ESMTPSA id k7sm6252281pfk.55.2019.10.26.15.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2019 15:14:04 -0700 (PDT)
Date:   Sat, 26 Oct 2019 15:14:03 -0700
From:   Paul Burton <paulburton@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [GIT PULL] MIPS fixes
Message-ID: <20191026221403.mfcxqs6yxgkl5ufx@pburton-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7fafao3awoilacds"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7fafao3awoilacds
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Here are a few small MIPS fixes; please pull.

Thanks,
    Paul


The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:

  Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git tags/mips_fixes_5.4_3

for you to fetch changes up to b42aa3fd5957e4daf4b69129e5ce752a2a53e7d6:

  MIPS: tlbex: Fix build_restore_pagemask KScratch restore (2019-10-23 21:12:49 -0700)

----------------------------------------------------------------
A few MIPS fixes:

- Fix VDSO time-related function behavior for systems where we need to
  fall back to syscalls, but were instead returning bogus results.

- A fix to TLB exception handlers for Cavium Octeon systems where they
  would inadvertently clobber the $1/$at register.

- A build fix for bcm63xx configurations.

- Switch to using my @kernel.org email address.

----------------------------------------------------------------
Jonas Gorski (1):
      MIPS: bmips: mark exception vectors as char arrays

Paul Burton (2):
      MAINTAINERS: Use @kernel.org address for Paul Burton
      MIPS: tlbex: Fix build_restore_pagemask KScratch restore

Vincenzo Frascino (1):
      mips: vdso: Fix __arch_get_hw_counter()

 .mailmap                                  |  3 ++-
 MAINTAINERS                               | 10 +++++-----
 arch/mips/bcm63xx/prom.c                  |  2 +-
 arch/mips/include/asm/bmips.h             | 10 +++++-----
 arch/mips/include/asm/vdso/gettimeofday.h |  4 +++-
 arch/mips/kernel/smp-bmips.c              |  8 ++++----
 arch/mips/mm/tlbex.c                      | 23 +++++++++++++++--------
 7 files changed, 35 insertions(+), 25 deletions(-)

--7fafao3awoilacds
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRgLjeFAZEXQzy86/s+p5+stXUA3QUCXbTFKwAKCRA+p5+stXUA
3RTNAP4tmpgLLDHBKXYn5qWtfHoW/ctiZdSoeZhxnP9y79D9JAD9EIzhEkfvPgEH
zKmSwtZbXLHW1m0+Lv+iKZJg9t3giAI=
=tAQO
-----END PGP SIGNATURE-----

--7fafao3awoilacds--
