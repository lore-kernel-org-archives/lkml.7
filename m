Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BCC04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09BC020881
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="l0NedCdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfEPBrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:47:10 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:38075 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbfEPBFv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:05:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 454CsS4CYZz9s3q;
        Thu, 16 May 2019 11:05:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557968748;
        bh=fZnwa8ubjzk25IayGtARl7gwjK8HMk9Y1XfVQcO7Gl8=;
        h=Date:From:To:Cc:Subject:From;
        b=l0NedCdbaOyLaWawUcBKlg+heKEbiG3cwoB2QTX3hi9XdS2RKdh7YA4QUyOdF5l0H
         YSlqbd+DjbhAoUg4vthOsyvIxWZUV6PtsuWadcgeD4nFh6/OPFVxEKN+DkHjOFptFo
         S6/2UaSDwuN8IRKc4/amzo8/OUFkeAIL3gBuv8ZZj+y6+F69u9UgC68PSDBmmCxI6y
         jV8+JWLyfV2ulBitlfLi4cPatmbujkenjCpwTXKOLHWlv+R9+NKNS+1L7AgzpDbsKF
         1Rr1N3lk01HIleZ05WJPZqP1jwWCVSZ3tbNm6oOFhqY5+mEq3s2HM9BqH+NdcTXpYi
         MytGEJY1Y2o2w==
Date:   Thu, 16 May 2019 11:05:48 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: manual merge of the ftrace tree with Linus' tree
Message-ID: <20190516110548.0d22d048@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yioRfzKsOHL0l_nK0l1RyO1"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yioRfzKsOHL0l_nK0l1RyO1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  include/linux/compiler.h

between commit:

  37686b1353cf ("tracing: Improve "if" macro code generation")

from Linus' tree and commit:

  a15fd609ad53 ("tracing: Simplify "if" macro code")

from the ftrace tree.

I fixed it up (I just used the latter version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/yioRfzKsOHL0l_nK0l1RyO1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzct2wACgkQAVBC80lX
0GwsFQgAifeawbCBdogc3+jkuvMkWdmndy76L6kGaUXr2LMVeJf4mBShwbBhB8FF
LMy+QQC6UFvs4sp1fZSfoZnNyKaYcnm/anmtAv5XgcNs5oOeQj8FR38hngsUHrQE
39Q4PkjV0xZUMR4BCDCEkB3mFKmzruXw5AE3pFgI1wBDlP4T9GaSR7D/KdFgBPc7
L0V8Pg3PnsiumgUpTEdS41iElgB/AQr69vHs+REZoO/jqFUX5PROGByKUetaKMdt
SBbs6hu3It5HX7uCIyTqLICN0Kpy+Xxp1DzrFio+JUTLAKx9j/aMHOvgxaNRctJy
Ns/A7sC30AReyfCGJzFT55HFcGgLPg==
=cqH5
-----END PGP SIGNATURE-----

--Sig_/yioRfzKsOHL0l_nK0l1RyO1--
