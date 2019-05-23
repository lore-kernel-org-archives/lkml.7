Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E00C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8A621773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 17:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbfEWRBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 13:01:03 -0400
Received: from phlegethon.blisses.org ([50.56.97.101]:46479 "EHLO
        phlegethon.blisses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730860AbfEWRBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 13:01:03 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 May 2019 13:01:02 EDT
Received: from cocytus.blisses.org (cocytus.blisses.org [64.223.129.151])
        by phlegethon.blisses.org (Postfix) with ESMTP id 39A00194DF0;
        Thu, 23 May 2019 12:52:59 -0400 (EDT)
Received: from blisses.org (acheron.int.blisses.org [10.0.1.10])
        by cocytus.blisses.org (Postfix) with ESMTPSA id 037EB80323;
        Thu, 23 May 2019 12:52:58 -0400 (EDT)
Date:   Thu, 23 May 2019 12:52:56 -0400
From:   Mason Loring Bliss <mason@blisses.org>
To:     Devel <zfs-devel@list.zfsonlinux.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Nicolai Stange <nstange@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [zfs-devel] Re: [PATCH] x86/fpu: allow kernel_fpu_{begin,end} to
 be used by non-GPL modules
Message-ID: <20190523165256.GD8766@blisses.org>
References: <20190522044204.24207-1-cyphar@cyphar.com>
 <20190522100959.GA15390@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20190522100959.GA15390@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 12:09:59PM +0200, Greg KH wrote:

> No, please, we have gone over this before, we do not care at all about
> external kernel modules, ESPECIALLY ones that are not GPL compatible.

The best option here is for you to start caring. Makes the world a better
place.

Free software people doing what they can to attack other free software based
on relatively trivial idealogical differences isn't a good look, and it's b=
ad
for the users.

--=20
Mason Loring Bliss  ((   If I have not seen as far as others, it is because
 mason@blisses.org   ))   giants were standing on my shoulders. - Hal Abels=
on

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEEXtBZz1axB5rEDCEnrJXcHbvJVUFAlzmz+cACgkQnrJXcHbv
JVVupw/7Bq36ybgI/6t7HDNeyUvKEHP5Jevf/nkUFQSSSwOU65qHzGLUcxjoMY31
jtLufmbCL4ggvA9yVxnQY3T1C4aT+j61IAPvKJ1AUgbfXxoahRgz0Lbf2HxKiSf/
jTBNAjGXaP06UmlWG2+Io15P90k2lThO67VPGtkH6/IqvynqIo0xE5zYnzDXu+XW
RDH0IlwvRt62jJjdNDQQw9Hz4JHebIrymgbUeSfLTPKYeb4eqnrrV1TpRQOIevTF
XjGaD5L21kr/00f1K7UvY9X0tYYVWBG1PC3RhKk1diTpRRypuYbkf05JowjqpE8O
sJYPY94ZUILz75mC8l2OCx2WbAEMeQ1zKQ16I9i1TLXysGl0cRpmfRjJPvyEjVAl
LJ+gaYyeOZVU9Leu4q2yYYyTXnJnKhbYaWcedNcPGpoSgLR9zQiHKhjG7wPXFW7v
iRztgB1EYuWXWscq7NfQmVTKUfVDq+LltKCtZePvMl+jW+zynoo5vZPhYgn84aBF
zLLHsoVehHAlHsp02SeEJWY9oNvxXUgwN7qxzU9VCMM6ns9fDnkHngXvLefuMQF6
EiQYmJoxjU8RBlyt++MlCjNydl2xSx5HFl5W87H1VFgxwDm/Ai2dL+PFVMv3+uZ+
RbC4VId+Z5UJUHqtw9ynsCR3lQVPbpfV5llf+vT7xdMQIveGp9Q=
=QjP0
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
