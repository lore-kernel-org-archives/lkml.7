Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2220FC2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 018162465E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729377AbfLEJzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:55:55 -0500
Received: from mga06.intel.com ([134.134.136.31]:20429 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbfLEJzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:55:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 01:55:54 -0800
X-IronPort-AV: E=Sophos;i="5.69,281,1571727600"; 
   d="scan'208";a="205719543"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2019 01:55:51 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "maarten.lankhorst\@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "mripard\@kernel.org" <mripard@kernel.org>,
        "sean\@poorly.run" <sean@poorly.run>,
        "airlied\@linux.ie" <airlied@linux.ie>,
        "daniel\@ffwll.ch" <daniel@ffwll.ch>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel\@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/modes: remove unused variables
In-Reply-To: <f210413f-2d2f-9887-ca3b-a3c48564d9d6@st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191119134706.10893-1-benjamin.gaignard@st.com> <8056f838-3ebf-26db-f5be-3e78d61aa512@suse.de> <f210413f-2d2f-9887-ca3b-a3c48564d9d6@st.com>
Date:   Thu, 05 Dec 2019 11:55:48 +0200
Message-ID: <87tv6fgkpn.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Dec 2019, Benjamin GAIGNARD <benjamin.gaignard@st.com> wrote:
> On 12/4/19 10:35 AM, Thomas Zimmermann wrote:
>> Hi
>>
>> Am 19.11.19 um 14:47 schrieb Benjamin Gaignard:
>>> When compiling with W=1 few warnings about unused variables show up.
>>> This patch removes all the involved variables.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>>> ---
>>>   drivers/gpu/drm/drm_modes.c | 22 +++-------------------
>>>   1 file changed, 3 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
>>> index 88232698d7a0..aca901aff042 100644
>>> --- a/drivers/gpu/drm/drm_modes.c
>>> +++ b/drivers/gpu/drm/drm_modes.c
>>> @@ -233,7 +233,7 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
>>>   		/* 3) Nominal HSync width (% of line period) - default 8 */
>>>   #define CVT_HSYNC_PERCENTAGE	8
>>>   		unsigned int hblank_percentage;
>>> -		int vsyncandback_porch, vback_porch, hblank;
>>> +		int vsyncandback_porch, hblank;
>>>   
>>>   		/* estimated the horizontal period */
>>>   		tmp1 = HV_FACTOR * 1000000  -
>>> @@ -249,7 +249,6 @@ struct drm_display_mode *drm_cvt_mode(struct drm_device *dev, int hdisplay,
>>>   		else
>>>   			vsyncandback_porch = tmp1;
>>>   		/* 10. Find number of lines in back porch */
>>> -		vback_porch = vsyncandback_porch - vsync;
>>>   		drm_mode->vtotal = vdisplay_rnd + 2 * vmargin +
>>>   				vsyncandback_porch + CVT_MIN_V_PORCH;
>>>   		/* 5) Definition of Horizontal blanking time limitation */
>>> @@ -386,9 +385,8 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
>>>   	int top_margin, bottom_margin;
>>>   	int interlace;
>>>   	unsigned int hfreq_est;
>>> -	int vsync_plus_bp, vback_porch;
>>> -	unsigned int vtotal_lines, vfieldrate_est, hperiod;
>>> -	unsigned int vfield_rate, vframe_rate;
>>> +	int vsync_plus_bp;
>>> +	unsigned int vtotal_lines;
>>>   	int left_margin, right_margin;
>>>   	unsigned int total_active_pixels, ideal_duty_cycle;
>>>   	unsigned int hblank, total_pixels, pixel_freq;
>>> @@ -451,23 +449,9 @@ drm_gtf_mode_complex(struct drm_device *dev, int hdisplay, int vdisplay,
>>>   	/* [V SYNC+BP] = RINT(([MIN VSYNC+BP] * hfreq_est / 1000000)) */
>>>   	vsync_plus_bp = MIN_VSYNC_PLUS_BP * hfreq_est / 1000;
>>>   	vsync_plus_bp = (vsync_plus_bp + 500) / 1000;
>>> -	/*  9. Find the number of lines in V back porch alone: */
>>> -	vback_porch = vsync_plus_bp - V_SYNC_RQD;
>>>   	/*  10. Find the total number of lines in Vertical field period: */
>>>   	vtotal_lines = vdisplay_rnd + top_margin + bottom_margin +
>>>   			vsync_plus_bp + GTF_MIN_V_PORCH;
>>> -	/*  11. Estimate the Vertical field frequency: */
>>> -	vfieldrate_est = hfreq_est / vtotal_lines;
>>> -	/*  12. Find the actual horizontal period: */
>>> -	hperiod = 1000000 / (vfieldrate_rqd * vtotal_lines);
>>> -
>>> -	/*  13. Find the actual Vertical field frequency: */
>>> -	vfield_rate = hfreq_est / vtotal_lines;
>>> -	/*  14. Find the Vertical frame frequency: */
>>> -	if (interlaced)
>>> -		vframe_rate = vfield_rate / 2;
>>> -	else
>>> -		vframe_rate = vfield_rate;
>> The amount of unused code is quite large, which makes me wonder if
>> there's something missing below where these variables are supposed to be
>> used.
>>
>> If these variables can be removed, comments should mention that steps 9
>> and 11 to 14 are being left out. After all, the function is fairly
>> explicit about implementing the GTF algorithm step by step.
>>
>> Best regards
>> Thomas
>
> If the goal is to keep all the steps then I could prefix all problematic 
> variables with __maybe_unused macro.

The effect is the same; it hides a potential bug that should be analyzed
and fixed. If you have the time, please look at the code and figure out
what it's supposed to do, and why isn't it using the information. Look
at git blame and log, was it always so, or did something change?

The warnings are about potential bugs. The objective or end goal is to
fix the bugs, not to silence the warnings.


BR,
Jani.


>
> Benjamin
>
>>
>>>   	/*  15. Find number of pixels in left margin: */
>>>   	if (margins)
>>>   		left_margin = (hdisplay_rnd * GTF_MARGIN_PERCENTAGE + 500) /
>>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Jani Nikula, Intel Open Source Graphics Center
