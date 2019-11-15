Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBA0C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27362073B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 11:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbfKOLxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 06:53:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:61657 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727210AbfKOLxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:53:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 03:53:00 -0800
X-IronPort-AV: E=Sophos;i="5.68,308,1569308400"; 
   d="scan'208";a="199178566"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.66.161])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Nov 2019 03:52:56 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Wambui Karuga <wambui.karugax@gmail.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        hjc@rock-chips.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] add new DRM_DEV_WARN macro
In-Reply-To: <20191114132436.7232-1-wambui.karugax@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20191114132436.7232-1-wambui.karugax@gmail.com>
Date:   Fri, 15 Nov 2019 13:52:53 +0200
Message-ID: <8736ep1hm2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2019, Wambui Karuga <wambui.karugax@gmail.com> wrote:
> This adds a new DRM_DEV_WARN helper macro for warnings log output that include
> device pointers. It also includes the use of the DRM_DEV_WARN macro in
> drm/rockchip to replace dev_warn.

I'm trying to solicit new struct drm_device based logging macros, and
starting to convert to those. [1]

BR,
Jani.


[1] http://patchwork.freedesktop.org/patch/msgid/63d1e72b99e9c13ee5b1b362a653ff9c21e19124.1572258936.git.jani.nikula@intel.com




>
> Wambui Karuga (2):
>   drm/print: add DRM_DEV_WARN macro
>   drm/rockchip: use DRM_DEV_WARN macro in debug output
>
>  drivers/gpu/drm/rockchip/inno_hdmi.c | 3 ++-
>  include/drm/drm_print.h              | 9 +++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)

-- 
Jani Nikula, Intel Open Source Graphics Center
