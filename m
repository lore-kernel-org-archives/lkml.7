Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D47CC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C5120833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 11:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfDIL7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 07:59:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:7770 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbfDIL7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 07:59:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 04:59:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="314377018"
Received: from dcondura-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.20.22])
  by orsmga005.jf.intel.com with ESMTP; 09 Apr 2019 04:59:14 -0700
Date:   Tue, 9 Apr 2019 12:59:13 +0100
From:   Eric Engestrom <eric.engestrom@intel.com>
To:     Ayan Halder <Ayan.Halder@arm.com>
Cc:     Liviu Dudau <Liviu.Dudau@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "robdclark@gmail.com" <robdclark@gmail.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>
Subject: Re: [PATCH libdrm] headers: Sync with drm-next
Message-ID: <20190409115913.hvyjxlda4wtzm75t@intel.com>
References: <20190408205422.dj7z4dl36nauwlk7@intel.com>
 <1554809706-15389-1-git-send-email-ayan.halder@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1554809706-15389-1-git-send-email-ayan.halder@arm.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. 1134945 - Pipers Way,
 Swindon SN3 1RJ
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2019-04-09 11:35:14 +0000, Ayan Halder wrote:
> Generated using make headers_install from the drm-next
> tree - git://anongit.freedesktop.org/drm/drm
> branch - drm-next
> commit - 14d2bd53a47a7e1cb3e03d00a6b952734cf90f3f
> 
> The changes were as follows :-
> 
> core: (drm.h, drm_fourcc.h, drm_mode.h)
> - Added 'struct drm_syncobj_transfer', 'struct drm_syncobj_timeline_wait' and 'struct drm_syncobj_timeline_array'
> - Added various DRM_IOCTL_SYNCOBJ_ ioctls
> - Added some new RGB and YUV formats
> - Added 'DRM_FORMAT_MOD_VENDOR_ALLWINNER'
> - Added 'SAMSUNG' and Arm's 'AFBC' and 'ALLWINNER' format modifiers
> - Added 'struct drm_mode_rect'
> 
> i915:
> - Added struct 'struct i915_user_extension' and various 'struct drm_i915_gem_context_'
> - Added different modes of per-process Graphics Translation Table
> 
> msm:
> - Added various get or set GEM buffer info flags
> - Added some MSM_SUBMIT_BO_ macros
> - Modified 'struct drm_msm_gem_info'
> 
> Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>

This looks sane, and applies cleanly :)
Acked-by: Eric Engestrom <eric.engestrom@intel.com>

