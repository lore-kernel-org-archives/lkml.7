Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C91C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 00:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DF75208CB
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 00:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="m/APnq7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfEMAtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 20:49:35 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59617 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727029AbfEMAtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 20:49:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 452Mf34pMMz9s00;
        Mon, 13 May 2019 10:49:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557708572;
        bh=RXiwC6MF0vkExHV24ZK3p1DFZr32r3dU8Rx73+YqEbQ=;
        h=Date:From:To:Cc:Subject:From;
        b=m/APnq7k9eni2Fq0SHS8bm6GkxeSUb8T+qi6bjP00koD+0wtHhnvoZXhdFUEp/gsr
         1fFZRUfdtXA+3cBfVHRyg1U5gTcDaaX2z2R2yODsiKyNFPu/cMT7fh0dWj/LbDFKPc
         WFccAr2yXCO61ipUXUYZsL4HxV++VGJPhB1kmpP9W5CBHA8WCexMjEnnOIgKhIMlBI
         h1oEeNt56zMe6dIfMAzzAcOB4SpY0SSnAg2evMuGvu996RnMO06sEhPojGrVUmB1y+
         7SwFqaDyBSRO5vkH81s6Xs3w239eACZ0gnzxOkaawDOZ+zPt455uuMBlO6gw0ukR+R
         n9P0RPH52GhSQ==
Date:   Mon, 13 May 2019 10:49:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Talel Shenhar <talel@amazon.com>
Subject: linux-next: manual merge of the thermal-soc tree with Linus' tree
Message-ID: <20190513104928.0265b40f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/guncOVbWEmKuoXHJ+5r=YwH"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/guncOVbWEmKuoXHJ+5r=YwH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the thermal-soc tree got a conflict in:

  MAINTAINERS

between commit:

  f23afd75fc99 ("RDMA/efa: Add driver to Kconfig/Makefile")

from Linus' tree and commit:

  7e34eb7dd067 ("thermal: Introduce Amazon's Annapurna Labs Thermal Driver")

from the thermal-soc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index 2ff031b5e620,7defe065470d..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -745,15 -744,12 +745,21 @@@ S:	Supporte
  F:	Documentation/networking/device_drivers/amazon/ena.txt
  F:	drivers/net/ethernet/amazon/
 =20
+ AMAZON ANNAPURNA LABS THERMAL MMIO DRIVER
+ M:	Talel Shenhar <talel@amazon.com>
+ S:	Maintained
+ F:	Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
+ F:	drivers/thermal/thermal_mmio.c
+=20
 +AMAZON RDMA EFA DRIVER
 +M:	Gal Pressman <galpress@amazon.com>
 +R:	Yossi Leybovich <sleybo@amazon.com>
 +L:	linux-rdma@vger.kernel.org
 +Q:	https://patchwork.kernel.org/project/linux-rdma/list/
 +S:	Supported
 +F:	drivers/infiniband/hw/efa/
 +F:	include/uapi/rdma/efa-abi.h
 +
  AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER
  M:	Tom Lendacky <thomas.lendacky@amd.com>
  M:	Gary Hook <gary.hook@amd.com>

--Sig_/guncOVbWEmKuoXHJ+5r=YwH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzYvxgACgkQAVBC80lX
0GyvtAf/cZ+z0g02uhGdK2xyMyYYXeQpeXq54Mwf1Rib2a9aiyUC+L9H2KyE3Oc8
+AftI2g1oL4jkY8iEnnKsZ+weWzD4wNtTW8MTnTw98v5Pb2AHUxsY10eyVkrvDQR
8TVXQK9Bpst6OdebVjortGVAUMbzEn/GkH+EJhlBY5+nNc9smzon9CjaoWwagXF+
gbq4nvhUHQC1HBX+VCJZuh1l7dqYhp8MfD8Nuf33aI6YjFJF6plefHQ8AvoAEwqC
gfLKGwpvERmWHT5oK8AXzOPeCkNkXzQPVOtTKivpYlNkYoQPIxtXe9v6JDut+j5c
Z6HMftc6xcGsCW14Z+w8nmB/bOPxzg==
=ja3g
-----END PGP SIGNATURE-----

--Sig_/guncOVbWEmKuoXHJ+5r=YwH--
