Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19379C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA77620842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 09:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfCEJ2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:28:34 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:38593 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCEJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 04:28:33 -0500
X-Originating-IP: 90.88.147.150
Received: from localhost (aaubervilliers-681-1-27-150.w90-88.abo.wanadoo.fr [90.88.147.150])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8BE28E000C;
        Tue,  5 Mar 2019 09:28:30 +0000 (UTC)
Date:   Tue, 5 Mar 2019 10:28:30 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Gerhard Wiesinger <lists@wiesinger.com>
Cc:     arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Florian Fainelli <f.fainelli@gmail.com>, filbar@centrum.cz
Subject: Re: Banana Pi-R1 stabil
Message-ID: <20190305092830.ef45kxzhdnxlh63g@flea>
References: <7b20af72-76ea-a7b1-9939-ca378dc0ed83@wiesinger.com>
 <20190227092023.nvr34byfjranujfm@flea>
 <5f63a2c6-abcb-736f-d382-18e8cea31b65@wiesinger.com>
 <20190228093516.abual3564dkvx6un@flea>
 <91c22ba4-39eb-dd3d-29bd-1bfa7a45e9cd@wiesinger.com>
 <20190301093038.oz56z22ivpntdcfw@flea>
 <8ad8fbeb-fad8-d39a-9cc6-e7f1deab0b4f@wiesinger.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cfsenmwwcmenvo3t"
Content-Disposition: inline
In-Reply-To: <8ad8fbeb-fad8-d39a-9cc6-e7f1deab0b4f@wiesinger.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cfsenmwwcmenvo3t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 02, 2019 at 09:42:08AM +0100, Gerhard Wiesinger wrote:
> On 01.03.2019 10:30, Maxime Ripard wrote:
> > On Thu, Feb 28, 2019 at 08:41:53PM +0100, Gerhard Wiesinger wrote:
> > > On 28.02.2019 10:35, Maxime Ripard wrote:
> > > > On Wed, Feb 27, 2019 at 07:58:14PM +0100, Gerhard Wiesinger wrote:
> > > > > On 27.02.2019 10:20, Maxime Ripard wrote:
> > > > > > On Sun, Feb 24, 2019 at 09:04:57AM +0100, Gerhard Wiesinger wro=
te:
> > > > > > > Hello,
> > > > > > >=20
> > > > > > > I've 3 Banana Pi R1, one running with self compiled kernel
> > > > > > > 4.7.4-200.BPiR1.fc24.armv7hl and old Fedora 25 which is VERY =
STABLE, the 2
> > > > > > > others are running with Fedora 29 latest, kernel 4.20.10-200.=
fc29.armv7hl. I
> > > > > > > tried a lot of kernels between of around 4.11
> > > > > > > (kernel-4.11.10-200.fc25.armv7hl) until 4.20.10 but all had c=
rashes without
> > > > > > > any output on the serial console or kernel panics after a sho=
rt time of
> > > > > > > period (minutes, hours, max. days)
> > > > > > >=20
> > > > > > > Latest known working and stable self compiled kernel: kernel
> > > > > > > 4.7.4-200.BPiR1.fc24.armv7hl:
> > > > > > >=20
> > > > > > > https://www.wiesinger.com/opensource/fedora/kernel/BananaPi-R=
1/
> > > > > > >=20
> > > > > > > With 4.8.x the DSA b53 switch infrastructure has been introdu=
ced which
> > > > > > > didn't work (until ca8931948344c485569b04821d1f6bcebccd376b a=
nd kernel
> > > > > > > 4.18.x):
> > > > > > >=20
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/tree/drivers/net/dsa/b53?h=3Dv4.20.12
> > > > > > >=20
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/log/drivers/net/dsa/b53?h=3Dv4.20.12
> > > > > > >=20
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/commit/drivers/net/dsa/b53?h=3Dv4.20.12&id=3Dca8931948344c485569b04821d=
1f6bcebccd376b
> > > > > > >=20
> > > > > > > I has been fixed with kernel 4.18.x:
> > > > > > >=20
> > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.=
git/log/drivers/net/dsa/b53?h=3Dlinux-4.18.y
> > > > > > >=20
> > > > > > >=20
> > > > > > > So current status is, that kernel crashes regularly, see some=
 samples below.
