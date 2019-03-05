Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46E6C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF7B204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 22:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551823288;
	bh=TAckDVuuwhxnYYY3WFegT1rA9jwVZ3kVUlFudMIqLOw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kLXbKLQrqbaSDGuAJ1DI2/4G9a+b6nyhg5OSm844TrFdD+sHbKJeBUx8agIF5tJcl
	 SUrNQUepuTv5Ql4lcYKzviX//fr6IUuCy0VkQ65TtduYPBevKciMadrtu24nZrsck9
	 ghKdHvKwDQRIX0jOpA4uim2GcKVW0yMVPTo4Kga4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCEWB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 17:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfCEWB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 17:01:26 -0500
Received: from earth.universe (unknown [185.216.33.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B78AA204EC;
        Tue,  5 Mar 2019 22:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551823285;
        bh=TAckDVuuwhxnYYY3WFegT1rA9jwVZ3kVUlFudMIqLOw=;
        h=Date:From:To:Cc:Subject:From;
        b=SQyOENHjt1ol0I/vW7CByvqxVuQmCpiMlnmTdWlOD3KiIdeZJqpZeXiMyMqobGAg2
         m0IFq9qT7THKO5IjAymaPDJ94a4gNn3u6zJ4Ce63xFzdqXV/aUq6BdU7emgBrzXP+d
         Q7qA9FTSIqJMhzZ/7FY7/MWbKrjFv+pMWRwPZUUM=
Received: by earth.universe (Postfix, from userid 1000)
        id 96AD23C0AE0; Tue,  5 Mar 2019 23:01:23 +0100 (CET)
Date:   Tue, 5 Mar 2019 23:01:23 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] hsi changes for hsi-5.1
Message-ID: <20190305220123.vxjgvbow2gcejxlw@earth.universe>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qs6etgsvd5a7s3gu"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qs6etgsvd5a7s3gu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-5.1

for you to fetch changes up to 1ff85bfa1614df6cacec780cd5922dc0b1c340c7:

  HSI: omap_ssi_port: fix debugfs_simple_attr.cocci warnings (2019-02-14 12:36:21 +0100)

----------------------------------------------------------------
HSI changes for the 5.1 series

* replace DEFINE_SIMPLE_ATTRIBUTE with DEFINE_DEBUGFS_ATTRIBUTE

----------------------------------------------------------------
YueHaibing (1):
      HSI: omap_ssi_port: fix debugfs_simple_attr.cocci warnings

 drivers/hsi/controllers/omap_ssi_port.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--qs6etgsvd5a7s3gu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlx+8bMACgkQ2O7X88g7
+pr8dA//cJh7r+mKIhMi60feOyjTn7kxWeRS7u32rVj8rhIT5zb89FBIbYgvtEvx
NXYqEy6q64X+0R5XUHy5EoEzDTHC7kkleUnywRKpAaGV4oaIywMixHgPcPNo1edM
+kZyn6LqO0bcC1d9Cvuo7wIvmLlQd3eALDpOk1rfrrthGnh6raRRecq8x+dyRNLs
sBz+afzGb6VwVStx4ONZK14s/Zoqw/OIZ1dHnvJQMZewOHkKgiLxrFOS0v//F7T7
NtCuFDeK/BzTaXegThkH7matlbwUHDQwtudbB25nTm0Xc1eJSQFoetNUnPI+A2BG
yYKuNto0ZOHw+5pKazzGLoXW4X1nDZt9JNnCRkmEbc8nHJ80ypSVDCdCVHIZCQIF
RwUO7ShrB4AAk1019b9yjyqyCmD0klnXw+9CP9Sz9ZwmJ6/TSmQdYjqMFgvGJ7mn
DoGvasKJYAxa8GTX+kJ1WeokXUhDyVZwdo6/yVV/bjNFGNwgyKNPfjTFK5K9mdYm
dQhmhbkmdgGVMZWiT+Zj9mUgzNamz3memn4jHbbf1Cm8Uzp5imIRvL6rZO+vDUTv
4yDbiRtaPRe6K+70jySQzrvyAqxxR4ecDcEYVL0fwxWMe1gmaC0qSNAez5gM1Qks
ZGsUkdE267ueGnQQ2hiDxI6zCJBUrKeNkvSCzSRXNM7wu5Hi430=
=0c2w
-----END PGP SIGNATURE-----

--qs6etgsvd5a7s3gu--
