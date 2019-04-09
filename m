Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CDDC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A312084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 12:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfDIM1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 08:27:16 -0400
Received: from mga18.intel.com ([134.134.136.126]:45470 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfDIM1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 08:27:15 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Apr 2019 05:27:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,329,1549958400"; 
   d="scan'208";a="147757555"
Received: from dcondura-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.20.22])
  by FMSMGA003.fm.intel.com with ESMTP; 09 Apr 2019 05:27:10 -0700
Date:   Tue, 9 Apr 2019 13:27:10 +0100
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
Message-ID: <20190409122710.k2bh25xg43lrqzvq@intel.com>
References: <20190408205422.dj7z4dl36nauwlk7@intel.com>
 <1554809706-15389-1-git-send-email-ayan.halder@arm.com>
 <20190409115913.hvyjxlda4wtzm75t@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190409115913.hvyjxlda4wtzm75t@intel.com>
Organization: Intel Corporation (UK) Ltd. - Co. Reg. 1134945 - Pipers Way,
 Swindon SN3 1RJ
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 2019-04-09 12:59:13 +0100, Eric Engestrom wrote:
> On Tuesday, 2019-04-09 11:35:14 +0000, Ayan Halder wrote:
> > Generated using make headers_install from the drm-next
> > tree - git://anongit.freedesktop.org/drm/drm
> > branch - drm-next
> > commit - 14d2bd53a47a7e1cb3e03d00a6b952734cf90f3f
> > 
> > The changes were as follows :-
> > 
> > core: (drm.h, drm_fourcc.h, drm_mode.h)
> > - Added 'struct drm_syncobj_transfer', 'struct drm_syncobj_timeline_wait' and 'struct drm_syncobj_timeline_array'
> > - Added various DRM_IOCTL_SYNCOBJ_ ioctls
> > - Added some new RGB and YUV formats
> > - Added 'DRM_FORMAT_MOD_VENDOR_ALLWINNER'
> > - Added 'SAMSUNG' and Arm's 'AFBC' and 'ALLWINNER' format modifiers
> > - Added 'struct drm_mode_rect'
> > 
> > i915:
> > - Added struct 'struct i915_user_extension' and various 'struct drm_i915_gem_context_'
> > - Added different modes of per-process Graphics Translation Table
> > 
> > msm:
> > - Added various get or set GEM buffer info flags
> > - Added some MSM_SUBMIT_BO_ macros
> > - Modified 'struct drm_msm_gem_info'
> > 
> > Signed-off-by: Ayan Kumar halder <ayan.halder@arm.com>
> 
> This looks sane, and applies cleanly :)
> Acked-by: Eric Engestrom <eric.engestrom@intel.com>

Actually, revoking that, as this patch breaks the build; see below.

> 
> > ---
> >  include/drm/drm.h        |  36 +++++++
> >  include/drm/drm_fourcc.h | 136 +++++++++++++++++++++++++++
> >  include/drm/drm_mode.h   |  23 ++++-
> >  include/drm/i915_drm.h   | 237 ++++++++++++++++++++++++++++++++++++++++-------
> >  include/drm/msm_drm.h    |  25 +++--
> >  5 files changed, 415 insertions(+), 42 deletions(-)
> > 
[snip]
> > diff --git a/include/drm/msm_drm.h b/include/drm/msm_drm.h
> > index c06d0a5..91a16b3 100644
> > --- a/include/drm/msm_drm.h
> > +++ b/include/drm/msm_drm.h
> > @@ -105,14 +105,24 @@ struct drm_msm_gem_new {
> >  	__u32 handle;         /* out */
> >  };
> >  
> > -#define MSM_INFO_IOVA	0x01
> > -
> > -#define MSM_INFO_FLAGS (MSM_INFO_IOVA)
> > +/* Get or set GEM buffer info.  The requested value can be passed
> > + * directly in 'value', or for data larger than 64b 'value' is a
> > + * pointer to userspace buffer, with 'len' specifying the number of
> > + * bytes copied into that buffer.  For info returned by pointer,
> > + * calling the GEM_INFO ioctl with null 'value' will return the
> > + * required buffer size in 'len'
> > + */
> > +#define MSM_INFO_GET_OFFSET	0x00   /* get mmap() offset, returned by value */
> > +#define MSM_INFO_GET_IOVA	0x01   /* get iova, returned by value */
> > +#define MSM_INFO_SET_NAME	0x02   /* set the debug name (by pointer) */
> > +#define MSM_INFO_GET_NAME	0x03   /* get debug name, returned by pointer */
> >  
> >  struct drm_msm_gem_info {
> >  	__u32 handle;         /* in */
> > -	__u32 flags;	      /* in - combination of MSM_INFO_* flags */
> > -	__u64 offset;         /* out, mmap() offset or iova */
> > +	__u32 info;           /* in - one of MSM_INFO_* */
> > +	__u64 value;          /* in or out */
> > +	__u32 len;            /* in or out */
> > +	__u32 pad;

freedreno/msm/msm_bo.c needs to be updated to reflect those changes.

> >  };
> >  
> >  #define MSM_PREP_READ        0x01
> > @@ -188,8 +198,11 @@ struct drm_msm_gem_submit_cmd {
> >   */
> >  #define MSM_SUBMIT_BO_READ             0x0001
> >  #define MSM_SUBMIT_BO_WRITE            0x0002
> > +#define MSM_SUBMIT_BO_DUMP             0x0004
> >  
> > -#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | MSM_SUBMIT_BO_WRITE)
> > +#define MSM_SUBMIT_BO_FLAGS            (MSM_SUBMIT_BO_READ | \
> > +					MSM_SUBMIT_BO_WRITE | \
> > +					MSM_SUBMIT_BO_DUMP)
> >  
> >  struct drm_msm_gem_submit_bo {
> >  	__u32 flags;          /* in, mask of MSM_SUBMIT_BO_x */
> > -- 
> > 2.7.4
> > 
