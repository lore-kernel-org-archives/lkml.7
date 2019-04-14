Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C39C282CE
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9F22148E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 07:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfDNH7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 03:59:14 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:43667 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfDNH7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 03:59:14 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 9912280721; Sun, 14 Apr 2019 09:59:03 +0200 (CEST)
Date:   Sun, 14 Apr 2019 09:59:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     syzbot <syzbot+9880e421ec82313d6527@syzkaller.appspotmail.com>
Cc:     amitoj1606@gmail.com, ap420073@gmail.com, avagin@gmail.com,
        dbueso@suse.de, ebiederm@xmission.com, jacek.anaszewski@gmail.com,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-mm@kvack.org, oleg@redhat.com, prsood@codeaurora.org,
        rpurdie@rpsys.net, syzkaller-bugs@googlegroups.com, tj@kernel.org
Subject: Re: INFO: task hung in do_exit
Message-ID: <20190414075915.GA29199@amd>
References: <000000000000e02bf505866414ae@google.com>
 <00000000000074e9d5058674a94f@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <00000000000074e9d5058674a94f@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2019-04-13 19:55:00, syzbot wrote:
> syzbot has bisected this bug to:
>=20
> commit 430e48ecf31f4f897047f22e02abdfa75730cad8
> Author: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> Date:   Thu Aug 10 16:28:09 2017 +0000
>=20
>     leds: lm3533: constify attribute_group structure
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15f4cee320=
0000
> start commit:   8ee15f32 Merge tag 'dma-mapping-5.1-1' of git://git.infra=
d..
> git tree:       upstream
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D17f4cee320=
0000

Is there human around? Please take your bot on the leash, this is
obviously bogus.
=20
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyy6FMACgkQMOfwapXb+vKFOwCfRgWU/WYanrFj17ZPDxKfLlwx
h+YAn3ywd9WkPk9NCik/4tydk6tI98bO
=aFTb
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
