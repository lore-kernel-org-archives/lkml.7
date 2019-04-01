Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8CE20663
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GWMaj0o5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbfDASIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:08:49 -0400
Received: from ozlabs.org ([203.11.71.1]:47691 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729427AbfDASIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:08:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44Y0hW4172z9sQr;
        Tue,  2 Apr 2019 05:08:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554142123;
        bh=97Q8JNWfYjBG4Ks5laY1k0rUO5Ht0+EOOpmUo2jD2AE=;
        h=Date:From:To:Cc:Subject:From;
        b=GWMaj0o597mydgoyTTMa1INB32ucG/suh5jl2/6tcOsfhWAAGC+vSNqm/IaWjPusn
         blRzDgJIH+fzGchb8K1rqOPBaoJ0EcDGCe4g2o7XKXzg5MB+oqNHPrNp73iCw2UbZV
         cS+hM+LAAUL93fEB2F+s5Ex0eEaftgR7WbUXVOdB3yG+ynFB5ZHb8lnbLNNKWHcjKD
         DmYNjDXc93j33C3iY1rg8HXkzxYqp916HjHifQ/8SfxZdINSTyvCz03ES65EP82tOG
         HXZl8MepWJjRwipyXjTd5WwyYq494rEDK9vwyYRC5VrFRulhQ4T5szZnMwzwvL5lCU
         JWz7I+xTskYBQ==
Date:   Tue, 2 Apr 2019 05:08:42 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the block tree
Message-ID: <20190402050842.2db07437@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hoXIUXK4_nbbYG+QyaZ=iS5"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hoXIUXK4_nbbYG+QyaZ=iS5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jens,

Commits

  837d7c7005c3 ("block: enable multi-page bvec for passthrough IO")
  df88a384baa3 ("block: pass page to xen_biovec_phys_mergeable")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/hoXIUXK4_nbbYG+QyaZ=iS5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyiU6oACgkQAVBC80lX
0GxYwAf/fQWS8rF7c1nzKnFqGDF53qMraksD1DjF6VVbzjZeR8Wa7UdrxDAt9x3q
tv++BUZoKhEGvHN6vuy0R6JrB3yb5gFP5flqxLpRWbkvqBLSlp9mOai26MU0yhQC
+HmfqycmvzlBRsnGRnuvZDpNlvqGRa5i5SdBN2b5fYTA4Ca8tM4K8MtbjCT1yMDI
HUT5SB0C4szs1pJr5Xgj7e+gNxBpNmeHvzRy1REEROyNP8Vth0/NLYUbI1k6FcVp
D7NQmc1fGhyF9lvT6pjz1OlKsGT2nSc96G54tzNHDW9zP81A29uqOqo8sJTWCMVX
8NHtaBhzd/P4xnInrnQR2+gk6QuuXw==
=vGtk
-----END PGP SIGNATURE-----

--Sig_/hoXIUXK4_nbbYG+QyaZ=iS5--
