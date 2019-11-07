Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF1CC5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1A821D7B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 22:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfKGWwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 17:52:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:21274 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfKGWwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 17:52:19 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 14:52:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,279,1569308400"; 
   d="asc'?scan'208";a="205819558"
Received: from karaker-mobl.amr.corp.intel.com ([10.254.95.244])
  by orsmga003.jf.intel.com with ESMTP; 07 Nov 2019 14:52:18 -0800
Message-ID: <6784fee2096c9bb103b8e0b8eb50cc1d9e494ad1.camel@intel.com>
Subject: Re: [PATCH net-next 1/2] net: ethernet: intel: Demote MTU change
 prints to debug
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Timur Tabi <timur@kernel.org>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Thu, 07 Nov 2019 14:52:17 -0800
In-Reply-To: <20191107223537.23440-2-f.fainelli@gmail.com>
References: <20191107223537.23440-1-f.fainelli@gmail.com>
         <20191107223537.23440-2-f.fainelli@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-+hEZUL/LnhJlbIkpTIaT"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+hEZUL/LnhJlbIkpTIaT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-11-07 at 14:35 -0800, Florian Fainelli wrote:
> Changing a network device MTU can be a fairly frequent operation, and
> failure to change the MTU is reflected to user-space properly, both by
> an appropriate message as well as by looking at whether the device's MTU
> matches the configuration.
>=20
> Demote the prints to debug prints by using netdev_dbg(), making all
> Intel wired LAN drivers consistent, since they used a mixture of PCI
> device and network device prints before.
>=20
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 4 ++--
>  drivers/net/ethernet/intel/e1000e/netdev.c    | 3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c     | 5 ++---
>  drivers/net/ethernet/intel/igbvf/netdev.c     | 4 ++--
>  drivers/net/ethernet/intel/igc/igc_main.c     | 5 ++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>  7 files changed, 14 insertions(+), 14 deletions(-)


--=-+hEZUL/LnhJlbIkpTIaT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAl3EoCEACgkQ5W/vlVpL
7c6Hkw//RAJ6/Y27nm995XzPzodZn0WzSEYsVPgc31gxVqdbPB3ZjbKCqxAgbnth
EA0ktXZh15OLcrONJB73WKDbPaeAGGXB+nPiGWa+6YApJ6YLh1feoqMUnB2Ah6RF
S8o2z3vsXFhzt28Zl0OEIou6/haJLy5ZhSOo9ftaKJmAWgQXbJ8IKQX5HEx4Y4W3
UQ/Zgcly2OgwoHHBwyYEyawhVJbl7+vOyjuk7DZUc9zWuCAOhd2whv74q6JNxS95
1QS3IpETL/S5GJ+FRM5Ijd8FmKxp9/FyknnxWF6mirtqlDTY+jwmmuQtVoKseH/+
RIxJ83NjX8PUtFNRXdRtW16y6OUGe1A1KGMC25u35N4ZSV63fma0d9+zIQzymKfr
8zVP5W1eGK+4lIJq8t8vZUybYPGXF+XevodBpavPX5x89c0yqe3XKNVrjgH1/FVv
J42nRFPijGxnDiUOz+5AgLmNrHy3zV8014fn7rTfpRoPIx+Wq+NoB3fZBZMeFfWA
IVBa7VWe+Xfg7N8GJbAiqTdiy5OScb0bcgv3vKt2f4kWdels0Zk3EkyqybozuKN3
QHl35P0L+p2K5wcC5LGS5jk8iQhcC61fQVar/aAOTR8uXKj9HmPScrQVf48ovA55
lcNSdYZobNrqG2jt/HgTu2pLMzi2Hy8Hc1Ux8thywIzrPKVad/Q=
=wWG1
-----END PGP SIGNATURE-----

--=-+hEZUL/LnhJlbIkpTIaT--

