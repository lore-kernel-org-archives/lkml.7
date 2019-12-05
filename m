Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D025BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15A220659
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 22:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbfLEWOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 17:14:55 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:44752 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbfLEWOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 17:14:55 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3AE5F1C246E; Thu,  5 Dec 2019 23:14:53 +0100 (CET)
Date:   Thu, 5 Dec 2019 23:14:52 +0100
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 226/321] mm/hotplug: invalid PFNs from
 pfn_to_online_page()
Message-ID: <20191205221452.GB25107@duo.ucw.cz>
References: <20191203223427.103571230@linuxfoundation.org>
 <20191203223438.874783822@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <20191203223438.874783822@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MW5yreqqjyrRcusr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This is due to the commit 9f1eb38e0e11 ("mm, kmemleak: little
> optimization while scanning") starts to use pfn_to_online_page() instead
> of pfn_valid().  However, in the CONFIG_MEMORY_HOTPLUG=3Dy case,
> pfn_to_online_page() does not call memblock_is_map_memory() while
> pfn_valid() does.
=2E..
> Fixes: 9f1eb38e0e11 ("mm, kmemleak: little optimization while scanning")

Commit 9f1eb38e0e11 does not seem to be in v4.19-stable tree. Is this
commit still neccessary/good idea?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXemBXAAKCRAw5/Bqldv6
8u04AKCqIrnoi0YcdRYZHeFmU+3ze5lRjwCgnNASLI6ofSVqOzrZ5hkmQly8FtI=
=Fc4n
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
