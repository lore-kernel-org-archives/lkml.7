Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EBEC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCF8206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 20:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lleZ2El1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfEFUnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 16:43:46 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55893 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbfEFUnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 16:43:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44yZTC5kKrz9s6w;
        Tue,  7 May 2019 06:43:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1557175424;
        bh=EECZu1HX/V4TAjeBwuys7l5NRaFjSC2WqLMhE3wlO8w=;
        h=Date:From:To:Cc:Subject:From;
        b=lleZ2El1A6S5IXAs1bxJKuX09JJEeKHbkfIaveHXiTPva/bGjsQUzafeXKa8yVeuE
         xXshIBXY8LxFwISmT7PP6XS+94n2T/d5tNT96YZHLUY4z+CcRO8QTHpefVELiqxIam
         5YDeWjIKeh4dKqb5nOFVcCT/rnpSqvQIMr1cDYCSebB8O88RmrLAGrSyig79kB1kNw
         R651JGmjO0xa07a+piot8h+BbfeAfhywFFAZmxUwDeXvnEpvwD0ZSo4HFPiu2b/VHs
         1lkqdsKMiRGoKAuNzSBNi+MCUipdtyekTsOljo2zcsnLPGTzQCs+3eS+sYKg+3ZF2V
         ZEuQWCNDbj8kg==
Date:   Tue, 7 May 2019 06:43:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Igor Konopko <igor.j.konopko@intel.com>
Subject: linux-next: Fixes tags need some work in the block tree
Message-ID: <20190507064341.7bbbe26c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/inYG87=b/69BKOYy3wOn2zC"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/inYG87=b/69BKOYy3wOn2zC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  486b5aac85f6 ("lightnvm: pblk: fix lock order in pblk_rb_tear_down_check")

Fixes tag

  Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

In commit

  4ca885241950 ("lightnvm: pblk: fix race during put line")

Fixes tag

  Fixes: a4bd217 ("lightnvm: physical block device (pblk) target")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/inYG87=b/69BKOYy3wOn2zC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlzQnH0ACgkQAVBC80lX
0GzpQAgAo+XRRC6UT+Ne1Ll0wqxSd/6z4u4udN6kp/378IMCS1fpPlTGWI4opXFh
+A6n9Dtbwlo+y+qSurUqN+6gcAnWHttguuiP0AvXfqN/BkN0eB0Gr204n99QQBK2
jKI920utHfbelirY6XMEyGj5l1YOvFiOowMO1xKxovFqdgsf7tGuYqlgunggo2aV
u/q7s21DQm+3mgU+ZqXK+cvXtoiwJccfEO7aQ/05hDZr6exE7Igbiuw+t4TmOvV+
gsbc3pbmy/aFltdO57gbBrioW0o854DYzfaAjEp/daU6t1x4g012lzCc6vYAB9SF
XUlySFf+zRwmxjFA8FuSpbvDjRoLdA==
=g2D4
-----END PGP SIGNATURE-----

--Sig_/inYG87=b/69BKOYy3wOn2zC--
