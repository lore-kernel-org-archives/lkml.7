Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BCCC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFD5420656
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 04:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="P7NJFYbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfF1E4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:56:31 -0400
Received: from ozlabs.org ([203.11.71.1]:41721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfF1E4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 00:56:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45Zkxk6xRKz9s3Z;
        Fri, 28 Jun 2019 14:56:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1561697788;
        bh=SMVYaDCX0DoBKxkS7rKJexefBsuGF79pADX+AZ8pbsg=;
        h=Date:From:To:Cc:Subject:From;
        b=P7NJFYbjIoQIG/9t9bAZCrJfga6hEeEfUm/GrC/VJGincQ6tsGtsX29BWJ+xYevfo
         VHl9NRxIQnErpsyeE/mTorg6NcvpuaitfHuBAwl4h3pvIcqj/DhBob4YrF2qIXfk5U
         omDMueQa1jTXmKGTxv5l/P6pe1ePC1FVJKV02hOsSK2t5q/FZJSCuROjZ/X/vzSwAA
         AZrBTiBUlMoO3k7RjqHEyBU2JkCcap5OoE9jCFbbGEjU7L2sRzDC6oa9BDNLqRdUoh
         D/0o+m6pOzB4qMSTDrdHsz1r//eTC8QucuOHlUtJswGfHE3BCgwhXzxrIvp2sZpKqs
         KN/sDQU3dhqRg==
Date:   Fri, 28 Jun 2019 14:56:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Subject: linux-next: manual merge of the devicetree tree with the net-next
 tree
Message-ID: <20190628145626.49859e33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/HF4KsNnPldgYIzA+x18Fgwl"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/HF4KsNnPldgYIzA+x18Fgwl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/net/ethernet.txt

between commit:

  79b647a0c0d5 ("dt-bindings: net: document new usxgmii phy mode")

from the net-next tree and commit:

  4e7a33bff7d7 ("dt-bindings: net: Add YAML schemas for the generic Etherne=
t options")

from the devicetree tree.

I fixed it up (the latter seems to include the change made by the former,
so I just used the latter) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/HF4KsNnPldgYIzA+x18Fgwl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0VnfoACgkQAVBC80lX
0GxUdAf7B/AAcvZuhPX+dhS+jfUFUfhLRu9xggQj6gTXZ+YVzbNstn3CwrW4Gstv
JwvExLmGjcIveNa1uSdlXHdZjWbmac1Qsb1h4/xmswxb7TbknFOsXcuoj7tjCN4P
Ug9ikIH8VKWT3RVUrbnxQExL583XdCoSE2IW2uMJoSOs07nr0q+BUXX7vPI+E//o
WdqQFBYJR+gvDT/uKz845I1yU/XedUOQvP5yaAob8MBBidohfvRhwD/z4lBFGM0I
vgt2/Q2DMjDdxfitXXLR1Tw4/G7ED5Baitfge1LKddQsLaK7qwzeyxbi8GqjlJiO
Ig9D/v3QryjdA9baAXAZCQ7T5fc+pA==
=+e43
-----END PGP SIGNATURE-----

--Sig_/HF4KsNnPldgYIzA+x18Fgwl--
