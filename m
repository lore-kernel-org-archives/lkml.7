Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD5FC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 743AA20674
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 10:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="AoxFlhN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfFXKZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 06:25:03 -0400
Received: from ozlabs.org ([203.11.71.1]:33341 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfFXKZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 06:25:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45XQQf4wknz9s4Y;
        Mon, 24 Jun 2019 20:24:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561371900;
        bh=3UdhL4q3dcS767+2M1H3YpNFxA/F+kQLYVDA+P0NOS4=;
        h=Date:From:To:Cc:Subject:From;
        b=AoxFlhN7MMeI8ngeaQ2gP9qGSGZKbmbVLz3E/obOh/Z2tQk3Ds0CA1TMOeRTZHJKp
         bjEAURtYef/RrisMub3BNMeqwn1Ero4Y75PrEG3HV3OQwAiDYJcEvMseMz561Kf2J9
         AF1zaM6ov2hI6AIuvOix6lnKe6366ndrha/GBNwDSIxgNRXvBCmITjYU4oAIUxSTGs
         rAlG0JyxOscKnKjaEFFGPIUjbMlgK0rJnc8UMJzWysdb7NntOzE8L6QTPtFSplH4on
         vDdcTgAapR6ZDEdZTkaM55W3volwiGO5rOr3Fl3FvcCB7gyvOjfSZoM+1r88LbY1fz
         H796BDQV8sMzA==
Date:   Mon, 24 Jun 2019 20:24:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: linux-next: manual merge of the akpm-current tree with the tip tree
Message-ID: <20190624202455.0d849686@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/2AihEn+dJVp7LFfzr_tJwd3"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2AihEn+dJVp7LFfzr_tJwd3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  lib/debugobjects.c

between commit:

  d5f34153e526 ("debugobjects: Move printk out of db->lock critical section=
s")

from the tip tree and commit:

  8b6b497dfb11 ("lib/debugobjects.c: move printk out of db lock critical se=
ctions")

from the akpm-current tree.

I fixed it up (I reverted the akpm-current tree version) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/2AihEn+dJVp7LFfzr_tJwd3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0QpPcACgkQAVBC80lX
0GyN+Af+O8hfDeKXrXOPtny8Ch0jXaEupfqfoIXYqCbk9VGkxpIpzByVtm5tnnIz
BR7HRB2NMgblTfKCMP/BdxB5yz99HFwpMqvHg1FB4c9mP2YNzcOaO+p2d3qkra+C
fMpyoiab0ePiclZJA0zfRGFGkFjfXGWX29KoIP+zayQUGuTQRgINQKcSeMOXBLSa
K0Ev2Zsv37VrsCaRNAX3cn78WW1w16mBKIkWVfkyRjAhh3PQM6zvsW72Udsf8LID
o9W0+SrL3+y3zzNAzFDu/V/obY5ALSY7q4mKVXEkrS1kXCMo+KEGpLKCZu2dn3so
rLMlUJphtQz/uJj/bD+eJlzXke4r3Q==
=Qaxh
-----END PGP SIGNATURE-----

--Sig_/2AihEn+dJVp7LFfzr_tJwd3--
