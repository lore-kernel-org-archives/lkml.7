Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A81C32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64FB420715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgAGCJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:09:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:26869 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgAGCJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:09:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 18:09:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="asc'?scan'208";a="420896975"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.116])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2020 18:09:11 -0800
Date:   Tue, 7 Jan 2020 10:06:37 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>, zhiyuan.lv@intel.com,
        hang.yuan@intel.com
Subject: Re: [PATCH 1/3] drm/i915/gvt: fix file paths in documentation
Message-ID: <20200107020637.GA5894@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200106140622.14393-1-julian.stecklina@cyberus-technology.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <20200106140622.14393-1-julian.stecklina@cyberus-technology.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.01.06 16:06:20 +0200, Julian Stecklina wrote:
> The documentation had some stale paths to i915 graphics virtualization
> code. Fix them to point to existing files.
>=20
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Cc: zhiyuan.lv@intel.com
> Cc: hang.yuan@intel.com
>=20
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> ---
>  Documentation/gpu/i915.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/gpu/i915.rst b/Documentation/gpu/i915.rst
> index e539c42a3e78..d644683c5249 100644
> --- a/Documentation/gpu/i915.rst
> +++ b/Documentation/gpu/i915.rst
> @@ -43,19 +43,19 @@ Interrupt Handling
>  Intel GVT-g Guest Support(vGPU)
>  -------------------------------
> =20
> -.. kernel-doc:: drivers/gpu/drm/i915/i915_vgpu.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gvt/vgpu.c
>     :doc: Intel GVT-g guest support
> =20
> -.. kernel-doc:: drivers/gpu/drm/i915/i915_vgpu.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gvt/vgpu.c
>     :internal:
> =20
>  Intel GVT-g Host Support(vGPU device model)
>  -------------------------------------------
> =20
> -.. kernel-doc:: drivers/gpu/drm/i915/intel_gvt.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gvt/gvt.c
>     :doc: Intel GVT-g host support
> =20
> -.. kernel-doc:: drivers/gpu/drm/i915/intel_gvt.c
> +.. kernel-doc:: drivers/gpu/drm/i915/gvt/gvt.c
>     :internal:
>

The i915_vgpu.c and intel_gvt.c are still there for guest
and host part of i915 interface with gvt. We still need them
in doc. The files in gvt/ directory are gvt device model internals.=20


>  Workarounds
> --=20
> 2.24.1
>=20

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXhPnrQAKCRCxBBozTXgY
JyMvAJ9TsnqY3mHUvUBZ/z7Xk72MkvNYRwCeJH2j6DznfHpxHvpobBYCwKxej0k=
=eCW/
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
