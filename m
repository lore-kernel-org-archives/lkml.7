Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAD4C07542
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EC7F21734
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 09:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfE0JI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 05:08:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:58675 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfE0JI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 05:08:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 02:08:58 -0700
X-ExtLoop1: 1
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.116])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2019 02:08:55 -0700
Date:   Mon, 27 May 2019 17:07:41 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Tina Zhang <tina.zhang@intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kraxel@redhat.com,
        zhenyuw@linux.intel.com, alex.williamson@redhat.com,
        hang.yuan@intel.com, zhiyuan.lv@intel.com
Subject: Re: [PATCH 1/2] vfio: ABI for setting mdev display flip eventfd
Message-ID: <20190527090741.GE29553@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20190527084312.8872-1-tina.zhang@intel.com>
 <20190527084312.8872-2-tina.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
In-Reply-To: <20190527084312.8872-2-tina.zhang@intel.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019.05.27 16:43:11 +0800, Tina Zhang wrote:
> Add VFIO_DEVICE_SET_GFX_FLIP_EVENTFD ioctl command to set eventfd
> based signaling mechanism to deliver vGPU framebuffer page flip
> event to userspace.
>

Should we add probe to see if driver can support gfx flip event?

> Signed-off-by: Tina Zhang <tina.zhang@intel.com>
> ---
>  include/uapi/linux/vfio.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>=20
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 02bb7ad6e986..27300597717f 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -696,6 +696,18 @@ struct vfio_device_ioeventfd {
> =20
>  #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
> =20
> +/**
> + * VFIO_DEVICE_SET_GFX_FLIP_EVENTFD - _IOW(VFIO_TYPE, VFIO_BASE + 17, __=
s32)
> + *
> + * Set eventfd based signaling mechanism to deliver vGPU framebuffer page
> + * flip event to userspace. A value of -1 is used to stop the page flip
> + * delivering.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +
> +#define VFIO_DEVICE_SET_GFX_FLIP_EVENTFD _IO(VFIO_TYPE, VFIO_BASE + 17)
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
> =20
>  /**
> --=20
> 2.17.1
>=20

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXOuo3QAKCRCxBBozTXgY
J7/dAJ9QLbQBdhMMbxjTKO1yebnD51NVUACcDHl7pOknebyQxRlI1LrDOuZu7Kw=
=g5+1
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--
