Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF5C606B0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB79216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 23:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nz5TC8cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbfGHXxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 19:53:25 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:55225 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbfGHXxY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 19:53:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45jMhy09TKz9s7T;
        Tue,  9 Jul 2019 09:53:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562630002;
        bh=2T2JsOmtRI9BYzCgGS52aR+LQlC+ky3qjxLHPZyECDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nz5TC8csNcNYbfCvNfPZXaqRRneBg0OxZgg8dDOBBa2CvpLe50D+Xta5apuBU6d98
         rKVCUHjkQU8YHA7RM6k/dkOjbEQUmjKR2/yrfle2/ylZIZRthNgKpX3aGob2Y/WbVC
         EHhtDelB00nTH43TFby9dPTwLUcw/ZTlCqqO4mcik5Um8azWoYMO+vfkzlw6/BPfp3
         yglsTiAwSIvYlFQA0hsHO1HpKPyaPgTexzEKoT6iFFwqMyG1uRjBs6Q57m685exWOv
         bYYmuo3YSsjxB4QnIt/UgOlcpLRAkyqn6J/y+S4W3WxJHrWt/EnNHC1eiVbzsxZFf5
         WxitGCWLoBF8Q==
Date:   Tue, 9 Jul 2019 09:53:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: linux-next: manual merge of the kvms390 tree with Linus' tree
Message-ID: <20190709095321.79175dfe@canb.auug.org.au>
In-Reply-To: <20190621154315.0a4d5f54@canb.auug.org.au>
References: <20190621154315.0a4d5f54@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/AJIC0XyY/9f0gT_N3IIHmKI"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AJIC0XyY/9f0gT_N3IIHmKI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 21 Jun 2019 15:43:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
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
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc tools/testing/selftests/kvm/Makefile
> index 62afd0b43074,0d7265da1583..000000000000
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@@ -10,25 -10,29 +10,30 @@@ UNAME_M :=3D $(shell uname -m
>   LIBKVM =3D lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/ucall.c l=
ib/sparsebit.c
>   LIBKVM_x86_64 =3D lib/x86_64/processor.c lib/x86_64/vmx.c
>   LIBKVM_aarch64 =3D lib/aarch64/processor.c
> + LIBKVM_s390x =3D lib/s390x/processor.c
>  =20
>  -TEST_GEN_PROGS_x86_64 =3D x86_64/platform_info_test
>  -TEST_GEN_PROGS_x86_64 +=3D x86_64/set_sregs_test
>  -TEST_GEN_PROGS_x86_64 +=3D x86_64/sync_regs_test
>  -TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_tsc_adjust_test
>  -TEST_GEN_PROGS_x86_64 +=3D x86_64/cr4_cpuid_sync_test
>  -TEST_GEN_PROGS_x86_64 +=3D x86_64/state_test
>  +TEST_GEN_PROGS_x86_64 =3D x86_64/cr4_cpuid_sync_test
>   TEST_GEN_PROGS_x86_64 +=3D x86_64/evmcs_test
>   TEST_GEN_PROGS_x86_64 +=3D x86_64/hyperv_cpuid
> - TEST_GEN_PROGS_x86_64 +=3D x86_64/kvm_create_max_vcpus
>  -TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_close_while_nested_test
>  +TEST_GEN_PROGS_x86_64 +=3D x86_64/mmio_warning_test
>  +TEST_GEN_PROGS_x86_64 +=3D x86_64/platform_info_test
>  +TEST_GEN_PROGS_x86_64 +=3D x86_64/set_sregs_test
>   TEST_GEN_PROGS_x86_64 +=3D x86_64/smm_test
>  +TEST_GEN_PROGS_x86_64 +=3D x86_64/state_test
>  +TEST_GEN_PROGS_x86_64 +=3D x86_64/sync_regs_test
>  +TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_close_while_nested_test
>   TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_set_nested_state_test
>  -TEST_GEN_PROGS_x86_64 +=3D kvm_create_max_vcpus
>  -TEST_GEN_PROGS_x86_64 +=3D dirty_log_test
>  +TEST_GEN_PROGS_x86_64 +=3D x86_64/vmx_tsc_adjust_test
>   TEST_GEN_PROGS_x86_64 +=3D clear_dirty_log_test
>  +TEST_GEN_PROGS_x86_64 +=3D dirty_log_test
> ++TEST_GEN_PROGS_x86_64 +=3D kvm_create_max_vcpus
>  =20
>  -TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
>   TEST_GEN_PROGS_aarch64 +=3D clear_dirty_log_test
>  +TEST_GEN_PROGS_aarch64 +=3D dirty_log_test
> + TEST_GEN_PROGS_aarch64 +=3D kvm_create_max_vcpus
> +=20
> + TEST_GEN_PROGS_s390x +=3D s390x/sync_regs_test
> + TEST_GEN_PROGS_s390x +=3D kvm_create_max_vcpus
>  =20
>   TEST_GEN_PROGS +=3D $(TEST_GEN_PROGS_$(UNAME_M))
>   LIBKVM +=3D $(LIBKVM_$(UNAME_M))

I am still getting this conflict (the commit ids may have changed).
Just a reminder in case you think Linus may need to know.

--=20
Cheers,
Stephen Rothwell

--Sig_/AJIC0XyY/9f0gT_N3IIHmKI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0j13EACgkQAVBC80lX
0Gw3FggAkp8Yp06G+AHtkJwgTUEh5zfEcvMHIH7L/w2NcFlv3XrEHEA8G0tnA6AW
oKb+UjPJz79QCX9q4GAJQBFi9oBBS9VdEZxiKKpfHd6v59xqG54P3IphQ+9//oIl
ttN/Se9px9TAf2sN09T0kEtvsMDJ9NIPGZ2DCadYkflYGmCnScaQMZ9Xx2rWENjA
zxPrIxWu9qVr1stYfOIQ3+i36TQCyBD/KrQuGaAwaWr2BuzCRFtFogWKrnXzwz3D
nJ4r28owSpIl3vJ03RXb3csLse2pEeeAbpSlNarvQ7oexNCwGjGdyTv2n4l5BOjV
lrQqBtym1TtlhNWcobThceqhUOel6A==
=bfBh
-----END PGP SIGNATURE-----

--Sig_/AJIC0XyY/9f0gT_N3IIHmKI--
