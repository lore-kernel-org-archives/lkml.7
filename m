Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FC1C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0968B20848
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 11:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfDOLan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 07:30:43 -0400
Received: from sauhun.de ([88.99.104.3]:40890 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfDOLak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 07:30:40 -0400
Received: from localhost (p54B331F8.dip0.t-ipconnect.de [84.179.49.248])
        by pokefinder.org (Postfix) with ESMTPSA id C6FA72C0114;
        Mon, 15 Apr 2019 13:30:37 +0200 (CEST)
Date:   Mon, 15 Apr 2019 13:30:37 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Qii Wang <qii.wang@mediatek.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        leilk.liu@mediatek.com, xinping.qian@mediatek.com,
        liguo.zhang@mediatek.com, robh@kernel.org
Subject: Re: [PATCH RESEND v6 0/6] add i2c support for mt8183
Message-ID: <20190415113037.GA2751@kunai>
References: <1554208560-14817-1-git-send-email-qii.wang@mediatek.com>
 <20190404230916.GA964@kunai>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20190404230916.GA964@kunai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2019 at 01:09:16AM +0200, Wolfram Sang wrote:
> On Tue, Apr 02, 2019 at 08:35:54PM +0800, Qii Wang wrote:
> > This series are based on 5.1-rc1 and the patch
> > https://patchwork.kernel.org/patch/10856987/(for dts)
> > We provide six patches to support mt8183 IC.
> >=20
> > Main changes compared to v5:
> > --add i2c controller nodes in mt8183.dtsi
> > --add a note that old i2c controllers also have I2C_ARB_LOST bit
> > --add a flag(ltiming_adjust) to avoid unnecessary settings
> > --add Reviewed-by from Rob Herring, Nicolas and Matthias
>=20
> Well, it seems you missed Rob's Rev-by. No need to resend, I can add it.
> I just wonder if Matthias wants to have another look at this?

Thanks Matthias! Patches 1-5 applied to for-next.


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAly0a1kACgkQFA3kzBSg
KbaRqw//W6Yqr4N1qOn8OrTcXiGxV2kYIlJZGifVdPC87dDKQuV+c10MmePB/zgL
mwdrFlvO0nKQE8cVzTB594+DJR/icbR7kQ4pRNXQaNKqzzHv9V021VPlWiFyklbF
TKheBbdXSG4GWcIOzQWmukrMPuZONGtyQzWJdrVHlDrifXnbwchXw5rGsq7yvRxr
E3nweabEvp2sRSyw0k1yzd9/I9aOGyfFuRnrYIEZ4HRL+7NUOzb3LCZLtRcTKUEM
sx6fJpMs5GzCwMwSYl2Kh1Fn4xUhvjSBzSZ5Yt6Usz03nvNiXLX4pvWNp98Ert4k
2QB0VWY9FdwmHDI0kUOdzBkNzTRRHc1kuiOgofOZjxYzGM/9zKAucVRbTGK5Jr/7
bMbLToxDNKrXMVwQ8G/t0PcwbGboquhhnOS5Sb/G47NumDNmWqEOZ4coH8gu5y5H
Cnf57CQKbH9NFmnSh7ovMqVeGDOfSapgiVrjjNrwZ8iEUeSCpO/3d503emWW97Xq
OVWw28npGySAdprdUrilUtJAW+xyeIN8LZ+z+oO3+ns5Av2pIbsBz10h5ooSyq6b
cHTHVW3TMlbFiWaEKvMwm1IpOL4qkLdGZJhqZX2xmfWzIIivCa9CvUw5LZqIImn4
NYmiP8mDh2Kwhsigpzho8qAXeodpTI0d8QTb1ecTp3/qezbLGGw=
=U4jH
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
