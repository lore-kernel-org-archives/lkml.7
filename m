Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377F3C10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F3620857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 14:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730191AbfDBOcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 10:32:53 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44592 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728908AbfDBOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 10:32:52 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBKT4-00062H-3t; Tue, 02 Apr 2019 15:32:50 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBKT3-0005qW-IR; Tue, 02 Apr 2019 15:32:49 +0100
Message-ID: <0fb333560ad4ed9d5c8bc0f71a46fee5b448f9e6.camel@decadent.org.uk>
Subject: Re: [PATCH 3.16 23/99] tty/ldsem: Wake up readers after timed out
 down_write()
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Dmitry Safonov <0x7f454c46@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Denis Kirjanov <kda@linux-powerpc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Dmitry Safonov <dima@arista.com>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 02 Apr 2019 15:32:49 +0100
In-Reply-To: <CAJwJo6ahUWWSMWfM+qk109YfzJAB0HBMKcrVFqK2wzdBv_OtGQ@mail.gmail.com>
References: <lsq.1554212307.17110877@decadent.org.uk>
         <lsq.1554212307.770456214@decadent.org.uk>
         <CAJwJo6ahUWWSMWfM+qk109YfzJAB0HBMKcrVFqK2wzdBv_OtGQ@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-tgzgFphxCjMOeCJzrSHr"
User-Agent: Evolution 3.30.5-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-tgzgFphxCjMOeCJzrSHr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2019-04-02 at 15:22 +0100, Dmitry Safonov wrote:
> Hi Ben,
>=20
> JFI: I haven't checked your tree, but the same patches set contains fixes
> that are more important to my mind (looking at 4.9 stable tree):
> - "tty: Drop tty->count on tty_reopen() failure" commit fe3241679009

You marked this as applicable to 4.6+.  Is it actually applicable to
older versions as well?

> - "tty: Hold tty_ldisc_lock() during tty_reopen()" commit 83d817f41070
>   with follow-up fixup "tty: Don't hold ldisc lock in tty_reopen() if
> ldisc present"
>   commit d3736d82e816
[...]

I will include these in a later update, unless you think they are
really urgent and should be added to this one.

Ben.

--=20
Ben Hutchings
Klipstein's 4th Law of Prototyping and Production:
                               A fail-safe circuit will destroy others.



--=-tgzgFphxCjMOeCJzrSHr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAlyjcpEACgkQ57/I7JWG
EQkPmA//bbFgu9N72NpQ9QSGyUrI6Wpkm9igwU2W48Fw/HXNCuO20QHqGgxg2Bss
Mp3rITekojM0GnUOMFKIIBzGBgBYiczSmXUviW8UTpQKHNSCsAYCSnbdt1E8wdTR
OavrLE7rj5eeIfFleChVicx4+LGkptwLhdRzuf/7eELFmcG1qK0MYHIoIzhNxe1I
ge53BxSOcBbcFbULIOqam0Bq/g3f+9r+dGon36zQ8csSDjBiSENYaii2hF5KoPj+
XuOIhEKUtupHuIcVbn3+cnfL3szDQETFV5OOR34W8TDIz27iXKeR413nURkwIy9x
xuLcx26QIWmKaKeeVLE/4X/A2BLOSobKTr1MQGIW3XdcxaXS/jYAbancEPJPMFsF
BjMVbJw6cn60XfDgp9kqxFOrRLtxX92Tg7fJgvoby25Pb54m5eKkP+NEhYxwegai
6heT87uzGfgbfl1HAzH0f7s4c5Y4SwU4P/LrcedRLcMUhwzd5UJ4qgGDpFZEDmUf
TfDL1tPtdVLj4hr8+alD49r7FoIC/OHTeLHopERZ/kicDMLOcz0OSgHtiKDm000b
vjmH0T3QJUL8HHQTeH213ZzYTEyQmh7Rv7OIs2+VDUVOgIlOLP5OsllcfEeV3LvS
vDNtdFxFMCAKbOjFhMx3V5C5ff7BP/rsdYugh0HetfAI6Chd5kU=
=Hmi7
-----END PGP SIGNATURE-----

--=-tgzgFphxCjMOeCJzrSHr--