> ---
>  include/drm/drm.h        |  36 +++++++
>  include/drm/drm_fourcc.h | 136 +++++++++++++++++++++++++++
>  include/drm/drm_mode.h   |  23 ++++-
>  include/drm/i915_drm.h   | 237 ++++++++++++++++++++++++++++++++++++++++-------
>  include/drm/msm_drm.h    |  25 +++--
>  5 files changed, 415 insertions(+), 42 deletions(-)
> 
> diff --git a/include/drm/drm.h b/include/drm/drm.h
> index 85c685a..c893f3b 100644
> --- a/include/drm/drm.h
> +++ b/include/drm/drm.h
> @@ -729,8 +729,18 @@ struct drm_syncobj_handle {
>  	__u32 pad;
>  };
>  
> +struct drm_syncobj_transfer {
> +	__u32 src_handle;
> +	__u32 dst_handle;
> +	__u64 src_point;
> +	__u64 dst_point;
> +	__u32 flags;
> +	__u32 pad;
> +};
> +
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_ALL (1 << 0)
>  #define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT (1 << 1)
> +#define DRM_SYNCOBJ_WAIT_FLAGS_WAIT_AVAILABLE (1 << 2) /* wait for time point to become available */
>  struct drm_syncobj_wait {
>  	__u64 handles;
>  	/* absolute timeout */
> @@ -741,12 +751,33 @@ struct drm_syncobj_wait {
>  	__u32 pad;
>  };
>  
> +struct drm_syncobj_timeline_wait {
> +	__u64 handles;
> +	/* wait on specific timeline point for every handles*/
> +	__u64 points;
> +	/* absolute timeout */
> +	__s64 timeout_nsec;
> +	__u32 count_handles;
> +	__u32 flags;
> +	__u32 first_signaled; /* only valid when not waiting all */
> +	__u32 pad;
> +};
> +
> +
>  struct drm_syncobj_array {
>  	__u64 handles;
>  	__u32 count_handles;
>  	__u32 pad;
>  };
>  
> +struct drm_syncobj_timeline_array {
> +	__u64 handles;
> +	__u64 points;
> +	__u32 count_handles;
> +	__u32 pad;
> +};
> +
> +
>  /* Query current scanout sequence number */
>  struct drm_crtc_get_sequence {
>  	__u32 crtc_id;		/* requested crtc_id */
> @@ -903,6 +934,11 @@ extern "C" {
>  #define DRM_IOCTL_MODE_GET_LEASE	DRM_IOWR(0xC8, struct drm_mode_get_lease)
>  #define DRM_IOCTL_MODE_REVOKE_LEASE	DRM_IOWR(0xC9, struct drm_mode_revoke_lease)
>  
> +#define DRM_IOCTL_SYNCOBJ_TIMELINE_WAIT	DRM_IOWR(0xCA, struct drm_syncobj_timeline_wait)
> +#define DRM_IOCTL_SYNCOBJ_QUERY		DRM_IOWR(0xCB, struct drm_syncobj_timeline_array)
> +#define DRM_IOCTL_SYNCOBJ_TRANSFER	DRM_IOWR(0xCC, struct drm_syncobj_transfer)
> +#define DRM_IOCTL_SYNCOBJ_TIMELINE_SIGNAL	DRM_IOWR(0xCD, struct drm_syncobj_timeline_array)
> +
>  /**
>   * Device specific ioctls should only be in their respective headers
>   * The device specific ioctl range is from 0x40 to 0x9f.
> diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> index 139632b..3feeaa3 100644
> --- a/include/drm/drm_fourcc.h
> +++ b/include/drm/drm_fourcc.h
> @@ -144,6 +144,17 @@ extern "C" {
>  #define DRM_FORMAT_RGBA1010102	fourcc_code('R', 'A', '3', '0') /* [31:0] R:G:B:A 10:10:10:2 little endian */
>  #define DRM_FORMAT_BGRA1010102	fourcc_code('B', 'A', '3', '0') /* [31:0] B:G:R:A 10:10:10:2 little endian */
>  
> +/*
> + * Floating point 64bpp RGB
> + * IEEE 754-2008 binary16 half-precision float
> + * [15:0] sign:exponent:mantissa 1:5:10
> + */
> +#define DRM_FORMAT_XRGB16161616F fourcc_code('X', 'R', '4', 'H') /* [63:0] x:R:G:B 16:16:16:16 little endian */
> +#define DRM_FORMAT_XBGR16161616F fourcc_code('X', 'B', '4', 'H') /* [63:0] x:B:G:R 16:16:16:16 little endian */
> +
> +#define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
> +#define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
> +
>  /* packed YCbCr */
>  #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
>  #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
> @@ -151,6 +162,52 @@ extern "C" {
>  #define DRM_FORMAT_VYUY		fourcc_code('V', 'Y', 'U', 'Y') /* [31:0] Y1:Cb0:Y0:Cr0 8:8:8:8 little endian */
>  
>  #define DRM_FORMAT_AYUV		fourcc_code('A', 'Y', 'U', 'V') /* [31:0] A:Y:Cb:Cr 8:8:8:8 little endian */
> +#define DRM_FORMAT_XYUV8888	fourcc_code('X', 'Y', 'U', 'V') /* [31:0] X:Y:Cb:Cr 8:8:8:8 little endian */
> +#define DRM_FORMAT_VUY888	fourcc_code('V', 'U', '2', '4') /* [23:0] Cr:Cb:Y 8:8:8 little endian */
> +#define DRM_FORMAT_VUY101010	fourcc_code('V', 'U', '3', '0') /* Y followed by U then V, 10:10:10. Non-linear modifier only */
> +
> +/*
> + * packed Y2xx indicate for each component, xx valid data occupy msb
> + * 16-xx padding occupy lsb
> + */
> +#define DRM_FORMAT_Y210         fourcc_code('Y', '2', '1', '0') /* [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 10:6:10:6:10:6:10:6 little endian per 2 Y pixels */
> +#define DRM_FORMAT_Y212         fourcc_code('Y', '2', '1', '2') /* [63:0] Cr0:0:Y1:0:Cb0:0:Y0:0 12:4:12:4:12:4:12:4 little endian per 2 Y pixels */
> +#define DRM_FORMAT_Y216         fourcc_code('Y', '2', '1', '6') /* [63:0] Cr0:Y1:Cb0:Y0 16:16:16:16 little endian per 2 Y pixels */
> +
> +/*
> + * packed Y4xx indicate for each component, xx valid data occupy msb
> + * 16-xx padding occupy lsb except Y410
> + */
> +#define DRM_FORMAT_Y410         fourcc_code('Y', '4', '1', '0') /* [31:0] A:Cr:Y:Cb 2:10:10:10 little endian */
> +#define DRM_FORMAT_Y412         fourcc_code('Y', '4', '1', '2') /* [63:0] A:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian */
> +#define DRM_FORMAT_Y416         fourcc_code('Y', '4', '1', '6') /* [63:0] A:Cr:Y:Cb 16:16:16:16 little endian */
> +
> +#define DRM_FORMAT_XVYU2101010	fourcc_code('X', 'V', '3', '0') /* [31:0] X:Cr:Y:Cb 2:10:10:10 little endian */
> +#define DRM_FORMAT_XVYU12_16161616	fourcc_code('X', 'V', '3', '6') /* [63:0] X:0:Cr:0:Y:0:Cb:0 12:4:12:4:12:4:12:4 little endian */
> +#define DRM_FORMAT_XVYU16161616	fourcc_code('X', 'V', '4', '8') /* [63:0] X:Cr:Y:Cb 16:16:16:16 little endian */
> +
> +/*
> + * packed YCbCr420 2x2 tiled formats
> + * first 64 bits will contain Y,Cb,Cr components for a 2x2 tile
> + */
> +/* [63:0]   A3:A2:Y3:0:Cr0:0:Y2:0:A1:A0:Y1:0:Cb0:0:Y0:0  1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian */
> +#define DRM_FORMAT_Y0L0		fourcc_code('Y', '0', 'L', '0')
> +/* [63:0]   X3:X2:Y3:0:Cr0:0:Y2:0:X1:X0:Y1:0:Cb0:0:Y0:0  1:1:8:2:8:2:8:2:1:1:8:2:8:2:8:2 little endian */
> +#define DRM_FORMAT_X0L0		fourcc_code('X', '0', 'L', '0')
> +
> +/* [63:0]   A3:A2:Y3:Cr0:Y2:A1:A0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 little endian */
> +#define DRM_FORMAT_Y0L2		fourcc_code('Y', '0', 'L', '2')
> +/* [63:0]   X3:X2:Y3:Cr0:Y2:X1:X0:Y1:Cb0:Y0  1:1:10:10:10:1:1:10:10:10 little endian */
> +#define DRM_FORMAT_X0L2		fourcc_code('X', '0', 'L', '2')
> +
> +/*
> + * 1-plane YUV 4:2:0
> + * In these formats, the component ordering is specified (Y, followed by U
> + * then V), but the exact Linear layout is undefined.
> + * These formats can only be used with a non-Linear modifier.
> + */
> +#define DRM_FORMAT_YUV420_8BIT	fourcc_code('Y', 'U', '0', '8')
> +#define DRM_FORMAT_YUV420_10BIT	fourcc_code('Y', 'U', '1', '0')
>  
>  /*
>   * 2 plane RGB + A
> @@ -181,6 +238,34 @@ extern "C" {
>  #define DRM_FORMAT_NV42		fourcc_code('N', 'V', '4', '2') /* non-subsampled Cb:Cr plane */
>  
>  /*
> + * 2 plane YCbCr MSB aligned
> + * index 0 = Y plane, [15:0] Y:x [10:6] little endian
> + * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
> + */
> +#define DRM_FORMAT_P210		fourcc_code('P', '2', '1', '0') /* 2x1 subsampled Cr:Cb plane, 10 bit per channel */
> +
> +/*
> + * 2 plane YCbCr MSB aligned
> + * index 0 = Y plane, [15:0] Y:x [10:6] little endian
> + * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [10:6:10:6] little endian
> + */
> +#define DRM_FORMAT_P010		fourcc_code('P', '0', '1', '0') /* 2x2 subsampled Cr:Cb plane 10 bits per channel */
> +
> +/*
> + * 2 plane YCbCr MSB aligned
> + * index 0 = Y plane, [15:0] Y:x [12:4] little endian
> + * index 1 = Cr:Cb plane, [31:0] Cr:x:Cb:x [12:4:12:4] little endian
> + */
> +#define DRM_FORMAT_P012		fourcc_code('P', '0', '1', '2') /* 2x2 subsampled Cr:Cb plane 12 bits per channel */
> +
> +/*
> + * 2 plane YCbCr MSB aligned
> + * index 0 = Y plane, [15:0] Y little endian
> + * index 1 = Cr:Cb plane, [31:0] Cr:Cb [16:16] little endian
> + */
> +#define DRM_FORMAT_P016		fourcc_code('P', '0', '1', '6') /* 2x2 subsampled Cr:Cb plane 16 bits per channel */
> +
> +/*
>   * 3 plane YCbCr
>   * index 0: Y plane, [7:0] Y
>   * index 1: Cb plane, [7:0] Cb
> @@ -223,6 +308,8 @@ extern "C" {
>  #define DRM_FORMAT_MOD_VENDOR_VIVANTE 0x06
>  #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
>  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
> +#define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
> +
>  /* add more to the end as needed */
>  
>  #define DRM_FORMAT_RESERVED	      ((1ULL << 56) - 1)
> @@ -339,6 +426,15 @@ extern "C" {
>  #define DRM_FORMAT_MOD_SAMSUNG_64_32_TILE	fourcc_mod_code(SAMSUNG, 1)
>  
>  /*
> + * Tiled, 16 (pixels) x 16 (lines) - sized macroblocks
> + *
> + * This is a simple tiled layout using tiles of 16x16 pixels in a row-major
> + * layout. For YCbCr formats Cb/Cr components are taken in such a way that
> + * they correspond to their 16x16 luma block.
> + */
> +#define DRM_FORMAT_MOD_SAMSUNG_16_16_TILE	fourcc_mod_code(SAMSUNG, 2)
> +
> +/*
>   * Qualcomm Compressed Format
>   *
>   * Refers to a compressed variant of the base format that is compressed.
> @@ -548,6 +644,9 @@ extern "C" {
>   * AFBC has several features which may be supported and/or used, which are
>   * represented using bits in the modifier. Not all combinations are valid,
>   * and different devices or use-cases may support different combinations.
> + *
> + * Further information on the use of AFBC modifiers can be found in
> + * Documentation/gpu/afbc.rst
>   */
>  #define DRM_FORMAT_MOD_ARM_AFBC(__afbc_mode)	fourcc_mod_code(ARM, __afbc_mode)
>  
> @@ -557,10 +656,18 @@ extern "C" {
>   * Indicates the superblock size(s) used for the AFBC buffer. The buffer
>   * size (in pixels) must be aligned to a multiple of the superblock size.
>   * Four lowest significant bits(LSBs) are reserved for block size.
> + *
> + * Where one superblock size is specified, it applies to all planes of the
> + * buffer (e.g. 16x16, 32x8). When multiple superblock sizes are specified,
> + * the first applies to the Luma plane and the second applies to the Chroma
> + * plane(s). e.g. (32x8_64x4 means 32x8 Luma, with 64x4 Chroma).
> + * Multiple superblock sizes are only valid for multi-plane YCbCr formats.
>   */
>  #define AFBC_FORMAT_MOD_BLOCK_SIZE_MASK      0xf
>  #define AFBC_FORMAT_MOD_BLOCK_SIZE_16x16     (1ULL)
>  #define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8      (2ULL)
> +#define AFBC_FORMAT_MOD_BLOCK_SIZE_64x4      (3ULL)
> +#define AFBC_FORMAT_MOD_BLOCK_SIZE_32x8_64x4 (4ULL)
>  
>  /*
>   * AFBC lossless colorspace transform
> @@ -620,6 +727,35 @@ extern "C" {
>   */
>  #define AFBC_FORMAT_MOD_SC      (1ULL <<  9)
>  
> +/*
> + * AFBC double-buffer
> + *
> + * Indicates that the buffer is allocated in a layout safe for front-buffer
> + * rendering.
> + */
> +#define AFBC_FORMAT_MOD_DB      (1ULL << 10)
> +
> +/*
> + * AFBC buffer content hints
> + *
> + * Indicates that the buffer includes per-superblock content hints.
> + */
> +#define AFBC_FORMAT_MOD_BCH     (1ULL << 11)
> +
> +/*
> + * Allwinner tiled modifier
> + *
> + * This tiling mode is implemented by the VPU found on all Allwinner platforms,
> + * codenamed sunxi. It is associated with a YUV format that uses either 2 or 3
> + * planes.
> + *
> + * With this tiling, the luminance samples are disposed in tiles representing
> + * 32x32 pixels and the chrominance samples in tiles representing 32x64 pixels.
> + * The pixel order in each tile is linear and the tiles are disposed linearly,
> + * both in row-major order.
> + */
> +#define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> diff --git a/include/drm/drm_mode.h b/include/drm/drm_mode.h
> index d3e0fe3..83cd163 100644
> --- a/include/drm/drm_mode.h
> +++ b/include/drm/drm_mode.h
> @@ -33,7 +33,6 @@
>  extern "C" {
>  #endif
>  
> -#define DRM_DISPLAY_INFO_LEN	32
>  #define DRM_CONNECTOR_NAME_LEN	32
>  #define DRM_DISPLAY_MODE_LEN	32
>  #define DRM_PROP_NAME_LEN	32
> @@ -622,7 +621,8 @@ struct drm_color_ctm {
>  
>  struct drm_color_lut {
>  	/*
> -	 * Data is U0.16 fixed point format.
> +	 * Values are mapped linearly to 0.0 - 1.0 range, with 0x0 == 0.0 and
> +	 * 0xffff == 1.0.
>  	 */
>  	__u16 red;
>  	__u16 green;
> @@ -888,6 +888,25 @@ struct drm_mode_revoke_lease {
>  	__u32 lessee_id;
>  };
>  
> +/**
> + * struct drm_mode_rect - Two dimensional rectangle.
> + * @x1: Horizontal starting coordinate (inclusive).
> + * @y1: Vertical starting coordinate (inclusive).
> + * @x2: Horizontal ending coordinate (exclusive).
> + * @y2: Vertical ending coordinate (exclusive).
> + *
> + * With drm subsystem using struct drm_rect to manage rectangular area this
> + * export it to user-space.
> + *
> + * Currently used by drm_mode_atomic blob property FB_DAMAGE_CLIPS.
> + */
> +struct drm_mode_rect {
> +	__s32 x1;
> +	__s32 y1;
> +	__s32 x2;
> +	__s32 y2;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
> index 268b585..2ab257c 100644
> --- a/include/drm/i915_drm.h
> +++ b/include/drm/i915_drm.h
> @@ -63,6 +63,28 @@ extern "C" {
>  #define I915_RESET_UEVENT		"RESET"
>  
>  /*
> + * i915_user_extension: Base class for defining a chain of extensions
> + *
> + * Many interfaces need to grow over time. In most cases we can simply
> + * extend the struct and have userspace pass in more data. Another option,
> + * as demonstrated by Vulkan's approach to providing extensions for forward
> + * and backward compatibility, is to use a list of optional structs to
> + * provide those extra details.
> + *
> + * The key advantage to using an extension chain is that it allows us to
> + * redefine the interface more easily than an ever growing struct of
> + * increasing complexity, and for large parts of that interface to be
> + * entirely optional. The downside is more pointer chasing; chasing across
> + * the boundary with pointers encapsulated inside u64.
> + */
> +struct i915_user_extension {
> +	__u64 next_extension;
> +	__u32 name;
> +	__u32 flags; /* All undefined bits must be zero. */
> +	__u32 rsvd[4]; /* Reserved for future use; must be zero. */
> +};
> +
> +/*
>   * MOCS indexes used for GPU surfaces, defining the cacheability of the
>   * surface data and the coherency for this data wrt. CPU vs. GPU accesses.
>   */
> @@ -99,6 +121,8 @@ enum drm_i915_gem_engine_class {
>  	I915_ENGINE_CLASS_VIDEO		= 2,
>  	I915_ENGINE_CLASS_VIDEO_ENHANCE	= 3,
>  
> +	/* should be kept compact */
> +
>  	I915_ENGINE_CLASS_INVALID	= -1
>  };
>  
> @@ -319,6 +343,7 @@ typedef struct _drm_i915_sarea {
>  #define DRM_I915_PERF_ADD_CONFIG	0x37
>  #define DRM_I915_PERF_REMOVE_CONFIG	0x38
>  #define DRM_I915_QUERY			0x39
> +/* Must be kept compact -- no holes */
>  
>  #define DRM_IOCTL_I915_INIT		DRM_IOW( DRM_COMMAND_BASE + DRM_I915_INIT, drm_i915_init_t)
>  #define DRM_IOCTL_I915_FLUSH		DRM_IO ( DRM_COMMAND_BASE + DRM_I915_FLUSH)
> @@ -367,6 +392,7 @@ typedef struct _drm_i915_sarea {
>  #define DRM_IOCTL_I915_GET_SPRITE_COLORKEY DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GET_SPRITE_COLORKEY, struct drm_intel_sprite_colorkey)
>  #define DRM_IOCTL_I915_GEM_WAIT		DRM_IOWR(DRM_COMMAND_BASE + DRM_I915_GEM_WAIT, struct drm_i915_gem_wait)
>  #define DRM_IOCTL_I915_GEM_CONTEXT_CREATE	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_CREATE, struct drm_i915_gem_context_create)
> +#define DRM_IOCTL_I915_GEM_CONTEXT_CREATE_EXT	DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_CREATE, struct drm_i915_gem_context_create_ext)
>  #define DRM_IOCTL_I915_GEM_CONTEXT_DESTROY	DRM_IOW (DRM_COMMAND_BASE + DRM_I915_GEM_CONTEXT_DESTROY, struct drm_i915_gem_context_destroy)
>  #define DRM_IOCTL_I915_REG_READ			DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_REG_READ, struct drm_i915_reg_read)
>  #define DRM_IOCTL_I915_GET_RESET_STATS		DRM_IOWR (DRM_COMMAND_BASE + DRM_I915_GET_RESET_STATS, struct drm_i915_reset_stats)
> @@ -412,6 +438,14 @@ typedef struct drm_i915_irq_wait {
>  	int irq_seq;
>  } drm_i915_irq_wait_t;
>  
> +/*
> + * Different modes of per-process Graphics Translation Table,
> + * see I915_PARAM_HAS_ALIASING_PPGTT
> + */
> +#define I915_GEM_PPGTT_NONE	0
> +#define I915_GEM_PPGTT_ALIASING	1
> +#define I915_GEM_PPGTT_FULL	2
> +
>  /* Ioctl to query kernel params:
>   */
>  #define I915_PARAM_IRQ_ACTIVE            1
> @@ -468,6 +502,7 @@ typedef struct drm_i915_irq_wait {
>  #define   I915_SCHEDULER_CAP_ENABLED	(1ul << 0)
>  #define   I915_SCHEDULER_CAP_PRIORITY	(1ul << 1)
>  #define   I915_SCHEDULER_CAP_PREEMPTION	(1ul << 2)
> +#define   I915_SCHEDULER_CAP_SEMAPHORES	(1ul << 3)
>  
>  #define I915_PARAM_HUC_STATUS		 42
>  
> @@ -551,6 +586,8 @@ typedef struct drm_i915_irq_wait {
>   */
>  #define I915_PARAM_MMAP_GTT_COHERENT	52
>  
> +/* Must be kept compact -- no holes and well documented */
> +
>  typedef struct drm_i915_getparam {
>  	__s32 param;
>  	/*
> @@ -566,6 +603,7 @@ typedef struct drm_i915_getparam {
>  #define I915_SETPARAM_TEX_LRU_LOG_GRANULARITY             2
>  #define I915_SETPARAM_ALLOW_BATCHBUFFER                   3
>  #define I915_SETPARAM_NUM_USED_FENCES                     4
> +/* Must be kept compact -- no holes */
>  
>  typedef struct drm_i915_setparam {
>  	int param;
> @@ -964,7 +1002,7 @@ struct drm_i915_gem_execbuffer2 {
>  	 * struct drm_i915_gem_exec_fence *fences.
>  	 */
>  	__u64 cliprects_ptr;
> -#define I915_EXEC_RING_MASK              (7<<0)
> +#define I915_EXEC_RING_MASK              (0x3f)
>  #define I915_EXEC_DEFAULT                (0<<0)
>  #define I915_EXEC_RENDER                 (1<<0)
>  #define I915_EXEC_BSD                    (2<<0)
> @@ -1112,32 +1150,34 @@ struct drm_i915_gem_busy {
>  	 * as busy may become idle before the ioctl is completed.
>  	 *
>  	 * Furthermore, if the object is busy, which engine is busy is only
> -	 * provided as a guide. There are race conditions which prevent the
> -	 * report of which engines are busy from being always accurate.
> -	 * However, the converse is not true. If the object is idle, the
> -	 * result of the ioctl, that all engines are idle, is accurate.
> +	 * provided as a guide and only indirectly by reporting its class
> +	 * (there may be more than one engine in each class). There are race
> +	 * conditions which prevent the report of which engines are busy from
> +	 * being always accurate.  However, the converse is not true. If the
> +	 * object is idle, the result of the ioctl, that all engines are idle,
> +	 * is accurate.
>  	 *
>  	 * The returned dword is split into two fields to indicate both
> -	 * the engines on which the object is being read, and the
> -	 * engine on which it is currently being written (if any).
> +	 * the engine classess on which the object is being read, and the
> +	 * engine class on which it is currently being written (if any).
>  	 *
>  	 * The low word (bits 0:15) indicate if the object is being written
>  	 * to by any engine (there can only be one, as the GEM implicit
>  	 * synchronisation rules force writes to be serialised). Only the
> -	 * engine for the last write is reported.
> +	 * engine class (offset by 1, I915_ENGINE_CLASS_RENDER is reported as
> +	 * 1 not 0 etc) for the last write is reported.
>  	 *
> -	 * The high word (bits 16:31) are a bitmask of which engines are
> -	 * currently reading from the object. Multiple engines may be
> +	 * The high word (bits 16:31) are a bitmask of which engines classes
> +	 * are currently reading from the object. Multiple engines may be
>  	 * reading from the object simultaneously.
>  	 *
> -	 * The value of each engine is the same as specified in the
> -	 * EXECBUFFER2 ioctl, i.e. I915_EXEC_RENDER, I915_EXEC_BSD etc.
> -	 * Note I915_EXEC_DEFAULT is a symbolic value and is mapped to
> -	 * the I915_EXEC_RENDER engine for execution, and so it is never
> +	 * The value of each engine class is the same as specified in the
> +	 * I915_CONTEXT_SET_ENGINES parameter and via perf, i.e.
> +	 * I915_ENGINE_CLASS_RENDER, I915_ENGINE_CLASS_COPY, etc.
>  	 * reported as active itself. Some hardware may have parallel
>  	 * execution engines, e.g. multiple media engines, which are
> -	 * mapped to the same identifier in the EXECBUFFER2 ioctl and
> -	 * so are not separately reported for busyness.
> +	 * mapped to the same class identifier and so are not separately
> +	 * reported for busyness.
>  	 *
>  	 * Caveat emptor:
>  	 * Only the boolean result of this query is reliable; that is whether
> @@ -1404,16 +1444,159 @@ struct drm_i915_gem_wait {
>  };
>  
>  struct drm_i915_gem_context_create {
> -	/*  output: id of new context*/
> -	__u32 ctx_id;
> +	__u32 ctx_id; /* output: id of new context*/
>  	__u32 pad;
>  };
>  
> +struct drm_i915_gem_context_create_ext {
> +	__u32 ctx_id; /* output: id of new context*/
> +	__u32 flags;
> +#define I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS	(1u << 0)
> +#define I915_CONTEXT_CREATE_FLAGS_UNKNOWN \
> +	(-(I915_CONTEXT_CREATE_FLAGS_USE_EXTENSIONS << 1))
> +	__u64 extensions;
> +};
> +
> +struct drm_i915_gem_context_param {
> +	__u32 ctx_id;
> +	__u32 size;
> +	__u64 param;
> +#define I915_CONTEXT_PARAM_BAN_PERIOD	0x1
> +#define I915_CONTEXT_PARAM_NO_ZEROMAP	0x2
> +#define I915_CONTEXT_PARAM_GTT_SIZE	0x3
> +#define I915_CONTEXT_PARAM_NO_ERROR_CAPTURE	0x4
> +#define I915_CONTEXT_PARAM_BANNABLE	0x5
> +#define I915_CONTEXT_PARAM_PRIORITY	0x6
> +#define   I915_CONTEXT_MAX_USER_PRIORITY	1023 /* inclusive */
> +#define   I915_CONTEXT_DEFAULT_PRIORITY		0
> +#define   I915_CONTEXT_MIN_USER_PRIORITY	-1023 /* inclusive */
> +	/*
> +	 * When using the following param, value should be a pointer to
> +	 * drm_i915_gem_context_param_sseu.
> +	 */
> +#define I915_CONTEXT_PARAM_SSEU		0x7
> +
> +/*
> + * Not all clients may want to attempt automatic recover of a context after
> + * a hang (for example, some clients may only submit very small incremental
> + * batches relying on known logical state of previous batches which will never
> + * recover correctly and each attempt will hang), and so would prefer that
> + * the context is forever banned instead.
> + *
> + * If set to false (0), after a reset, subsequent (and in flight) rendering
> + * from this context is discarded, and the client will need to create a new
> + * context to use instead.
> + *
> + * If set to true (1), the kernel will automatically attempt to recover the
> + * context by skipping the hanging batch and executing the next batch starting
> + * from the default context state (discarding the incomplete logical context
> + * state lost due to the reset).
> + *
> + * On creation, all new contexts are marked as recoverable.
> + */
> +#define I915_CONTEXT_PARAM_RECOVERABLE	0x8
> +/* Must be kept compact -- no holes and well documented */
> +
> +	__u64 value;
> +};
> +
> +/**
> + * Context SSEU programming
> + *
> + * It may be necessary for either functional or performance reason to configure
> + * a context to run with a reduced number of SSEU (where SSEU stands for Slice/
> + * Sub-slice/EU).
> + *
> + * This is done by configuring SSEU configuration using the below
> + * @struct drm_i915_gem_context_param_sseu for every supported engine which
> + * userspace intends to use.
> + *
> + * Not all GPUs or engines support this functionality in which case an error
> + * code -ENODEV will be returned.
> + *
> + * Also, flexibility of possible SSEU configuration permutations varies between
> + * GPU generations and software imposed limitations. Requesting such a
> + * combination will return an error code of -EINVAL.
> + *
> + * NOTE: When perf/OA is active the context's SSEU configuration is ignored in
> + * favour of a single global setting.
> + */
> +struct drm_i915_gem_context_param_sseu {
> +	/*
> +	 * Engine class & instance to be configured or queried.
> +	 */
> +	__u16 engine_class;
> +	__u16 engine_instance;
> +
> +	/*
> +	 * Unused for now. Must be cleared to zero.
> +	 */
> +	__u32 flags;
> +
> +	/*
> +	 * Mask of slices to enable for the context. Valid values are a subset
> +	 * of the bitmask value returned for I915_PARAM_SLICE_MASK.
> +	 */
> +	__u64 slice_mask;
> +
> +	/*
> +	 * Mask of subslices to enable for the context. Valid values are a
> +	 * subset of the bitmask value return by I915_PARAM_SUBSLICE_MASK.
> +	 */
> +	__u64 subslice_mask;
> +
> +	/*
> +	 * Minimum/Maximum number of EUs to enable per subslice for the
> +	 * context. min_eus_per_subslice must be inferior or equal to
> +	 * max_eus_per_subslice.
> +	 */
> +	__u16 min_eus_per_subslice;
> +	__u16 max_eus_per_subslice;
> +
> +	/*
> +	 * Unused for now. Must be cleared to zero.
> +	 */
> +	__u32 rsvd;
> +};
> +
> +struct drm_i915_gem_context_create_ext_setparam {
> +#define I915_CONTEXT_CREATE_EXT_SETPARAM 0
> +	struct i915_user_extension base;
> +	struct drm_i915_gem_context_param param;
> +};
> +
>  struct drm_i915_gem_context_destroy {
>  	__u32 ctx_id;
>  	__u32 pad;
>  };
>  
> +/*
> + * DRM_I915_GEM_VM_CREATE -
> + *
> + * Create a new virtual memory address space (ppGTT) for use within a context
> + * on the same file. Extensions can be provided to configure exactly how the
> + * address space is setup upon creation.
> + *
> + * The id of new VM (bound to the fd) for use with I915_CONTEXT_PARAM_VM is
> + * returned in the outparam @id.
> + *
> + * No flags are defined, with all bits reserved and must be zero.
> + *
> + * An extension chain maybe provided, starting with @extensions, and terminated
> + * by the @next_extension being 0. Currently, no extensions are defined.
> + *
> + * DRM_I915_GEM_VM_DESTROY -
> + *
> + * Destroys a previously created VM id, specified in @id.
> + *
> + * No extensions or flags are allowed currently, and so must be zero.
> + */
> +struct drm_i915_gem_vm_control {
> +	__u64 extensions;
> +	__u32 flags;
> +	__u32 vm_id;
> +};
> +
>  struct drm_i915_reg_read {
>  	/*
>  	 * Register offset.
> @@ -1426,6 +1609,7 @@ struct drm_i915_reg_read {
>  
>  	__u64 val; /* Return value */
>  };
> +
>  /* Known registers:
>   *
>   * Render engine timestamp - 0x2358 + 64bit - gen7+
> @@ -1465,22 +1649,6 @@ struct drm_i915_gem_userptr {
>  	__u32 handle;
>  };
>  
> -struct drm_i915_gem_context_param {
> -	__u32 ctx_id;
> -	__u32 size;
> -	__u64 param;
> -#define I915_CONTEXT_PARAM_BAN_PERIOD	0x1
> -#define I915_CONTEXT_PARAM_NO_ZEROMAP	0x2
> -#define I915_CONTEXT_PARAM_GTT_SIZE	0x3
> -#define I915_CONTEXT_PARAM_NO_ERROR_CAPTURE	0x4
> -#define I915_CONTEXT_PARAM_BANNABLE	0x5
> -#define I915_CONTEXT_PARAM_PRIORITY	0x6
> -#define   I915_CONTEXT_MAX_USER_PRIORITY	1023 /* inclusive */
> -#define   I915_CONTEXT_DEFAULT_PRIORITY		0
> -#define   I915_CONTEXT_MIN_USER_PRIORITY	-1023 /* inclusive */
> -	__u64 value;
> -};
> -
>  enum drm_i915_oa_format {
>  	I915_OA_FORMAT_A13 = 1,	    /* HSW only */
>  	I915_OA_FORMAT_A29,	    /* HSW only */
> @@ -1642,6 +1810,7 @@ struct drm_i915_perf_oa_config {
>  struct drm_i915_query_item {
>  	__u64 query_id;
>  #define DRM_I915_QUERY_TOPOLOGY_INFO    1
> +/* Must be kept compact -- no holes and well documented */
>  
>  	/*
>  	 * When set to zero by userspace, this is filled with the size of the
> diff --git a/include/drm/msm_drm.h b/include/drm/msm_drm.h
> index c06d0a5..91a16b3 100644
> --- a/include/drm/msm_drm.h
> +++ b/include/drm/msm_drm.h
> @@ -105,14 +105,24 @@ struct drm_msm_gem_new {
>  	__u32 handle;         /* out */
>  };
>  
> -#define MSM_INFO_IOVA	0x01
> -
> -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> +/* Get or set GEM buffer info.  The requested value can be passed
> + * directly in 'value', or for data larger than 64b 'value' is a
> + * pointer to userspace buffer, with 'len' specifying the number of
> + * bytes copied into that buffer.  For info returned by pointer,
> + * calling the GEM_INFO ioctl with null 'value' will return the
> + * required buffer size in 'len'
> + */
> +#define MSM_INFO_GET_OFFSET	0x00   /* get mmap() offset, returned by value */
> +#define MSM_INFO_GET_IOVA	0x01   /* get iova, returned by value */
> +#define MSM_INFO_SET_NAME	0x02   /* set the debug name (by pointer) */
> +#define MSM_INFO_GET_NAME	0x03   /* get debug name, returned by pointer */
>  
>  struct drm_msm_gem_info {
>  	__u32 handle;         /* in */
> -	__u32 flags;	      /* in - combination of MSM_INFO_* flags */
> -	__u64 offset;         /* out, mmap() offset or iova */
> +	__u32 info;           /* in - one of MSM_INFO_* */
> +	__u64 value;          /* in or out */
> +	__u32 len;            /* in or out */
> +	__u32 pad;
>  };
>  
>  #define MSM_PREP_READ        0x01
> @@ -188,8 +198,11 @@ struct drm_msm_gem_submit_cmd {
>   */
>  #define MSM_SUBMIT_BO_READ             0x0001
>  #define MSM_SUBMIT_BO_WRITE            0x0002
> +#define MSM_SUBMIT_BO_DUMP             0x0004
>  
> -#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | MSM_SUBMIT_BO_WRITE)
> +#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
> +					MSM_SUBMIT_BO_WRITE | \
> +					MSM_SUBMIT_BO_DUMP)
>  
>  struct drm_msm_gem_submit_bo {
>  	__u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
> -- 
> 2.7.4
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
