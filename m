Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A87C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4CA214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 04:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="kuy7lMgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfFKEbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 00:31:44 -0400
Received: from ozlabs.org ([203.11.71.1]:54131 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfFKEbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:31:44 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45NHC12PXnz9s4Y;
        Tue, 11 Jun 2019 14:31:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560227501;
        bh=AdCCbWYS8wIxzvqOOIihi4/d78PPt00vkrmvnznb5Dk=;
        h=Date:From:To:Cc:Subject:From;
        b=kuy7lMgUJFwVZgzPAk201y2cniRiWaY5m0Pzol8MyWEqSzsJMtT6e0/qgpWg15KYb
         +a10BYgj+ACK0GHALE2zlcbZkwEM6HQ/W5TJb2gXKPFYjvbK7J9hNybQSgwaOoiS+y
         oE8z/wGNQfBYvJqhePLE8INtMS44WCtDfE+8WUVeHnqBZDYmTzJI9iByoK3MCNTLkG
         l4g+zo/CKKNiYPUFahXar2olp60/edtZJ0PZu2ZINKlYltiwuhYBsH32qAlKbEWGQ8
         N97EWGJlw5juiRb5L6r33ghaU7vK/OE5dMqfUdfkBXbbRBUYQXeJAJ0UzizNgOrneS
         EYq7pP7kPntoA==
Date:   Tue, 11 Jun 2019 14:31:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: linux-next: manual merge of the mfd tree with Linus' tree
Message-ID: <20190611143139.174e3eec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/5umunqededOQoV7r75zUz7/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5umunqededOQoV7r75zUz7/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  include/linux/mfd/cros_ec_commands.h

between commit:

  9c92ab619141 ("treewide: Replace GPLv2 boilerplate/reference with SPDX - =
rule 282")

from Linus' tree and commit:

  2769bd79a915 ("mfd: cros_ec: Update license term")

from the mfd tree.

I fixed it up (I use the SPDX tag from the former and the later change
to the comment from the latter) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/5umunqededOQoV7r75zUz7/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz/LqsACgkQAVBC80lX
0Gyipwf/TG3CER5ZZi0mDfQLl3i/+fCIAntcXgf8Uk72mMSNDPQMU++y92Idx3P6
SwC3yO9lR2hFzIBIMlJZFCktwStVklV4grNf6K2vD2sVuWoSkNYJDR/Ve0eJXp3C
0vxeefnrtnp4VGE6Lr/eLe0c9FoS+4LtNr3mwZH3Bk9Z83fzYfMhmqMysjAD1XRI
lfthvUpjWPWoB9ziLBCWr3l+XckgmLXxs9OE0NfaNgAojYQwuBokBOo1zbEnb9hh
6c51S9/9VxWUNGYCOLHdjt769ZBKmPnmJxexkBrAXHjS2qoMhab4XgkhsbeUkkwe
JNE3a30qUsJ/Z8/njo1gCIWmkrxE4g==
=SuZT
-----END PGP SIGNATURE-----

--Sig_/5umunqededOQoV7r75zUz7/--
