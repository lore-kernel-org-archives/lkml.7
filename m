Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F32C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 478B52082C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 09:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfFNJjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 05:39:18 -0400
Received: from 8bytes.org ([81.169.241.247]:43896 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726831AbfFNJjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 05:39:17 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 78CBC396; Fri, 14 Jun 2019 11:39:16 +0200 (CEST)
Date:   Fri, 14 Jun 2019 11:39:15 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.2-rc4
Message-ID: <20190614093854.GA10155@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.2-rc4

for you to fetch changes up to 4e4abae311e4b44aaf61f18a826fd7136037f199:

  iommu/arm-smmu: Avoid constant zero in TLBI writes (2019-06-12 10:08:56 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.2-rc4

Including:

	- Three Fixes for Intel VT-d to fix a potential dead-lock, a
	  formatting fix and a bit setting fix.

	- One fix for the ARM-SMMU to make it work on some platforms
	  with sub-optimal SMMU emulation.

----------------------------------------------------------------
Dave Jiang (1):
      iommu/vt-d: Fix lock inversion between iommu->lock and device_domain_lock

Lu Baolu (2):
      iommu: Add missing new line for dma type
      iommu/vt-d: Set the right field for Page Walk Snoop

Robin Murphy (1):
      iommu/arm-smmu: Avoid constant zero in TLBI writes

 drivers/iommu/arm-smmu.c    | 15 ++++++++++++---
 drivers/iommu/intel-iommu.c |  7 ++++---
 drivers/iommu/intel-pasid.c |  2 +-
 drivers/iommu/iommu.c       |  2 +-
 4 files changed, 18 insertions(+), 8 deletions(-)

Please pull.

Thanks,

	Joerg

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl0Day4ACgkQK/BELZcB
GuN4XQ/9ESs/R57pgy5JsASOyxos6MfTmVTEBk3lKl2TIB0CUs9P8KMp8etYT/kI
Uk0UefkoWyiXpUWmdqQ8SGirAwoV7qHTDNVVbIjDTogjrMEYllPohG9Gli94PcJO
/Fgoq1MEv5dibOKSctR3zsCzRwr0bhjJVNezQxvwVUvZmwee6dlpVg279Xki5sia
H/zzsiCt69fqLT2mlUCo96GsbAJPlLHXNZa1Nrm306GL9LvxtTHfTWq9vmVKBpzI
e9bRQYNUMEuW+QOfuxcKtBf4oNN3nMrIVjq7YIsMPUyjkvSSk7jDN1rtZOERg583
dEL1pgjIZ1HVdjvZaefRT794PDlC+199FPSmKOzMWGvZ3QTymUHjUg379PkJkUC1
dTfNg7ahdggj/yzmEs1ZFg8Pwz3ZMdnoLOWRNRg+VPVMianvp1EOVvUCZPvJhE6S
grgtsvJPbrJZc++zCevSQSZqqfzGmhyHUWBhIbme9Ia6iwEMzCP3z8Lq4SwKUO83
/mjw84X1ve/x93kvr6jOlOzJVKV+bsH+ETGAc3OTkOMqA9P2cjf2o3oGHgDcahtC
Sc4QkoC5rHZgIOgierv+iwvGBj3SvCTnEYH4qBvMOHIzPUd3ugpgKKXf5BnyekYP
3ydQx9K9oDXzisCJY9TQXyBT7dowF7TbCKmJFsND5DYBeH3b4kg=
=uyv9
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
