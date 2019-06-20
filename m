Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE39C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE277208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 01:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="tFCxgIz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbfFTBLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 21:11:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33501 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730991AbfFTBLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 21:11:34 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45TkKs2dKLz9s7h;
        Thu, 20 Jun 2019 11:11:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1560993090;
        bh=CNbxJiYq6C75CwfdocCTPBs4JFfe36r1O41S28vRkEs=;
        h=Date:From:To:Cc:Subject:From;
        b=tFCxgIz0cyASNgeqVJqGmjTW3bsRbj1lxGg4rvSL6wMTEUAQCQtGeqNUSdv/xCoPK
         5dvfu9iiYcBYf3Jrru1SOnEb0OaGYI6vfjxdmz4ukHjX+H1PjAXpPwtliDkb/anu18
         xDizcI2g3YGmHVT9yrt2aLrRvw+8TR2rCbdkqPcgEUYpm78E/wfk/LaPBoXlfBsdno
         GLZGZSwAjizH5QKNiluNJR1KtxKSGHfrNXCULXu+q0eBmK3vivxW8/RozKxOoK5YED
         CsIHLNbC6nvTOJXs3JJ8ymoRgR4yiCdyOv2PR2Oa3JoRteHRrOKciRR9jtuBkpS1uA
         mTqv4N84YjMLQ==
Date:   Thu, 20 Jun 2019 11:11:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jonathan Corbet <corbet@lwn.net>, Greg KH <greg@kroah.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: linux-next: manual merge of the jc_docs tree with the
 char-misc.current tree
Message-ID: <20190620111128.7599af5a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/v4hr7Ndm5uVt_YBbpG.wv/o"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/v4hr7Ndm5uVt_YBbpG.wv/o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the jc_docs tree got a conflict in:

  Documentation/fb/fbcon.rst

between commit:

  fce677d7e8f0 ("docs: fb: Add TER16x32 to the available font names")

from the char-misc.current tree and commit:

  ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")

from the jc_docs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/fb/fbcon.rst
index 5a865437b33f,cfb9f7c38f18..000000000000
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@@ -77,12 -80,12 +80,12 @@@ C. Boot option
 =20
  1. fbcon=3Dfont:<name>
 =20
-         Select the initial font to use. The value 'name' can be any of the
-         compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
-         PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8=
x8.
+ 	Select the initial font to use. The value 'name' can be any of the
+ 	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
 -	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, VGA8x16, VGA8x8.
++	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
 =20
  	Note, not all drivers can handle font with widths not divisible by 8,
-         such as vga16fb.
+ 	such as vga16fb.
 =20
  2. fbcon=3Dscrollback:<value>[k]
 =20

--Sig_/v4hr7Ndm5uVt_YBbpG.wv/o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0K3UAACgkQAVBC80lX
0GyZSAf/ejm/xy2L7QtLuyvIeP+EA7tnZomLg/ClcB+ensLAMtiCrmgwfNoJ2Y3D
ls1SneS4rFxLtzBcdgt7AR7efBEXAzU+dJKMZ//AM989PxqCqNwp0V9SkfM0oab/
6lne7+lVQ0jlGGpLv8Nayl8vu1gY8i5ImgIvAZvEmbHqyOryncVt6V0/lOGDVgQn
oErbtyY/6KA1q1vvVLCuQP790uvg1BMhlluw5cZcmgiaSp5IFImkI5ooSGWLR3rK
q7MstizHQoEtIAUXudNOao+s/VKXo0rrtvORoAPRCEvIU1xLhcgpUuGTz/HHk4fM
MBh25L/UypEEQY+lcV8UtJMWMFpdNg==
=oxjW
-----END PGP SIGNATURE-----

--Sig_/v4hr7Ndm5uVt_YBbpG.wv/o--
