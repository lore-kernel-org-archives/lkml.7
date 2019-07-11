Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B264C74A42
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31DE3208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 06:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfGKG3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 02:29:08 -0400
Received: from mga02.intel.com ([134.134.136.20]:48814 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbfGKG3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 02:29:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 23:29:08 -0700
X-IronPort-AV: E=Sophos;i="5.63,476,1557212400"; 
   d="scan'208";a="159976996"
Received: from jkrzyszt-desk.igk.intel.com (HELO jkrzyszt-desk.ger.corp.intel.com) ([172.22.244.18])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 23:29:05 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?utf-8?B?TWljaGHFgg==?= Wajdeczko <michal.wajdeczko@intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [RFC PATCH] drm/i915: Drop extern qualifiers from header function prototypes
Date:   Thu, 11 Jul 2019 08:28:55 +0200
Message-ID: <1625229.KzvQlO0Tx8@jkrzyszt-desk.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <156277086449.4055.15655120452619911756@skylake-alporthouse-com>
References: <20190710145239.12844-1-janusz.krzysztofik@linux.intel.com> <156277086449.4055.15655120452619911756@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Wednesday, July 10, 2019 5:01:04 PM CEST Chris Wilson wrote:
> Quoting Janusz Krzysztofik (2019-07-10 15:52:39)
> > Follow dim checkpatch recommendation so it doesn't complain on that now
> > and again on header file modifications.
> > 
> > Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
> 
> > --- a/drivers/gpu/drm/i915/i915_drv.h
> > +++ b/drivers/gpu/drm/i915/i915_drv.h
> > @@ -2388,19 +2388,18 @@ __i915_printk(struct drm_i915_private *dev_priv, 
const char *level,
> >         __i915_printk(dev_priv, KERN_ERR, fmt, ##__VA_ARGS__)
> >  
> >  #ifdef CONFIG_COMPAT
> > -extern long i915_compat_ioctl(struct file *filp, unsigned int cmd,
> > -                             unsigned long arg);
> > +long i915_compat_ioctl(struct file *filp, unsigned int cmd, unsigned long 
arg);
> >  #else
> >  #define i915_compat_ioctl NULL
> >  #endif
> >  extern const struct dev_pm_ops i915_pm_ops;
> > +extern const struct dev_pm_ops i915_pm_ops_1;
> 
> That's novel.

Oh, sorry, that was my testing of how dim checkpatch reacts on extern 
qualifiers on variables.  Thanks for catching this.

Janusz

> > -Chris
> 




