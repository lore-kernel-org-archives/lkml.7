Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0BEC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440D620857
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 21:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="koswgkmL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfDHV1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 17:27:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46013 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDHV1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 17:27:31 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44dNmc1nY8z9sPP;
        Tue,  9 Apr 2019 07:27:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1554758848;
        bh=9iIcHRjOpp37vpajAdQaZJYTiJ77fn+t1UBpv4wVIt8=;
        h=Date:From:To:Cc:Subject:From;
        b=koswgkmL+sPftnWxTx7Gr+vJRZqI73cfEEww1b9BYbXIxcJjkbOnXu68GauJnLfOB
         CBH6yT3Y5rn1dUqYGKkWjcbh6N+/2rXe1UF9k+VhKWNRuL0bAglQyV2p7hIZVLRaEN
         ry//TMp26/WaQ9MV4xUut2plhTpzvA2Nme+aFSNHZANRSeFcG9WXpETseRGW2qk0Ma
         0DayHcPzgWF8zwTMvG2V0vyalkKqDLMQKmChcw6HQw82LGbdvSY7WbPHlbJZ303UA4
         v+VXVpb0idLKBz/qOlXdmG/40oZ6yjkN8S0EX5hCFMEEDpzi1Xm0TVwxW+M5M0TZdo
         3yG8Hdk9fo44g==
Date:   Tue, 9 Apr 2019 07:27:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: linux-next: Fixes tags need some work in the sound-asoc tree
Message-ID: <20190409072720.0f51ff2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pQyu_hxH_r8UsjTVlhUT5z/"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pQyu_hxH_r8UsjTVlhUT5z/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b4ed6b51f356 ("ASoC: core: conditionally increase module refcount on comp=
onent open")

Fixes tag

  Fixes: b450b878('ASoC: core: don't increase component module refcount

has these problem(s):

  - missing space between the SHA1 and the subject
  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").
  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not wrap FIxes tags over more than one line.


In commit

  17d3069ccf06 ("ASoC: stm32: fix sai driver name initialisation")

Fixes tag

  Fixes: 3e086ed ("ASoC: stm32: add SAI driver")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
    or later) just making sure it is not set (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/pQyu_hxH_r8UsjTVlhUT5z/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlyrvLgACgkQAVBC80lX
0GyBJQf+JTDG0sHcZEmjh5Z2Sz3cfy7m2JX7WlH7U0/kSTZKGc/zUCWUfwV38DH3
z4lLIZIwtlb0dyjbGbXAahq065eBV1oMl68i9ppLwtXpuY3oyUP10Blq0sXvou+p
hoRmfjtZP0sK3GgeZILI2ydMrhsBcY1g74tZF8WwJ+wA6gfoG1xZAxb++79qKDfz
B4I3ixjHI9Lo9ULVw/crOiL/hlHI1+KeT45GeK4MhoAtzBI4QR/8Wpxb2Zn4WLIJ
z/sp9hbXQHrG6tHHcUPF3socU3X9vFN+9U1RZV/C3zzwwk7CQht9/SAaZehQOtmM
cty7uTbedG1yPFyz+e+dyjQvEx2M0Q==
=dR/G
-----END PGP SIGNATURE-----

--Sig_/pQyu_hxH_r8UsjTVlhUT5z/--
