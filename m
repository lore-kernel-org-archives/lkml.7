Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8DCC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 985CF2146F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rBcRkx/y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfGBM5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:57:46 -0400
Received: from ozlabs.org ([203.11.71.1]:59525 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfGBM5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:57:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45dPR91RCrz9sND;
        Tue,  2 Jul 2019 22:57:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562072263;
        bh=c8HFSJIbsKhcHkqCQUcnR2C5+bu7b0qkiVXwqTZscWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rBcRkx/yrmxHYVuNH6+gydiCLE+EpDprNWuw58Lg+rF/UuhVuGNSMoewj0gcu/fE/
         Nv3wa+Ufh0XXnN01KKF5Oz/DHskBSLqEGARnM3tLIds3d10niZz7ZPLoNmLCyd6NVd
         qVmrmuIZs5P1ekloF5bQW+nhc+Nse9CBZ/UHTCuguBdSUGDdb3eB3s1TCZwsXoXcCL
         ORhNAjEknpLlvQAdtN+95w+/8Unjtqz8w3ALi/QxVaSdEPmEpBqBPgL9F3id+DwlrJ
         hau6/yX4FhVfOlKzuCXSfkiVi2NhgJAQnN0P9zNVnOzibSFSU2981ZK9reMDn04Lyp
         ontWmwVP14QgQ==
Date:   Tue, 2 Jul 2019 22:57:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>
Subject: Re: linux-next: build failure after merge of the tip tree
Message-ID: <20190702225739.729332c4@canb.auug.org.au>
In-Reply-To: <20190702102832.GP20977@suse.cz>
References: <20190702153302.28e7948d@canb.auug.org.au>
        <20190702102832.GP20977@suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/+carHLLokJ73STF=D9yMtk0"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+carHLLokJ73STF=D9yMtk0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi David,

On Tue, 2 Jul 2019 12:28:32 +0200 David Sterba <dsterba@suse.cz> wrote:
>
> I can move the patches out of the for-5.3 branch and send them
> separately after the rename gets merged, they're merely adding the
> assertion and otherwise do not affect the rest of the code.
>=20
> Fixing that in another way would probably need more synchronization
> between the branches but I don't think it's necessary in this case. The
> next for-next snapshot branch will fix the compilation issue.

Its a simple enough conflict for Linus to fix up as long as someone
tells him to expect it ...

--=20
Cheers,
Stephen Rothwell

--Sig_/+carHLLokJ73STF=D9yMtk0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0bVMMACgkQAVBC80lX
0Gxg6Qf9FUPLmhiCcxi8HsFZk2wJtLaL2E1CVl5gcVJg/xsnqOQnyaIrTkjJJYJL
oYT6P9NlfDAtQOCGQgwII5lxOVfhUzmhrEtHLITZqpAa85XJk4IdaZPEuhyDanYN
GeutTIvmPH8jvKe3qL28yduNWiiEHC3j7KGMaPh800av1Ku/lWH7rqt9zm4t27j/
nFl0von5HJVeEakWkik6xu7NW3ThqWcp95U+tAtex0Ya5rbPz8+b8ZlI9cTobhQf
erKnhJLe3xb1kr+gEvM3xXwZJx4bkqNxWSKwRiFyyGGlC67FuuL/sZPlLfJnZMg8
iH//7JCqCJSItBlGhyNaXjbqiAu/FQ==
=rD2X
-----END PGP SIGNATURE-----

--Sig_/+carHLLokJ73STF=D9yMtk0--
