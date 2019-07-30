Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA1BC76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24FA22089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfG3DI4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 23:08:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:16036 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726281AbfG3DIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 23:08:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 20:08:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,325,1559545200"; 
   d="scan'208";a="346861983"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga005.jf.intel.com with ESMTP; 29 Jul 2019 20:08:52 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jul 2019 20:08:52 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jul 2019 20:08:51 -0700
Received: from shsmsx105.ccr.corp.intel.com ([169.254.11.15]) by
 shsmsx102.ccr.corp.intel.com ([169.254.2.19]) with mapi id 14.03.0439.000;
 Tue, 30 Jul 2019 11:08:49 +0800
From:   "Zhao, Yan Y" <yan.y.zhao@intel.com>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>
CC:     David Airlie <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>
Subject: RE: [PATCH] drm/i915/gvt: remove duplicate entry of trace
Thread-Topic: [PATCH] drm/i915/gvt: remove duplicate entry of trace
Thread-Index: AQHVIM5kvexPfpkDmUCNSg2o5koBYqbixmwQ
Date:   Tue, 30 Jul 2019 03:08:49 +0000
Message-ID: <F22B14EC3CFBB843AD3E03B6B78F2C6A4B8CB34E@SHSMSX105.ccr.corp.intel.com>
References: <20190526075633.GA9245@hari-Inspiron-1545>
 <20190612032236.GH9684@zhen-hp.sh.intel.com>
In-Reply-To: <20190612032236.GH9684@zhen-hp.sh.intel.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2Q5NmYwODMtYmQ2NS00NDVjLWJkNGQtNGRjYzFlMWY4ZjZiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVVFxRnF6Tjd0TkFUXC9PRk0wMUlRVHkxc0VSUEIyTUxEZzVFMk9OM09QUjlzMDloZERFQmJLak9RREROQmhydVcifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Yan Zhao <yan.y.zhao@intel.com>

> -----Original Message-----
> From: intel-gvt-dev [mailto:intel-gvt-dev-bounces@lists.freedesktop.org] On
> Behalf Of Zhenyu Wang
> Sent: Wednesday, June 12, 2019 11:23 AM
> To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Cc: David Airlie <airlied@linux.ie>; intel-gfx@lists.freedesktop.org; Joonas
> Lahtinen <joonas.lahtinen@linux.intel.com>; linux-kernel@vger.kernel.org; Jani
> Nikula <jani.nikula@linux.intel.com>; dri-devel@lists.freedesktop.org; Daniel
> Vetter <daniel@ffwll.ch>; Vivi, Rodrigo <rodrigo.vivi@intel.com>; intel-gvt-
> dev@lists.freedesktop.org; Wang, Zhi A <zhi.a.wang@intel.com>
> Subject: Re: [PATCH] drm/i915/gvt: remove duplicate entry of trace
> 
> On 2019.05.26 13:26:33 +0530, Hariprasad Kelam wrote:
> > Remove duplicate include of trace.h
> >
> > Issue identified by includecheck
> >
> > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > ---
> >  drivers/gpu/drm/i915/gvt/trace_points.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/i915/gvt/trace_points.c
> > b/drivers/gpu/drm/i915/gvt/trace_points.c
> > index a3deed69..569f5e3 100644
> > --- a/drivers/gpu/drm/i915/gvt/trace_points.c
> > +++ b/drivers/gpu/drm/i915/gvt/trace_points.c
> > @@ -32,5 +32,4 @@
> >
> >  #ifndef __CHECKER__
> >  #define CREATE_TRACE_POINTS
> > -#include "trace.h"
> >  #endif
> > --
> 
> This actually caused build issue like
> ERROR: "__tracepoint_gma_index" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_render_mmio" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_gvt_command" [drivers/gpu/drm/i915/i915.ko]
> undefined!
> ERROR: "__tracepoint_spt_guest_change" [drivers/gpu/drm/i915/i915.ko]
> undefined!
> ERROR: "__tracepoint_gma_translate" [drivers/gpu/drm/i915/i915.ko]
> undefined!
> ERROR: "__tracepoint_spt_alloc" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_spt_change" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_oos_sync" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_write_ir" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_propagate_event" [drivers/gpu/drm/i915/i915.ko]
> undefined!
> ERROR: "__tracepoint_inject_msi" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_spt_refcount" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_spt_free" [drivers/gpu/drm/i915/i915.ko] undefined!
> ERROR: "__tracepoint_oos_change" [drivers/gpu/drm/i915/i915.ko] undefined!
> scripts/Makefile.modpost:91: recipe for target '__modpost' failed
> 
> Looks we need fix like below.
> 
> Subject: [PATCH] drm/i915/gvt: remove duplicate include of trace.h
> 
> This removes duplicate include of trace.h. Found by Hariprasad Kelam with
> includecheck.
> 
> Reported-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
> ---
>  drivers/gpu/drm/i915/gvt/trace_points.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/trace_points.c
> b/drivers/gpu/drm/i915/gvt/trace_points.c
> index a3deed692b9c..fe552e877e09 100644
> --- a/drivers/gpu/drm/i915/gvt/trace_points.c
> +++ b/drivers/gpu/drm/i915/gvt/trace_points.c
> @@ -28,8 +28,6 @@
>   *
>   */
> 
> -#include "trace.h"
> -
>  #ifndef __CHECKER__
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
> --
> 2.20.1
> 
> --
> Open Source Technology Center, Intel ltd.
> 
> $gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827
