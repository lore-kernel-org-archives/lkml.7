Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19EB2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF2AB204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 11:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfDWLWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 07:22:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:35322 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727467AbfDWLWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 07:22:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B9228AE89;
        Tue, 23 Apr 2019 11:22:10 +0000 (UTC)
Subject: Re: [PATCH 06/20] lib: Add video format information library
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-media@vger.kernel.org
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <c17a896150f0b793cfa8581d18969cd7b3e93bf2.1555487650.git-series.maxime.ripard@bootlin.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNKFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmNvbT7CwJQEEwEIAD4W
 IQRyF/usjOnPY0ShaOVoDcEdUwt6IwUCWznTtgIbAwUJA8JnAAULCQgHAgYVCgkICwIEFgID
 AQIeAQIXgAAKCRBoDcEdUwt6I7D7CACBK42XW+7mCiK8ioXMEy1NzGbXC51RzGea8N83oEJS
 1KVUtQxrkDxgrW/WLSl/TfqHFsJpdEFOv1XubWbleun3uKPy0e5vZCd5UjZPkeNjnqfCYTDy
 hVVsdOuFbtWDppJyJrThLqr9AgSFmoCNNUt1SVpYEEOLNE6C32BhlnSq21VLC+YXTgO/ZHTa
 YXkq54hHj63jwrcjkBSCkXLh37kHeqnl++GHpN+3R+o3w2OpwHAlvVjdKPT27v1tVkiydsFG
 65Vd0n3m/ft+IOrGgxQM1C20uqKvsZGB4r3OGR50ekAybO7sjEJJ1Obl4ge/6RRqcvKz4LMb
 tGs85D6tPIeFzsBNBFs50uABCADGJj+DP1fk+UWOWrf4O61HTbC4Vr9QD2K4fUUHnzg2B6zU
 R1BPXqLGG0+lzK8kfYU/F5RjmEcClsIkAaFkg4kzKP14tvY1J5+AV3yNqcdg018HNtiyrSwI
 E0Yz/qm1Ot2NMZ0DdvVBg22IMsiudQ1tx9CH9mtyTbIXgACvl3PW2o9CxiHPE/bohFhwZwh/
 kXYYAE51lhinQ3oFEeQZA3w4OTvxSEspiQR8dg8qJJb+YOAc5IKk6sJmmM7JfFMWSr22satM
 23oQ3WvJb4RV6HTRTAIEyyZS7g2DhiytgMG60t0qdABG5KXSQW+OKlZRpuWwKWaLh3if/p/u
 69dvpanbABEBAAHCwHwEGAEIACYWIQRyF/usjOnPY0ShaOVoDcEdUwt6IwUCWznS4AIbDAUJ
 A8JnAAAKCRBoDcEdUwt6I6X3CACJ8D+TpXBCqJE5xwog08+Dp8uBpx0T9n1wE0GQisZruACW
 NofYn8PTX9k4wmegDLwt7YQDdKxQ4+eTfZeLNQqWg6OCftH5Kx7sjWnJ09tOgniVdROzWJ7c
 VJ/i0okazncsJ+nq48UYvRGE1Swh3A4QRIyphWX4OADOBmTFl9ZYNPnh23eaC9WrNvFr7yP7
 iGjMlfEW8l6Lda//EC5VpXVNza0xeae0zFNst2R9pn+bLkihwDLWxOIyifGRxTqNxoS4I1aw
 VhxPSVztPMSpIA/sOr/N/p6JrBLn+gui2K6mP7bGb8hF+szfArYqz3T1rv1VzUWAJf5Wre5U
 iNx9uqqx
Message-ID: <0aae62f0-776a-6933-2290-f0141d01c5b2@suse.de>
Date:   Tue, 23 Apr 2019 13:22:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <c17a896150f0b793cfa8581d18969cd7b3e93bf2.1555487650.git-series.maxime.ripard@bootlin.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2edTowVqNYYMw19yEZVm8UQFHdkGKgNy3"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2edTowVqNYYMw19yEZVm8UQFHdkGKgNy3
Content-Type: multipart/mixed; boundary="fg3gjYeGEpzlDhdchAV2UbYmr50PKY8EI";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Daniel Vetter <daniel.vetter@intel.com>, David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-media@vger.kernel.org
Message-ID: <0aae62f0-776a-6933-2290-f0141d01c5b2@suse.de>
Subject: Re: [PATCH 06/20] lib: Add video format information library
References: <cover.8ec406bf8f4f097e9dc909d5aac466556822f592.1555487650.git-series.maxime.ripard@bootlin.com>
 <c17a896150f0b793cfa8581d18969cd7b3e93bf2.1555487650.git-series.maxime.ripard@bootlin.com>
In-Reply-To: <c17a896150f0b793cfa8581d18969cd7b3e93bf2.1555487650.git-series.maxime.ripard@bootlin.com>

--fg3gjYeGEpzlDhdchAV2UbYmr50PKY8EI
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 17.04.19 um 09:54 schrieb Maxime Ripard:
> Move the DRM formats API to turn this into a more generic image formats=
 API
> to be able to leverage it into some other places of the kernel, such as=

> v4l2 drivers.

