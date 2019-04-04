Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AD7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869972082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 14:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfDDOCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 10:02:14 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:42156 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbfDDOCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 10:02:13 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 940DB72CCF7;
        Thu,  4 Apr 2019 17:02:10 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8B1F07CCE4F; Thu,  4 Apr 2019 17:02:10 +0300 (MSK)
Date:   Thu, 4 Apr 2019 17:02:10 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Roland McGrath <roland@hack.frob.com>,
        Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Drewry <wad@chromium.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/6 v3] riscv: Fix syscall_get_arguments() and
 syscall_set_arguments()
Message-ID: <20190404140210.GC4962@altlinux.org>
References: <20190401134104.676620247@goodmis.org>
 <20190401134420.958530155@goodmis.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VywGB/WGlW4DM4P8"
Content-Disposition: inline
In-Reply-To: <20190401134420.958530155@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--VywGB/WGlW4DM4P8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 09:41:07AM -0400, Steven Rostedt wrote:
> From: "Dmitry V. Levin" <ldv@altlinux.org>
>=20
> RISC-V syscall arguments are located in orig_a0,a1..a5 fields
> of struct pt_regs.
>=20
> Due to an off-by-one bug and a bug in pointer arithmetic
> syscall_get_arguments() was reading s3..s7 fields instead of a1..a5.
> Likewise, syscall_set_arguments() was writing s3..s7 fields
> instead of a1..a5.
>=20
> Link: http://lkml.kernel.org/r/20190329171221.GA32456@altlinux.org
>=20
> Fixes: e2c0cdfba7f69 ("RISC-V: User-facing API")
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Will Drewry <wad@chromium.org>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Cc: stable@vger.kernel.org # v4.15+
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

According to
https://lore.kernel.org/lkml/mhng-8e9b547b-7fe3-43d2-9dea-b217de923605@palm=
er-si-x1c4/
the following tag could be added to this patch:
=20
Acked-by: Palmer Dabbelt <palmer@sifive.com>


--=20
ldv

--VywGB/WGlW4DM4P8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcpg5iAAoJEAVFT+BVnCUIDIAP/3GSr42HPH1rGGfez7Mp3k1o
M+8EC8bLlrRNLd2j5aoPWq+nkh+cWTnfv0b8ti6L7mvbQn5234wD/bDsE7Gu0XXA
msxnRFf810p+74KGQRkPVsBzchSE6lP3y3uvKTsB80UGMPI+B7T17PMxCbFjpFPT
a5wX7cJ2aAimU3h36wwKA5x65oJk18cI4/+hu4bXKRiUkYNMtbHKS+oqAGgDNuax
awzYF8Ii6Kd7PP+dIIf/Uc00FKdv8wLIgOcAXrM65QyrpyQDwfmdvH9r4mf2P/IK
D0FsyQt45fBMwSocQltMJUqB264I7BWT6JnqftwsEZlmREHG0zg8egOb7BvMJJXZ
ijSzX1SXiiv58EKUDqchjA/8T7mgPr0VybnWDPXN/RAbCyIFxtd8jQ6hpB8IoTri
oRazU1t9KuJ+m5TTEixoNmu64NsRL0eyqgAsIeLP4qSHDKGAYBM2ZR/eqTFGtvgK
Dk6XbKWaVkQRPFp9EDO/1W/cSo2XJiKV+viSl3DrbxdfCXpZ5PGz+vU+ICRvm/eF
Hnw2Qe0ZPAQtmjzDD83fRLYiImN6UuULnXzFM5STsQIFwRscGDGVI39F+0tESXI9
1+4lzzn0lZL1t9pMIdHAu+o/eyqu2O5pD3rQVBweGT+3LQ9dhoTTl14U6XSjUHOl
0DoNd/EsPdwSIOTAT/QG
=0m93
-----END PGP SIGNATURE-----

--VywGB/WGlW4DM4P8--
