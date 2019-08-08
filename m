Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25410C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D73912166E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403988AbfHHVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:55:51 -0400
Received: from mga17.intel.com ([192.55.52.151]:29603 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732427AbfHHVzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:55:51 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 14:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,363,1559545200"; 
   d="asc'?scan'208";a="199199965"
Received: from jtkirshe-desk1.jf.intel.com ([134.134.177.96])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2019 14:55:50 -0700
Message-ID: <86082ebc5080859735ce69655166da2beb2c3b7d.camel@intel.com>
Subject: Re: drivers/net/ethernet/intel/i40e/i40e_main.c:7089:35-37: ERROR:
 invalid reference to the index variable of the iterator on line 7056 (fwd)
From:   Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Reply-To: jeffrey.t.kirsher@intel.com
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@01.org
Date:   Thu, 08 Aug 2019 14:55:50 -0700
In-Reply-To: <alpine.DEB.2.21.1908081806370.2995@hadrien>
References: <alpine.DEB.2.21.1908081806370.2995@hadrien>
Organization: Intel
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-SKF+JxVFJgP7GgL8tAk7"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SKF+JxVFJgP7GgL8tAk7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2019-08-08 at 18:08 +0200, Julia Lawall wrote:
> Hello,
>=20
> Is it guaranteed that the loop starting on line 7056 will eventually
> take
> the break?  If not, line 7089 will be performing an invalid
> dereference of
> ch.

Good catch Julia, I have talked with Harshitha and if after checking
the list of channels and not finding an available channel, we should
exit the function instead of proceeding on to add the MACVLAN filter.

Harshitha said she would put together a patch to fix the issue in the
next day or two, unless you or someone else gets to it first.

>=20
> ---------- Forwarded message ----------
> Date: Thu, 8 Aug 2019 21:31:53 +0800
> From: kbuild test robot <lkp@intel.com>
> To: kbuild@01.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Subject: drivers/net/ethernet/intel/i40e/i40e_main.c:7089:35-37:
> ERROR: invalid
>     reference to the index variable of the iterator on line 7056
>=20
> CC: kbuild-all@01.org
> CC: linux-kernel@vger.kernel.org
> TO: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>=20
> tree:  =20
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.g=
it
> master
> head:   ecb095bff5d4b8711a81968625b3b4a235d3e477
> commit: 1d8d80b4e4ff641eefa5250cba324dfa5861a9f1 i40e: Add macvlan
> support on i40e
> date:   6 weeks ago
> :::::: branch date: 15 hours ago
> :::::: commit date: 6 weeks ago
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>=20
> > > drivers/net/ethernet/intel/i40e/i40e_main.c:7089:35-37: ERROR:
> > > invalid reference to the index variable of the iterator on line
> > > 7056
>=20
> git remote add linus=20
> https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.g=
it
> git remote update linus
> git checkout 1d8d80b4e4ff641eefa5250cba324dfa5861a9f1
> vim +7089 drivers/net/ethernet/intel/i40e/i40e_main.c
>=20
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7037
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7038  /**
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7039   *
> i40e_fwd_ring_up - bring the macvlan device up
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7040   * @vsi: the
> VSI we want to access
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7041   * @vdev:
> macvlan netdevice
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7042   * @fwd: the
> private fwd structure
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7043   */
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7044  static int
> i40e_fwd_ring_up(struct i40e_vsi *vsi, struct net_device *vdev,
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7045  	=09
> 	    struct i40e_fwd_adapter *fwd)
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7046  {
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7047  	int ret
> =3D 0, num_tc =3D 1,  i, aq_err;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7048  	struct
> i40e_channel *ch, *ch_tmp;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7049  	struct
> i40e_pf *pf =3D vsi->back;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7050  	struct
> i40e_hw *hw =3D &pf->hw;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7051
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7052  	if
> (list_empty(&vsi->macvlan_list))
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7053  	=09
> return -EINVAL;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7054
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7055  	/* Go
> through the list and find an available channel */
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19 @7056  	list_fo
> r_each_entry_safe(ch, ch_tmp, &vsi->macvlan_list, list) {
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7057  	=09
> if (!i40e_is_channel_macvlan(ch)) {
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7058  	=09
> 	ch->fwd =3D fwd;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7059  	=09
> 	/* record configuration for macvlan interface in vdev */
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7060  	=09
> 	for (i =3D 0; i < num_tc; i++)
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7061  	=09
> 		netdev_bind_sb_channel_queue(vsi->netdev, vdev,
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7062  	=09
> 					     i,
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7063  	=09
> 					     ch->num_queue_pairs,
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7064  	=09
> 					     ch->base_queue);
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7065  	=09
> 	for (i =3D 0; i < ch->num_queue_pairs; i++) {
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7066  	=09
> 		struct i40e_ring *tx_ring, *rx_ring;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7067  	=09
> 		u16 pf_q;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7068
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7069  	=09
> 		pf_q =3D ch->base_queue + i;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7070
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7071  	=09
> 		/* Get to TX ring ptr */
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7072  	=09
> 		tx_ring =3D vsi->tx_rings[pf_q];
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7073  	=09
> 		tx_ring->ch =3D ch;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7074
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7075  	=09
> 		/* Get the RX ring ptr */
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7076  	=09
> 		rx_ring =3D vsi->rx_rings[pf_q];
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7077  	=09
> 		rx_ring->ch =3D ch;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7078  	=09
> 	}
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7079  	=09
> 	break;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7080  	=09
> }
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7081  	}
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7082
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7083  	/*
> Guarantee all rings are updated before we update the
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7084  	 * MAC
> address filter.
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7085  	 */
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7086  	wmb();
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7087
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7088  	/* Add
> a mac filter */
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19 @7089  	ret =3D
> i40e_add_macvlan_filter(hw, ch->seid, vdev->dev_addr, &aq_err);
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7090  	if
> (ret) {
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7091  	=09
> /* if we cannot add the MAC rule then disable the offload */
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7092  	=09
> macvlan_release_l2fw_offload(vdev);
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7093  	=09
> for (i =3D 0; i < ch->num_queue_pairs; i++) {
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7094  	=09
> 	struct i40e_ring *rx_ring;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7095  	=09
> 	u16 pf_q;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7096
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7097  	=09
> 	pf_q =3D ch->base_queue + i;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7098  	=09
> 	rx_ring =3D vsi->rx_rings[pf_q];
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7099  	=09
> 	rx_ring->netdev =3D NULL;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7100  	=09
> }
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7101  	=09
> dev_info(&pf->pdev->dev,
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7102  	=09
> 	 "Error adding mac filter on macvlan err %s, aq_err %s\n",
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7103  	=09
> 	  i40e_stat_str(hw, ret),
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7104  	=09
> 	  i40e_aq_str(hw, aq_err));
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7105  	=09
> netdev_err(vdev, "L2fwd offload disabled to L2 filter error\n");
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7106  	}
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7107
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7108  	return
> ret;
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7109  }
> 1d8d80b4e4ff64 Harshitha Ramamurthy 2019-06-19  7110
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel
> Corporation


--=-SKF+JxVFJgP7GgL8tAk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiTyZWz+nnTrOJ1LZ5W/vlVpL7c4FAl1MmmYACgkQ5W/vlVpL
7c7KMw//WWDEg9XixgDbze2aJqbrEWGqL7MIDbqJ9+Mz9bv8IYQpp1Qy4biKP5xI
hRqmy+cviW4dboMFiTgU2ib8Z3TEczWSKKRSXpRVl0J7VlcCDFCm0Rj6wu+q6akY
wFQjvolznrT4BqXkgec7+RCB9IOlZeP5w1+bAytwxjNEevXqeBElRGQzPDl/Oc/W
xWbmIreb8qEbnHVMtPmPZY1SrN9a0QJMLE93aNph1coUboJkcZLfmZULuOlk3lc4
nG90fkKYf1dIP+OtELsFELkJdO+Mzmlmi/xImFkM0iXtM4ORdtd5bUfv0bNnHrCG
9o5NqeE5uVjzWKLHS0mPdHx5hACtMY+6ZuwVzxJ0eEFOlTazrSRtYFYoMKj5bpRU
PaOxdLrkGrsNapW78hjSXodqJMSmRJ1nhCGDED/aZbI4lizuKA5lGMuHcgAfhRJK
I+NLhlQHfKTFn1ma5qSaV0qUkHEb/dv2eQRC8MUFF4Nw6neeNHxQPEt6BjWHx2ef
evIGRtUllpERxcmUM8F4Ny+hcyiXP3r56cg4IMPphCNBaDGTt2AR+WdyOfA9mojK
FbumIs+mzb7dige6NEY+jXgcQfGuYlhLNYjxaZhfp6S3vqYE8s4IR+Kfz88j/j4k
oUhT6jMq/5HzQh+H/kTh1LiduPIOCnHMkRh3JtBA0NJTJpyvNYw=
=J562
-----END PGP SIGNATURE-----

--=-SKF+JxVFJgP7GgL8tAk7--