Here's some nitpicking: 'image_format_*' appears slightly vague; it
could refer to a disk or ROM image as well. Something like
'pixel_format_*', 'pixbuf_format_*', etc. would clearly indicate graphics=
=2E

Best regards
Thomas

>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  include/linux/image-formats.h | 387 +++++++++++++++++++++-
>  lib/Kconfig                   |   7 +-
>  lib/Makefile                  |   3 +-
>  lib/image-formats-selftests.c | 325 +++++++++++++++++-
>  lib/image-formats.c           | 655 ++++++++++++++++++++++++++++++++++=
+-
>  5 files changed, 1377 insertions(+)
>  create mode 100644 include/linux/image-formats.h
>  create mode 100644 lib/image-formats-selftests.c
>  create mode 100644 lib/image-formats.c
>=20
> diff --git a/include/linux/image-formats.h b/include/linux/image-format=
s.h
> new file mode 100644
> index 000000000000..ec43d9f9a527
> --- /dev/null
> +++ b/include/linux/image-formats.h
> @@ -0,0 +1,387 @@
> +/*
> + * Copyright (c) 2016 Laurent Pinchart <laurent.pinchart@ideasonboard.=
com>
> + * Copyright (c) 2019 Maxime Ripard <maxime.ripard@bootlin.com>
> + *
> + * Permission to use, copy, modify, distribute, and sell this software=
 and its
> + * documentation for any purpose is hereby granted without fee, provid=
ed that
> + * the above copyright notice appear in all copies and that both that =
copyright
> + * notice and this permission notice appear in supporting documentatio=
n, and
> + * that the name of the copyright holders not be used in advertising o=
r
> + * publicity pertaining to distribution of the software without specif=
ic,
> + * written prior permission.  The copyright holders make no representa=
tions
> + * about the suitability of this software for any purpose.  It is prov=
ided "as
> + * is" without express or implied warranty.
> + *
> + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS S=
OFTWARE,
> + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN=
 NO
> + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRE=
CT OR
> + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS=
 OF USE,
> + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OT=
HER
> + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PE=
RFORMANCE
> + * OF THIS SOFTWARE.
> + */
> +
> +#ifndef _IMAGE_FORMATS_H_
> +#define _IMAGE_FORMATS_H_
> +
> +#include <linux/kernel.h>
> +#include <linux/types.h>
> +
> +/**
> + * struct image_format_info - information about a image format
> + */
> +struct image_format_info {
> +	union {
> +		/**
> +		 * @drm_fmt:
> +		 *
> +		 * DRM 4CC format identifier (DRM_FORMAT_*)
> +		 */
> +		u32 drm_fmt;
> +
> +		/**
> +		 * @format:
> +		 *
> +		 * DRM 4CC format identifier (DRM_FORMAT_*). Kept
> +		 * around for compatibility reasons with the current
> +		 * DRM drivers.
> +		 */
> +		u32 format;
> +	};
> +
> +	/**
> +	 * @depth:
> +	 *
> +	 * Color depth (number of bits per pixel excluding padding bits),
> +	 * valid for a subset of RGB formats only. This is a legacy field, do=

> +	 * not use in new code and set to 0 for new formats.
> +	 */
> +	u8 depth;
> +
> +	/** @num_planes: Number of color planes (1 to 3) */
> +	u8 num_planes;
> +
> +	union {
> +		/**
> +		 * @cpp:
> +		 *
> +		 * Number of bytes per pixel (per plane), this is aliased with
> +		 * @char_per_block. It is deprecated in favour of using the
> +		 * triplet @char_per_block, @block_w, @block_h for better
> +		 * describing the pixel format.
> +		 */
> +		u8 cpp[3];
> +
> +		/**
> +		 * @char_per_block:
> +		 *
> +		 * Number of bytes per block (per plane), where blocks are
> +		 * defined as a rectangle of pixels which are stored next to
> +		 * each other in a byte aligned memory region. Together with
> +		 * @block_w and @block_h this is used to properly describe tiles
> +		 * in tiled formats or to describe groups of pixels in packed
> +		 * formats for which the memory needed for a single pixel is not
> +		 * byte aligned.
> +		 *
> +		 * @cpp has been kept for historical reasons because there are
> +		 * a lot of places in drivers where it's used. In drm core for
> +		 * generic code paths the preferred way is to use
> +		 * @char_per_block, image_format_info_block_width() and
> +		 * image_format_info_block_height() which allows handling both
> +		 * block and non-block formats in the same way.
> +		 *
> +		 * For formats that are intended to be used only with non-linear
> +		 * modifiers both @cpp and @char_per_block must be 0 in the
> +		 * generic format table. Drivers could supply accurate
> +		 * information from their drm_mode_config.get_format_info hook
> +		 * if they want the core to be validating the pitch.
> +		 */
> +		u8 char_per_block[3];
> +	};
> +
> +	/**
> +	 * @block_w:
> +	 *
> +	 * Block width in pixels, this is intended to be accessed through
> +	 * image_format_info_block_width()
> +	 */
> +	u8 block_w[3];
> +
> +	/**
> +	 * @block_h:
> +	 *
> +	 * Block height in pixels, this is intended to be accessed through
> +	 * image_format_info_block_height()
> +	 */
> +	u8 block_h[3];
> +
> +	/** @hsub: Horizontal chroma subsampling factor */
> +	u8 hsub;
> +	/** @vsub: Vertical chroma subsampling factor */
> +	u8 vsub;
> +
> +	/** @has_alpha: Does the format embeds an alpha component? */
> +	bool has_alpha;
> +
> +	/** @is_yuv: Is it a YUV format? */
> +	bool is_yuv;
> +};
> +
> +/**
> + * image_format_info_is_yuv_packed - check that the format info matche=
s a YUV
> + * format with data laid in a single plane
> + * @info: format info
> + *
> + * Returns:
> + * A boolean indicating whether the format info matches a packed YUV f=
ormat.
> + */
> +static inline bool
> +image_format_info_is_yuv_packed(const struct image_format_info *info)
> +{
> +	return info->is_yuv && info->num_planes =3D=3D 1;
> +}
> +
> +/**
> + * image_format_info_is_yuv_semiplanar - check that the format info ma=
tches a YUV
> + * format with data laid in two planes (luminance and chrominance)
> + * @info: format info
> + *
> + * Returns:
> + * A boolean indicating whether the format info matches a semiplanar Y=
UV format.
> + */
> +static inline bool
> +image_format_info_is_yuv_semiplanar(const struct image_format_info *in=
fo)
> +{
> +	return info->is_yuv && info->num_planes =3D=3D 2;
> +}
> +
> +/**
> + * image_format_info_is_yuv_planar - check that the format info matche=
s a YUV
> + * format with data laid in three planes (one for each YUV component)
> + * @info: format info
> + *
> + * Returns:
> + * A boolean indicating whether the format info matches a planar YUV f=
ormat.
> + */
> +static inline bool
> +image_format_info_is_yuv_planar(const struct image_format_info *info)
> +{
> +	return info->is_yuv && info->num_planes =3D=3D 3;
> +}
> +
> +/**
> + * image_format_info_is_yuv_sampling_410 - check that the format info =
matches a
> + * YUV format with 4:1:0 sub-sampling
> + * @info: format info
> + *
> + * Returns:
> + * A boolean indicating whether the format info matches a YUV format w=
ith 4:1:0
> + * sub-sampling.
> + */
> +static inline bool
> +image_format_info_is_yuv_sampling_410(const struct image_format_info *=
info)
> +{
> +	return info->is_yuv && info->hsub =3D=3D 4 && info->vsub =3D=3D 4;
> +}
> +
> +/**
> + * image_format_info_is_yuv_sampling_411 - check that the format info =
matches a
> + * YUV format with 4:1:1 sub-sampling
> + * @info: format info
> + *
> + * Returns:
> + * A boolean indicating whether the format info matches a YUV format w=
ith 4:1:1
> + * sub-sampling.
> + */
> +static inline bool
> +image_format_info_is_yuv_sampling_411(const struct image_format_info *=
info)
> +{
> +	return info->is_yuv && info->hsub =3D=3D 4 && info->vsub =3D=3D 1;
> +}
> +
> +/**
> + * image_format_info_is_yuv_sampling_420 - check that the format info =
matches a
> + * YUV format with 4:2:0 sub-sampling
> + * @info: format info
> + *
> + * Returns:
> + * A boolean indicating whether the format info matches a YUV format w=
ith 4:2:0
> + * sub-sampling.
> + */
> +static inline bool
> +image_format_info_is_yuv_sampling_420(const struct image_format_info *=
info)
> +{
> +	return info->is_yuv && info->hsub =3D=3D 2 && info->vsub =3D=3D 2;
> +}
> +
> +/**
> + * image_format_info_is_yuv_sampling_422 - check that the format info =
matches a
> + * YUV format with 4:2:2 sub-sampling
> + * @info: format info
> + *
> + * Returns:
> + * A boolean indicating whether the format info matches a YUV format w=
ith 4:2:2
> + * sub-sampling.
> + */
> +static inline bool
> +image_format_info_is_yuv_sampling_422(const struct image_format_info *=
info)
> +{
> +	return info->is_yuv && info->hsub =3D=3D 2 && info->vsub =3D=3D 1;
> +}
> +
> +/**
> + * image_format_info_is_yuv_sampling_444 - check that the format info =
matches a
> + * YUV format with 4:4:4 sub-sampling
> + * @info: format info
> + *
> + * Returns:
> + * A boolean indicating whether the format info matches a YUV format w=
ith 4:4:4
> + * sub-sampling.
> + */
> +static inline bool
> +image_format_info_is_yuv_sampling_444(const struct image_format_info *=
info)
> +{
> +	return info->is_yuv && info->hsub =3D=3D 1 && info->vsub =3D=3D 1;
> +}
> +
> +/**
> + * image_format_info_plane_cpp - determine the bytes per pixel value
> + * @format: pixel format info
> + * @plane: plane index
> + *
> + * Returns:
> + * The bytes per pixel value for the specified plane.
> + */
> +static inline
> +int image_format_info_plane_cpp(const struct image_format_info *info, =
int plane)
> +{
> +	if (!info || plane >=3D info->num_planes)
> +		return 0;
> +
> +	return info->cpp[plane];
> +}
> +
> +/**
> + * image_format_info_plane_width - width of the plane given the first =
plane
> + * @format: pixel format info
> + * @width: width of the first plane
> + * @plane: plane index
> + *
> + * Returns:
> + * The width of @plane, given that the width of the first plane is @wi=
dth.
> + */
> +static inline
> +int image_format_info_plane_width(const struct image_format_info *info=
, int width,
> +				  int plane)
> +{
> +	if (!info || plane >=3D info->num_planes)
> +		return 0;
> +
> +	if (plane =3D=3D 0)
> +		return width;
> +
> +	return width / info->hsub;
> +}
> +
> +/**
> + * image_format_info_plane_height - height of the plane given the firs=
t plane
> + * @format: pixel format info
> + * @height: height of the first plane
> + * @plane: plane index
> + *
> + * Returns:
> + * The height of @plane, given that the height of the first plane is @=
height.
> + */
> +static inline
> +int image_format_info_plane_height(const struct image_format_info *inf=
o, int height,
> +				   int plane)
> +{
> +	if (!info || plane >=3D info->num_planes)
> +		return 0;
> +
> +	if (plane =3D=3D 0)
> +		return height;
> +
> +	return height / info->vsub;
> +}
> +
> +/**
> + * image_format_info_block_width - width in pixels of block.
> + * @format: pointer to the image_format_info
> + * @plane: plane index
> + *
> + * Returns:
> + * The width in pixels of a block, depending on the plane index.
> + */
> +static inline
> +unsigned int image_format_info_block_width(const struct image_format_i=
nfo *format,
> +					   int plane)
> +{
> +	if (!format)
> +		return 0;
> +
> +	if (plane < 0 || plane >=3D ARRAY_SIZE(format->block_w))
> +		return 0;
> +
> +	if (plane >=3D format->num_planes)
> +		return 0;
> +
> +	if (!format->block_w[plane])
> +		return 1;
> +
> +	return format->block_w[plane];
> +}
> +
> +/**
> + * image_format_info_block_height - height in pixels of a block
> + * @info: pointer to the image_format_info
> + * @plane: plane index
> + *
> + * Returns:
> + * The height in pixels of a block, depending on the plane index.
> + */
> +static inline
> +unsigned int image_format_info_block_height(const struct image_format_=
info *format,
> +					    int plane)
> +{
> +	if (!format)
> +		return 0;
> +
> +	if (plane < 0 || plane >=3D ARRAY_SIZE(format->block_w))
> +		return 0;
> +
> +	if (plane >=3D format->num_planes)
> +		return 0;
> +
> +	if (!format->block_h[plane])
> +		return 1;
> +
> +	return format->block_h[plane];
> +}
> +
> +/**
> + * image_format_info_min_pitch - computes the minimum required pitch i=
n bytes
> + * @info: pixel format info
> + * @plane: plane index
> + * @buffer_width: buffer width in pixels
> + *
> + * Returns:
> + * The minimum required pitch in bytes for a buffer by taking into con=
sideration
> + * the pixel format information and the buffer width.
> + */
> +static inline
> +uint64_t image_format_info_min_pitch(const struct image_format_info *i=
nfo,
> +				     int plane, unsigned int buffer_width)
> +{
> +	if (!info || plane < 0 || plane >=3D info->num_planes)
> +		return 0;
> +
> +	return DIV_ROUND_UP_ULL((u64)buffer_width * info->char_per_block[plan=
e],
> +			    image_format_info_block_width(info, plane) *
> +			    image_format_info_block_height(info, plane));
> +}
> +
> +const struct image_format_info *__image_format_drm_lookup(u32 drm);
> +const struct image_format_info *image_format_drm_lookup(u32 drm);
> +
> +#endif /* _IMAGE_FORMATS_H_ */
> diff --git a/lib/Kconfig b/lib/Kconfig
> index fb453afff32e..9a0160d3123b 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -625,3 +625,10 @@ config GENERIC_LIB_UCMPDI2
> =20
>  config OBJAGG
>  	tristate "objagg" if COMPILE_TEST
> +
> +config IMAGE_FORMATS
> +	bool
> +
> +config IMAGE_FORMATS_SELFTESTS
> +	tristate "Test image format functions"
> +	depends on IMAGE_FORMATS
> diff --git a/lib/Makefile b/lib/Makefile
> index 6996d2b9f401..203336b91248 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -280,3 +280,6 @@ obj-$(CONFIG_GENERIC_LIB_MULDI3) +=3D muldi3.o
>  obj-$(CONFIG_GENERIC_LIB_CMPDI2) +=3D cmpdi2.o
>  obj-$(CONFIG_GENERIC_LIB_UCMPDI2) +=3D ucmpdi2.o
>  obj-$(CONFIG_OBJAGG) +=3D objagg.o
> +
> +obj-$(CONFIG_IMAGE_FORMATS) +=3D image-formats.o
> +obj-$(CONFIG_IMAGE_FORMATS_SELFTESTS) +=3D image-formats-selftests.o
> diff --git a/lib/image-formats-selftests.c b/lib/image-formats-selftest=
s.c
> new file mode 100644
> index 000000000000..d0f0011b535e
> --- /dev/null
> +++ b/lib/image-formats-selftests.c
> @@ -0,0 +1,325 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Test cases for the image_format functions
> + */
> +
> +#define pr_fmt(fmt) "image_format: " fmt
> +
> +#include <linux/errno.h>
> +#include <linux/image-formats.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +#include <drm/drm_fourcc.h>
> +
> +#define FAIL(test, msg, ...) \
> +	do { \
> +		if (test) { \
> +			pr_err("%s/%u: " msg, __FUNCTION__, __LINE__, ##__VA_ARGS__); \
> +			return -EINVAL; \
> +		} \
> +	} while (0)
> +
> +#define FAIL_ON(x) FAIL((x), "%s", "FAIL_ON(" __stringify(x) ")\n")
> +
> +static int test_image_format_info_block_width(void)
> +{
> +	const struct image_format_info *info =3D NULL;
> +
> +	/* Test invalid arguments */
> +	FAIL_ON(image_format_info_block_width(info, 0) !=3D 0);
> +	FAIL_ON(image_format_info_block_width(info, -1) !=3D 0);
> +	FAIL_ON(image_format_info_block_width(info, 1) !=3D 0);
> +
> +	/* Test 1 plane format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_XRGB4444);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_block_width(info, 0) !=3D 1);
> +	FAIL_ON(image_format_info_block_width(info, 1) !=3D 0);
> +	FAIL_ON(image_format_info_block_width(info, -1) !=3D 0);
> +
> +	/* Test 2 planes format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_NV12);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_block_width(info, 0) !=3D 1);
> +	FAIL_ON(image_format_info_block_width(info, 1) !=3D 1);
> +	FAIL_ON(image_format_info_block_width(info, 2) !=3D 0);
> +	FAIL_ON(image_format_info_block_width(info, -1) !=3D 0);
> +
> +	/* Test 3 planes format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_YUV422);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_block_width(info, 0) !=3D 1);
> +	FAIL_ON(image_format_info_block_width(info, 1) !=3D 1);
> +	FAIL_ON(image_format_info_block_width(info, 2) !=3D 1);
> +	FAIL_ON(image_format_info_block_width(info, 3) !=3D 0);
> +	FAIL_ON(image_format_info_block_width(info, -1) !=3D 0);
> +
> +	/* Test a tiled format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_X0L0);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_block_width(info, 0) !=3D 2);
> +	FAIL_ON(image_format_info_block_width(info, 1) !=3D 0);
> +	FAIL_ON(image_format_info_block_width(info, -1) !=3D 0);
> +
> +	return 0;
> +}
> +
> +static int test_image_format_info_block_height(void)
> +{
> +	const struct image_format_info *info =3D NULL;
> +
> +	/* Test invalid arguments */
> +	FAIL_ON(image_format_info_block_height(info, 0) !=3D 0);
> +	FAIL_ON(image_format_info_block_height(info, -1) !=3D 0);
> +	FAIL_ON(image_format_info_block_height(info, 1) !=3D 0);
> +
> +	/* Test 1 plane format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_XRGB4444);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_block_height(info, 0) !=3D 1);
> +	FAIL_ON(image_format_info_block_height(info, 1) !=3D 0);
> +	FAIL_ON(image_format_info_block_height(info, -1) !=3D 0);
> +
> +	/* Test 2 planes format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_NV12);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_block_height(info, 0) !=3D 1);
> +	FAIL_ON(image_format_info_block_height(info, 1) !=3D 1);
> +	FAIL_ON(image_format_info_block_height(info, 2) !=3D 0);
> +	FAIL_ON(image_format_info_block_height(info, -1) !=3D 0);
> +
> +	/* Test 3 planes format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_YUV422);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_block_height(info, 0) !=3D 1);
> +	FAIL_ON(image_format_info_block_height(info, 1) !=3D 1);
> +	FAIL_ON(image_format_info_block_height(info, 2) !=3D 1);
> +	FAIL_ON(image_format_info_block_height(info, 3) !=3D 0);
> +	FAIL_ON(image_format_info_block_height(info, -1) !=3D 0);
> +
> +	/* Test a tiled format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_X0L0);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_block_height(info, 0) !=3D 2);
> +	FAIL_ON(image_format_info_block_height(info, 1) !=3D 0);
> +	FAIL_ON(image_format_info_block_height(info, -1) !=3D 0);
> +
> +	return 0;
> +}
> +
> +static int test_image_format_info_min_pitch(void)
> +{
> +	const struct image_format_info *info =3D NULL;
> +
> +	/* Test invalid arguments */
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) !=3D 0);
> +
> +	/* Test 1 plane 8 bits per pixel format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_RGB332);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) !=3D 0);
> +
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) !=3D 1);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) !=3D 640);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) !=3D 1024);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) !=3D 1920);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) !=3D 4096);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) !=3D 671);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=3D
> +			(uint64_t)UINT_MAX);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=3D
> +			(uint64_t)(UINT_MAX - 1));
> +
> +	/* Test 1 plane 16 bits per pixel format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_XRGB4444);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) !=3D 0);
> +
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) !=3D 4);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) !=3D 1280);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) !=3D 2048);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) !=3D 3840);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) !=3D 8192);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) !=3D 1342);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=3D
> +			(uint64_t)UINT_MAX * 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=3D
> +			(uint64_t)(UINT_MAX - 1) * 2);
> +
> +	/* Test 1 plane 24 bits per pixel format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_RGB888);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) !=3D 0);
> +
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) !=3D 3);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) !=3D 6);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) !=3D 1920);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) !=3D 3072);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) !=3D 5760);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) !=3D 12288);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) !=3D 2013);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=3D
> +			(uint64_t)UINT_MAX * 3);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX - 1) !=3D
> +			(uint64_t)(UINT_MAX - 1) * 3);
> +
> +	/* Test 1 plane 32 bits per pixel format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_ABGR8888);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) !=3D 0);
> +
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) !=3D 4);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) !=3D 8);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) !=3D 2560);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) !=3D 4096);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) !=3D 7680);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) !=3D 16384);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) !=3D 2684);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=3D
> +			(uint64_t)UINT_MAX * 4);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX - 1) !=3D
> +			(uint64_t)(UINT_MAX - 1) * 4);
> +
> +	/* Test 2 planes format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_NV12);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 0) !=3D 0);
> +
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) !=3D 1);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 1) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 1) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) !=3D 640);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 320) !=3D 640);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) !=3D 1024);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 512) !=3D 1024);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) !=3D 1920);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 960) !=3D 1920);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) !=3D 4096);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 2048) !=3D 4096);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) !=3D 671);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 336) !=3D 672);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=3D
> +			(uint64_t)UINT_MAX);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1) !=3D
> +			(uint64_t)UINT_MAX + 1);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, (UINT_MAX - 1)) !=3D
> +			(uint64_t)(UINT_MAX - 1));
> +	FAIL_ON(image_format_info_min_pitch(info, 1, (UINT_MAX - 1) /  2) !=3D=

> +			(uint64_t)(UINT_MAX - 1));
> +
> +	/* Test 3 planes 8 bits per pixel format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_YUV422);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 3, 0) !=3D 0);
> +
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) !=3D 1);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 1) !=3D 1);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 1) !=3D 1);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 2) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 2) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) !=3D 640);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 320) !=3D 320);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 320) !=3D 320);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) !=3D 1024);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 512) !=3D 512);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 512) !=3D 512);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) !=3D 1920);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 960) !=3D 960);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 960) !=3D 960);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) !=3D 4096);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 2048) !=3D 2048);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 2048) !=3D 2048);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) !=3D 671);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 336) !=3D 336);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, 336) !=3D 336);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=3D
> +			(uint64_t)UINT_MAX);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, UINT_MAX / 2 + 1) !=3D
> +			(uint64_t)UINT_MAX / 2 + 1);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, UINT_MAX / 2 + 1) !=3D
> +			(uint64_t)UINT_MAX / 2 + 1);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, (UINT_MAX - 1) / 2) !=3D=

> +			(uint64_t)(UINT_MAX - 1) / 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, (UINT_MAX - 1) / 2) !=3D=

> +			(uint64_t)(UINT_MAX - 1) / 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 2, (UINT_MAX - 1) / 2) !=3D=

> +			(uint64_t)(UINT_MAX - 1) / 2);
> +
> +	/* Test tiled format */
> +	info =3D image_format_drm_lookup(DRM_FORMAT_X0L2);
> +	FAIL_ON(!info);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, -1, 0) !=3D 0);
> +	FAIL_ON(image_format_info_min_pitch(info, 1, 0) !=3D 0);
> +
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1) !=3D 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 2) !=3D 4);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 640) !=3D 1280);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1024) !=3D 2048);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 1920) !=3D 3840);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 4096) !=3D 8192);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, 671) !=3D 1342);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX) !=3D
> +			(uint64_t)UINT_MAX * 2);
> +	FAIL_ON(image_format_info_min_pitch(info, 0, UINT_MAX - 1) !=3D
> +			(uint64_t)(UINT_MAX - 1) * 2);
> +
> +	return 0;
> +}
> +
> +#define selftest(test)	{ .name =3D #test, .func =3D test, }
> +
> +static struct image_format_test {
> +	char	*name;
> +	int	(*func)(void);
> +} tests[] =3D {
> +	selftest(test_image_format_info_block_height),
> +	selftest(test_image_format_info_block_width),
> +	selftest(test_image_format_info_min_pitch),
> +};
> +
> +static int __init image_format_test_init(void)
> +{
> +	unsigned int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(tests); i++) {
> +		struct image_format_test *test =3D &tests[i];
> +		int ret;
> +
> +		ret =3D test->func();
> +		if (ret) {
> +			pr_err("Failed test %s\n", test->name);
> +			return ret;
> +		}
> +	}
> +
> +	pr_info("All tests executed properly.\n");
> +	return 0;
> +}
> +module_init(image_format_test_init);
> +
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_AUTHOR("Maxime Ripard <maxime.ripard@bootlin.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/lib/image-formats.c b/lib/image-formats.c
> new file mode 100644
> index 000000000000..1e52a7410222
> --- /dev/null
> +++ b/lib/image-formats.c
> @@ -0,0 +1,655 @@
> +/*
> + * Copyright (c) 2016 Laurent Pinchart <laurent.pinchart@ideasonboard.=
com>
> + * Copyright (c) 2019 Maxime Ripard <maxime.ripard@bootlin.com>
> + *
> + * Permission to use, copy, modify, distribute, and sell this software=
 and its
> + * documentation for any purpose is hereby granted without fee, provid=
ed that
> + * the above copyright notice appear in all copies and that both that =
copyright
> + * notice and this permission notice appear in supporting documentatio=
n, and
> + * that the name of the copyright holders not be used in advertising o=
r
> + * publicity pertaining to distribution of the software without specif=
ic,
> + * written prior permission.  The copyright holders make no representa=
tions
> + * about the suitability of this software for any purpose.  It is prov=
ided "as
> + * is" without express or implied warranty.
> + *
> + * THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS S=
OFTWARE,
> + * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN=
 NO
> + * EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRE=
CT OR
> + * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS=
 OF USE,
> + * DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OT=
HER
> + * TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PE=
RFORMANCE
> + * OF THIS SOFTWARE.
> + */
> +
> +#include <linux/bug.h>
> +#include <linux/image-formats.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +
> +#include <uapi/drm/drm_fourcc.h>
> +
> +static const struct image_format_info formats[] =3D {
> +	{
> +		.drm_fmt =3D DRM_FORMAT_C8,
> +		.depth =3D 8,
> +		.num_planes =3D 1,
> +		.cpp =3D { 1, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGB332,
> +		.depth =3D 8,
> +		.num_planes =3D 1,
> +		.cpp =3D { 1, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGR233,
> +		.depth =3D 8,
> +		.num_planes =3D 1,
> +		.cpp =3D { 1, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XRGB4444,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XBGR4444,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBX4444,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRX4444,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_ARGB4444,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_ABGR4444,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBA4444,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRA4444,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XRGB1555,
> +		.depth =3D 15,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XBGR1555,
> +		.depth =3D 15,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBX5551,
> +		.depth =3D 15,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRX5551,
> +		.depth =3D 15,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_ARGB1555,
> +		.depth =3D 15,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_ABGR1555,
> +		.depth =3D 15,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBA5551,
> +		.depth =3D 15,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRA5551,
> +		.depth =3D 15,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGB565,
> +		.depth =3D 16,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGR565,
> +		.depth =3D 16,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGB888,
> +		.depth =3D 24,
> +		.num_planes =3D 1,
> +		.cpp =3D { 3, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGR888,
> +		.depth =3D 24,
> +		.num_planes =3D 1,
> +		.cpp =3D { 3, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XRGB8888,
> +		.depth =3D 24,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XBGR8888,
> +		.depth =3D 24,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBX8888,
> +		.depth =3D 24,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRX8888,
> +		.depth =3D 24,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGB565_A8,
> +		.depth =3D 24,
> +		.num_planes =3D 2,
> +		.cpp =3D { 2, 1, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGR565_A8,
> +		.depth =3D 24,
> +		.num_planes =3D 2,
> +		.cpp =3D { 2, 1, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XRGB2101010,
> +		.depth =3D 30,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XBGR2101010,
> +		.depth =3D 30,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBX1010102,
> +		.depth =3D 30,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRX1010102,
> +		.depth =3D 30,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_ARGB2101010,
> +		.depth =3D 30,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_ABGR2101010,
> +		.depth =3D 30,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBA1010102,
> +		.depth =3D 30,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRA1010102,
> +		.depth =3D 30,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_ARGB8888,
> +		.depth =3D 32,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_ABGR8888,
> +		.depth =3D 32,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBA8888,
> +		.depth =3D 32,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRA8888,
> +		.depth =3D 32,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGB888_A8,
> +		.depth =3D 32,
> +		.num_planes =3D 2,
> +		.cpp =3D { 3, 1, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGR888_A8,
> +		.depth =3D 32,
> +		.num_planes =3D 2,
> +		.cpp =3D { 3, 1, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XRGB8888_A8,
> +		.depth =3D 32,
> +		.num_planes =3D 2,
> +		.cpp =3D { 4, 1, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XBGR8888_A8,
> +		.depth =3D 32,
> +		.num_planes =3D 2,
> +		.cpp =3D { 4, 1, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_RGBX8888_A8,
> +		.depth =3D 32,
> +		.num_planes =3D 2,
> +		.cpp =3D { 4, 1, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_BGRX8888_A8,
> +		.depth =3D 32,
> +		.num_planes =3D 2,
> +		.cpp =3D { 4, 1, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YUV410,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 4,
> +		.vsub =3D 4,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YVU410,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 4,
> +		.vsub =3D 4,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YUV411,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 4,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YVU411,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 4,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YUV420,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 2,
> +		.vsub =3D 2,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YVU420,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 2,
> +		.vsub =3D 2,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YUV422,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 2,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YVU422,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 2,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YUV444,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YVU444,
> +		.depth =3D 0,
> +		.num_planes =3D 3,
> +		.cpp =3D { 1, 1, 1 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_NV12,
> +		.depth =3D 0,
> +		.num_planes =3D 2,
> +		.cpp =3D { 1, 2, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 2,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_NV21,
> +		.depth =3D 0,
> +		.num_planes =3D 2,
> +		.cpp =3D { 1, 2, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 2,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_NV16,
> +		.depth =3D 0,
> +		.num_planes =3D 2,
> +		.cpp =3D { 1, 2, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_NV61,
> +		.depth =3D 0,
> +		.num_planes =3D 2,
> +		.cpp =3D { 1, 2, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_NV24,
> +		.depth =3D 0,
> +		.num_planes =3D 2,
> +		.cpp =3D { 1, 2, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_NV42,
> +		.depth =3D 0,
> +		.num_planes =3D 2,
> +		.cpp =3D { 1, 2, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YUYV,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_YVYU,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_UYVY,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_VYUY,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 2, 0, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_XYUV8888,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_AYUV,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.cpp =3D { 4, 0, 0 },
> +		.hsub =3D 1,
> +		.vsub =3D 1,
> +		.has_alpha =3D true,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_Y0L0,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.char_per_block =3D { 8, 0, 0 },
> +		.block_w =3D { 2, 0, 0 },
> +		.block_h =3D { 2, 0, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 2,
> +		.has_alpha =3D true,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_X0L0,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.char_per_block =3D { 8, 0, 0 },
> +		.block_w =3D { 2, 0, 0 },
> +		.block_h =3D { 2, 0, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 2,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_Y0L2,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.char_per_block =3D { 8, 0, 0 },
> +		.block_w =3D { 2, 0, 0 },
> +		.block_h =3D { 2, 0, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 2,
> +		.has_alpha =3D true,
> +		.is_yuv =3D true,
> +	}, {
> +		.drm_fmt =3D DRM_FORMAT_X0L2,
> +		.depth =3D 0,
> +		.num_planes =3D 1,
> +		.char_per_block =3D { 8, 0, 0 },
> +		.block_w =3D { 2, 0, 0 },
> +		.block_h =3D { 2, 0, 0 },
> +		.hsub =3D 2,
> +		.vsub =3D 2,
> +		.is_yuv =3D true,
> +	},
> +};
> +
> +#define __image_format_lookup(_field, _fmt)			\
> +	({							\
> +		const struct image_format_info *format =3D NULL;	\
> +		unsigned i;					\
> +								\
> +		for (i =3D 0; i < ARRAY_SIZE(formats); i++)	\
> +			if (formats[i]._field =3D=3D _fmt)		\
> +				format =3D &formats[i];		\
> +								\
> +		format;						\
> +	})
> +
> +/**
> + * __image_format_drm_lookup - query information for a given format
> + * @drm: DRM fourcc pixel format (DRM_FORMAT_*)
> + *
> + * The caller should only pass a supported pixel format to this functi=
on.
> + *
> + * Returns:
> + * The instance of struct image_format_info that describes the pixel f=
ormat, or
> + * NULL if the format is unsupported.
> + */
> +const struct image_format_info *__image_format_drm_lookup(u32 drm)
> +{
> +	return __image_format_lookup(drm_fmt, drm);
> +}
> +EXPORT_SYMBOL(__image_format_drm_lookup);
> +
> +/**
> + * image_format_drm_lookup - query information for a given format
> + * @drm: DRM fourcc pixel format (DRM_FORMAT_*)
> + *
> + * The caller should only pass a supported pixel format to this functi=
on.
> + * Unsupported pixel formats will generate a warning in the kernel log=
=2E
> + *
> + * Returns:
> + * The instance of struct image_format_info that describes the pixel f=
ormat, or
> + * NULL if the format is unsupported.
> + */
> +const struct image_format_info *image_format_drm_lookup(u32 drm)
> +{
> +	const struct image_format_info *format;
> +
> +	format =3D __image_format_drm_lookup(drm);
> +
> +	WARN_ON(!format);
> +	return format;
> +}
> +EXPORT_SYMBOL(image_format_drm_lookup);
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Linux GmbH, Maxfeldstrasse 5, 90409 Nuernberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)


--fg3gjYeGEpzlDhdchAV2UbYmr50PKY8EI--

--2edTowVqNYYMw19yEZVm8UQFHdkGKgNy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEchf7rIzpz2NEoWjlaA3BHVMLeiMFAly+9V8ACgkQaA3BHVML
eiO3cwf+PVNupFX5H/UB3QhXSz1xO9DcQwFHwUvZ4es7KoNbIDZqksQ8FxuUyyg4
7svYhEfvkYw9Gk6tP7GmSVC+JqxQ7106+8U7CE7umBhG8Oz8JyJD81lqt5ESX0cW
0Xc5zgW6z5L8xGZUgKG+H8zsCdNNzkgx8UARnYHX50l+NEfmxi7Xsc1GqSIw63wO
tE+mD16FfgWSdKssfbm+6Y5JGSBngeg1INfJCObIh8lIloa2IaXCtICEcegK0yhq
avhM5ZvuttnTw0R5i899cFxsU0oXhfmjvz7SCrQQPW6AWxFElven5t0o2cLqqQFn
nN5YAu5qbxvpc6MK3gTAmrTELGx9Vg==
=4HiX
-----END PGP SIGNATURE-----

--2edTowVqNYYMw19yEZVm8UQFHdkGKgNy3--
