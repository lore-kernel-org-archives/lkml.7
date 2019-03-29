Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6042C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2F7D20811
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 18:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbfC2SLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 14:11:13 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:52826 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729902AbfC2SLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 14:11:11 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id D572B72CC64;
        Fri, 29 Mar 2019 21:11:09 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id C7C0C7CC74C; Fri, 29 Mar 2019 21:11:09 +0300 (MSK)
Date:   Fri, 29 Mar 2019 21:11:09 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Will Drewry <wad@chromium.org>,
        Kees Cook <keescook@chromium.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@redhat.com>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190329181109.GA32651@altlinux.org>
References: <20190329171221.GA32456@altlinux.org>
 <20190329131514.3e4ec93e@gandalf.local.home>
 <CAEn-LTpY6Tto1N9irXJeOb4iB=qSYhb=jM0E=Z9ppumbPX6GSw@mail.gmail.com>
 <20190329135635.7e136350@gandalf.local.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20190329135635.7e136350@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2019 at 01:56:35PM -0400, Steven Rostedt wrote:
> On Fri, 29 Mar 2019 18:52:18 +0100
> David Abdurachmanov <david.abdurachmanov@gmail.com> wrote:
>=20
> > I have alternative version posted in December part of SECCOMP
> > patchset which is based on arm64 implementation.
> >=20
> > http://lists.infradead.org/pipermail/linux-riscv/2018-December/002450.h=
tml
> >=20
> > I noticed that SECCOMP wasn't working properly if filters were
> > checking syscall arguments, because populated arguments were wrong.
> >=20
> > Btw, I plan to send v2 of SECCOMP patchset soonish.
>=20
> Please do. I want to get my patch series out, which will require these
> changes.

Sorry, I haven't seen the alternative patch posted by David before.
Apparently, besides fixing the bug it also introduces new sanity checks
of "i" and "n" arguments in syscall_get_arguments() and
syscall_set_arguments().

Given that your patchset removes these arguments completely,
I see little sense in adding new checks that are going to be removed
by the subsequent commit in the series.


--=20
ldv

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcnl+9AAoJEAVFT+BVnCUIg2IP/0CQe7zqBd/Ucsy5T9H2Qg+z
cEUGm375hGIVystw8XU6VkZzKKDH5vNv35puJWVPuGyb9LgBVBdpDJo5Y+2icT/t
IONzwecTV4CGQQxT1sdaQdt/zSqDLOczOyby1jOEyqoZy0EGMlrDiDVK251OmQHT
uoqY0HAnaNoNAYGP6ZsO+QNg4bZWonH1AFUxj2Q2Y6h+m28ObyLlRpyuTYRYm696
NBMMWs/oHwb51AA3bR5IfXBZ0hqErWmrk4VJ2LeW2c5xo9thKH4mmLligglACkYa
JKBE4nMmizUFTSu/rKMqisPqEesY3yqgRyj/dRgSQ0/ElDBfhqBxknJUOcLdV7FG
VdiGBln6HrxHsvVvLGJpCa+oH1ju0rW00zvBn726oQt3FVD/7djUwHkKb7DcmEc0
ux+dPVnyNnLM1gxjeRFhbcgQfXWMG5GA3HRDUJpzqFmHP4lbzqxPjdVou4XzFIz0
MngCuVsGEhWsBrTzb4/ZS6BZjn40YvrgsyUI767MwtKG8WylaRpWkarpoOgEc36/
2LuG6IEkVNVY9Cv7r8xC59DUqOu2TeDHMKrpjnf6Z+5aKThQyB8GdmugVu/Dj1Ph
7FAbjAC3wRECwnkjcJnbRfvLdZ3/haO00tIccDVGmzJl2aiQm3wllFW9y6qVo/E1
j+36iOMurjxeiB/dzEJ+
=0Lij
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
