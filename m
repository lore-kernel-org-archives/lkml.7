Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7AFC28CC6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F77928051
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="QoJ+gWlW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfFCJuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 05:50:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:51795 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfFCJuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 05:50:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45HVff5rs6z9s4V;
        Mon,  3 Jun 2019 19:50:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1559555436;
        bh=vhY0kokUcUkFOU3lj9cjTwC2KAuA/uoQnNufYlcVcnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QoJ+gWlWFzaP3ZpzUUOovUV/R94v2s1tumzbtenF2SSUOfZ37YSq5uUXifWZ3amFi
         VX4QuZOdYtcxN7VsX4YlzZxN0z6kkRJlGKhP+d1Ssb0L4FKCAdyNKdkeU6/nJoiFwg
         WS1//h56etyxwdcQFWSH6fv/VjDcbc407d0+PDUrosozJftVxSs257gDQn0LOo3TCk
         pIRnNtOBGTUxc4uKwWHFGSji3Ip+DCIW/y47Q0EBALPkFp6WTfbDRCnVVsMN7dYxp+
         JBBmyjDapbLsZ6uEUBmmFB06SNPHqArffofQUWyRirPyJmM9zwW6jAuN1rAkhlVZcz
         aiKA617962JQQ==
Date:   Mon, 3 Jun 2019 19:50:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: linux-next: unable to fetch the drm-intel-fixes tree
Message-ID: <20190603195018.2b7d5650@canb.auug.org.au>
In-Reply-To: <20190603073103.GC21222@phenom.ffwll.local>
References: <20190603082051.273a014c@canb.auug.org.au>
        <20190603110403.0412ed22@canb.auug.org.au>
        <20190603073103.GC21222@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_//JwQn17N9SqUiY8Nnw9PZsD"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//JwQn17N9SqUiY8Nnw9PZsD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Mon, 3 Jun 2019 09:31:03 +0200 Daniel Vetter <daniel@ffwll.ch> wrote:
>
> drm.git too I guess?

No, I fetch that from git://git.freedesktop.org/ which seems to answer.

> But yeah fd.o anongit keeled over over the w/e :-( Admins not yet awake,
> so can't tell you what's up.

No worries, I will just keep using what I have previously fetched.

--=20
Cheers,
Stephen Rothwell

--Sig_//JwQn17N9SqUiY8Nnw9PZsD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlz07VoACgkQAVBC80lX
0GzFTgf+IsAiY4vcv67JmXh8J250uxzWfqRZnd+JaMvMMjoe+z170eoKbfTn4f95
jsYo+OaQfET7cvpoeeWO8CcF3IJDIE2Q+Z0/yARzvwvoIInN9ddwZ4U+zUwutBQm
Ij1j14Ct+mGmGWwyWI7u9PVnMZTsgV5hrNOMbB86NEYbWr/GcfgcmLkX/uQTcBfp
jLDZfkBCJ0maM8HeeHH83gEWoDG3/VY4gTcbMoFamcfsLUAoWEW3RVJdrvEN37En
XIx+EsGZ6H35DqingsPw/SJ+T7NAavXgFevVSNE7b/z3aP2bfJTHdeZyAKzwZAXP
1XSnbB8I6J5F4ISJ+Zn7NTHO5yiOQg==
=QKuk
-----END PGP SIGNATURE-----

--Sig_//JwQn17N9SqUiY8Nnw9PZsD--
