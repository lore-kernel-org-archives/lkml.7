Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FD9C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C6821850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfDKHiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:38:11 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:47665 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbfDKHiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:38:11 -0400
Received: from [IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc] ([IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc])
        by smtp-cloud8.xs4all.net with ESMTPA
        id EUHehwvoZUjKfEUHfhl2in; Thu, 11 Apr 2019 09:38:07 +0200
Subject: Re: [RFC PATCH 18/20] lib: image-formats: Add v4l2 formats support
To:     Nicolas Dufresne <nicolas@ndufresne.ca>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
References: <cover.92acdec88ee4c280cb74e08ea22f0075e5fa055c.1553032382.git-series.maxime.ripard@bootlin.com>
 <c97024b97d3261dcf41aad3c8bc1c5d9906f33c9.1553032382.git-series.maxime.ripard@bootlin.com>
 <3f5748a6422d2f7eb11601bad297df870ff5952b.camel@ndufresne.ca>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5385672c-cfee-7bc4-9c2e-e4d8d964b748@xs4all.nl>
Date:   Thu, 11 Apr 2019 09:38:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <3f5748a6422d2f7eb11601bad297df870ff5952b.camel@ndufresne.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJhH7vSblYToem5OelvjVz+/mChL5HpqiSCgyq7Jx6AbMUDMU7EZ2rqVIZwfeE0C3GIUQhD2EVUMXCLZ9N+19nTAxlpNOCCbtT4td2J5XYn/ukVtmDNL
 Q3Z2VVLjGh6A2GjpHv/g4mIWaM3Iq+K9MlZ6KwOVE1FSuWaSUty/pjHPCK1A2V8i1bUYE084oEQ12LtCLgTnMvhdw4V+bNR3HnRAWChW3BHsCvAxLZalo/IH
 +75KSSxQqe1PCewJ9KFCF4WqANMe3emDySVE451uqayqy4PZy5TvOaOeog8l9vZCoUANKwvQK0E/0TW2TVMVfQPbSvM96o3EyQp6UUrmcaYsZY4TsSwRl4oz
 mBCTQkKk5a7FchmsAF0JjYiVejqbgFBZAyMKHOrNNT2rxvhGUC9B67lS+4Qrmu2dNBwuVBakFqtQaVVzmeAyVY450GMQyGCjRd55Hc9yldPBO89frn+D9F73
 JMXz5ngkvS42V8CX3PnN3eQb/iF/TMrgmshsPwjAmrL0RFb6n+h9r+hHSIx+n4nz0Xs9ZiGsC40oWqQIUGqITFEAJTl6iWGUj1zQ2QQnO7fBo4/M33xqojFr
 2ag86YuG3svteU8JbStfmuTbUq0sAhehuZYYfT+KuYFYkSmrKdeI/0rkimofm7JpeNWkBKcjxfdFm1fGiHB23CggsLMXvyletaTz7kgPepx+/o2NSuCavHqF
 cuwH+6wE5QHRuFjLbcin4SfAMWbhnXj29qGRrdXKoM/buEWKyCHVlOB4i6kqxVDh/+bxt5c+WiwdFF5DC701afTUiZ6JdKiBm3va05Fa0HrytR7LO0L8jQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/19 8:55 PM, Nicolas Dufresne wrote:
