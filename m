Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC70C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996AD2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfDKHMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:12:48 -0400
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:41930 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726104AbfDKHMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:12:47 -0400
Received: from [IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc] ([IPv6:2001:983:e9a7:1:4cd3:53c0:7e2b:d8bc])
        by smtp-cloud8.xs4all.net with ESMTPA
        id ETt2hwk1DUjKfETt3hksND; Thu, 11 Apr 2019 09:12:44 +0200
Subject: Re: [RFC PATCH 18/20] lib: image-formats: Add v4l2 formats support
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
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
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <7e905f61-3570-d66b-949b-36cc9ba840a9@xs4all.nl>
Date:   Thu, 11 Apr 2019 09:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <c97024b97d3261dcf41aad3c8bc1c5d9906f33c9.1553032382.git-series.maxime.ripard@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfBvGeAZgJTEYLRFNKcvgIbeLB3QDZkfmhUzUO8M4idvy33oIo1KWgaQRRNTQfN05T7KC4YnizJIsgwLWN8p100UuT0kTLB2zqt7wFBDFvdRqumpUgIfD
 NfGGd8wpgJhJ5wkACQf2jmPXGGsoYzYBjeGmmu8UXfKToNIZaQJkZ7m5ymN99DyR5a6FaT+v/x8KhIwJ6c7rktk8oPPg9b+qOUMpGB+n65DFfAe3TYUSd//y
 RjhGS+I7hRNkAwvbppQDGKUzBSw3O5hSAKaZHuib2wttzbEwyY0Zm6MOMU8+G1fnEwTn1G0JQv9QiMJx7IU//gX6Nm1FZEvMMDS+5HLbbu6kuK/dAy6DOZgE
 gDSD7EawEvk89ne8BuOcT6gVj9rZ3owTdvn+5wUwApFp2osMl3oN4HfqAr9M9TTWc1/DLVOmTxppxMCrKpWbHG1KyakzY/ALs5E2Nm2Iy0GVvABHn9eogsGH
 dlyBc5gFfW7+xr18D1AvgdTTwR4qGTHyl4jTp+bRSLshLuDImG53Dmehv+khmvnb5cF1bO355AhsV1C32hPdwe0rooFQEd0V+tq1s24gkM51OrQoXY35djEu
 yPds6lIth0OV+YXcBBaEvXx7Qj62HA58bqc2a28YwG/6jkj7LCdGyryVEwq3+jSqO1BAMwNWummRcr1O6WEPWNe6bbwiEmJGafBgzD3OjqNwK1lXPGpVbIDs
 jAzfoFolKZRdFC0OJr3vWI/1UTnQv2Cdmbj7Yt9FHSUG+XPUkw2gdqgVJv/4rzHKcs59URJmqW5XG5NlOxGj6ClazaMnSvNC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

Some comments below...

