Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D273EC32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E8220665
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 13:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391907AbfHBNdY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 09:33:24 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:48144 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389830AbfHBNdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 09:33:20 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 6C1438037F; Fri,  2 Aug 2019 15:33:06 +0200 (CEST)
Date:   Fri, 2 Aug 2019 15:33:17 +0200
From:   Pavel Machek <pavel@denx.de>
To:     syzbot <syzbot+b156665cf4d1b5e00c76@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        len.brown@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        rjw@rjwysocki.net, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Read in __pm_runtime_resume
Message-ID: <20190802133317.GA5538@amd>
References: <000000000000cd0435058f21e8c3@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <000000000000cd0435058f21e8c3@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-08-02 05:58:05, syzbot wrote:
> Hello,
>=20
> syzbot found the following crash on:
>=20
> HEAD commit:    e96407b4 usb-fuzzer: main usb gadget fuzzer driver
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D146071b4600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D792eb47789f57=
810
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Db156665cf4d1b5e=
00c76
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>=20
> Unfortunately, I don't have any reproducer for this crash yet.

I asked a question, noone bothered to reply, yet you spam me again?

You are a bad bot. Go away. Come back when your human master is
willing to communicate.

								Pavel
							=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1EO50ACgkQMOfwapXb+vKYhQCdHY91WvBbV3DB8W3q/3RcVQjz
/pEAn0cD5LtqdCPW2XZorEGD4M4g0uPN
=iWNk
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
