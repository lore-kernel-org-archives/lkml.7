Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6B1C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5498206C2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 14:00:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbfJHOAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 10:00:19 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:49946 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbfJHOAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 10:00:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 49ACD8368F00;
        Tue,  8 Oct 2019 14:00:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: year93_1f3b28f822a23
X-Filterd-Recvd-Size: 2066
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  8 Oct 2019 14:00:14 +0000 (UTC)
Message-ID: <05e9cf0254790321433fd7d2c19129ec952bb3ac.camel@perches.com>
Subject: Re: [PATCH] drm/amdgpu/display: make various arrays static, makes
 object smaller
From:   Joe Perches <joe@perches.com>
To:     Harry Wentland <hwentlan@amd.com>,
        Colin King <colin.king@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Cc:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Tue, 08 Oct 2019 07:00:13 -0700
In-Reply-To: <9579bfae-1db5-d282-79ea-df1966f4c123@amd.com>
References: <20191007215857.14720-1-colin.king@canonical.com>
         <9579bfae-1db5-d282-79ea-df1966f4c123@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-10-08 at 13:56 +0000, Harry Wentland wrote:
[]
> > diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> []
> > @@ -2745,7 +2745,7 @@ static enum bp_result bios_get_board_layout_info(
> >  	struct bios_parser *bp;
> >  	enum bp_result record_result;
> >  
> > -	const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
> > +	static const unsigned int slot_index_to_vbios_id[MAX_BOARD_SLOTS] = {
> 
> Won't this break the multi-GPU case where you'll have multiple driver
> instances with different layout?

As the array is read-only, how could that happen?


