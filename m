Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A3C8C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E802089E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfFUIFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:05:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40406 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfFUIFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F2D7930821C0;
        Fri, 21 Jun 2019 08:05:17 +0000 (UTC)
Received: from gondolin (dhcp-192-192.str.redhat.com [10.33.192.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B005E19722;
        Fri, 21 Jun 2019 08:05:16 +0000 (UTC)
Date:   Fri, 21 Jun 2019 10:05:06 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: linux-next: manual merge of the kvms390 tree with Linus' tree
Message-ID: <20190621100506.16a04050.cohuck@redhat.com>
In-Reply-To: <20190621154315.0a4d5f54@canb.auug.org.au>
References: <20190621154315.0a4d5f54@canb.auug.org.au>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/537ZVHAA4mwT_g40ZASjXPc"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 21 Jun 2019 08:05:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/537ZVHAA4mwT_g40ZASjXPc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 21 Jun 2019 15:43:15 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>=20
> Today's linux-next merge of the kvms390 tree got a conflict in:
>=20
>   tools/testing/selftests/kvm/Makefile
>=20
> between commit:
>=20
>   61cfcd545e42 ("kvm: tests: Sort tests in the Makefile alphabetically")
>=20
> from Linus' tree and commits:
>=20
>   ee1563f42856 ("KVM: selftests: Add the sync_regs test for s390x")
>   49fe9a5d1638 ("KVM: selftests: Move kvm_create_max_vcpus test to generi=
c code")
>=20
> from the kvms390 tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20

Thanks, looks good.

--Sig_/537ZVHAA4mwT_g40ZASjXPc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl0Mj7IACgkQ3s9rk8bw
L69STQ//cZ1nLCh5h0fl1pK9I4n0kCsnbmNfj5lfo9Shof5RqgIAw6W4sXaaZcpg
C8Vt7l9MaySdu+ur1f7NTyCOg4nFZ1yM3Y6YCrZSU+iMpPU0XTgDWf+c3Xc9QYWX
bGZgDFz4RvBNUYFzRDO7JS4XDNyfTcx55RdIoE/pHK9rSXkHfxjApjgEVMxlZBem
SFoPEDvoVtl8MUGlIKKma2PgZRpT5ixkB4lVVOK88YFXzVRlwDjW1sc31YsNxhdB
yiQnzMc/ZwxbfXl0ULK29dETxt8MeqRt13q5O5+jqCyoI3dpAwwQh7WlooFFBvXp
Pv7HN6YPxvcDm31qREiF9hBxn0XpPo2ghXDdUAMOaoBF4Pmrtq7PR0L5nviH0GM1
E7jyDYZ4d16Sij5MAhL+UybgyBlHS1xeeyNAekoG7ttHuFphaDOOcAVojL8xHyHK
ypJYGgPgGwp5SkXbT9FSjurZsIdjvTSDLjK2CFs0gAiwCkgxbSkVAqTu75fvK0Pk
3ix1PrVm1p+yXh2Dvk7Jlub7HNRAXTG8FDnHEmsIZPsZXoninNLrgaXz7NQvsT8Z
YZqpvRwYptF9Dk18fSQDvh4c18lKVs5Rpu48lNtAZ2sSekuLBAmD+nyYPSN27PWO
wHvdb6InEuA0gDqUXH9yeduUuOB9vpiRfpA06e2uRxgezcn5vKU=
=divz
-----END PGP SIGNATURE-----

--Sig_/537ZVHAA4mwT_g40ZASjXPc--
