Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6144BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359C9205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 08:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfCVIVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 04:21:09 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:51327 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfCVIVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 04:21:08 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 42C7D80570; Fri, 22 Mar 2019 09:20:59 +0100 (CET)
Date:   Fri, 22 Mar 2019 09:21:06 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Harry Pan <harry.pan@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, gs0622@gmail.com,
        rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 1/2] PM / sleep: refactor the filesystems sync to
 reduce duplication
Message-ID: <20190322082106.GA27015@amd>
References: <20190224061753.17638-2-harry.pan@intel.com>
 <20190225123642.17111-1-harry.pan@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20190225123642.17111-1-harry.pan@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-02-25 20:36:41, Harry Pan wrote:
> This patch creates a common helper to sync filesystems and shares
> to the suspend, hibernate, and snapshot.
>=20
> Signed-off-by: Harry Pan <harry.pan@intel.com>

ACK.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyUmvIACgkQMOfwapXb+vIdigCfRAYktLKnih5/9rlYqZ2KPvNE
rAcAn0Q8VToSSHWYQKmbTDbr8/1EiuwB
=URrF
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
