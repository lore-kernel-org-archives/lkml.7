Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F40C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC82217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 00:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbfDXAlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 20:41:35 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:60612 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728615AbfDXAle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 20:41:34 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 64DDF72CC58;
        Wed, 24 Apr 2019 03:41:31 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 5B7D17CCE3A; Wed, 24 Apr 2019 03:41:31 +0300 (MSK)
Date:   Wed, 24 Apr 2019 03:41:31 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [GIT PULL] arch: add pidfd and io_uring syscalls everywhere
Message-ID: <20190424004131.GA19764@altlinux.org>
References: <CAK8P3a3bT=HO=YQ7PY7wOEsJTzf0jS4PkqNHSqYX4JjwmbhY+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <CAK8P3a3bT=HO=YQ7PY7wOEsJTzf0jS4PkqNHSqYX4JjwmbhY+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 23, 2019 at 09:28:48PM +0200, Arnd Bergmann wrote:
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa23=
1b:
>=20
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
> syscalls-5.1
>=20
> for you to fetch changes up to 39036cd2727395c3369b1051005da74059a85317:
>=20
>   arch: add pidfd and io_uring syscalls everywhere (2019-04-15 16:31:17 +=
0200)
>=20
> ----------------------------------------------------------------
> arch: add pidfd and io_uring syscalls everywhere
>=20
> This comes a bit late, but should be in 5.1 anyway: we want the newly
> added system calls to be synchronized across all architectures in
> the release.
>=20
> I hope that in the future, any newly added system calls can be added
> to all architectures at the same time, and tested there while they
> are in linux-next, avoiding dependencies between the architecture
> maintainer trees and the tree that contains the new system call.

Is "everywhere" really means everywhere?
The reason I'm asking this question is that sh64 seems to be excluded:
arch/sh/kernel/syscalls_64.S hasn't got any syscall entries since commit
v4.8-rc1~15^2~3.  Is sh64 supported in any way at all?


--=20
ldv

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcv7C6AAoJEAVFT+BVnCUI0JEQAJ2bzaxtiKTDlR49Nlq0dQhS
fmtO5WLf3d6e11pAG0gyau7tYaLfjVLa1oaLpaH1aRVUrDbX6SyZSkLyaguzeayE
iFvMz5QeDU8QLjMQZd/Gy6Nr5BwGKxUndKcMY2vEvGRXGUlg17rr/DXcmXm5+PIb
hUvzEljiuldojTTTNju1NsTl5Rt6eW+GYG5Sfm/qjGaYaG1qFQUvh5wDx5Ct9qMr
GkKZM+GDnj8fkreM9tQwBpVGKequhdfdMRyCQSAcuGsLxTvClYefRHUd1Wos8xYG
za5Vqz4t2T1JpQTl5bBsnH4bxjjrYRXPO1/WIAIutYRcHZ7SNPTRi/Pxlxzi4XFI
E6N2LuhUFZJmzH3EIguadWlLwalirS4zEY8Q0rnvq4UfnfHG75XuHtTUSpNus/Ar
+hlSaotcRHBmA2wAJjl72KmJSe7xouj2M6ZSBSWmMpE8FefqESXpKCR7vAe8sLOz
RYWsV043x53EWH8rEfALDIqV1IslvWU+DkxeclgCCPMnaril8g72KBRIhW9IzZkf
NkErJHy0ReEQ30ctg7l/Jy2H3ClevOFmsVQ6kiVmaabl4PPfwiAHmmi9BO3SdzIF
P8NJRM/wPvxYV0KlgClGMF4j70hW+fEytmbDZs75THMcr3/VjYSHxgsMdQMS2lE9
SxN5dBBxvaB4KarTpGVS
=sopX
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
