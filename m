Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65D8C43603
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 07:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 791392173E
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 07:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="S/H7s0wf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfLGHSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 02:18:08 -0500
Received: from ozlabs.org ([203.11.71.1]:43117 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfLGHSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 02:18:07 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47VLQP02Thz9sQp;
        Sat,  7 Dec 2019 18:18:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1575703085;
        bh=J6CnWZDK7IbehjVb4HCsRnaeRzOsdUFeVe2tUiM32aE=;
        h=Date:From:To:Cc:Subject:From;
        b=S/H7s0wf2ecObr/Z3bzXzy08NSM33853r/HG7n+DdDHIeCOMsKI0cOPfsQo4cvHAK
         D7sSE216yB1KMILeVTV+wpcZ8QvpSPealz0WwF7uA9ySWwcnszIpZHdk7pMulGOPv6
         eZqSBSfJQrPm3pGz5U00oTuNjttCjEfwJZAY2VyXiQ6gPkjiyrfLHDAWEB/gHwrqar
         yNW+wpfR+Z1NavkfFhMPy7HkIMv37lVjWVDXA+f3+Mttyvzux6/Is4cqvNnceXbaNn
         rl9RQ6Jypwfgtwl1UL6U4Xu9+kKhNw07uKaDfmkd5xb9zUf+hNLuyokWXp/W0W3X8+
         hDpJy+0JSOf1w==
Date:   Sat, 7 Dec 2019 18:18:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jouni Hogander <jouni.hogander@unikie.com>
Subject: linux-next: Signed-off-by missing for commit in the net tree
Message-ID: <20191207181803.0cada15d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o_BXvv_SfkZT/UlWNB_BRH1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o_BXvv_SfkZT/UlWNB_BRH1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e0b60903b434 ("net-sysfs: Call dev_hold always in netdev_queue_add_kobjec=
t")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/o_BXvv_SfkZT/UlWNB_BRH1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl3rUisACgkQAVBC80lX
0GwUwwf/dZ/u5N/PWmA/qVYQpEnTqXzQfWn8qTn1r2TWWEvrUtSUlZdS2zVi6Hmf
aTsfoy4vZOZtiCZRVnJjNh1mNKXvdr0XkuGKFdr6FjIu2mNr2f7K7jaDMVT23Lr2
22oBPFl8xYqoliCGv7T/DMxHZjwVCQJ6XBtCkFQ1JNjDmm5gW3kGWrpdQj3rZEC9
/NrmJ0hDUojq5OEVa1NJFocbQmK9dBpGR2arLFgwSql6a2QxxGuZL8gVAcXszcV1
v6A7IrJmm4gv5tJRMDaOwjArBB1iCu5qj9Yh4wQGEVDNiKfz/UKRqYmJgwV1nsW9
hSX7l7mGTN4lKXW4t8lFJUPO+4JAiA==
=+rIm
-----END PGP SIGNATURE-----

--Sig_/o_BXvv_SfkZT/UlWNB_BRH1--
