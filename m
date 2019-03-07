Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58317C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F572081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfCGL1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:27:17 -0500
Received: from monster.unsafe.ru ([5.9.28.80]:42140 "EHLO mail.unsafe.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfCGL1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:27:17 -0500
Received: from Legion-PC.fortress (nat-pool-brq-t.redhat.com [213.175.37.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.unsafe.ru (Postfix) with ESMTPSA id C8A90C61AC5;
        Thu,  7 Mar 2019 11:27:14 +0000 (UTC)
Date:   Thu, 7 Mar 2019 12:27:12 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH v1] moduleparam: Save information about built-in modules
 in separate file
Message-ID: <20190307112712.GA8455@Legion-PC.fortress>
References: <20190306165425.GD14017@MacBook-PC.fortress>
 <871s3jv97c.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <871s3jv97c.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 04:07:03PM -0800, Andi Kleen wrote:
> Alexey Gladkov <gladkov.alexey@gmail.com> writes:
>=20
> > Problem:
> >
> > When a kernel module is compiled as a separate module, some important
> > information about the kernel module is available via .modinfo section of
> > the module.  In contrast, when the kernel module is compiled into the
> > kernel, that information is not available.
> >
> > Information about built-in modules is necessary in the following cases:
> >
> > 1. When it is necessary to find out what additional parameters can be
> > passed to the kernel at boot time.
> >
> > 2. When you need to know which module names and their aliases are in
> > the kernel. This is very useful for creating an initrd image.
>=20
> I would just keep it in the vmlinux as a non loadable segment, which
> won't make it into bzImage. vmlinux passed around anyways, and
> it's easier to handle than extra files, and it already has plenty
> of metadata in it.

Not for all architectures bzImage is created. Also not all distros pack
vmlinux and requiring them to start doing this for a few kilobytes seems
to me wrong.

As follow up I plan to add support of kernel.builtin.modinfo to kmod. The
kmod takes information only from /lib/modules/KVER and does not require the
kernel itself.

--=20
Rgrds, legion


--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcgQAQAAoJEKRaulRM/9Q0DzEP/3WLVGNcIlU3AzYjqmTBeMa/
MiYIb2wbI/hgbcQHgaNF5oc5irzSeH1adCK4miuuucwg3MLw0XK8CabdIGSyJJeb
g4mTFm3AL/XzOKFsCrWFOdpmvIBM5UYOmVflW0G/Z2BiTWuU4AXPNVj7n5WD/ib9
TPIBUr/3lsYmax/saIBQXlZ5xPy46NQvWtUMaVXzPppdEDgtgfu/rlIQ0GcA77oh
+TqinCQMquomARLJapVwBi3KRbdWjrZv0xi/17cJsn2ESKchXha2FE7BK04QtAaZ
3z3IAyRHCv6fkKPLzRVp0DtsnXxVwLnEsXKLpXzfqMvnRJYKsAAVL0sWv6lBFp3/
TbchI67HxMUdIyDydMTr5cYARzc/FdTKX76Zq6tnVfgvkkWeKng29bAIEeNmCZMQ
OWrvh7w2Os1jWjwOm0o1impqEqEjrwixkjAY2blI3UB5/V2KT7IrtF1Hy+u+nr9M
22w2a0en2IeWa1Qu7yLkaz2S/ZZhqmwLqe4iECYyAvVP7CloKrheCL1CT4QhX5jV
PmFM7zdTdARcbcCu1+mhjl1l3c9XssECt6l6MZjzH7ICcjdfhjPGPIM3BxJRW4sy
AP7YDoOZJwPQCOwXLaiqyVwvxlj6xo/Ym+/MIIqxayKF4C62ZSjQYa9VM0lETMSx
hwcjQIi5GoOtj/TK1f0P
=lVI/
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
