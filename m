Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6462C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DFE24682
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 20:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="A+1AZUbZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbfLOUsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:48:46 -0500
Received: from ozlabs.org ([203.11.71.1]:51645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbfLOUsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 15:48:46 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47bc233HQqz9sP3;
        Mon, 16 Dec 2019 07:48:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1576442923;
        bh=zIIWc7HmThOLOR+cqusbgAbs44tHwrZUKgrea6L6OPk=;
        h=Date:From:To:Cc:Subject:From;
        b=A+1AZUbZuqqzhYYuN1LH6fFajrnslMDvqhj7jhba1A089b8E5J3dPdHBdULioyEx5
         nLnViccMuLIp0OZ42vccymgu8YiEsB18VDNsQYWOBg7w2llVenN62ZH0quQh2CaFcQ
         XlYaH6SlSp9inm1wZt19e7xBunGseiOWobLHkZ2TEZIrriZuZKVTFvf7odxWhNkawT
         Y+UOd144gcrfYakpI/zp6vMt96E1yxwD1ZJwcdXm0AHb/ypj6YEhuTnmgyI+IbWq8A
         eE7F9d5IdY2KT30vdGStz79AUV+Kgy8QX+E9JJAkGOuNaiT5gTGDS51bAvnUH3E9F2
         ynnrW0ajR1dZA==
Date:   Mon, 16 Dec 2019 07:48:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the vhost tree
Message-ID: <20191216074836.3b0bc0a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GwKOCVXK1PQG.pZTTBLt+4c";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GwKOCVXK1PQG.pZTTBLt+4c
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6bd262d5eafc ("Revert "vhost/net: add an option to test new code"")

is missing a Signed-off-by from its author and committer.

Reverts are commits as well (and should have reasonable commit messages).

--=20
Cheers,
Stephen Rothwell

--Sig_/GwKOCVXK1PQG.pZTTBLt+4c
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl32nCQACgkQAVBC80lX
0Gz55AgAnuO3Qj5L2bm2Xe/j6HjtmYZtslZWRmO1tMLMOTGiPxZdtv1tQiI3xdNM
5tysstmsW1fUVYmT/kIjLHVEJFkuXbPBYX5EJu5n9PIiNmxUhkbNiNobYp2sfRNM
5uAfMhwSB1Vq0+ROBZ/+l4wni01eywvJ5LAv7XFoRKCFeGaSO6wlssWigWe2nj9B
ooaPLg1QLG0hOUvqWjQSlUfdPbxAxrhmVKOpEyiSABc8YjLEugA5zzPFootSRp5M
HlFJvUtayz9ok7W6KmzH7ntUnEzlgbH5Eupz1BkLOOnt4rikRoRU2wLREVyik0P6
/v1veNc29o3LkoNGINxn7iWwFU+sPA==
=T3+z
-----END PGP SIGNATURE-----

--Sig_/GwKOCVXK1PQG.pZTTBLt+4c--
