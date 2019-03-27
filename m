Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 951B0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3712075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 01:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfC0B0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 21:26:10 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:46702 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfC0B0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 21:26:08 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 6BCD972CCAC;
        Wed, 27 Mar 2019 04:26:06 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 61C917CC74C; Wed, 27 Mar 2019 04:26:06 +0300 (MSK)
Date:   Wed, 27 Mar 2019 04:26:06 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH v2] x86/syscalls: Mark expected switch fall-throughs
Message-ID: <20190327012606.GA16532@altlinux.org>
References: <20190228192746.GA13021@embeddedor>
 <alpine.DEB.2.21.1903231457590.1798@nanos.tec.linutronix.de>
 <20190326151244.GC16837@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20190326151244.GC16837@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 04:12:45PM +0100, Oleg Nesterov wrote:
> On 03/23, Thomas Gleixner wrote:
[...]
> >  2) syscall_set_arguments() has been introduced in 2008 and we still ha=
ve
> >     no caller. Instead of polishing it, can it be removed completely or=
 are
> >     there plans to actually use it?
>=20
> I think it can die.

When PTRACE_GET_SYSCALL_INFO is finally squeezed into the kernel,
we could discuss adding PTRACE_SET_SYSCALL_INFO as well, and it
will need syscall_set_arguments().


--=20
ldv

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJcmtEuAAoJEAVFT+BVnCUI3zUP/2RZWYWuiAp3lHUdLmqHR3eY
3u8EEPpVPtF+crpRfqoQiW2FG2cSKfRnEHfrFw9zldkcVtzrRIMuk9o/7cPyPtb2
A68+LQzhB4Np4VOhoYp75OpQFFkYZYkyvKcFdCgOrnOsqXz7//S+9coaSaImNOqG
Pn6l6aozZ77rCZ2YIv6viLQNo8eHhs0Qkdo0dsZ6RIDfAbRcXx7KNhNBZF2yxYis
QQJrf/vU/PmjOLCFvHsOKqZRF0fh9OMG2R+9CizYfbQv3KZb5oWXVH+F2SLwQhRO
xXCDJJ203Ete6xZHcwMNheZmBX7+TfiXowlatY5DE2dVSBS+n5sVlceprKNg1Cq1
97No96ngGmcCywXSHxDUPUcEVN1XNGN+V5mhGWO4aV5T4bbmcEVk6pYHflOVng2z
gknj0x2PBgR0k4eVtZvBt2j+owrHS1oSS34wBP4DVCriicwIDNMqv+2cWOKs/BHn
o6b17QFVbh8+DbfaBvaAVzlrJneAwkbP5BstorFdCiplRcu6NCY0rkj/T8f3urOO
esDLlxaizbPGDX/uc0GvG/HgPJC+qt+qZXxE6bsYHLEKvKZFGMrOPbTws3bGl85A
iHz+hVMF5g1YnICerbnmQdXcpUopR9XcmpI1cSaxj1hbWh3mfNzhmwtiXrwB+jCp
eR7q0PDioucgVdaLAtbd
=UA9I
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
