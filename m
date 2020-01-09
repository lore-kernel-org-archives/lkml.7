Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD89C282DD
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D5C2075D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 21:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgAIVFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:05:38 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:34108 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgAIVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 16:05:38 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E2A021C25CE; Thu,  9 Jan 2020 22:05:36 +0100 (CET)
Date:   Thu, 9 Jan 2020 22:05:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Subject: Re: OOM killer not nearly agressive enough?
Message-ID: <20200109210535.GB1553@duo.ucw.cz>
References: <20200107204412.GA29562@amd>
 <20200109115633.GR4951@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Content-Disposition: inline
In-Reply-To: <20200109115633.GR4951@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-01-09 12:56:33, Michal Hocko wrote:
> On Tue 07-01-20 21:44:12, Pavel Machek wrote:
> > Hi!
> >=20
> > I updated my userspace to x86-64, and now chromium likes to eat all
> > the memory and bring the system to standstill.
> >=20
> > Unfortunately, OOM killer does not react:
> >=20
> > I'm now running "ps aux", and it prints one line every 20 seconds or
> > more. Do we agree that is "unusable" system? I attempted to do kill
> > from other session.
>=20
> Does sysrq+f help?
>=20
> > Do we agree that OOM killer should have reacted way sooner?
>=20
> This is impossible to answer without knowing what was going on at the
> time. Was the system threshing over page cache/swap? In other words, is
> the system completely out of memory or refaulting the working set all
> the time because it doesn't fit into memory?

What statistics are best to collect? Would the memory lines from top
do the trick? I normally have gkrellm running, but I found its results
hard to interpret.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXheVnwAKCRAw5/Bqldv6
8ltpAJ96WOJA8wlWQlNnrSUmaHkimRk6dwCdHRfTvxQxVf+vUV01MoDCPPpBrWw=
=3Jem
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
