Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F7BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE142238C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 11:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="KFCu1BSI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbfGYLSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 07:18:01 -0400
Received: from ozlabs.org ([203.11.71.1]:33145 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403940AbfGYLR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:17:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45vV7S3ZQmz9sDQ;
        Thu, 25 Jul 2019 21:17:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564053476;
        bh=/i3NQQ0toEw4SRGaWHbWAYnk6aaHQk6Yx7cIdSQKRI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KFCu1BSI3GEx5MYD6aO4rJeS+0YyJP1DvAN0f3QeKfZfgLzGFmRDUW+TD9ag7ZOHi
         gJbssHhy6Po5Wgmt5rE8l+ZOQ2kBQH64nso9JVJmxMQwQQv2KyjDi57oT+AhpZYREN
         Pt7C+5lQFpxS0VdZm+9e0+5WVG8QR/bJtT81OC0zUwj8VfjSzB319RVNDLQAhvumO1
         SvCSQMUvU8yRJxsoraSqYX1cV9luPzDMHWpPCwBhI2eMAEGYsx1NBmrrXaWKXVx81P
         gGLufb5/tGknnoWwt7nEDY4sDAV57takrXBKEcDdSA4rM7q9iVGeDNnD1HcmWzGaCK
         U5FgRI0+Z5QcA==
Date:   Thu, 25 Jul 2019 21:17:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 5.3-rc1)
Message-ID: <20190725211754.5aa1640a@canb.auug.org.au>
In-Reply-To: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5RiFGHPF5CPL.CP=sbkKfbn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5RiFGHPF5CPL.CP=sbkKfbn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20190709 was the first linux-next after
the merge window opened.)

Commits in v5.3-rc1 (relative to v5.2):            12608
Commits in next-20190709:                          12256
Commits with the same SHA1:                        11291
Commits with the same patch_id:                      303 (1)
Commits with the same subject line:                   63 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20190709:     11657 92%

Some breakdown of the list of extra commits (relative to next-20190709)
in -rc1:

Top ten first word of commit summary:

     85 net
     78 docs
     64 perf
     61 drm
     39 kvm
     37 x86
     26 scsi
     24 kbuild
     23 selftests
     21 s390

Top ten authors:

     78 mchehab+samsung@kernel.org
     33 yamada.masahiro@socionext.com
     23 adrian.hunter@intel.com
     21 jpoimboe@redhat.com
     18 arnd@arndb.de
     18 acme@redhat.com
     15 iii@linux.ibm.com
     14 rui.zhang@intel.com
     14 pbonzini@redhat.com
     14 hoeppner@linux.ibm.com

Top ten commiters:

    157 davem@davemloft.net
     77 mchehab+samsung@kernel.org
     63 acme@redhat.com
     54 tglx@linutronix.de
     46 alexander.deucher@amd.com
     44 pbonzini@redhat.com
     34 yamada.masahiro@socionext.com
     29 rafael.j.wysocki@intel.com
     28 torvalds@linux-foundation.org
     26 daniel@iogearbox.net

There are also 599 commits in next-20190709 that didn't make it into
v5.3-rc1.

Top ten first word of commit summary:

    286 drm
     27 mm
     25 xtensa
     25 vfs
     24 arm
     21 pm
     11 nfc
      9 apparmor
      8 lib
      8 dt-bindings

Top ten authors:

     65 chris@chris-wilson.co.uk
     42 xiaojie.yuan@amd.com
     37 tvrtko.ursulin@intel.com
     29 dhowells@redhat.com
     23 imre.deak@intel.com
     21 jcmvbkbc@gmail.com
     21 james.qian.wang@arm.com
     21 akpm@linux-foundation.org
     19 olof@lixom.net
     16 digetx@gmail.com

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

     95 sfr@canb.auug.org.au
     86 chris@chris-wilson.co.uk
     53 alexander.deucher@amd.com
     39 tvrtko.ursulin@intel.com
     38 liviu.dudau@arm.com
     35 viro@zeniv.linux.org.uk
     28 jcmvbkbc@gmail.com
     23 imre.deak@intel.com
     21 myungjoo.ham@samsung.com
     19 olof@lixom.net

Those commits by me are from the quilt series (mainly Andrew's mmotm
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/5RiFGHPF5CPL.CP=sbkKfbn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl05j+IACgkQAVBC80lX
0GyCigf/d/jWkpnGcxnUezQuyTLZIiu2Ho9OfrxtTmrmO84IVkDW01RMKSxP9IkF
JzTuqKif6mv1r3ECp/SA5jzLLKh48FXfcS7qPcYa3mtgjhkEaXY8+Ij0bvCEZOA1
aSZ4YQbtOsDHmmNrxK7IXdBoYJ0stZ+CA6dcr/cKQxeEWr3v+CRXJnwNixJ+MSqJ
gScf8VsW0wT2S5V0WbDZDzRFbP9hl4Z2LEMXyw5cg8a+bHCwWHvEo+IHsYc8y3W+
IOzyhAWA8vSQ+XM1D6ghqy2uazLlSYDO+//6LtozM4XKf/To/IsPhD0v7PtOr3QF
ggc5DiUt0ODP11TSDSudbrqA8UYqRQ==
=GqK3
-----END PGP SIGNATURE-----

--Sig_/5RiFGHPF5CPL.CP=sbkKfbn--
