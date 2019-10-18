Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C8CCA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0ED52064B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 15:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408855AbfJRPyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 11:54:11 -0400
Received: from 8bytes.org ([81.169.241.247]:48058 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727668AbfJRPyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 11:54:11 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5576C367; Fri, 18 Oct 2019 17:54:10 +0200 (CEST)
Date:   Fri, 18 Oct 2019 17:54:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.4-rc3
Message-ID: <20191018155403.GA9621@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.4-rc3

for you to fetch changes up to 46ac18c347b00be29b265c28209b0f3c38a1f142:

  iommu/amd: Check PM_LEVEL_SIZE() condition in locked section (2019-10-18 16:52:37 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.4-rc3:

Including:

	- Fixes for page-table issues on Mali GPUs

	- Missing free in an error path for ARM-SMMU

	- PASID decoding in the AMD IOMMU Event log code

	- Another update for the locking fixes in the AMD IOMMU driver

	- Reduce the calls to platform_get_irq() in the IPMMU-VMSA and
	  Rockchip IOMMUs to get rid of the warning message added to this
	  function recently

----------------------------------------------------------------
Geert Uytterhoeven (1):
      iommu/ipmmu-vmsa: Only call platform_get_irq() when interrupt is mandatory

Heiko Stuebner (1):
      iommu/rockchip: Don't use platform_get_irq to implicitly count irqs

Joerg Roedel (2):
      Merge branch 'for-joerg/arm-smmu/fixes' of git://git.kernel.org/.../will/linux into iommu/fixes
      iommu/amd: Check PM_LEVEL_SIZE() condition in locked section

Liu Xiang (1):
      iommu/arm-smmu: Free context bitmap in the err path of arm_smmu_init_domain_context

Robin Murphy (2):
      iommu/io-pgtable-arm: Correct Mali attributes
      iommu/io-pgtable-arm: Support all Mali configurations

Suthikulpanit, Suravee (1):
      iommu/amd: Fix incorrect PASID decoding from event log

 drivers/iommu/amd_iommu.c       | 12 +++++----
 drivers/iommu/amd_iommu_types.h |  4 +--
 drivers/iommu/arm-smmu.c        |  1 +
 drivers/iommu/io-pgtable-arm.c  | 58 ++++++++++++++++++++++++++++++++---------
 drivers/iommu/ipmmu-vmsa.c      |  3 +--
 drivers/iommu/rockchip-iommu.c  | 19 ++++++++++----
 6 files changed, 70 insertions(+), 27 deletions(-)

Please pull.

Thanks,

	Joerg

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl2p4BgACgkQK/BELZcB
GuO8sA/9HtDW6b8w/r2XJOcxP01hP59c9AveS1VNwR2KyBjZepprg9geSmLz921G
063ozZ02UJ4gIZ3R/7nJ9oisQ3C2UGZz8/apPVm+hLu3/ywYLLDucuXLGmzc4Yyj
62Ya2Mvu4InK6TunBxxARgWHBXEIJN915usyy9oAMTSZtlshvkwZU36SrArVAbCY
SXdF3lT8aHqRN2FTNQo4B1/kiW9lPWKnXmBqs/zt6kvOzxHQtiusdpYZK8nubm7B
J3a2vyWpflwsf9yxMI/3B1Nlb/+GQlodg1KEuK20hZc3V9Ov4MDEI6P2ZcTTUywR
qprVn7MERqtNHT9Pna2O4bj7ugPdp44p2dI4lXJBxdBIavYx0F+nCbvLh8qpoC2v
Lkz1kDqf1Cz5FrlYroOsFCZfTpLo3cgFomm/KyRZCD0rSJxxLd/irV8TsmLZe2GQ
6fKxoCMpkq4HaXdT0+nA5NclY9z/UWNS8KvhmsF9djhVmgiE/viZkFAnyBUncN0z
vpd0jfy5M6DHT1aqBEfciVo/plcNpyaR8OqgdkInILOMAAWL3BTpGDpUmvHEu6x0
rkOWSAcLXRTvb6EKxqOvSx3bwW2DnthPhqxa0nnuK/yrDSK/lrT0YOpL3Pl2hwsR
0p0iqqIeHYPaiW+anmnRlA7Jd50Su/CweuXGG6QBn4IdMhUUOfQ=
=2SpP
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
