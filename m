Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAA9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5A902075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 12:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731172AbfCYMR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:17:58 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:43428 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbfCYMR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 08:17:57 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id A276D72CCAC;
        Mon, 25 Mar 2019 15:17:54 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 8F0417CC74C; Mon, 25 Mar 2019 15:17:54 +0300 (MSK)
Date:   Mon, 25 Mar 2019 15:17:54 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     arnd@arndb.de, linux-arch@vger.kernel.org,
        strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
        ren_guo@c-sky.com
Subject: Re: [PATCH] csky: Update syscall_trace_enter/exit implementation
Message-ID: <20190325121754.GB19244@altlinux.org>
References: <1553515419-1797-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <1553515419-1797-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2019 at 08:03:39PM +0800, guoren@kernel.org wrote:
[...]
> diff --git a/arch/csky/include/uapi/asm/ptrace.h b/arch/csky/include/uapi=
/asm/ptrace.h
> index a4eaa8d..9bf5b1a 100644
> --- a/arch/csky/include/uapi/asm/ptrace.h
> +++ b/arch/csky/include/uapi/asm/ptrace.h
> @@ -62,6 +62,11 @@ struct user_fp {
>  #define instruction_pointer(regs) ((regs)->pc)
>  #define profile_pc(regs) instruction_pointer(regs)
> =20
> +static inline unsigned long regs_return_value(struct pt_regs *regs)
> +{
> +	return regs->a0;
> +}
> +
>  #endif /* __KERNEL__ */
>  #endif /* __ASSEMBLY__ */
>  #endif /* _CSKY_PTRACE_H */

I wonder why we have this #ifdef __KERNEL__ code in the uapi namespace,
it defeats the idea of uapi.  Doesn't it belong to non-uapi
include/asm/ptrace.h namespace?


--=20
ldv

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcmMbyAAoJEAVFT+BVnCUIM+AQAMe0vpZIv4qZieKg3wIu95Dw
Mm0g/7gD9nBwEjnmN6dwMPtWGL7v7fZMdJ9bHLNW9bgpgfbqTDvnavkZrXjS0SKZ
f+vJ1Hfa/wEsYbhfN4oY3lpPMuVEUR76eAItM7n97OfZ5fHaDd45qy0Cp24iwAk2
IQ/CaBat8a0FuJrHeUZ+LlEYVzWkuXjwn6IBKr7bbPQQ8PsbsYC19YggijvJiSRv
S119Zexsy7yQYv5Lex45e4cAwlxKkUyc21qmYgi92wUcCRiVrlDqsR9GB5pBZm/n
S4N3hMQ5Hl7KNYc1tnvr3AifSmJVpwblSSe0SXUeU4Sq+kyqAYYVFZOAHoXbCEp6
836P4PTQR34/1EG4mdHKmXuE/W/w2YRwbcrRrauGUYoKFc6V0KF5hxLCeYJnls+y
ZZLt5nP6x9aXu1glqz8I278qDaWbWrU5Wd2tjfF18qwHAkYjI0zkhA2J9HciRTjR
SpJ6pHxrxQRoe7cqByi2C5qi4Q0WsUm9P/NZIWewOtpUQ3kJC87jnE+PeYm+1AG/
TSy3pWprX+0d2TmPWMfUcnUM0NblaMK+phUdM46V+xE4e4I2SmVMJ/8sidQprhiQ
sbDydfRqS2TlbBkgdlbRIutt7UrQd8MypcWRikgv+h9+NWCoo1p6NSkOudM+Z/Yn
V9MVLm4Yq32EWZCTTj09
=2022
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
