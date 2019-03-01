Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2004BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE802087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 09:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbfCAJan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 04:30:43 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53985 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbfCAJan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 04:30:43 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 979D64001C;
        Fri,  1 Mar 2019 09:30:39 +0000 (UTC)
Date:   Fri, 1 Mar 2019 10:30:38 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Gerhard Wiesinger <lists@wiesinger.com>
Cc:     arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
Subject: Re: Banana Pi-R1 stabil
Message-ID: <20190301093038.oz56z22ivpntdcfw@flea>
References: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
 <20190227092023.nvr34byfjranujfm@flea>
 <5f63a2c6-abcb-736f-d382-18e8cea31b65@wiesinger.com>
 <20190228093516.abual3564dkvx6un@flea>
 <91c22ba4-39eb-dd3d-29bd-1bfa7a45e9cd@wiesinger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5dqx3l4hsuk3weiw"
Content-Disposition: inline
In-Reply-To: <91c22ba4-39eb-dd3d-29bd-1bfa7a45e9cd@wiesinger.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5dqx3l4hsuk3weiw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 28, 2019 at 08:41:53PM +0100, Gerhard Wiesinger wrote:
> On 28.02.2019 10:35, Maxime Ripard wrote:
> > On Wed, Feb 27, 2019 at 07:58:14PM +0100, Gerhard Wiesinger wrote:
> > > On 27.02.2019 10:20, Maxime Ripard wrote:
> > > > On Sun, Feb 24, 2019 at 09:04:57AM +0100, Gerhard Wiesinger wrote:
> > > > > Hello,
> > > > >=20
> > > > > I've 3 Banana Pi R1, one running with self compiled kernel
> > > > > 4.7.4-200.BPiR1.fc24.armv7hl and old Fedora 25 which is VERY STAB=
LE, the 2
> > > > > others are running with Fedora 29 latest, kernel 4.20.10-200.fc29=
=2Earmv7hl. I
> > > > > tried a lot of kernels between of around 4.11
> > > > > (kernel-4.11.10-200.fc25.armv7hl) until 4.20.10 but all had crash=
es without
> > > > > any output on the serial console or kernel panics after a short t=
ime of
> > > > > period (minutes, hours, max. days)
> > > > >=20
> > > > > Latest known working and stable self compiled kernel: kernel
> > > > > 4.7.4-200.BPiR1.fc24.armv7hl:
> > > > >=20
> > > > > https://www.wiesinger.com/opensource/fedora/kernel/BananaPi-R1/
> > > > >=20
> > > > > With 4.8.x the DSA b53 switch infrastructure has been introduced =
which
> > > > > didn't work (until ca8931948344c485569b04821d1f6bcebccd376b and k=
ernel
> > > > > 4.18.x):
> > > > >=20
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
tree/drivers/net/dsa/b53?h=3Dv4.20.12
> > > > >=20
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
log/drivers/net/dsa/b53?h=3Dv4.20.12
> > > > >=20
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
commit/drivers/net/dsa/b53?h=3Dv4.20.12&id=3Dca8931948344c485569b04821d1f6b=
cebccd376b
> > > > >=20
> > > > > I has been fixed with kernel 4.18.x:
> > > > >=20
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/=
log/drivers/net/dsa/b53?h=3Dlinux-4.18.y
> > > > >=20
> > > > >=20
> > > > > So current status is, that kernel crashes regularly, see some sam=
ples below.
> > > > > It is typically a "Unable to handle kernel paging request at virt=
ual addres"
> > > > >=20
> > > > > Another interesting thing: A Banana Pro works well (which has als=
o an
> > > > > Allwinner A20 in the same revision) running same Fedora 29 and la=
test
> > > > > kernels (e.g. kernel 4.20.10-200.fc29.armv7hl.).
> > > > >=20
> > > > > Since it happens on 2 different devices and with different power =
supplies
> > > > > (all with enough power) and also the same type which works well o=
n the
> > > > > working old kernel) a hardware issue is very unlikely.
> > > > >=20
> > > > > I guess it has something to do with virtual memory.
> > > > >=20
> > > > > Any ideas?
> > > > > [47322.960193] Unable to handle kernel paging request at virtual =
addres 5675d0
> > > > That line is a bit suspicious
> > > >=20
> > > > Anyway, cpufreq is known to cause those kind of errors when the
> > > > voltage / frequency association is not correct.
> > > >=20
> > > > Given the stack trace and that the BananaPro doesn't have cpufreq
> > > > enabled, my first guess would be that it's what's happening. Could =
you
> > > > try using the performance governor and see if it's more stable?
> > > >=20
> > > > If it is, then using this:
> > > > https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-=
test
> > > >=20
> > > > will help you find the offending voltage-frequency couple.
> > > For me it looks like they have all the same config regarding cpu gove=
rnor
> > > (Banana Pro, old kernel stable one, new kernel unstable ones)
> > The Banana Pro doesn't have a regulator set up, so it will only change
> > the frequency, not the voltage.
> >=20
> > > They all have the ondemand governor set:
> > >=20
> > > I set on the 2 unstable "new kernel Banana Pi R1":
> > >=20
> > > # Set to max performance
> > > echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_gov=
ernor
> > > echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_gov=
ernor
> > What are the results?
>=20
> Stable since more than around 1,5 days. Normally they have been crashed f=
or
> such a long uptime. So it looks that the performance governor fixes it.
>=20
> I guess crashes occour because of changing CPU voltage and clock changes =
and
> invalid data (e.g. also invalid RAM contents might be read, register
> problems, etc).
>=20
> Any ideas how to fix it for ondemand mode, too?

Run https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-test

> But it doesn't explaing that it works with kernel 4.7.4 without any
> problems.

My best guess would be that cpufreq wasn't enabled at that time, or
without voltage scaling.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--5dqx3l4hsuk3weiw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXHj7vgAKCRDj7w1vZxhR
xecyAP4mfLXF4qD/SP+n+VXeyb0mvspwFb3VpGY2eW1ERmcyyAEAk8LZZvC3+zOR
JanaiJJh7WJroKFs4P31bTIzuu2abA4=
=k0lp
-----END PGP SIGNATURE-----

--5dqx3l4hsuk3weiw--
