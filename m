Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C1BCA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB292166E
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 06:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="Pty571UL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437719AbfJXGQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 02:16:39 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34701 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437707AbfJXGQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 02:16:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 46zH7m0Tl1z9sQm;
        Thu, 24 Oct 2019 17:16:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1571897797;
        bh=5LZtGB6MpqVjniWkZe+D10Mn/VWNL4Dp4QZvuqo+V8g=;
        h=Date:From:To:Cc:Subject:From;
        b=Pty571ULRKxFJP4VguEno1jWhrV1gwckqog/SoVUNaM6vO+BVi3npirHatRDqw1qJ
         OTeAu2JqcKdPLze19UpgH9D1qs4TwKGQXt1V/6OwHxynpXa9Sqgz6cU0mCMF0L8Yw7
         Qdj1Mt9JfB2YaAqkLg3Cqx0vFh+2JCxYMrcmHKhT8fUKW6S9ixetMiEksqYIvIuXQ7
         4uJKjrZUKXdTAky1cT4OjbOGuhpqOdaCuyh9Nw1VOMHIAycfQ2gjZCVbSTkDyEa9DP
         4QWPutZAT65blByCQo3MbH1I8N4OjfbAPTHeCYs2lc92piIQh8yLFHCVJAPbo/MAdQ
         nRbH9L3uwJ7Qg==
Date:   Thu, 24 Oct 2019 17:16:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jackie Liu <liuyun01@kylinos.cn>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20191024171634.298c96df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xqZBob5s/U0TS4sAHWvB0NN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xqZBob5s/U0TS4sAHWvB0NN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  f131f240623a ("io_uring: cq entries should be equal to (or greater) than =
sq entries")

Fixes tag

  Fixes: 95d8765bd9f2 ("io_uring: allow application controlled CQ ring size=
")

has these problem(s):

  - Target SHA1 does not exist

Did you mean

Fixes: f3cbc97703c5 ("io_uring: allow application controlled CQ ring size")

--=20
Cheers,
Stephen Rothwell

--Sig_/xqZBob5s/U0TS4sAHWvB0NN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl2xQcIACgkQAVBC80lX
0GyO5Qf6A+mgdkYFOPN3YBmj1EqsxA8gnJ1fnCJWSI49f018qN0l0KRsL2AAFOWc
MnJqlEDtVPMIFhQS+OpW1xKiMrVxZyz3wWNqm6MtJ1x7Oa7l7Up4BuLejwT0XkMQ
yOpdZw9RAkJD7hNXvLPG0lgTswfzzxV2/1728OvAQO4G753Qmgu8rUBF9QVZ4uN/
JVlzG9Edn2XTrHyiMPAwXR5Ruzvoz7jSjR7xA+I1UNSHUClzVu8WUcNJgAVeE9G4
gOv7yAdWc3VOgjUvW+Pt91jZ8HDwFJP2jtRveT9S9GDCFHD4e5nqaw5Dmsida9AQ
fVUR0gWykzugeZppGf1nYPTJcafpjg==
=9gY+
-----END PGP SIGNATURE-----

--Sig_/xqZBob5s/U0TS4sAHWvB0NN--
