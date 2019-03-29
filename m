Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCE0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECA32075E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bJ0cJV8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbfC2CjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:39:19 -0400
Received: from ozlabs.org ([203.11.71.1]:35923 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfC2CjS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:39:18 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44VmCR72tJz9sPv;
        Fri, 29 Mar 2019 13:39:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1553827156;
        bh=H1AaXsMpn0dAS8oFuJxO8XQunSfed2XWz16NkDpb1aU=;
        h=Date:From:To:Cc:Subject:From;
        b=bJ0cJV8Uf60F4El5D3xdaY9kt9VcS+s9L0JbG6In/KnuUVPA616+kZdkZGo3Zq6ZR
         s2Fhby7f4/ceV+7fBTOj6TTVtyplPmmZ4GfMVEchsuQ9Hvyq4tyehgQEidZxVTHTH+
         tvEL9GdSxqrWcbjOyeq+/MZR+gS8e0iAvS6TXYz85ylkawTWtlmfEitEZSFJwG6HDl
         Igk61aLF1JUwUNNNzrSa71kwgYjblMukE9I3/LlJcPpZNUeNq9aI+XL0W3eL4F7/wb
         WRH/0q7WiCDTLX1LB1deXP7+JQNHU7wAY2+eU4iadJSP8V9NZUSJvQkCjWYhR/64E2
         D/gtUFvOpeDMw==
Date:   Fri, 29 Mar 2019 13:39:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        George Spelvin <lkml@sdf.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190329133914.45a4a255@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bz/5X2ivF34+g6UO7vy52Fz"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bz/5X2ivF34+g6UO7vy52Fz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

lib/list_sort.c:17:36: warning: 'pure' attribute ignored [-Wattributes]
   struct list_head const *, struct list_head const *);
                                    ^~~~~~~~~

Introduced by commit

  820c81be5237 ("lib/list_sort: simplify and remove MAX_LIST_LENGTH_BITS")

--=20
Cheers,
Stephen Rothwell

--Sig_/bz/5X2ivF34+g6UO7vy52Fz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlydhVIACgkQAVBC80lX
0Gwfcwf/a08aToYMZc7G6FsZ5WGZIELQG6jO+w/bgXuIo+Oq68NVJm1mCrH0oiM9
pTlM/1BXDvLqyRsIBkDCeTjC02oZrPBMB7MrzYQKzRFkgpRTZWkKDG3qz5S8SgHQ
Q4/A577fqDglq+zdnKfMz05CpioFd8r4vsA1UpfcqNZljirmWa9MZOA7FYhPYV64
q5y1yk71YtERywotcCRQw/RYQ9DkVq0Mkgk9fgxQsLkIyVKdJxqVFVvjyW1eZZ3k
PVv9chwoluBaMwLuxlaA9hkBwqCecLeZMMayZ8Nu/UwRsQhviGy1FKK+tn4KU1Vx
AIt8EqYqDHW7iT90MnvGH7OqSo4cyQ==
=6CYq
-----END PGP SIGNATURE-----

--Sig_/bz/5X2ivF34+g6UO7vy52Fz--
