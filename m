Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD851C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E761218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfCUGIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:08:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:46860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725800AbfCUGIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:08:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 171D3AFF1;
        Thu, 21 Mar 2019 06:08:08 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     syzbot <syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com>,
        bfields@fieldses.org, jlayton@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Date:   Thu, 21 Mar 2019 17:07:59 +1100
Subject: Re: general protection fault in __x86_indirect_thunk_rbx
In-Reply-To: <000000000000b3976c0584940e6e@google.com>
References: <000000000000b3976c0584940e6e@google.com>
Message-ID: <87lg187oao.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20 2019, syzbot wrote:

> syzbot has bisected this bug to:
>
> commit dee160df820de41ff2f59a715643680822a0ab06
> Author: NeilBrown <neilb@suse.com>
> Date:   Mon Nov 5 01:30:47 2018 +0000
>
>      locks: use properly initialized file_lock when unlocking.

This commit did not make it to mainline.
It was replaced by

Commit d6367d624137 ("fs/locks: use properly initialized file_lock when unl=
ocking.")

which added a call to locks_init_lock() in flock_make_lock().

NeilBrown

>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D13f39fd720=
0000
> start commit:   dee160df locks: use properly initialized file_lock when u=
n..
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=3D100b9fd720=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17f39fd7200000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcaa433e1c8778=
437
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D83e12cf81d2c148=
42146
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15bd9447400=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1121d82b400000
>
> Reported-by: syzbot+83e12cf81d2c14842146@syzkaller.appspotmail.com
> Fixes: dee160df ("locks: use properly initialized file_lock when=20=20
> unlocking.")

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlyTKkAACgkQOeye3VZi
gbne0hAAqYfEfGRgEWYgVOZtRJTccuuxkZBfdZwp07Xn2L8Jq9ypS/6esIlXm1WT
9WlfcA+812/Tsucz19qISeIhCPkntvvofglJWZRXrQANhQwm7spGHzQ9A2hnYrCq
CmlnSuFYYCkDWLETpeoIAlMDelGFBP0lJqr4YpQz8+29RqWk5+/Dya6gDeynFivx
OHNhZ7Fr7juIa6LwtLZFbPdnpVGAzXVPAP6Uy4irBPrnvoHqloQkhao73tlid+GT
d5IgEzq2QezLXXNXMrC02IAP59/CvTHS0Wp8KE5KxjfG7ztTbwNWDtTSRY7LKWmD
VMPvwdHzDh+7yp6iZjwGvTftxTbLOhRBhu5+IYvG07KxaCZhgSUW0ApnK3H4K8ER
KEHQeGG3NhqHeSIaKcRWNwCyADpmWTIcrGjqU2OFM5MBk3Gu+kb7rel3iVXiACW1
i8XseGhzF2odCSo8ucRNIbhPgO0dWdLYFsCUwJP7JS5K9QFemsx/00uc38y0a6iW
ouduTKG3Obedd2VOEan8XAPQNgHtNLTKPiGGtK//C+4FyUxEfD8D6yTwE8kgRcbo
dAhJe2uTE3nMpsvVqIdk/f0E2lCZJO3MfVfH44nbwpIUTH13c50VDRUlugz6JFoe
NDOOGMkXvzGjRmVWTifQ6JetMopS1VuH0T5TZqjbqXgzap381Ns=
=d21Y
-----END PGP SIGNATURE-----
--=-=-=--
