Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A44C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB95A206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 04:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="YcqN5tXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbfHBEss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 00:48:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40771 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbfHBEss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 00:48:48 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 460F6j1x5fz9s7T;
        Fri,  2 Aug 2019 14:48:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1564721325;
        bh=fvg7BcTA+nfVBNPckHnwFUybVoaL8/VIweZ6p0SgTlU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YcqN5tXupvdoxbnh+LzR+L2wmMCvORjlqpcvUITfQb/f1zseWLUYic94Xs5DF3m+N
         O+CSJzxJX/FnnGt6J7QBomx8eJZ8LZF/b8J7Y9Bh7rR33j/gTGsogdBtUuueUz1eEW
         9hn+cRQjBEoZyzZeXUzVdUq77sLNPqhLRTNGQTLnx1cqSWTvKhtYO34BZd8YEGBJG7
         31vvc7YTm0tLbTS8ZWNQ2FaFXnUrPqPR4WayhqY0PQGKq8Z5nNBVFiOSAXD+zIeXCp
         ehwgXuCT24cG0G1EliQ9sz7KV66R2O3t1byId8gdTP4r7En8rRGnKQAH52b08sJDpG
         lOf6tYYIhnpkw==
Date:   Fri, 2 Aug 2019 14:48:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Patrick Steuer <steuer@linux.ibm.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: linux-next: Tree for Jul 31 - s390 crypto build breakage
Message-ID: <20190802144844.43508be1@canb.auug.org.au>
In-Reply-To: <20190802031414.GB14879@gondor.apana.org.au>
References: <20190731163915.3fdfcb14@canb.auug.org.au>
        <20190731085819.GA3488@osiris>
        <20190731110816.GA20753@gondor.apana.org.au>
        <20190731111520.GC3488@osiris>
        <20190731113216.GA21068@gondor.apana.org.au>
        <20190731114453.GD3488@osiris>
        <20190801122849.GB4163@osiris>
        <CAKv+Gu_1HP2NapMk5O_-XpJdga5zyFJDkVudTRT6CWm+tqPndA@mail.gmail.com>
        <20190802102019.6a789c51@canb.auug.org.au>
        <20190802031414.GB14879@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WV=Ll5clhjs7L92CiGDoOM6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WV=Ll5clhjs7L92CiGDoOM6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On Fri, 2 Aug 2019 13:14:14 +1000 Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
>
> For now I'm going to back out those two specific patches as the
> rest seem to be valid by themselves.

I have applied the top commit from your tree to linux-next today just
to help with building and testing over the weekend (I had already
merged your tree before you added the revert).

Thanks
--=20
Cheers,
Stephen Rothwell

--Sig_/WV=Ll5clhjs7L92CiGDoOM6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl1DwKwACgkQAVBC80lX
0Gx4KAgAiV9cuFhIGVwQAfbUj4A9D69fl2gB+ggN5Tg6pyo4CrosPziIsPG1bEkj
d0RCgB60EJb3You7yESMfn6LMAx15gLTq4UyIImnZiGbgKlpeQNbOGpJ4J5T3UEK
yuXf73EGoh608Mx5guggDqPzk3Ww4BeqUgwZYvLSK9JC/GG73aGkziXPeZSoE9Ta
oz5GRxCXLlHxBsLWry97jZ1d43CIhlio2Z4QLvyOK8cwLRNrb1Hd+qDNog9BvAK3
J+b5Zgj01vCKpuwn8AW3VecydnbQa3UBqiWnjXXrDNRPrPEtRUOXUdmIN0WCppYy
7flo7JAwQqsIx5shJLoh+nsE7xKANw==
=GAVZ
-----END PGP SIGNATURE-----

--Sig_/WV=Ll5clhjs7L92CiGDoOM6--
