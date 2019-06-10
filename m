Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55354C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A76A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 18:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="I6qPHaSi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388573AbfFJSmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 14:42:03 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55007 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387398AbfFJSmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 14:42:03 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45N26c0Wd8z9sNT;
        Tue, 11 Jun 2019 04:41:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560192120;
        bh=td/hw+So+4iP64koL8dtNxsx3PBw/MlsVMwrb15FM+o=;
        h=Date:From:To:Cc:Subject:From;
        b=I6qPHaSiRCxoFnKjY7uYRCCJpUiD+uaaORFGai5vzIrYKZfBxplWfCFQVyrgZtfYV
         zTOmUN2TYatHfD++MT54VaUBGsAOtREqhMJOP00PPtMloigbNyP4rsIAdKZbcGRP8I
         LX58YRWGn+88aaddqxxAnptCfiOmpr+jJknZlm29Fjf7jklFNzg5k1yuoLPQoV/lj/
         +N1S1nrJ68zmvDyW7TkFoPD79IdKcgnrMudb9+A8MzCRVjDmgKcXL2JmmYP3gjoEuK
         IqIlOZIUnEeLs0uCOMX32VFWkYFMiLM6felK0ahKLECCg10z6Yj1L49XtDJVZaH55j
         QXzOLTAQatK2Q==
Date:   Tue, 11 Jun 2019 04:41:59 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: linux-next: Fixes tag needs some work in the sound-asoc-fixes tree
Message-ID: <20190611044159.404eeca8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/or3r.EkbKmEUakTMut__poe"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/or3r.EkbKmEUakTMut__poe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  495f926c68dd ("ASoC: core: Fix deadlock in snd_soc_instantiate_card()")

Fixes tag

  Fixes: 34ac3c3eb8 (ASoC: core: lock client_mutex while removing

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").
  - Subject has leading but no trailing parentheses

Please do not split FIxe tags over more than one line.

--=20
Cheers,
Stephen Rothwell

--Sig_/or3r.EkbKmEUakTMut__poe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz+pHcACgkQAVBC80lX
0GyD7gf/Xi/QM17HlMan9fAoHBii6N9Zq96NqMlChelvws87hgJH2k5wmXNT0qUV
2pt7vBsupUaLnk35eayTSjqImMuP4z/gkiUmRZQsfajcaNdN4SJaPfuCxQBMMhrD
EhVOFPPdfiW4qAqgoR0cmh9FbDq8eI6JEm4akiX22kCOPUgiUTwwy76Mj3uImJWI
A2qWwZCsmZAI4IlGDTuYnw3GVx5w+dbUaqbDsl4xdDQI2ayuwMDHUKbzUUh/OR76
e6wfxdXioTDcUyJrp/oWkaeQyluOjMCKR4Pd96i4lGACVmZHso5F3a01HwAL6Yrp
ejPah6E40m15+T0jDVTId6e0SYcxXg==
=Kz7Z
-----END PGP SIGNATURE-----

--Sig_/or3r.EkbKmEUakTMut__poe--
