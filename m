Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6912BC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44D9A206F4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfKQSzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 13:55:18 -0500
Received: from 8bytes.org ([81.169.241.247]:52120 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfKQSzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 13:55:17 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 81C9E401; Sun, 17 Nov 2019 19:55:16 +0100 (CET)
Date:   Sun, 17 Nov 2019 19:55:15 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.4-rc7
Message-ID: <20191117185507.GA2578@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 31f4f5b495a62c9a8b15b1c3581acd5efeb9af8c:

  Linux 5.4-rc7 (2019-11-10 16:17:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.4-rc7

for you to fetch changes up to 4e7120d79edb31e4ee68e6f8421448e4603be1e9:

  iommu/vt-d: Fix QI_DEV_IOTLB_PFSID and QI_DEV_EIOTLB_PFSID macros (2019-11-11 16:10:54 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.4-rc7

Including:

	- Fix for Intel IOMMU to correct invalidation commands
	  when in SVA mode.

	- Update MAINTAINERS entry for Intel IOMMU

----------------------------------------------------------------
Eric Auger (1):
      iommu/vt-d: Fix QI_DEV_IOTLB_PFSID and QI_DEV_EIOTLB_PFSID macros

Lu Baolu (1):
      MAINTAINERS: Update for INTEL IOMMU (VT-d) entry

 MAINTAINERS                 | 7 +++++--
 include/linux/intel-iommu.h | 6 ++++--
 2 files changed, 9 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl3Rl4oACgkQK/BELZcB
GuOL8A//a0Max/LICckgUSaguAP+EfNssZszVwrVg8+Nq6/FCH9vGy1JZb6xXIYF
xOtdO1B6j3OkGjOtLNMOGfc2qUN5K9tBmmk3OhXcbg1oOD/6b3tQ02BSVTaVAmy4
JyQHsZlFqLFvivxR8Stkr6pki91pVN1Kfe3OAh7Hu+9vh18pHGGpkpHH8U2V23lv
5Nof0OwZ6uq15kvAUET+6Oniw8C/haanE0dwmT1+SyzqdTqVZu9d9OY6M0N3yPpm
X0UaLQQ6iS45qae4EQXTVSq225yc2OVcdD3R0Rgf9/TEAOpjcB5AmYV6m2oLoLN0
101uHZu5FQ58aGY+Py0jRj9yalb8C+C09X0o3QF9iQRMWa4aSuUC6ceS08iD+NvU
pLGsRbyZMWC1rBAkeTP+xlWAQ/0WeRx4ebE4egVoh0r+ScDcV2bbFxZbOsSie1Jr
UQmpt6k3Uo+Yrxya9509YfzIdaY3SD8xlxYxmo64f/WwcWSCOgDLaXc/VdG9Tofk
mdAFeLfdC2i1IlsedBKSp0CgQuCHrLDauYYMLI9u3tXjPCTvsGxuLv5xkq3uF+rZ
23I1buo43g21RO93JuV5fNWf8vsJnJcxRY0w/08p73UCTceDfj6uTUooBt4e+ln3
2LPNkWDfaCiaCIvBh6oLL5UhITqSsQ/Z4XG4XAYtOFbWp1RrQws=
=DKzr
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
