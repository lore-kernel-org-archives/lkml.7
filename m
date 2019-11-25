Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82B56C43215
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5639020815
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 07:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oh901/4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfKYH2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 02:28:43 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:55995 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfKYH2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 02:28:43 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47LzD70g7lz9sNx;
        Mon, 25 Nov 2019 18:28:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1574666920;
        bh=1TESMScnVmMk34IZjeN8RcVqg0yHL59WVHIXkAaRuHU=;
        h=Date:From:To:Cc:Subject:From;
        b=oh901/4v5cDfblwO2k0TobXwTsQc2oO+ghzL7gMOHA6hrfo6s+q6TiaEazDynWbxI
         EsP4nx26WA2XULJzQvoq7zopEmxpuLdc2LrFnk1HkQ1LrfWyUqVV0PN2ZWzJnY8aiJ
         d78FanF1XUO/q4vjxtl6a6T4YunotIhL/t8emSdbuxYST1WthMlbVCKw+rj3o9jIyV
         VTgMB2k8GPJPHkGcjnhnb37gW7TvWtEGeszt3igzIYOR5n3wsbo74AWJ/vCElyTkvA
         NWCByztvYZGJ+S5pOk3K0LPFyDXD4N03FqH9eyLKnA8tYe+Ps1e2EeIDlvBZtX6Nuz
         P/TH6Jh1OP99g==
Date:   Mon, 25 Nov 2019 18:28:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: linux-next: Signed-off-by missing for commits in the net-next tree
Message-ID: <20191125182834.5c97443e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rlp/qcp2ieaK8GQTwI6lbFG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rlp/qcp2ieaK8GQTwI6lbFG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dave,

Commits

  5940c5bf6504 ("selftests, bpftool: Skip the build test if not in tree")
  31f8b8295bb8 ("selftests, bpftool: Set EXIT trap after usage function")
  a89b2cbf71d6 ("tools, bpf: Fix build for 'make -s tools/bpf O=3D<dir>'")
  a0f17cc6665c ("tools, bpftool: Fix warning on ignored return value for 'r=
ead'")
  5d946c5abbaf ("xsk: Fix xsk_poll()'s return type")

are missing a Signed-off-by from their committers.

Presumably because the bpf-next tree has been rebased before asking you
to merge it.  :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/rlp/qcp2ieaK8GQTwI6lbFG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3bgqIACgkQAVBC80lX
0Gxy9wf/aOFKkVA4ZwiNAcn12OODBgeZ+Pa7GHk3/K0ezvEvo/qj4hV3ogxdqzHt
Qro2swQFIIWSqzDG7y99G5GyGsXAhtHHY43//X1rAcH48a82ZGP0WCpt694c7uv1
7tTm/Dli33taxw3mbvLmv8hamDvcd+6m6RXj5ich+WEsKjiVfcm7BvD7GdVhREIL
ypUU0M4B07uTBHBpai6XZF6NSIb96cXLS8ZNmeDGGEAP8cGFfUj4x4DWwiUjr1qM
zvC1q99iwaLbTdpbXSwZXi21g0ZjfbjFlphdSJh1WdXL2IjXqCeRXjseImZKFr9n
IDc5OzyUiYfQ50+lhurTYNbelkOkkw==
=Q/t+
-----END PGP SIGNATURE-----

--Sig_/rlp/qcp2ieaK8GQTwI6lbFG--
