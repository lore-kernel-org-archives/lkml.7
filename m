Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFC9C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B285214DE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbfIFPM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:12:29 -0400
Received: from 8bytes.org ([81.169.241.247]:53380 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730926AbfIFPM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:12:29 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C25EB2D9; Fri,  6 Sep 2019 17:12:27 +0200 (CEST)
Date:   Fri, 6 Sep 2019 17:12:26 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.3-rc7
Message-ID: <20190906151220.GA8420@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a55aa89aab90fae7c815b0551b07be37db359d76:

  Linux 5.3-rc6 (2019-08-25 12:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.3-rc7

for you to fetch changes up to 754265bcab78a9014f0f99cd35e0d610fcd7dfa7:

  iommu/amd: Fix race in increase_address_space() (2019-09-06 10:55:51 +0200)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.3-rc7

Including:

	* Revert for an Intel VT-d patch that caused problems for some
	  users.

	* Removal of a feature in the Intel VT-d driver that was never
	  supported in hardware. This qualifies as a fix because the
	  code for this feature sets reserved bits in the invalidation
	  queue descriptor, causing failed invalidations on real
	  hardware.

	* Two fixes for AMD IOMMU driver to fix a race condition and to
	  add a missing IOTLB flush when kernel is booted in kdump mode.

----------------------------------------------------------------
Jacob Pan (1):
      iommu/vt-d: Remove global page flush support

Joerg Roedel (1):
      iommu/amd: Fix race in increase_address_space()

Lu Baolu (1):
      Revert "iommu/vt-d: Avoid duplicated pci dma alias consideration"

Stuart Hayes (1):
      iommu/amd: Flush old domains in kdump kernel

 drivers/iommu/amd_iommu.c   | 40 ++++++++++++++++++++++++++++-----
 drivers/iommu/intel-iommu.c | 55 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/iommu/intel-svm.c   | 36 +++++++++++++----------------
 include/linux/intel-iommu.h |  3 ---
 4 files changed, 103 insertions(+), 31 deletions(-)

Please pull.

Thanks,

	Joerg

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAl1yd1QACgkQK/BELZcB
GuPzJw/9Fovs43Zte02ZZuzwcYPEkErhLi6mwB37Oj0u0MTzPf0zrYn6u0dn320N
xzTEfGYWFRp/PRIfwR5JiJsDU8BvlfCAJZEGp8sAnOTMto2AGG5rgZ4ZxVypK6vm
6bM92eSESQJjseyZTva4IZOF4qeWTgzO7voox84IgWHrWCoem5aS8Y1EVC69+uxa
EOH1TSb3TJLfOf0TKW3aDrftrTbtsvvliOFYLNHoUOx9iOkBzb/0XpL71r6x71dP
n9jNEpxVAJJNuM/oYK9j1UDASHH8Vxdqh0Joy47hhysiBlI9Nnv6rrE06BvVXq0O
ap4PSK9h3fNrDCvpF7G0gGapesieMzJH1Ogu9I1egm3sbD6VJZHz1XK2ynY69y+X
8ZMlPnQu1MDedmYcUj8WixJxTDZO69+nSUhVJF7VG4pmnizKjsjoBDjTpPnv1vwj
E23R4BvStG/44vNPYEps879U5xpjAKrnaq4JwVQD9C5fsiTFlmwcbZrFifllyhae
YpjNMzeifbhx+YQi8mq/4rBgSOZ4rh9qRxaN6iVs9lbN6WQvwMCI23g6Y3onZaIW
+RhJhq6d96yl/CzbUdesk7SWEBxI7INoPpmsKN2Z6+uolIBuRbM3amv4CH4G7IV/
czphzdovKPPmj625crlzchFg+rDOhVWjdcQEmdnBVQXeCTjt48o=
=DD9K
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
