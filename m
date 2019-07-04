Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B5EC0651B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6292064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="HVeEW4h1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbfGDMYz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:24:55 -0400
Received: from ozlabs.org ([203.11.71.1]:55339 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727662AbfGDMYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:24:54 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45fccN0Nflz9sPB;
        Thu,  4 Jul 2019 22:24:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562243092;
        bh=YjZCJzosdnnZQiGvxZ7GKA1yF9Hna7aWijtc8kraDtk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HVeEW4h1EufhNQonhPYYJUPJwyB4Ebp80SoOJF0VbgcvzXvjgtfiwJMYXVXhBH36b
         KJB/8TI/2KALNJmJ7k5uRceu+SsEFq3VaB7/bMZvjBbdr/UZbQ+DqtlArh/LEfBSfP
         Sm6+FR1zd4aYf5d/9QMTYGtTpZ+tZ54jWV/ws7EhaJD3bYnK5oQ8L2ZXHzFoE2ROX3
         2kJGIINBJ59uYNbXfUGZBauJc0IZtAaFzLzp/C6sm9tnqmtbd7lpCdl/bjWXKSL/tQ
         sobrIPZxbCP4ywDukIaYWZOcNkDisWwIMjEeiY3/rQpslk4txmD5BjMc2AtBE1eA//
         YwS++u28h+Bhw==
Date:   Thu, 4 Jul 2019 22:24:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Jul 4
Message-ID: <20190704222450.021c9d71@canb.auug.org.au>
In-Reply-To: <20190704220945.27728dd9@canb.auug.org.au>
References: <20190704220945.27728dd9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/aFgoZVgLZdD8RnoYLhkX+Yn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aFgoZVgLZdD8RnoYLhkX+Yn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

This release produces a whole lot (over 200) of this message in my qemu
boot tests:

[    1.698497] debugfs: File 'sched' already present!

Introduced by commit

  43e23b6c0b01 ("debugfs: log errors when something goes wrong")

from the driver-core tree.  I assume that the error(?) was already
happening, but it is now being reported.
--=20
Cheers,
Stephen Rothwell

--Sig_/aFgoZVgLZdD8RnoYLhkX+Yn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0d8BIACgkQAVBC80lX
0GxTkAf7BHLEOpMboFMuyb2ROmNYim997CGj7Lr1ZAR3CtPOnuA2mMWmETHx30eD
DMxceHj4ffP69RDVH5qcGcgyDZptEDfx8DDhYgqKC74V5ppwJQbzjFVZumxIS5lH
4aKQO+ZKZattgDr0EPUivFUiRMqun2dUGTHBLIuKbZGEo1SqIncqfa70JbOxD+FN
TlI4Eh/0FlPY68b03Gfgi9ToXwLJosbq3LJY/vflmE7XI+z3dztUMtzd48ROda3y
FYBNkb4a9zUowxB6sihGkgd4n9pdFUNXdWbAWTKiU5xGxotl6Hb9+iRW5QyN4QTz
+Y3g66mxQhmtdASPErsn4fVdNBmXdA==
=w4Pg
-----END PGP SIGNATURE-----

--Sig_/aFgoZVgLZdD8RnoYLhkX+Yn--
