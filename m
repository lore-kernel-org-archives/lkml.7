Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C317FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB962075C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rFc6zUOv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfC0Uiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:38:51 -0400
Received: from ozlabs.org ([203.11.71.1]:38721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbfC0Uiq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:38:46 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44V0Fw5SvRz9sPx;
        Thu, 28 Mar 2019 07:38:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553719124;
        bh=p2iupHb9LwMH0tvhq9ISxzxGDEkh0eA0si4UEFFjGNY=;
        h=Date:From:To:Cc:Subject:From;
        b=rFc6zUOvvvTrvc2OBvtE4bASV+ys2E2Ha1JFBTQlamKR2Z7Z1FVdDVI/EXx91XXVo
         5VgKa8CSpWdbNf2XwOon1Ecpr31vtZbqwPopnUXgXPh8wp0abzcl67gRzQt7nt8jEB
         fxoSu/rP5aQChpqnfMcvYH5dqNsb8AzFeDQXiGyjIvw2oea6A53fhj0fKlR3fkqvAI
         RoW6RqhE03tOMqBGspQdhNN8mOyo2vFeJkTBjbO6TLauV7+YpkNd4x6mKIdPKNK9x6
         jCyGuwjnlv8OsJHVb3uE+N5EGJB1ypBJXIgOP8XwhiWfJnNnt50ablKL0iPoPYMpZa
         4+BKLyY2b6OAg==
Date:   Thu, 28 Mar 2019 07:38:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the icc tree
Message-ID: <20190328073843.18533a29@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/7ejJJBxhFvYxuf2rXj90q9T"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7ejJJBxhFvYxuf2rXj90q9T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Georgi,

Commit

  dae6d5996c36 ("interconnect: convert to DEFINE_SHOW_ATTRIBUTE")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/7ejJJBxhFvYxuf2rXj90q9T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyb31MACgkQAVBC80lX
0Gym9Af7BvoqFH3uaqnnh5LUJjrtNc74ATtpLOF0zIFKwx1Hz/L5cn4fk0CV+yI3
jU5hxHkV0v6ypiLPRDPGFU3PYw2FIBjXiwto9vzusaBLI4V0Vxkd+dPhXh8dapJg
zh/QXri6F+lIhqEgi+EuMK24ZWFX8MhxROZEiVRNT6yU1PbZ1WjHuTz+OpCBZmtG
F1NNDNUtYWPe5zhQthlFhMvczaBZD1o0lb+sF+mo/Tlp3KyIhAy7x5vyy00LMHq2
xK4ph0TnWAea2Iw/e73wMIvHzYCwzmkl1B0j5ccOkdUejo0R7wyjo0OjLEOW2PZn
Y+0IKVTaBzVf6AwEv9GjXEp3qsyc3A==
=x121
-----END PGP SIGNATURE-----

--Sig_/7ejJJBxhFvYxuf2rXj90q9T--