On 3/19/19 10:57 PM, Maxime Ripard wrote:
> V4L2 uses different fourcc's than DRM, and has a different set of formats.
> For now, let's add the v4l2 fourcc's for the already existing formats.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  include/linux/image-formats.h |  9 +++++-
>  lib/image-formats.c           | 67 ++++++++++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+)
> 
> diff --git a/include/linux/image-formats.h b/include/linux/image-formats.h
> index 53fd73a71b3d..fbc3a4501ebd 100644
> --- a/include/linux/image-formats.h
> +++ b/include/linux/image-formats.h
> @@ -26,6 +26,13 @@ struct image_format_info {
>  	};
>  
>  	/**
> +	 * @v4l2_fmt:
> +	 *
> +	 * V4L2 4CC format identifier (V4L2_PIX_FMT_*)
> +	 */
> +	u32 v4l2_fmt;
> +
> +	/**
>  	 * @depth:
>  	 *
>  	 * Color depth (number of bits per pixel excluding padding bits),
> @@ -222,6 +229,8 @@ image_format_info_is_yuv_sampling_444(const struct image_format_info *info)
>  
>  const struct image_format_info *__image_format_drm_lookup(u32 drm);
>  const struct image_format_info *image_format_drm_lookup(u32 drm);
> +const struct image_format_info *__image_format_v4l2_lookup(u32 v4l2);
> +const struct image_format_info *image_format_v4l2_lookup(u32 v4l2);
>  unsigned int image_format_plane_cpp(const struct image_format_info *format,
>  				    int plane);
>  unsigned int image_format_plane_width(int width,
> diff --git a/lib/image-formats.c b/lib/image-formats.c
> index 9b9a73220c5d..39f1d38ae861 100644
> --- a/lib/image-formats.c
> +++ b/lib/image-formats.c
> @@ -8,6 +8,7 @@
>  static const struct image_format_info formats[] = {
>  	{
>  		.drm_fmt = DRM_FORMAT_C8,
> +		.v4l2_fmt = V4L2_PIX_FMT_GREY,
>  		.depth = 8,
>  		.num_planes = 1,
>  		.cpp = { 1, 0, 0 },
> @@ -15,6 +16,7 @@ static const struct image_format_info formats[] = {
>  		.vsub = 1,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_RGB332,
> +		.v4l2_fmt = V4L2_PIX_FMT_RGB332,
>  		.depth = 8,
>  		.num_planes = 1,
>  		.cpp = { 1, 0, 0 },
> @@ -29,6 +31,7 @@ static const struct image_format_info formats[] = {
>  		.vsub = 1,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_XRGB4444,
> +		.v4l2_fmt = V4L2_PIX_FMT_XRGB444,
>  		.depth = 0,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -57,6 +60,7 @@ static const struct image_format_info formats[] = {
>  		.vsub = 1,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_ARGB4444,
> +		.v4l2_fmt = V4L2_PIX_FMT_ARGB444,
>  		.depth = 0,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -89,6 +93,7 @@ static const struct image_format_info formats[] = {
>  		.has_alpha = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_XRGB1555,
> +		.v4l2_fmt = V4L2_PIX_FMT_XRGB555,
>  		.depth = 15,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -117,6 +122,7 @@ static const struct image_format_info formats[] = {
>  		.vsub = 1,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_ARGB1555,
> +		.v4l2_fmt = V4L2_PIX_FMT_ARGB555,
>  		.depth = 15,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -149,6 +155,7 @@ static const struct image_format_info formats[] = {
>  		.has_alpha = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_RGB565,
> +		.v4l2_fmt = V4L2_PIX_FMT_RGB565,
>  		.depth = 16,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -163,6 +170,7 @@ static const struct image_format_info formats[] = {
>  		.vsub = 1,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_RGB888,
> +		.v4l2_fmt = V4L2_PIX_FMT_RGB24,

The V4L2 pixelformats describe the order of the components in memory, and as
such are independent of the CPU endianness. How is that for the DRM formats?

Will the order of DRM_FORMAT_RGB888 in memory differ between little and big
endian systems?

Mind you, V4L2 drivers are frankly never tested on big endian systems and I
suspect many if not all will fail miserably on details like this.

>  		.depth = 24,
>  		.num_planes = 1,
>  		.cpp = { 3, 0, 0 },
> @@ -170,6 +178,7 @@ static const struct image_format_info formats[] = {
>  		.vsub = 1,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_BGR888,
> +		.v4l2_fmt = V4L2_PIX_FMT_BGR24,
>  		.depth = 24,
>  		.num_planes = 1,
>  		.cpp = { 3, 0, 0 },
> @@ -177,6 +186,7 @@ static const struct image_format_info formats[] = {
>  		.vsub = 1,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_XRGB8888,
> +		.v4l2_fmt = V4L2_PIX_FMT_XRGB32,
>  		.depth = 24,
>  		.num_planes = 1,
>  		.cpp = { 4, 0, 0 },
> @@ -281,6 +291,7 @@ static const struct image_format_info formats[] = {
>  		.has_alpha = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_ARGB8888,
> +		.v4l2_fmt = V4L2_PIX_FMT_ARGB32,
>  		.depth = 32,
>  		.num_planes = 1,
>  		.cpp = { 4, 0, 0 },
> @@ -361,6 +372,7 @@ static const struct image_format_info formats[] = {
>  		.has_alpha = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YUV410,
> +		.v4l2_fmt = V4L2_PIX_FMT_YUV410,
>  		.depth = 0,
>  		.num_planes = 3,
>  		.cpp = { 1, 1, 1 },
> @@ -369,6 +381,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YVU410,
> +		.v4l2_fmt = V4L2_PIX_FMT_YVU410,
>  		.depth = 0,
>  		.num_planes = 3,
>  		.cpp = { 1, 1, 1 },
> @@ -393,6 +406,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YUV420,
> +		.v4l2_fmt = V4L2_PIX_FMT_YUV420M,
>  		.depth = 0,
>  		.num_planes = 3,
>  		.cpp = { 1, 1, 1 },
> @@ -401,6 +415,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YVU420,
> +		.v4l2_fmt = V4L2_PIX_FMT_YVU420M,
>  		.depth = 0,
>  		.num_planes = 3,
>  		.cpp = { 1, 1, 1 },
> @@ -409,6 +424,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YUV422,
> +		.v4l2_fmt = V4L2_PIX_FMT_YUV422M,
>  		.depth = 0,
>  		.num_planes = 3,
>  		.cpp = { 1, 1, 1 },
> @@ -417,6 +433,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YVU422,
> +		.v4l2_fmt = V4L2_PIX_FMT_YVU422M,
>  		.depth = 0,
>  		.num_planes = 3,
>  		.cpp = { 1, 1, 1 },
> @@ -425,6 +442,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YUV444,
> +		.v4l2_fmt = V4L2_PIX_FMT_YUV444M,
>  		.depth = 0,
>  		.num_planes = 3,
>  		.cpp = { 1, 1, 1 },
> @@ -433,6 +451,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YVU444,
> +		.v4l2_fmt = V4L2_PIX_FMT_YVU444M,
>  		.depth = 0,
>  		.num_planes = 3,
>  		.cpp = { 1, 1, 1 },
> @@ -441,6 +460,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_NV12,
> +		.v4l2_fmt = V4L2_PIX_FMT_NV12,
>  		.depth = 0,
>  		.num_planes = 2,
>  		.cpp = { 1, 2, 0 },
> @@ -449,6 +469,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_NV21,
> +		.v4l2_fmt = V4L2_PIX_FMT_NV21,
>  		.depth = 0,
>  		.num_planes = 2,
>  		.cpp = { 1, 2, 0 },
> @@ -457,6 +478,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_NV16,
> +		.v4l2_fmt = V4L2_PIX_FMT_NV16,
>  		.depth = 0,
>  		.num_planes = 2,
>  		.cpp = { 1, 2, 0 },
> @@ -465,6 +487,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_NV61,
> +		.v4l2_fmt = V4L2_PIX_FMT_NV61,
>  		.depth = 0,
>  		.num_planes = 2,
>  		.cpp = { 1, 2, 0 },
> @@ -473,6 +496,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_NV24,
> +		.v4l2_fmt = V4L2_PIX_FMT_NV24,
>  		.depth = 0,
>  		.num_planes = 2,
>  		.cpp = { 1, 2, 0 },
> @@ -481,6 +505,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_NV42,
> +		.v4l2_fmt = V4L2_PIX_FMT_NV42,
>  		.depth = 0,
>  		.num_planes = 2,
>  		.cpp = { 1, 2, 0 },
> @@ -489,6 +514,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YUYV,
> +		.v4l2_fmt = V4L2_PIX_FMT_YUYV,
>  		.depth = 0,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -497,6 +523,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_YVYU,
> +		.v4l2_fmt = V4L2_PIX_FMT_YVYU,
>  		.depth = 0,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -505,6 +532,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_UYVY,
> +		.v4l2_fmt = V4L2_PIX_FMT_UYVY,
>  		.depth = 0,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -513,6 +541,7 @@ static const struct image_format_info formats[] = {
>  		.is_yuv = true,
>  	}, {
>  		.drm_fmt = DRM_FORMAT_VYUY,
> +		.v4l2_fmt = V4L2_PIX_FMT_VYUY,
>  		.depth = 0,
>  		.num_planes = 1,
>  		.cpp = { 2, 0, 0 },
> @@ -632,6 +661,44 @@ const struct image_format_info *image_format_drm_lookup(u32 drm)
>  EXPORT_SYMBOL(image_format_drm_lookup);
>  
>  /**
> + * __image_format_v4l2_lookup - query information for a given format
> + * @v4l2: V4L2 fourcc pixel format (V4L2_PIX_FMT_*)
> + *
> + * The caller should only pass a supported pixel format to this function.
> + *
> + * Returns:
> + * The instance of struct image_format_info that describes the pixel format, or
> + * NULL if the format is unsupported.
> + */
> +const struct image_format_info *__image_format_v4l2_lookup(u32 v4l2)
> +{
> +	return __image_format_lookup(v4l2_fmt, v4l2);
> +}
> +EXPORT_SYMBOL(__image_format_v4l2_lookup);
> +
> +/**
> + * image_format_v4l2_lookup - query information for a given format
> + * @v4l2: V4L2 fourcc pixel format (V4L2_PIX_FMT_*)
> + *
> + * The caller should only pass a supported pixel format to this function.
> + * Unsupported pixel formats will generate a warning in the kernel log.
> + *
> + * Returns:
> + * The instance of struct image_format_info that describes the pixel format, or
> + * NULL if the format is unsupported.
> + */
> +const struct image_format_info *image_format_v4l2_lookup(u32 v4l2)
> +{
> +	const struct image_format_info *format;
> +
> +	format = __image_format_v4l2_lookup(v4l2);
> +
> +	WARN_ON(!format);
> +	return format;
> +}
> +EXPORT_SYMBOL(image_format_v4l2_lookup);
> +
> +/**
>   * image_format_plane_cpp - determine the bytes per pixel value
>   * @format: pointer to the image_format
>   * @plane: plane index
> 

Anyway, I think this is a great improvement!

Regards,

	Hans
