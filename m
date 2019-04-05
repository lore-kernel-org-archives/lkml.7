Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840D2C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1802186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554472795;
	bh=SH3hi1nePzhLHjLCJLW6uRcos6S1EVYQqeNfHFVTQf0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yxZRFTZ86JuyvAZ86oWUqMZxxctersSPFFPAb2Puzv0oIDeinh3wFtWwEL7z2kIV0
	 qOm8izxlmIN5h0Kf8zdnylOG3+uDs0reRs9pIZI5lcWpM/V7y8GkkB8t793+XXoD/U
	 q/cnaSsExmVt4AARrfjXKcamlO/CJyMeNQqIOAzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbfDEN7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 09:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731191AbfDEN7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 09:59:52 -0400
Received: from earth.universe (host-091-097-083-087.ewe-ip-backbone.de [91.97.83.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 665BA21850;
        Fri,  5 Apr 2019 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554472790;
        bh=SH3hi1nePzhLHjLCJLW6uRcos6S1EVYQqeNfHFVTQf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+QeqKJGNdOetqdMBbMjZSxne1b1UFU6nzt/q7EeaVoAbd/+MoxUCJ+7OL51Nfdt+
         vSQ1xfEqdbA5mjTtv9IEPI63M0xuSb7CkYpqa7jzVsXMbIUoKooZy3SX2WhMavZqC6
         OD7ZkDe7bW0rshb0h9Zg6qRqrSY5VufR92xMez/s=
Received: by earth.universe (Postfix, from userid 1000)
        id 63DD93C08D5; Fri,  5 Apr 2019 15:59:48 +0200 (CEST)
Date:   Fri, 5 Apr 2019 15:59:48 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Darren Hart <dvhart@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 04/10] x86, olpc: Use a correct version when making up a
 battery node
Message-ID: <20190405135948.wnwv2qq3wz7bzsog@earth.universe>
References: <20190310162419.11861-1-lkundrak@v3.sk>
 <20190310162419.11861-5-lkundrak@v3.sk>
 <alpine.DEB.2.21.1903230020270.2157@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cicfdoeib2e7lfta"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1903230020270.2157@nanos.tec.linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cicfdoeib2e7lfta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 23, 2019 at 12:25:58AM +0100, Thomas Gleixner wrote:
> On Sun, 10 Mar 2019, Lubomir Rintel wrote:
>=20
> Subject prefix ...
>=20
> > The XO-1 and XO-1.5 batteries apparently differ in an ability to report
> > ambient temperature. We need to use a different compatible string for t=
he
> > XO-1.5 battery.
> >=20
> > Previously olpc_dt_fixup() used the presence od the battery node's
>=20
> s/od/of/
>=20
> > =20
> > +int olpc_dt_compatible_match(phandle node, const char *compat)
> > +{
> > +	char buf[64];
> > +	int plen;
> > +	char *p;
> > +	int len;
>=20
> Please coalesce variables of the same type. No point in wasting space.
>=20
> 	char buf[64], *p;
> 	int plen, len;
>=20
> Hmm?
>=20
> > +
> > +		if (olpc_dt_compatible_match(node, "olpc,xo1-battery")) {
> > +			/* If we have a olpc,xo1-battery compatible, then we're
> > +			 * running a new enough firmware that already has
> > +			 * the dcon node.
> > +			 */
>=20
> Comment style:
>=20
>        		 	 /*
> 			  * This is a proper multi line comment even
> 			  * if networking people use that horrible style
> 			  * above.
> 			  */
>=20
> With those nitpicks fixed:
>=20
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Looks like this is the last required change before this can be
merged. Assuming Lubomir sends a fixed series soon, how should
it be merged?

a) I get a pull-request with a immutable branch for patch 2-4
b) Complete patchset goes in via x86
c) Complete patchset goes in via power-supply

I'm fine with all variants.

-- Sebastian

--cicfdoeib2e7lfta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlynX1QACgkQ2O7X88g7
+ppT6hAAnwa8NzJM9yXdDEp4T6Ci3Aiq3Nus2/3mrQwSI66pYQkangJzm0S1wy8u
p9Y/SUD1PXtAKPtcnfh6uKp78gsqig+SmKaVC6CU415NuewyjzXDh0jnDAYGjR71
QfofvUZc/l2X5Dl0AzpiUHp3uGb90pkAGqbo3hLdLGRfM6ZQUMs56uC2qyhYBj/U
P2hi6sDnpCFGzk+5JkL2oR/XSuq4EUeJXoRfUsvMyFfmwKewbZCi9yONn6HVy9tF
DfI6ATIbicDQ8RqaLFAcSFukIL/z0B1KTrc8W49b3XPMLbsmF5jm4iEYJem99k2p
MD8pp0JSJudbDwD/rw2GseyAI1JS7qcAysdMQ8AvXqk8zjG3h+qtcopeCM9IZJmJ
sK1UPEwY9uIuzrAylGw0HyqRPrPvDU3GUNC49+N7M2GA2Se0GSatkwc+FmAnhaUV
6BvGQSkVPU2sANVYdy9bRgPGXscJcCZ5Bodmd/70tYlFfKQgUY5Cs6R1YWSs4CSd
nInDgYrUnG8zggqWbFnVt+XIg+6Gzrf6w4d3AABBxin7x+beno98pLx/nUeVa1Wh
jvYzTn1cfq52ZmayrkwLTHnnljCqoYhuAXK8JLsijO5PNJyfPbRH2ptADTBtbW+W
UlfEol9hp7SGMwBFJKZ06ksvpl+JqQJuDrhHeOfBlQdfOeKG0II=
=Fcpl
-----END PGP SIGNATURE-----

--cicfdoeib2e7lfta--
