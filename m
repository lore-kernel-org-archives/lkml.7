Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC975C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A09120883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbfDHRPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:15:38 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:57400 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbfDHRPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:15:38 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0A95172CCAC;
        Mon,  8 Apr 2019 20:15:35 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id F36347CCE4F; Mon,  8 Apr 2019 20:15:34 +0300 (MSK)
Date:   Mon, 8 Apr 2019 20:15:34 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Paul Moore <paul@paul-moore.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (Red Hat)" <rostedt@goodmis.org>
Subject: Re: linux-next: manual merge of the audit tree with Linus' tree
Message-ID: <20190408171534.GA11717@altlinux.org>
References: <20190408113131.222f480a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20190408113131.222f480a@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 11:31:31AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Today's linux-next merge of the audit tree got conflicts in:
>=20
>   arch/mips/kernel/ptrace.c
>   kernel/seccomp.c
>=20
> between commit:
>=20
>   b35f549df1d7 ("syscalls: Remove start and number from syscall_get_argum=
ents() args")
>=20
> from Linus' tree and commit:
>=20
>   16add411645c ("syscall_get_arch: add "struct task_struct *" argument")
>=20
> from the audit tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks, the merge fix is correct.
I've also re-tested it using the new selftests/ptrace test
=66rom PTRACE_GET_SYSCALL_INFO patchset.


--=20
ldv

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcq4G2AAoJEAVFT+BVnCUINAoP/14EAeKd7+bWRNdoEU4exRZC
2vn4pFxOrdIYMjW7gPbwrWE1ZOFbCQY1A3hMGAlpY5L3vnYEADgCgivf3Q0avXz5
jREBv6rCeafV9vwl+f8NXeJcLtOg/GcZlGCOShcx/mqJq2bfJIobkkEt2JWgmuOU
0NnD3qaZuhXOSVBC5lOTT+HTcv7EW9IXqF/FgXqF+iSjk18nrAEswbwPn1nlIu3d
IgoU71U8QjAYvQ4rgRVnnv9fpXCRlkv8n4tZJNzgI0JONvvoNg5DXkg5XKx3ZmIW
24G2uABODEoSKNKuZLhQANQC/8U+Q5EGcIHAo61AExhulB3nXG/A4wjbE7YS9Fcp
dkHrvfHYU1xU+9i59pSgbozhCOoFSbFcnvYIKYsziALjh1hNMwSREZWDFKmEwGnf
UXIaz+WBYUUyqhxakmg+qPNnstyx7QKMouwkp1niLaFxp3I7b0r5Ddz+/iC8Mxxd
RpKk1XKOiT18K8iPhCYhytPKVPsT3Wk/ircQqZc06nyPIFwMbbW4NTrr8TbCOALx
2WF48nxt0ICQwRmBecHKXnMILErpaIUc98Q5jg2atRQaFLGz77c0rzU9WAy57yGn
bmoIvoGNeL7zrkn9qERnOHC7Qz8VRpa981tTgTJGdTkQcVpD95+EWj9PMoPtW0vK
E+MT9jnFq/4h2UIHhNI0
=+pnC
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
