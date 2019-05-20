Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8965DC04AAF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E46920657
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 03:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="C5v1tLbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfETDiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 23:38:01 -0400
Received: from ozlabs.org ([203.11.71.1]:44407 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730242AbfETDiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 23:38:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 456l39564nz9s3q;
        Mon, 20 May 2019 13:37:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1558323477;
        bh=mQzgKIkGvpMR6uHP9nccj6f4S2zSwaB82iPMnjnCFzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C5v1tLbfC62A7AphZVORqj+4pi8LnNAc0AE3TPUsLOHyWnLaNf1GVAhsFZ4kRkzVw
         hzeA/OVdKR1Y6EH9rj3k9a/uUj0NpigDhoGhbHTwhd28MTlfmrrXWrX//QVyjucWrS
         /kXTYlvQeqJFToUJ73u5V0DvyaJq7jtjftR4BbJIQP3tNoKt8zj3vVpf/Qhj/dqUBj
         vVb43zN+k268kqwODDXPTBk7ZPGM4aZ3BdQNpr2u7ljsCl+awL73VWBiTAdnYiG+zi
         LWroQM7ZR1gOEG6Q8nwtuf9Z9z6ruxI5m119RcZd+C3JfSa5uoQ0A/gL3ipzsgEDdF
         8yYczOTDKirag==
Date:   Mon, 20 May 2019 13:37:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: linux-next: stats
Message-ID: <20190520133751.5e47cde8@canb.auug.org.au>
In-Reply-To: <CAHk-=wgxi6fnxZ+p5Zdqr-i4s=xhOCBJL6s_RauYkjxM2CpXeA@mail.gmail.com>
References: <CAHk-=wgxi6fnxZ+p5Zdqr-i4s=xhOCBJL6s_RauYkjxM2CpXeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Dlg4REijNlevxIC6yrJ+w7o"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Dlg4REijNlevxIC6yrJ+w7o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20190507 was the first linux-next after
the merge window opened.)

Commits in v5.2-rc1 (relative to v5.1):            12064
Commits in next-20190507:                          11388
Commits with the same SHA1:                        10638
Commits with the same patch_id:                      350 (1)
Commits with the same subject line:                   61 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20190507:     11049 91%

Some breakdown of the list of extra commits (relative to next-20190507)
in -rc1:

Top ten first word of commit summary:

     58 net
     46 afs
     44 perf
     35 kvm
     35 drm
     34 x86
     34 tools
     33 documentation
     25 thermal
     23 drivers

Top ten authors:

     50 dhowells@redhat.com
     28 yamada.masahiro@socionext.com
     28 tstoyanov@vmware.com
     27 changbin.du@intel.com
     21 amit.kucheria@linaro.org
     20 jlayton@kernel.org
     16 hch@lst.de
     15 bgolaszewski@baylibre.com
     14 deller@gmx.de
     13 yuehaibing@huawei.com

Top ten commiters:

    105 davem@davemloft.net
     73 acme@redhat.com
     59 edubezval@gmail.com
     50 lee.jones@linaro.org
     50 dhowells@redhat.com
     42 pbonzini@redhat.com
     31 yamada.masahiro@socionext.com
     31 jgg@ziepe.ca
     31 corbet@lwn.net
     29 idryomov@gmail.com

There are also 339 commits in next-20190507 that didn't make it into
v5.2-rc1.

Top ten first word of commit summary:

     27 drm
     20 xtensa
     20 mm
     20 arm
     19 nvmem
     19 i2c
     15 selftests
     14 ntb
     11 nfc
     10 arm64

Top ten authors:

     18 jcmvbkbc@gmail.com
     17 akpm@linux-foundation.org
     12 wsa+renesas@sang-engineering.com
     12 evan.quan@amd.com
     10 stefan.wahren@i2se.com
     10 linux@rasmusvillemoes.dk
      9 zohar@linux.ibm.com
      9 logang@deltatee.com
      7 jean-philippe.brucker@arm.com
      6 tadeusz.struk@intel.com

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

    103 sfr@canb.auug.org.au
     23 jcmvbkbc@gmail.com
     23 alexander.deucher@amd.com
     22 srinivas.kandagatla@linaro.org
     15 wsa@the-dreams.de
     15 jarkko.sakkinen@linux.intel.com
     14 jdmason@kudzu.us
     12 stefan.wahren@i2se.com
     11 sameo@linux.intel.com
     11 mst@redhat.com

Those commits by me are from the quilt series (mainly Andrew's mmotm
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/Dlg4REijNlevxIC6yrJ+w7o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlziIQ8ACgkQAVBC80lX
0GyOQgf/YUoXTvaZGZwRATywOYhHagZDDl2GHSe9N9lJMOxdzSzFdYK0ydsAMk/x
T9FGQBWSj0FO6UxkQ7vVVpLZ7Xe7MCjkRkkQqqwUqnkqEMkkM7ESQz/uecVSZLCn
LjqGKIY7ZAO4ZeX64N8tD2wWlhHDkUp8V0rrchT5jO4I9SskfwPDx6+fBn7gTyhk
m/ld1DcnvT/qT4uAtP3h5H7YY8/7PcisnOALXcmo1FKlsRUsGPjp3yC9+o/SHf3W
MyeBHGhgYO7R6hG5u5HYsHGmN+8ZGYWQt06rGSLRqMkTmEBtxPNLO/kDylx72our
WlGXzldIQZjNPXqCgXR47gIYMSqnkQ==
=uKbi
-----END PGP SIGNATURE-----

--Sig_/Dlg4REijNlevxIC6yrJ+w7o--
