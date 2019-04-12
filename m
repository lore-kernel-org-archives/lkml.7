Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B3EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 835EF2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 13:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfDLN3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 09:29:47 -0400
Received: from 8bytes.org ([81.169.241.247]:34454 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbfDLN3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 09:29:47 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D02622A4; Fri, 12 Apr 2019 15:29:45 +0200 (CEST)
Date:   Fri, 12 Apr 2019 15:29:44 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.1-rc4
Message-ID: <20190412132938.GA13555@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 15ade5d2e7775667cf191cf2f94327a4889f8b9d:

  Linux 5.1-rc4 (2019-04-07 14:09:59 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v5.1-rc5

for you to fetch changes up to 3c677d206210f53a4be972211066c0f1cd47fe12:

  iommu/amd: Set exclusion range correctly (2019-04-12 12:59:45 +0200)

----------------------------------------------------------------
IOMMU Fix for Linux v5.1-rc5

	- Fix an AMD IOMMU issue where the driver didn't correctly setup the
	  exclusion range in the hardware registers, resulting in exclusion
	  ranges being one page too big. This can cause data corruption of the
	  address of that last page is used by DMA operations.

----------------------------------------------------------------
Joerg Roedel (1):
      iommu/amd: Set exclusion range correctly

 drivers/iommu/amd_iommu_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please pull.

Thanks,

	Joerg

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAlywksIACgkQK/BELZcB
GuO9Uw/+NJ6SBq7Jxex3lfAJ0169Vejne8T92Zkqs+eLpdHSHhBRE+7DxXrpsXi9
d83Fg6cuPAa2igKNC0tPQI17k68VTCBJxInebb69FaqCHPtm29FGHSFCBE9gC00y
czDqfqFEkobLdMrP99Yok9RNqeK8TnZnanbieC4eo9rXsIf2t2iE8VwxR8wW9PGT
EcFf1Xc6/7RkcSvIHE5/Tn1ywmKBJgc9QmO+0OtjpQO/WU9Og2GbgyBWSnQA9MCh
Drz/91cOKz43sVKzPRoH/qRw3IRqYXEh3W92Y8PL4M1EzqIH/aZ3iLEwJnj1Xylz
mb6yBJB+PH8+E8iNVe+sSB35obHJkRP4QHWghLC3t24RvAfvTWib1pqFYcI9npr2
9AMcIB1myvl63qB7Bmwb48RZ9WtvL+oiTm1MyX3V424cgkpa7AAsjL4Bf/vQt7Rk
1KHTSJ9D5hOCbFCtic74vPcVrPy9KQf8zhyGdLkiSyczR2mDXoy0TL+3LTQ//Y2M
Lop9bRR4Y/6RLItNFVAej1sgjs9KdNuLoNnePwKt0sjlh+JhUNDtAoYMdVtKYbfL
5vdVrbDe8OfxZUIydoCm3mrq4TdzAvtTFFOuqvPW8qbywOljDswfmJ9CcFwkBWLt
BpLQdfMLi56FF7Jnmt4I+su6bfaY33v0JQBWIxp99LG+vWNVuWM=
=vUzi
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
