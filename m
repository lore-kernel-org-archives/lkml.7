Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FC6C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFB92083E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 21:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BmLh1JKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfDGVRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 17:17:45 -0400
Received: from ozlabs.org ([203.11.71.1]:47009 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbfDGVRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 17:17:45 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44cmbn74Hnz9sP7;
        Mon,  8 Apr 2019 07:17:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554671862;
        bh=fC6jvS5HOG6qo+xacJjZCOrd/gGlohVAvEm8VvrmQz0=;
        h=Date:From:To:Cc:Subject:From;
        b=BmLh1JKKb3SwbBV6xCtCjNK2fQZThHttaTEe3mqAdUIGXtQkKHHqyJ/eoIaxYQe3I
         mKNzeGPrFr2EJmD/dDmCZSAk5lGEfOPipWo/6p/2zTq/cxS0dHeDbCFkBlCWjxRndW
         pHNKYrhUcTK0153WvyNjkWrFfSZhNHJpQ4Ke2+qoZ17kjEW70f+sCdngUaPWB7uoso
         8ggPT90cvhEvpxCDjLcrajtCgLU8sIYyVJqNlKVtSPq2EhHvj+Ard0YYS7zDTnUtrv
         BPFyxcAYqYJoPd1+UADF/VD0D/Q7COz/zybbZF+IiMFaBce5Chizgq4SMCT7zZ7b1w
         CHJMqMiDlYeAQ==
Date:   Mon, 8 Apr 2019 07:17:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: linux-next: manual merge of the kspp-gustavo tree with Linus' tree
Message-ID: <20190408071731.6bd422f3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Y475Gd=COLBmDJe7eBg+gzi"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y475Gd=COLBmDJe7eBg+gzi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the kspp-gustavo tree got a conflict in:

  arch/x86/include/asm/syscall.h

between commits:

  b35f549df1d7 ("syscalls: Remove start and number from syscall_get_argumen=
ts() args")
  32d92586629a ("syscalls: Remove start and number from syscall_set_argumen=
ts() args")

from Linus' tree and commit:

  1f7ae812f87e ("x86/syscalls: Mark expected switch fall-throughs")

from the kspp-gustavo tree.

I fixed it up (I just used the version from Linus' tree) and can carry the
fix as necessary. This is now fixed as far as linux-next is concerned,
but any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Y475Gd=COLBmDJe7eBg+gzi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyqaOwACgkQAVBC80lX
0Gx+Pgf+N9aZKC61UevWKUQaZgOhdFapOma2hw3WBjRl87tVHEXsOIVem1c8/Y+O
w71OM2AbIyyQUCOBzNqLARbqcZORrvW/yJ5FAVgAS7ZIJFG1NcAHMEwWe500jugQ
wNi2POD7di6TwQiAsm5YOKg987vmDfj7gjzS31vvuFVT+o7zpDOMefUuWTgclLG0
ZDDbYGkTY+ZrOyQceYlK3YvJZeR7puq4RK5r/4AXRBa0JIsif2dnal6iKIsJ2jw1
tf/X7nNeGfkRBEQNMlU8Ix1Tds0XWVeuT2+blBkkeRzD2KWsfJws++i1Xj9iXJzK
xhAl50X0ypbbYPD9Rdlvl/8UpXV86A==
=Xbdc
-----END PGP SIGNATURE-----

--Sig_/Y475Gd=COLBmDJe7eBg+gzi--
