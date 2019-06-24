Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B942C48BE8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB108205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 05:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QBuzV7eH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfFXFvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 01:51:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:41163 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbfFXFvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 01:51:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XJM36Cg4z9s7h;
        Mon, 24 Jun 2019 15:51:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561355488;
        bh=A2H0SbW8DGW0X8tBFZMR4MMlUkgu2U/0lJP6eVxZ4yQ=;
        h=Date:From:To:Cc:Subject:From;
        b=QBuzV7eHp+1EWjbKA/c95haXQE/B+HWwUv6LQGlYXbJXtfiuE/wJHLei8iiHpj3YE
         d8Xo4k99E8qRMFIHQypGEp0lc58Y23cWgYaRkcjE2YySlthSNY+cdCIZ3zCuK3tc0v
         cvFsUO0oswIsNRj126tyqOYSE0l5CzfPDl2APu1/HKcC/y9jfLeVSKbg9dq6cBl2BW
         9zpTNzOP54Ubek508o8vL1NkUa0AjAwIIyLzmtWMRanhMu2ZzLV0u/ydULv/nxXePG
         fAvoCYPHUVtdYCTrlFSqzeGNihCLVcuq2MXHFBPL21yoS6QE7827I7MXQjs9rd0KlP
         r/xTTAxlbGrTw==
Date:   Mon, 24 Jun 2019 15:51:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the devicetree tree with Linus' tree
Message-ID: <20190624155124.7bcae936@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/nVnfEbbmgtYUvDqa/+K1y91"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nVnfEbbmgtYUvDqa/+K1y91
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got conflicts in:

  scripts/dtc/Makefile.dtc
  scripts/dtc/libfdt/Makefile.libfdt

between commit:

  ec8f24b7faaf ("treewide: Add SPDX license identifier - Makefile/Kconfig")

from Linus' tree and commit:

  12869ecd5eef ("scripts/dtc: Update to upstream version v1.5.0-30-g702c1b6=
c0e73")

from the devicetree tree.

I fixed it up (I used the latter's SPDX tags as these come from an
upstream project) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/nVnfEbbmgtYUvDqa/+K1y91
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QZNwACgkQAVBC80lX
0Gx0rQgAjslL/D3eaQiEzoIy5IND9ZCSQvj3pBNrCFLJwm9k8CFktGQeszkfEybm
rvYmICZoZrlgs4FNSRtu72QSLA+WuaD4i7zBXtNH/kLS0cy5hk5R1pxpvdNCXOOB
j3sUba3oRnOJ68/CI4BlxqI4HQCQ1etwrOWmRB3iLsddIBB3Nnoy4nQn5biNV6pi
2OFdeSSfBi/oDxsflGFrNArm5EDRueRAj4X5C3dlvg60kvMpyxxhndZE8dOZPlRp
wWxla/nzrq/z5s2fI0HiBgnosDs75pUfD1sdfNoWW4qDxkT2XUVI7IscMOgNDU8x
TBVGt8N4k+B2ss8JI6jWxhO50FRPSA==
=9D7D
-----END PGP SIGNATURE-----

--Sig_/nVnfEbbmgtYUvDqa/+K1y91--
