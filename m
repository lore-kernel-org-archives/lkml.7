Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFE7C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEECD215EA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 17:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408481AbfFLR3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 13:29:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:53478 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406395AbfFLR3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 13:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C45A5AEBB;
        Wed, 12 Jun 2019 17:29:16 +0000 (UTC)
Date:   Wed, 12 Jun 2019 19:29:15 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     gorcunov@gmail.com, linux-mm@kvack.org,
        Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [RFC PATCH] binfmt_elf: Protect mm_struct access with mmap_sem
Message-ID: <20190612172914.GC9638@blackbody.suse.cz>
References: <20190612142811.24894-1-mkoutny@suse.com>
 <20190612170034.GE32656@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <20190612170034.GE32656@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2019 at 10:00:34AM -0700, Matthew Wilcox <willy@infradead.o=
rg> wrote:
> On Wed, Jun 12, 2019 at 04:28:11PM +0200, Michal Koutn=FD wrote:
> > -	/* N.B. passed_fileno might not be initialized? */
> > +
>=20
> Why did you delete this comment?
The variable got removed in
    d20894a23708 ("Remove a.out interpreter support in ELF loader")
so it is not relevant anymore.


--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAl0BNl8ACgkQK2l36XSZ
9y4uOxAAjMDNYmUD6lLGAzeXFrP+1e5ZsH+N+j2Qh62Pahnv0oBIbre4TBhAk4xm
av5IPuXrU5Ov5DrRGwDlDP1B2gHbCsvkMxjN+fhrqDRaP9q2y1+UIwKJD66VTxIQ
KiEEiU0uZvikSW4/s4OWstiLxj9nZmiun/YiJ5qVNVuvsfoUjvTHK0BbAN6Vdaab
M80HDqLf+uuERUiaSb8xa5WVB0QViHICBJ2LDfDnVtiioJPn44kPmFwyao+nZJ1T
/RlZ9jFB0UIFSRWIwAxA+qwyWj2hlfT3NC8DMqROJzQDwje6op8keLSWJnwWGMzG
OldDk2uRA5DUi3nliUhp6iv8fDgcryT0IvV5GsphE/LHU/xVMymC0ZkIMksTq4pG
cWU1rnWOLgDpr9BHzP2Zhl7RjSyPUNBojV/hVvo0hpPt2gFgQOlhegKkKl/pURjG
jsLbYKr9aA99OJUEIfk4qK019j6b2If2Ixh5FyXAcxzDpQWIMWAaZdyoFkytnYK9
tKW0uHeCA6irmDKIAQiXfftfLH+UnZtgyOC6LPv17R708LxUpaoUTANh0tP6oLv5
JSABgDwjlbdD9Z9IAfpwOXlbiy5SNyVj68KnZqOfdr0Fb8RVcZ1cLDL8l/EV5COV
40ZmE+Enx5DK9cL9+pTYqi2EPAq96UEZnWOWP9D9s8F2bxjBOAA=
=67iw
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--
