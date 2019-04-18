Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8743C10F14
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DFC2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 03:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555644896;
	bh=LYmZYhMZULHGsrIGjrMQukvqyGHoBiuvoPz0HPPw97k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cm3F2PYGtP1inyfLy92Ysz0koK0VEVAQvSO/CLGaTvAMcUSESyxPmxmQMAqKq++fe
	 AiqUWU6gXEXK54kBv/WTWVOHVomYpSRzQWcGHPRbm0HfAxOAauOLowZVW0foren5pt
	 kcIT0EvHHC3ux0oxJGXF4eNezt40dlyc6pkVr/Us=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfDSDev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 23:34:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727205AbfDSDet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 23:34:49 -0400
Received: from earth.universe (dyndsl-091-248-050-217.ewe-ip-backbone.de [91.248.50.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67DC6217FA;
        Fri, 19 Apr 2019 03:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555644888;
        bh=LYmZYhMZULHGsrIGjrMQukvqyGHoBiuvoPz0HPPw97k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JI/mgTzdWFGzxFHGyst00mgujTx89cfbEOVTUW2oxr10asLIdpfC8FyjBpF4YMiMK
         JndHup2NhYFDzNg1qSw+8CBiMfHt0vd+IT8PeNFf5hp0POxW3YzTQGkNUhnBk4nvJW
         iDs24JRWwRLlkVl7vV36BNJM02SseVbBNOhcifcA=
Received: by earth.universe (Postfix, from userid 1000)
        id 55E853C0984; Thu, 18 Apr 2019 22:20:00 +0200 (CEST)
Date:   Thu, 18 Apr 2019 22:20:00 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/10] Add support for XO 1.75 to OLPC battery driver
Message-ID: <20190418202000.hcojhcf2f47te44u@earth.universe>
References: <20190418144655.18758-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jx6vzhc64gitrwmn"
Content-Disposition: inline
In-Reply-To: <20190418144655.18758-1-lkundrak@v3.sk>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jx6vzhc64gitrwmn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 18, 2019 at 04:46:45PM +0200, Lubomir Rintel wrote:
> This patch set modifies the OLPC battery driver so that it could eventual=
ly
> be used on an Arm-based OLPC XO 1.75 machine.
>=20
> Compared to the previous version, it addresses review comments for the
> x86 platform parts from Thomas Gleixner. Details in individual patches'
> change logs.
>=20
> I've failed to version the previous iteration of the set that should've
> been "v6" for the change logs to make sense. Sorry for that.
>=20
> Thank you,
> Lubo

I queued up the complete patchset via an immutable branch based on
v5.1-rc1. X86 maintainers can pull this signed immutable branch as
required. Thanks for the patches,

-- Sebastian

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git =
tags/psy-olpc-1.75-battery-signed

for you to fetch changes up to 31e220877981d0005d0c4a76f68027a73131212b:

  power: supply: olpc_battery: Have the framework register sysfs files for =
us (2019-04-18 21:55:04 +0200)

----------------------------------------------------------------
Immutable branch between x86 and power-supply for OLPC

This immutable branch contains the changes required for OLPC
1.75 battery, which touches x86 and power-supply and is based
on v5.1-rc1.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

----------------------------------------------------------------
Lubomir Rintel (10):
      dt-bindings: olpc_battery: Add XO-1.5 battery
      x86/platform/olpc: Don't split string literals when fixing up the DT
      x86/platform/olpc: Trivial code move in DT fixup
      x86/platform/olpc: Use a correct version when making up a battery node
      power: supply: olpc_battery: Use DT to get battery version
      power: supply: olpc_battery: Move priv data to a struct
      power: supply: olpc_battery: Use devm_power_supply_register()
      power: supply: olpc_battery: Avoid using platform_info
      power: supply: olpc_battery: Add OLPC XO 1.75 support
      power: supply: olpc_battery: Have the framework register sysfs files =
for us

 .../bindings/power/supply/olpc_battery.txt         |   2 +-
 arch/x86/platform/olpc/olpc_dt.c                   | 101 ++++++++----
 drivers/power/supply/olpc_battery.c                | 169 +++++++++++++----=
----
 3 files changed, 177 insertions(+), 95 deletions(-)

--jx6vzhc64gitrwmn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly42+wACgkQ2O7X88g7
+pqEIw/+IH19WGdKSJX8Ybr2LDUp56np4dT3S5GM0EFoxiC8hmpFtMKIBw5kdI2l
KoBQhsDJTwDnrycuDsFs4eNYZXw+qoNktW4bHNJe6Hdr0C3k77ITT86Y1QwZGH60
HD/E9brMn5HBBRi1/0YUCkRJa3Iy2nzr+hk8RE/gynHOXywqqmbRA+QCtG4P52Xf
0azBVaPT163+ioWB4K0P1JeVoGVz583+C9ZfWP683CfuZhLZ2zoLPWCl4hwTpgcJ
mWoX4jrALIvu8DJZslpg2vKFVqomWg1IMD/OXkDBKo7y/9/LKdb+qCRfFmwNPJQ/
D0xrhaCeCZeO/t5yMoI/pWRQMPU0TBreXYhydlL59L0mKgH8f1n99lqzDDn9+Vgv
vEVSIy9RrSmQ4tPcN3JnWw+MlzCqn8lB1xGWbXH2qlRP+hOZWAX5RQNh5t8KeBEk
vH1FzOSiMxBDgnHG4vHhjcwOf3UmD5ZlUuaIadN5KUIpC1ie126vqsutuQ7IzkmG
47oxKGsZxtK3ilJe1Pu/MKwQAQD1uTXkEMPeZ6D2ONJebgGbmSnvdZ05puusLwFH
PYhHFwf2cY+gydMZ5ONM1Rs3FNDsYOt/tOyHXYq/aZqh+d/DXMv5USm6XrLYKyKp
np8bpoUNdiyeoKQ0RQ1dyAw3qC2Z9s8Sz25IPpls7iNtayjJQB4=
=sV9a
-----END PGP SIGNATURE-----

--jx6vzhc64gitrwmn--
