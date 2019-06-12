Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24B1C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C5D7207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 03:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392200AbfFLDYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 23:24:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:58308 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391141AbfFLDYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 23:24:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jun 2019 20:24:29 -0700
X-ExtLoop1: 1
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.116])
  by orsmga003.jf.intel.com with ESMTP; 11 Jun 2019 20:24:26 -0700
Date:   Wed, 12 Jun 2019 11:22:36 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: remove duplicate entry of trace
Message-ID: <20190612032236.GH9684@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20190526075633.GA9245@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JSVXQxoTSdH0Ya++"
Content-Disposition: inline
In-Reply-To: <20190526075633.GA9245@hari-Inspiron-1545>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JSVXQxoTSdH0Ya++
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019.05.26 13:26:33 +0530, Hariprasad Kelam wrote:
> Remove duplicate include of trace.h
>=20
> Issue identified by includecheck
>=20
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/trace_points.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/trace_points.c b/drivers/gpu/drm/i9=
15/gvt/trace_points.c
> index a3deed69..569f5e3 100644
> --- a/drivers/gpu/drm/i915/gvt/trace_points.c
> +++ b/drivers/gpu/drm/i915/gvt/trace_points.c
> @@ -32,5 +32,4 @@
> =20
>  #ifndef __CHECKER__
>  #define CREATE_TRACE_POINTS
> -#include "trace.h"
>  #endif
> --=20

This actually caused build issue like
ERROR: "__tracepoint_gma_index" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_render_mmio" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_gvt_command" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_spt_guest_change" [drivers/gpu/drm/i915/i915.ko] undef=
ined!
ERROR: "__tracepoint_gma_translate" [drivers/gpu/drm/i915/i915.ko] undefine=
d!
ERROR: "__tracepoint_spt_alloc" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_spt_change" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_oos_sync" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_write_ir" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_propagate_event" [drivers/gpu/drm/i915/i915.ko] undefi=
ned!
ERROR: "__tracepoint_inject_msi" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_spt_refcount" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_spt_free" [drivers/gpu/drm/i915/i915.ko] undefined!
ERROR: "__tracepoint_oos_change" [drivers/gpu/drm/i915/i915.ko] undefined!
scripts/Makefile.modpost:91: recipe for target '__modpost' failed

Looks we need fix like below.

Subject: [PATCH] drm/i915/gvt: remove duplicate include of trace.h

This removes duplicate include of trace.h. Found by Hariprasad Kelam
with includecheck.

Reported-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 drivers/gpu/drm/i915/gvt/trace_points.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/trace_points.c b/drivers/gpu/drm/i915=
/gvt/trace_points.c
index a3deed692b9c..fe552e877e09 100644
--- a/drivers/gpu/drm/i915/gvt/trace_points.c
+++ b/drivers/gpu/drm/i915/gvt/trace_points.c
@@ -28,8 +28,6 @@
  *
  */
=20
-#include "trace.h"
-
 #ifndef __CHECKER__
 #define CREATE_TRACE_POINTS
 #include "trace.h"
--=20
2.20.1

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--JSVXQxoTSdH0Ya++
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXQBv/AAKCRCxBBozTXgY
J6qvAJ9q4SpHBMazUVGyrExwIyT3tac9zQCbB8m/t9a9wlOqkm0W0bss9NDOds0=
=lNiG
-----END PGP SIGNATURE-----

--JSVXQxoTSdH0Ya++--
