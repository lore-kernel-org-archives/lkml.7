Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890E5C31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61660214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 03:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="fu4WLvm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfFQDUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Jun 2019 23:20:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:37417 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727413AbfFQDUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jun 2019 23:20:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45RxL44gKHz9sBp;
        Mon, 17 Jun 2019 13:20:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560741630;
        bh=E/UjMzzNWzIgmLLzo+hdSHFAPtSWXV8GhaxPEJkzphk=;
        h=Date:From:To:Cc:Subject:From;
        b=fu4WLvm4Mw5YKmAtHV/Y3TXcMt8Pl/ZTQPTUWZRRDLQkh032RrbvwH76tKvs66agi
         SzIcbze6nzd3Z7a5Yi2YQmCwZjUFxqjugGbiItQpJ824VMdJqK761e5iO0D51ojyHh
         D0sgy/pPop3ZpjvpsBT1DmFRWoBqbBj3H8dSmvneicfGlKlBo6yM2qU2wKwODxT5zi
         jIy8PhVQ80ZQekLqKmrWX7hohMRGQkngSPVgZPGvgAyjKoTBMcpJOH5Mk52cc9f/Tc
         BU0KIA0b/jama+2c8BD5lAVPvq137q2WOj2bw/8fOWEndYYia4HqaP22pcjr6jgzgG
         /04RExVHDmCzg==
Date:   Mon, 17 Jun 2019 13:20:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: manual merge of the drm-intel tree with the pci tree
Message-ID: <20190617132027.3e34597d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/9kndnzh67+Mx8fK+8VeLJRh"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/9kndnzh67+Mx8fK+8VeLJRh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/i915_drv.h

between commit:

  151f4e2bdc7a ("docs: power: convert docs to ReST and rename to *.rst")

from the pci tree and commit:

  1bf676cc2dba ("drm/i915: move and rename i915_runtime_pm")

from the drm-intel tree.

I fixed it up (I just removed the struct definition form this files as
the latter did - its comment will need to be fixed up in its new file)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/9kndnzh67+Mx8fK+8VeLJRh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0HBvsACgkQAVBC80lX
0Gyk1ggAiwbMletwQoXyZZsEPGev6xTTFAiXKTVhxWibzPjsgFPeDzPPU8avptjH
vfQrvA5n+D1cxIhUBFZ9GtDqg3/tb1/pbwFinOqrCM5kmprNl4UjzeGbi705YWm1
OKY2GphAh/lhAB8cSIvjKcEOy54QBOgfkzoSgRNnhRUbgUSEDs5PYEaehocqpxxK
Z91kCr2QuH4ehARKWcPOog9rMNp2R/XzZy00C1vjboK4W3BPtpsIZR/R4Y9Rb3sF
QyCnyuhr+YpZKQxZwLwIqZn2raxkNe03UG/eKKQHhov+VLA5KgasT3hIbWHaCVTk
XFQC3TTTn1XvFV2jRXIIJkN+yoM8qA==
=hw7+
-----END PGP SIGNATURE-----

--Sig_/9kndnzh67+Mx8fK+8VeLJRh--
