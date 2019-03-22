Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F320C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F0D2190A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbfCVLWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:22:33 -0400
Received: from 8bytes.org ([81.169.241.247]:58632 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728789AbfCVLWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:22:31 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 4D293259; Fri, 22 Mar 2019 12:22:30 +0100 (CET)
Date:   Fri, 22 Mar 2019 12:22:29 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [git pull] IOMMU Fixes for Linux v5.1-rc1
Message-ID: <20190322112224.GA22496@8bytes.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v5.1-rc2

for you to fetch changes up to 84c11e4df5aa4955acaa441f0cf1cb2e50daf64b:

  iommu/vt-d: Save the right domain ID used by hardware (2019-03-22 12:02:27 +0100)

----------------------------------------------------------------
IOMMU Fixes for Linux v5.1-rc2

Including:

	- AMD IOMMU fix for sg-mapping with sg->offset > PAGE_SIZE

	- Fix for IOVA code to trigger the slow-path less often

	- Two fixes for Intel VT-d to avoid writing to read-onl registers and
	  to flush the right domain id for the default domains in scalable
	  mode

----------------------------------------------------------------
Lu Baolu (2):
      iommu/vt-d: Check capability before disabling protected memory
      iommu/vt-d: Save the right domain ID used by hardware

Robert Richter (1):
      iommu/iova: Fix tracking of recently failed iova address

Stanislaw Gruszka (1):
      iommu/amd: fix sg->dma_address for sg->offset bigger than PAGE_SIZE

 drivers/iommu/amd_iommu.c   | 7 ++++++-
 drivers/iommu/intel-iommu.c | 5 ++++-
 drivers/iommu/iova.c        | 5 +++--
 3 files changed, 13 insertions(+), 4 deletions(-)

Please pull.

Thanks,

	Joerg

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEr9jSbILcajRFYWYyK/BELZcBGuMFAlyUxXAACgkQK/BELZcB
GuOOXA//flT1sZ7JMkiPtVO3sH67adhWnge3n++mWn7SEjSw4s4HJ+Bvu7VztrrG
yq/EifBsUncZbd/LsCDypNBSVRNinnro+NJbrlpn7Bxg+Rgyw6Y5y2fqh+C/5NA9
xLVxwETJYuv9koK1QqbfV2I2maZ2Xn8WwBNK8XvvsqCrtnahX/xuybQZDqqCZwJh
swEqBPzqOmIQocUAQf66XYQBGFjz/Rv5iTvJHY/XMVIS9TCwidtxvnrtesm9unCx
+i45CGJ9J55f2iEVPyPQlpkP9eCd+TR3WIc42No56copsBA/o7upSAji8V2acoSC
uLv9bUEy7S7s9rjnD4usRxIixTP876ehOw8Agq3n3XsMobZBYXOpewJAB0TTaxmK
6cMYV73cErOzRNylCVeAI9Z6i1ztniXITM+KapgAc97DlpDwYyvDIJj4pGvum1P1
ZXT56EparVhPBWeBP6gHlBYun5bJJ99Q3VPDvG+TzET3v9Uov2v+K8/LP7Fi7IYP
pz9JtEtlV4Dnbc9Gzn09PkmbAzposcfj7UTgaJ5ZRASbQ1VFR23SJ751EE3C0qM3
u0oEX0CV/uhlDa7/45FNwHe+bKAVyHPEYGAj8u2OMnxJSqFVTDmmVrt6Iw+h6XED
SI94psVbwBh5uxnx82wChlC2pIecf3Y5cCj45/kDzel6D2zqmqw=
=ZgKz
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
