Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915D4C7618F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666752075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 23:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="R4BJbtEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfG1XZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 19:25:20 -0400
Received: from ozlabs.org ([203.11.71.1]:35431 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbfG1XZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 19:25:20 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45xf7K0scRz9sBt;
        Mon, 29 Jul 2019 09:25:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564356317;
        bh=BljZEOlkc0W0NeIxt8gVxip2VkivG4oSoW6uKHxHpB4=;
        h=Date:From:To:Cc:Subject:From;
        b=R4BJbtEHFuy67IeBGAx+VhvkesZV22pEDUaB1pkal9crgcXUN0Wkh4Sgt9rUSBjMO
         6kQw1aUC60l1kOTAOXtTnq0JPq9XqVE+DJTRwJlA3KQARqmocMLgHODCR3nh2nyW9T
         r9xKBdPcIzq1PVXVLg+aeUYhk5o9rgcpowmHCdNdBkMUWSInxYUbH5nUaY4KtbdHVe
         t1vmF0xN14rqfQxxq3iZ/c3DXyvY3XuT7nJuE0z4JJz1b9XH4xZXPKShns4fHug2bS
         91DBA8oEpiasr7rCKgRKNlD36NXoeoFCnF2QwjtWNLlC84x+LFmlcrrGTmo6+BpbD/
         tXPStfIKFni3Q==
Date:   Mon, 29 Jul 2019 09:25:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: linux-next: manual merge of the sh tree with Linus' tree
Message-ID: <20190729092510.5e269cac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BxDyDWOKbe+Rq69Bnd_nACt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BxDyDWOKbe+Rq69Bnd_nACt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the sh tree got conflicts in:

  arch/sh/include/uapi/asm/setup.h
  arch/sh/include/uapi/asm/types.h

between commit:

  d9c525229521 ("treewide: add "WITH Linux-syscall-note" to SPDX tag of uap=
i headers")

from Linus' tree and commit:

  cd10afbc932d ("sh: remove unneeded uapi asm-generic wrappers")

from the sh tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/BxDyDWOKbe+Rq69Bnd_nACt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0+LtYACgkQAVBC80lX
0GwxHwf/QPHqVBNCp6xbO2JaJLqVG4mPC5TmH7R6UImXcmPDPt5mO1hryua725ZQ
EyhIjO76IGxDQHwjOWBxx7cvtfVJZKp+y49tIT1tIyjtTbjCejiL77bI8kReXHW2
B0e7d2uymWY9HcIJcA6sq9tmSKtB/ebf3kbcJQMLT5rWPCFiFqTCS3aH2KtOY8+6
o0ElKBVhYgNWhK8+oyvU3vyyUBVvcwGeg88PaRvz0+lQRwXpTT8HS/yWx72WwaQ5
Vlt0MqLGUOJiCm4KLwFvEwbJUGJ5uOTX8uhKfDAE1vzmAbd6l2a+PQQlyHhgMO+C
VRsBNxWXtZovLPz7BvqT4C+C1jqSqQ==
=/2NV
-----END PGP SIGNATURE-----

--Sig_/BxDyDWOKbe+Rq69Bnd_nACt--