> > > > > > > It is typically a "Unable to handle kernel paging request at =
virtual addres"
> > > > > > >=20
> > > > > > > Another interesting thing: A Banana Pro works well (which has=
 also an
> > > > > > > Allwinner A20 in the same revision) running same Fedora 29 an=
d latest
> > > > > > > kernels (e.g. kernel 4.20.10-200.fc29.armv7hl.).
> > > > > > >=20
> > > > > > > Since it happens on 2 different devices and with different po=
wer supplies
> > > > > > > (all with enough power) and also the same type which works we=
ll on the
> > > > > > > working old kernel) a hardware issue is very unlikely.
> > > > > > >=20
> > > > > > > I guess it has something to do with virtual memory.
> > > > > > >=20
> > > > > > > Any ideas?
> > > > > > > [47322.960193] Unable to handle kernel paging request at virt=
ual addres 5675d0
> > > > > > That line is a bit suspicious
> > > > > >=20
> > > > > > Anyway, cpufreq is known to cause those kind of errors when the
> > > > > > voltage / frequency association is not correct.
> > > > > >=20
> > > > > > Given the stack trace and that the BananaPro doesn't have cpufr=
eq
> > > > > > enabled, my first guess would be that it's what's happening. Co=
uld you
> > > > > > try using the performance governor and see if it's more stable?
> > > > > >=20
> > > > > > If it is, then using this:
> > > > > > https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-str=
ess-test
> > > > > >=20
> > > > > > will help you find the offending voltage-frequency couple.
> > > > > For me it looks like they have all the same config regarding cpu =
governor
> > > > > (Banana Pro, old kernel stable one, new kernel unstable ones)
> > > > The Banana Pro doesn't have a regulator set up, so it will only cha=
nge
> > > > the frequency, not the voltage.
> > > >=20
> > > > > They all have the ondemand governor set:
> > > > >=20
> > > > > I set on the 2 unstable "new kernel Banana Pi R1":
> > > > >=20
> > > > > # Set to max performance
> > > > > echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling=
_governor
> > > > > echo "performance" > /sys/devices/system/cpu/cpu1/cpufreq/scaling=
_governor
> > > > What are the results?
> > > Stable since more than around 1,5 days. Normally they have been crash=
ed for
> > > such a long uptime. So it looks that the performance governor fixes i=
t.
> > >=20
> > > I guess crashes occour because of changing CPU voltage and clock chan=
ges and
> > > invalid data (e.g. also invalid RAM contents might be read, register
> > > problems, etc).
> > >=20
> > > Any ideas how to fix it for ondemand mode, too?
> > Run https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-=
test
> >=20
> > > But it doesn't explaing that it works with kernel 4.7.4 without any
> > > problems.
> > My best guess would be that cpufreq wasn't enabled at that time, or
> > without voltage scaling.
> >=20
>=20
> Where can I see the voltage scaling parameters?
>=20
> on DTS I don't see any difference between kernel 4.7.4 and 4.20.10 regard=
ing
> voltage:
>=20
> dtc -I dtb -O dts -o
> /boot/dtb-4.20.10-200.fc29.armv7hl/sun7i-a20-lamobo-r1.dts
> /boot/dtb-4.20.10-200.fc29.armv7hl/sun7i-a20-lamobo-r1.dtb

This can be also due to configuration being changed, driver support, etc.

> There is another strange thing (tested with
> kernel-5.0.0-0.rc8.git1.1.fc31.armv7hl, kernel-4.19.8-300.fc29.armv7hl,
> kernel-4.20.13-200.fc29.armv7hl, kernel-4.20.10-200.fc29.armv7hl):
>=20
> There is ALWAYS high CPU of around 10% in kworker:
>=20
> =A0 PID USER=A0=A0=A0=A0=A0 PR=A0 NI=A0=A0=A0 VIRT=A0=A0=A0 RES=A0=A0=A0 =
SHR S=A0 %CPU=A0 %MEM TIME+ COMMAND
> 18722 root=A0=A0=A0=A0=A0 20=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0 0=
=A0=A0=A0=A0=A0 0 I=A0=A0 9.5=A0=A0 0.0 0:47.52
> [kworker/1:3-events_freezable_power_]
>
> =A0 PID USER=A0=A0=A0=A0=A0 PR=A0 NI=A0=A0=A0 VIRT=A0=A0=A0 RES=A0=A0=A0 =
SHR S=A0 %CPU=A0 %MEM TIME+ COMMAND
> =A0 776 root=A0=A0=A0=A0=A0 20=A0=A0 0=A0=A0=A0=A0=A0=A0 0=A0=A0=A0=A0=A0=
 0=A0=A0=A0=A0=A0 0 I=A0=A0 8.6=A0=A0 0.0 0:02.77
> [kworker/0:4-events]

The first one looks like it's part of the workqueue code.

> Therefore CPU doesn't switch to low frequencies (see below).

You said previously that those crashes were happening when the board
was changing frequency, so I'm confused?

> Any ideas?

Run the cpustress program I told you to use already twice.

> BTW: Still stable at aboout 2,5days on both devices. So solution IS the
> performance governor.

No, the performance governor prevents any change in frequency. My
guess is that a lower frequency operating point is not working and is
crashing the CPU.

Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--cfsenmwwcmenvo3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXH5BPgAKCRDj7w1vZxhR
xS2wAQCrYmvmqeaxIJeP2CrIbiuDo+B1ZA2vOOrm7phibW0m2wEAkOlkFixpr4E3
yqQL9k9rEMnmYePmRiu6hcFMf2pCOQ0=
=fMmS
-----END PGP SIGNATURE-----

--cfsenmwwcmenvo3t--
