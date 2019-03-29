Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFC4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8592173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfC2Q0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:26:44 -0400
Received: from 8bytes.org ([81.169.241.247]:59788 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbfC2Q0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:26:44 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6E544303; Fri, 29 Mar 2019 17:26:43 +0100 (CET)
Date:   Fri, 29 Mar 2019 17:26:42 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.1-rc3
Message-ID: <20190329162636.GA29901@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.1-rc3

for you to fetch changes up to 8aafaaf2212192012f5bae305bb31cdf7681d777:

  iommu/amd: Reserve exclusion range in iova-domain (2019-03-29 17:12:57 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.1-rc3

Including:

	- Fix a bug in the AMD IOMMU driver not handling exclusion ranges
	  correctly. In fact the driver did not reserve these ranges for
	  IOVA allocations, so that dma-handles could be allocated in an
	  exclusion range, leading to data corruption. Exclusion ranges
	  have not been used by any firmware up to now, so this issue
	  remained undiscovered for quite some time.

	- Fix wrong warning messages that the IOMMU core code prints
	  when it tries to allocate the default domain for an iommu
	  group and the driver does not support any of the default
	  domain types (like Intel VT-d).

----------------------------------------------------------------
Joerg Roedel (2):
      iommu: Don't print warning when IOMMU driver only supports unmanaged domains
      iommu/amd: Reserve exclusion range in iova-domain

 drivers/iommu/amd_iommu.c       | 9 ++++++---
 drivers/iommu/amd_iommu_init.c  | 7 ++++---
 drivers/iommu/amd_iommu_types.h | 2 ++
 drivers/iommu/iommu.c           | 8 +++++---
 4 files changed, 17 insertions(+), 9 deletions(-)

Please pull.

Thanks,

	Joerg

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAlyeRzwACgkQK/BELZcB
GuM71g/8DR8/HcnbEjWjYEEeSRRreyOO+oKku8wW7khaK8+rQ3jjn9qQ/pVYaImv
wZmuF4GDO51r+xZzjOxavKEYYHTrc3jvaK8JNcmVJzZKyOopm/F9Foy/sBrKgMXd
JttxqISIM1zAE0G5Nvx+jyx4PIp5qyy8w+S9L1srooRHCi6WYaIDajIbx1sYhLtb
cLUqk1whM24kBQFEAETidizoCczGGzmp7hKuTUMVIKyOyFETYcRUleITToVY18sY
Spv/S2QzI/rx49Kb2D+AlEMy3RyIFO26eltOk8ecyCWf3TVgrwjLFc3pmv22Bq6u
yoqSrpXcFilK2ZMef9ZWC8phtI5J3tSY9uAJAJdjCDx8tlkug2kD+IxrDXTYddrF
1fSfpHogXLirVKvVTgaCCnNMKRZGA+UM5lLjDoMbhsKzNh22sAxslbYP/3GQVHPK
TiKtRZGYKlHSIzn3yFbak7I8Kz8R6m+mOLPAf4WwCfFphINEX1K2ybYumVE9/MgS
4Z+pVn28EcXnbDvCxJXoZdveSPo3dmEJAiEsWv2AFt4Rp4iifxo0/2NxP3NymBlD
mM10O+SjHhLML6+jtQH6x8arJEvO9rdQtbtlvlJDVtlgH/ps5l8OS+FUSu14X7I9
U1ViaI+lA68CsooAEohpDFC+66AyaboOoiaNzuy7hO2y3isOyKE=
=ABZo
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
