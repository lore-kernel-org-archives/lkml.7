Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D606C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CC9218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbfC2SQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:16:23 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:58788 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbfC2SQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:16:23 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 0F77D72CCAD;
        Fri, 29 Mar 2019 21:16:20 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id F1DAB7CC74C; Fri, 29 Mar 2019 21:16:19 +0300 (MSK)
Date:   Fri, 29 Mar 2019 21:16:19 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190329181619.GB32651@altlinux.org>
References: <20190329171221.GA32456@altlinux.org>
 <20190329131514.3e4ec93e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20190329131514.3e4ec93e@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2019 at 01:15:14PM -0400, Steven Rostedt wrote:
> On Fri, 29 Mar 2019 20:12:21 +0300
> "Dmitry V. Levin" <ldv@altlinux.org> wrote:
>=20
> > RISC-V syscall arguments are located in orig_a0,a1..a5 fields
> > of struct pt_regs.
> >=20
> > Due to an off-by-one bug and a bug in pointer arithmetic
> > syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
> > Likewise, syscall_set_arguments() was writing s3..s7 fields
> > instead of a1..a5.
>=20
> Should I add this to my series? And then rebase on top of it?

This is fine with me.  If you are adding the fix for riscv,
please consider adding the fix for csky, too.


--=20
ldv

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcnmDzAAoJEAVFT+BVnCUIEwoQAJFU9YuwW0jEozEhXNul4GNR
E1aMCIPrK/9OKouxQNBkQSRgE5bnbmvvSW5UBDKmJ+kzHXSTvZ2iOV5aPkng7Svk
eVjeBnu8pdX3uNFpZ5WHDVfs+qr7oDuBZpdmK3h1RfxA9PBtwpg/SBOBXlGwCS+J
vYn19hxasA5hJ3bXlBP0ssiQT0hTsqmTkIfD0QWtaPJq3lRXYYHt29CoEgXE6/qv
Ju5XS/2pSH6Lt7JJQvT9BmcE7VIJI/T91mRS7CD8UfS2wyaNDV1r3/PMx2KF+nmN
z/4MTFYXbVHKuxn8ljg6qUWhV4lEaKXInBuIKZN/LHmiuRxgTST6EoBYZrtYjr+O
D6KyotRxjJR703YYrZmZq90Ms/nzshgU5OAeg6mdurmC6wYaf7Sm7WdcZv97HMJ1
FHxpy3zhtIuhif6riqolNqusOXFkhtADURXkSfNoJhiig4EWRxrcOml7+dzQN9Z1
QoVkx79yVTFeV8VbnxhYGR0OkSgmp/DOwa0jBJDCecTBs5lmkGe0WPNd5mYhQ/jw
0SevXWtSTbY9BEiTangFnkx1YuwyFybAHTzvgbVBoagWTbypZU3P57s+Sne5xNN/
MZ6EVNraPEbtimzLrXjvqKXgSHCgkmhzP0u3Z4ll1JRz6qA0jL5k43wwB6842+Ss
XhK4Wa03+nTDpzzB4P1j
=wm1N
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
