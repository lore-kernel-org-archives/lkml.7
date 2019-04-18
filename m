Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8A9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184CB2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 04:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="jaMpsNJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfDREOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 00:14:16 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53937 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbfDREOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 00:14:16 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44l5Mm3d79z9s3l;
        Thu, 18 Apr 2019 14:14:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1555560853;
        bh=P3F7TqdXZAwYdJIugEs//zkAsdTMjOeOGfu1ll05HVc=;
        h=Date:From:To:Cc:Subject:From;
        b=jaMpsNJNofWBBEOgg9FUweba/VS5QbtttGtloqxN5dpoCyGuxea1EsAv0vLMSRWyn
         i4WvT4Uywj25McS+6f/0Ln6p9vF7xIKcN2cL6e1oHsXCenLRxQFArB4LivI2Fz8hjV
         eNOXtWaNG+SHUTCk4o10yg6vxpenNxa4hSVy3JeDoLstJyDQce919BoTIwQ5s4jRrJ
         i+YLoll2C4AqfaoydzmGBMjXegve/7RccjANfD97PUWdOBHVriC1HSQqkIT/RdILyH
         czA55CS8wrVADn5JF4qq+gaPkKlccDUOEuh8F9ZMsqaVclHAKaYUwPkHhKY9RhiAxj
         0BkNiFhAr9DQA==
Date:   Thu, 18 Apr 2019 14:14:11 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Subject: linux-next: manual merge of the tip tree with the printk tree
Message-ID: <20190418141411.417e5c99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_vOeBQlSfJaWe6hFJ8BwoxI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_vOeBQlSfJaWe6hFJ8BwoxI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/kernel/irq_64.c

between commit:

  d75f773c86a2 ("treewide: Switch printk users from %pf and %pF to %ps and =
%pS, respectively")

from the printk tree and commit:

  117ed4548541 ("x86/irq/64: Remove stack overflow debug code")

from the tip tree.

I fixed it up (the latter removed taht code updated by the former) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/_vOeBQlSfJaWe6hFJ8BwoxI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAly3+ZMACgkQAVBC80lX
0GzMbwgAhbS4CbE61NbDYUAffPKO7r8e31VCo7CsSPAWcztIdusvrFELeMe0A8J0
ut0F75yv4xCSNrM7aMM7nO+k3wajCecGmXZqzjExqQ+qVZJhxUOP54TYcwPeCI4I
hyLSpasLKjD/UzRZG6P82CeUaJBVNRdz9QWg+UJx9aabObHMy2QfxNNu3J+XkU8S
mroxvEoHc1mLtDHIH9+251k0rznFsvaT7Ih+MR/TUCesXLY/Gm66aujZk3IXaulg
MvUPbokNbifYQ3y/rs+FtQ3oSbLzkhyLzMb5fUf/TIob97GJexphqbYJtKacCELW
XVAHUnSzuYbv+lW91g55FDrnwE0M4A==
=paty
-----END PGP SIGNATURE-----

--Sig_/_vOeBQlSfJaWe6hFJ8BwoxI--
