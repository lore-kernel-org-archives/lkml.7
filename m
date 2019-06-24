Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59491C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BACC2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 03:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfFXDrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 23:47:00 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:44831 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727132AbfFXDrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 23:47:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E5BE8837F24C;
        Mon, 24 Jun 2019 03:46:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dust72_279b0f5cc505
X-Filterd-Recvd-Size: 3038
Received: from XPS-9350 (cpe-23-242-70-174.socal.res.rr.com [23.242.70.174])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 03:46:56 +0000 (UTC)
Message-ID: <f7af76e8237f490f75d9f2624127e01c55476d2f.camel@perches.com>
Subject: Re: [PATCH -next v2] drm/amdgpu: return 'ret' in amdgpu_pmu_init
From:   Joe Perches <joe@perches.com>
To:     maowenan <maowenan@huawei.com>, airlied@linux.ie, daniel@ffwll.ch,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, dan.carpenter@oracle.com, julia.lawall@lip6.fr
Cc:     kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jonathan Kim <jonathan.kim@amd.com>
Date:   Sun, 23 Jun 2019 20:46:55 -0700
In-Reply-To: <b468d765-bef7-70a8-9a14-bad0e6ed14df@huawei.com>
References: <20190622104318.GT28859@kadam>
         <20190622130527.182022-1-maowenan@huawei.com>
         <0ab82cdb0bec30e7e431f106f8e0e9d141491555.camel@perches.com>
         <b468d765-bef7-70a8-9a14-bad0e6ed14df@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 11:41 +0800, maowenan wrote:
> 
> On 2019/6/23 2:13, Joe Perches wrote:
> > On Sat, 2019-06-22 at 21:05 +0800, Mao Wenan wrote:
> > > There is one warning:
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c: In function ‘amdgpu_pmu_init’:
> > > drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c:249:6: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> > >   int ret = 0;
> > []
> > >  v1->v2: change the subject for this patch; change the indenting when it calls init_pmu_by_type; use the value 'ret' in
> > >  amdgpu_pmu_init().
> > []
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pmu.c
> > []
> > > @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)
> > >  	case CHIP_VEGA20:
> > >  		/* init df */
> > >  		ret = init_pmu_by_type(adev, df_v3_6_attr_groups,
> > > -				       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> > > -				       DF_V3_6_MAX_COUNTERS);
> > > +							   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,
> > > +							   DF_V3_6_MAX_COUNTERS);
> > 
> > trivia:
> > 
> > The indentation change seems superfluous and
> > appears to make the code harder to read.
> > 
> > You could also cc Jonathan Kim who wrote all of this.
> I think this is just display issue in mail format. It is correct that in vi/vim.
> The arguments are line up with '(' after my change.

Use 8 character tabs and try again please.

> @@ -252,8 +252,8 @@ int amdgpu_pmu_init(struct amdgpu_device *adev)$
>  ^Icase CHIP_VEGA20:$
>  ^I^I/* init df */$
>  ^I^Iret = init_pmu_by_type(adev, df_v3_6_attr_groups,$
> -^I^I^I^I       "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,$
> -^I^I^I^I       DF_V3_6_MAX_COUNTERS);$
> +^I^I^I^I^I^I^I   "DF", "amdgpu_df", PERF_TYPE_AMDGPU_DF,$
> +^I^I^I^I^I^I^I   DF_V3_6_MAX_COUNTERS);$


