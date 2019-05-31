Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18243C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49ED24F28
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 08:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfEaIwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 04:52:12 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:50246 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 04:52:12 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id C6B4F80233; Fri, 31 May 2019 10:52:00 +0200 (CEST)
Date:   Fri, 31 May 2019 10:52:10 +0200
From:   Pavel Machek <pavel@denx.de>
To:     kernel list <linux-kernel@vger.kernel.org>,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        teheo@suse.de, sre@kernel.org
Subject: devm_* vs. PROBE_DEFFER: memory leaks?
Message-ID: <20190531085209.GA20964@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Is devm_ supposed to work with EPROBE_DEFFER?

Probe function is now called multiple times; is memory freed between
calling probe()? Will allocations from failed probe()s remain after
the driver is inserted successfully, leaking memory?

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlzw6zkACgkQMOfwapXb+vL0igCeJvVsNfBl8H8xvikYrAeaSVJm
t2oAn360LyefEazCKa/r0oLjLL+fhRNn
=dPKe
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
