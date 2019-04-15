Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1D2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711D020818
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 22:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555366203;
	bh=SYglmHg+X3HSahatRhPiR/hVA/Qahb7EHBkSkK8sy0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eBSNwzHkQQLcn76jYVd/SBMcfk/ojdmgvXQT4QP0XnrqTIztjFKiupJBM1FM+WfhN
	 h+5yHEdRxR5fLdw9G+Cl0kj6TycIEtJ+M5Ign0+DuWNfIiBs9Tg3FTpO90JA9wrlsG
	 6k+R8rXdRzTAT4zoDV7wM7RuM3uoIwhGR0gBt6lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfDOWKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbfDOWKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 18:10:02 -0400
Received: from earth.universe (unknown [185.62.205.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 184642075B;
        Mon, 15 Apr 2019 22:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555366201;
        bh=SYglmHg+X3HSahatRhPiR/hVA/Qahb7EHBkSkK8sy0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRF3CzTC3826y0wRld/Um4W20GK0LPrGa35vM+2k8zIF5DY5HlwfJbjnj0bGNLn2r
         jBLFtjAEar2K9JvtYubNYnBoCwkAIZrY3udkIcX49aLZLPKEOLyEYjERI9zGoR5Yuz
         EBTmF8FaIgPjm5vNk4Rjsp4TfpCgpQaFMGMkAAy0=
Received: by earth.universe (Postfix, from userid 1000)
        id A55203C08D5; Tue, 16 Apr 2019 00:09:58 +0200 (CEST)
Date:   Tue, 16 Apr 2019 00:09:58 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 4/4] power: supply: add Ingenic JZ47xx battery driver.
Message-ID: <20190415220958.d3hr6ymwoy43npjw@earth.universe>
References: <20190323172809.14407-1-contact@artur-rojek.eu>
 <20190323172809.14407-4-contact@artur-rojek.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rw2r4of4bpn34oof"
Content-Disposition: inline
In-Reply-To: <20190323172809.14407-4-contact@artur-rojek.eu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rw2r4of4bpn34oof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Mar 23, 2019 at 06:28:09PM +0100, Artur Rojek wrote:
> Add a driver for battery present on Ingenic JZ47xx SoCs.
>=20
> Signed-off-by: Artur Rojek <contact@artur-rojek.eu>

I just applied the patch, but it results in the following warning:

WARNING: modpost: missing MODULE_LICENSE() in drivers/power/supply/ingenic-=
battery.o

Please add MODULE_LICENSE & Co and send a v4 of patch 4/4.

-- Sebastian

--rw2r4of4bpn34oof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly1ASsACgkQ2O7X88g7
+pqTVA/+Ik4sVPteTU4wCrybHl8pxCnajSRMODXGm3MxbBSs6vpI4wr5/aqD3P5Z
iWMburw6eg3YZOk5kK9awGkykioyZ4MGlfTURZyKo7QKMPbEruY1RUTnJRBtZ9d6
oV8HxzzuiZlY9pN0Szlw8UYK7aZOKR5CqtTzL3HHsZR+mHTLFZG+W5tQdALQzs/6
GS+V3d48s5o+JVYnZePwFe4b6Qi9cs57f/JFJ6hOnpIdKQzEh1xxbw/6axMaIZBh
nzlh2pdJT0bN/uPOYztunaGefrkht7YH+SCYttAr6Valxa7UJIccYwhggTAtCwFK
UAYDyZVPuhp3i9vBMBeNRIdCoxwqoHUsdffpRrIMlJvxa2Jkvff4dAfcoVtzgJpq
VzbOfRsquhVxlCiOScO5cc9WK+qAifoy7Q+yo8uZ5Y+oniMx72zueeOvG6Kv+idL
jDbMvSxqVv7QdqSv/fA/7X9cjeu90548YvBRB0dkKh9fvNfaD2myGeW6VKl2/m6T
c7OSOaUS0HAD/hfDIaZaJX72fK7cVGNJ7bF8dMPv57Y7oBoH6r4eaLvIdxAv3xnH
kGR6ZGZ1KB0LNxYH/lblosuo5N3lVFSToXsluvhfpjQHbNKtXXZhDJTKSvA0nUu5
yLItgAQ4Qfsc3k30zoQinBbADuD5ibptP9KM/6BPaeCnp7lSKqA=
=S6TG
-----END PGP SIGNATURE-----

--rw2r4of4bpn34oof--