> Le mardi 19 mars 2019 à 22:57 +0100, Maxime Ripard a écrit :
>> V4L2 uses different fourcc's than DRM, and has a different set of formats.
>> For now, let's add the v4l2 fourcc's for the already existing formats.
> 
> Hopefully I get the fixup right this time, see inline.
> 
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
>> ---
>>  include/linux/image-formats.h |  9 +++++-
>>  lib/image-formats.c           | 67 ++++++++++++++++++++++++++++++++++++-
>>  2 files changed, 76 insertions(+)
>>
>> diff --git a/include/linux/image-formats.h b/include/linux/image-formats.h
>> index 53fd73a71b3d..fbc3a4501ebd 100644
>> --- a/include/linux/image-formats.h
>> +++ b/include/linux/image-formats.h
>> @@ -26,6 +26,13 @@ struct image_format_info {
>>  	};
>>  
>>  	/**
>> +	 * @v4l2_fmt:
>> +	 *
>> +	 * V4L2 4CC format identifier (V4L2_PIX_FMT_*)
>> +	 */
>> +	u32 v4l2_fmt;
>> +
>> +	/**
>>  	 * @depth:
>>  	 *
>>  	 * Color depth (number of bits per pixel excluding padding bits),
>> @@ -222,6 +229,8 @@ image_format_info_is_yuv_sampling_444(const struct image_format_info *info)
>>  
>>  const struct image_format_info *__image_format_drm_lookup(u32 drm);
>>  const struct image_format_info *image_format_drm_lookup(u32 drm);
>> +const struct image_format_info *__image_format_v4l2_lookup(u32 v4l2);
>> +const struct image_format_info *image_format_v4l2_lookup(u32 v4l2);
>>  unsigned int image_format_plane_cpp(const struct image_format_info *format,
>>  				    int plane);
>>  unsigned int image_format_plane_width(int width,
>> diff --git a/lib/image-formats.c b/lib/image-formats.c
>> index 9b9a73220c5d..39f1d38ae861 100644
>> --- a/lib/image-formats.c
>> +++ b/lib/image-formats.c
>> @@ -8,6 +8,7 @@
>>  static const struct image_format_info formats[] = {
>>  	{
>>  		.drm_fmt = DRM_FORMAT_C8,
>> +		.v4l2_fmt = V4L2_PIX_FMT_GREY,
>>  		.depth = 8,
>>  		.num_planes = 1,
>>  		.cpp = { 1, 0, 0 },
>> @@ -15,6 +16,7 @@ static const struct image_format_info formats[] = {
>>  		.vsub = 1,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_RGB332,
>> +		.v4l2_fmt = V4L2_PIX_FMT_RGB332,
>>  		.depth = 8,
>>  		.num_planes = 1,
>>  		.cpp = { 1, 0, 0 },
>> @@ -29,6 +31,7 @@ static const struct image_format_info formats[] = {
>>  		.vsub = 1,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_XRGB4444,
>> +		.v4l2_fmt = V4L2_PIX_FMT_XRGB444,
> 
> Not completely sure, looks like in the V4L2 variant, the padding is on
> the 4 MSB of the second byte, which makes it incompatible. There is no
> other equivalent.
> 
>>  		.depth = 0,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -57,6 +60,7 @@ static const struct image_format_info formats[] = {
>>  		.vsub = 1,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_ARGB4444,
>> +		.v4l2_fmt = V4L2_PIX_FMT_ARGB444,
> 
> Similarly.
> 
>>  		.depth = 0,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -89,6 +93,7 @@ static const struct image_format_info formats[] = {
>>  		.has_alpha = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_XRGB1555,
>> +		.v4l2_fmt = V4L2_PIX_FMT_XRGB555,
> 
> Same swapping, can't find a match.
> 
>>  		.depth = 15,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -117,6 +122,7 @@ static const struct image_format_info formats[] = {
>>  		.vsub = 1,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_ARGB1555,
>> +		.v4l2_fmt = V4L2_PIX_FMT_ARGB555,
> 
> Same.
> 
>>  		.depth = 15,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -149,6 +155,7 @@ static const struct image_format_info formats[] = {
>>  		.has_alpha = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_RGB565,
>> +		.v4l2_fmt = V4L2_PIX_FMT_RGB565,
> 
> -> V4L2_PIX_FMT_RGB565X
> 
> Was added later, as what you expect is not compatible.

All these 16-bit V4L2 pixelformats are ancient, but they are (to my knowledge)
correct w.r.t. the documented layout of the bits in memory. I.e., that's what
the hardware will give you.

I think if there is no equivalence between the drm and v4l2 fourcc's, then
you need two entries in this table, one for drm (v4l2_fmt == 0), one for v4l2
(drm_fmt == 0).

> 
>>  		.depth = 16,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -163,6 +170,7 @@ static const struct image_format_info formats[] = {
>>  		.vsub = 1,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_RGB888,
>> +		.v4l2_fmt = V4L2_PIX_FMT_RGB24,
> 
> -> V4L2_PIX_FMT_BGR24
> 
>>  		.depth = 24,
>>  		.num_planes = 1,
>>  		.cpp = { 3, 0, 0 },
>> @@ -170,6 +178,7 @@ static const struct image_format_info formats[] = {
>>  		.vsub = 1,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_BGR888,
>> +		.v4l2_fmt = V4L2_PIX_FMT_BGR24,
> 
> -> V4L2_PIX_FMT_RGB24
> 
>>  		.depth = 24,
>>  		.num_planes = 1,
>>  		.cpp = { 3, 0, 0 },
>> @@ -177,6 +186,7 @@ static const struct image_format_info formats[] = {
>>  		.vsub = 1,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_XRGB8888,
>> +		.v4l2_fmt = V4L2_PIX_FMT_XRGB32,
> 
> -> V4L2_PIX_FMT_XBGR32
> 
>>  		.depth = 24,
>>  		.num_planes = 1,
>>  		.cpp = { 4, 0, 0 },
>> @@ -281,6 +291,7 @@ static const struct image_format_info formats[] = {
>>  		.has_alpha = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_ARGB8888,
>> +		.v4l2_fmt = V4L2_PIX_FMT_ARGB32,
> 
> -> V4L2_PIX_FMT_ABGR32
> 
>>  		.depth = 32,
>>  		.num_planes = 1,
>>  		.cpp = { 4, 0, 0 },
>> @@ -361,6 +372,7 @@ static const struct image_format_info formats[] = {
>>  		.has_alpha = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YUV410,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YUV410,
>>  		.depth = 0,
>>  		.num_planes = 3,
>>  		.cpp = { 1, 1, 1 },
>> @@ -369,6 +381,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YVU410,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YVU410,
>>  		.depth = 0,
>>  		.num_planes = 3,
>>  		.cpp = { 1, 1, 1 },
>> @@ -393,6 +406,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YUV420,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YUV420M,
> 
> There is two valid matches in V4L2 for this format, not sure how this
> will be handled. The M variant is to be used with MPLANE v4l2_buffer
> when num_planes is bigger then 1.

We should use the non-multiplanar variant (without the M). At least for now.

> 
>>  		.depth = 0,
>>  		.num_planes = 3,
>>  		.cpp = { 1, 1, 1 },
>> @@ -401,6 +415,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YVU420,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YVU420M,
> 
> Same.
> 
>>  		.depth = 0,
>>  		.num_planes = 3,
>>  		.cpp = { 1, 1, 1 },
>> @@ -409,6 +424,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YUV422,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YUV422M,
> 
> Same.
> 
>>  		.depth = 0,
>>  		.num_planes = 3,
>>  		.cpp = { 1, 1, 1 },
>> @@ -417,6 +433,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YVU422,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YVU422M,
> 
> Same. 
> 
>>  		.depth = 0,
>>  		.num_planes = 3,
>>  		.cpp = { 1, 1, 1 },
>> @@ -425,6 +442,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YUV444,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YUV444M,
> 
> Same.
> 
>>  		.depth = 0,
>>  		.num_planes = 3,
>>  		.cpp = { 1, 1, 1 },
>> @@ -433,6 +451,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YVU444,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YVU444M,
> 
> Same.
> 
>>  		.depth = 0,
>>  		.num_planes = 3,
>>  		.cpp = { 1, 1, 1 },
>> @@ -441,6 +460,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_NV12,
>> +		.v4l2_fmt = V4L2_PIX_FMT_NV12,
> 
> V4L2_PIX_FMT_NV12M is the mplane variant. Depending on how you handle,
> which should be concistant picking one up.
> 
>>  		.depth = 0,
>>  		.num_planes = 2,
>>  		.cpp = { 1, 2, 0 },
>> @@ -449,6 +469,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_NV21,
>> +		.v4l2_fmt = V4L2_PIX_FMT_NV21,
> 
> Same, NV12M for mplane.
> 
>>  		.depth = 0,
>>  		.num_planes = 2,
>>  		.cpp = { 1, 2, 0 },
>> @@ -457,6 +478,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_NV16,
>> +		.v4l2_fmt = V4L2_PIX_FMT_NV16,
> 
> Same, NV16M.
> 
>>  		.depth = 0,
>>  		.num_planes = 2,
>>  		.cpp = { 1, 2, 0 },
>> @@ -465,6 +487,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_NV61,
>> +		.v4l2_fmt = V4L2_PIX_FMT_NV61,
> 
> Same, NV61M.
> 
>>  		.depth = 0,
>>  		.num_planes = 2,
>>  		.cpp = { 1, 2, 0 },
>> @@ -473,6 +496,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_NV24,
>> +		.v4l2_fmt = V4L2_PIX_FMT_NV24,
> 
> For extra fun, the M variant has not been added yet.

Note that it has been the practice in V4L2 to avoid adding pixelformats unless
they are in use by a V4L2 driver. So that's why some combinations do not exist.

If we are creating a common library then I think we should change that rule
to: "unless they are in use by a DRM or V4L2 driver". And when new formats are
added, and they exists already for DRM or V4L2, then we should use the same
fourcc for the other subsystem.

I.e. if pixelformat V4L2_PIX_FMT_FOO was already defined, then add a:

#define DRM_FORMAT_FOO V4L2_PIX_FMT_FOO

rather than creating a new fourcc.

We could even start looking at redoing the whole scheme in a unified way, but
that's something for the (far) future.

This is already a big step forward.

Regards,

	Hans

> 
>>  		.depth = 0,
>>  		.num_planes = 2,
>>  		.cpp = { 1, 2, 0 },
>> @@ -481,6 +505,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_NV42,
>> +		.v4l2_fmt = V4L2_PIX_FMT_NV42,
>>  		.depth = 0,
>>  		.num_planes = 2,
>>  		.cpp = { 1, 2, 0 },
>> @@ -489,6 +514,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YUYV,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YUYV,
>>  		.depth = 0,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -497,6 +523,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_YVYU,
>> +		.v4l2_fmt = V4L2_PIX_FMT_YVYU,
>>  		.depth = 0,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -505,6 +532,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_UYVY,
>> +		.v4l2_fmt = V4L2_PIX_FMT_UYVY,
>>  		.depth = 0,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -513,6 +541,7 @@ static const struct image_format_info formats[] = {
>>  		.is_yuv = true,
>>  	}, {
>>  		.drm_fmt = DRM_FORMAT_VYUY,
>> +		.v4l2_fmt = V4L2_PIX_FMT_VYUY,
>>  		.depth = 0,
>>  		.num_planes = 1,
>>  		.cpp = { 2, 0, 0 },
>> @@ -632,6 +661,44 @@ const struct image_format_info *image_format_drm_lookup(u32 drm)
>>  EXPORT_SYMBOL(image_format_drm_lookup);
>>  
>>  /**
>> + * __image_format_v4l2_lookup - query information for a given format
>> + * @v4l2: V4L2 fourcc pixel format (V4L2_PIX_FMT_*)
>> + *
>> + * The caller should only pass a supported pixel format to this function.
>> + *
>> + * Returns:
>> + * The instance of struct image_format_info that describes the pixel format, or
>> + * NULL if the format is unsupported.
>> + */
>> +const struct image_format_info *__image_format_v4l2_lookup(u32 v4l2)
>> +{
>> +	return __image_format_lookup(v4l2_fmt, v4l2);
>> +}
>> +EXPORT_SYMBOL(__image_format_v4l2_lookup);
>> +
>> +/**
>> + * image_format_v4l2_lookup - query information for a given format
>> + * @v4l2: V4L2 fourcc pixel format (V4L2_PIX_FMT_*)
>> + *
>> + * The caller should only pass a supported pixel format to this function.
>> + * Unsupported pixel formats will generate a warning in the kernel log.
>> + *
>> + * Returns:
>> + * The instance of struct image_format_info that describes the pixel format, or
>> + * NULL if the format is unsupported.
>> + */
>> +const struct image_format_info *image_format_v4l2_lookup(u32 v4l2)
>> +{
>> +	const struct image_format_info *format;
>> +
>> +	format = __image_format_v4l2_lookup(v4l2);
>> +
>> +	WARN_ON(!format);
>> +	return format;
>> +}
>> +EXPORT_SYMBOL(image_format_v4l2_lookup);
>> +
>> +/**
>>   * image_format_plane_cpp - determine the bytes per pixel value
>>   * @format: pointer to the image_format
>>   * @plane: plane index

