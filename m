Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4F6C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4202075A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgAFPgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:36:50 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:46540 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgAFPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:36:49 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 149BE804F9;
        Mon,  6 Jan 2020 16:36:45 +0100 (CET)
Date:   Mon, 6 Jan 2020 16:36:43 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christian Gmeiner <christian.gmeiner@gmail.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Russell King <linux+etnaviv@armlinux.org.uk>
Subject: Re: [PATCH v2 0/6] update hwdw for gc400
Message-ID: <20200106153643.GA8535@ravnborg.org>
References: <20200106151655.311413-1-christian.gmeiner@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106151655.311413-1-christian.gmeiner@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8
        a=eDDQxHsoJXqcITB9VNUA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
        a=CjuIK1q_8ugA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian

On Mon, Jan 06, 2020 at 04:16:45PM +0100, Christian Gmeiner wrote:
> This patch series extends the hwdb for an entry for the gc400 found
> in the ST STM32 SoC. With this patches we report the same limits and
> features for this GPU as the galcore kernel driver does.

For future patches can you please incldue a small changelog
within each patch.

Something like

v2:
  - Drop redundant newlines (Lucas)

This serves several purposes:
- It explains what was changed since last version
- It allow the reader to focus on changed parts
- It attributes who requested a specific change
- It gives a good idea of the history of a patch

In the DRM sub-subsystem the idea is that if it is written it
should be visible in git too. So include the changelog part in the
normal commit-message.

	Sam

> 
> Christian Gmeiner (6):
>   drm/etnaviv: update hardware headers from rnndb
>   drm/etnaviv: determine product, customer and eco id
>   drm/etnaviv: show identity information in debugfs
>   drm/etnaviv: update gc7000 chip identity entry
>   drm/etnaviv: update hwdb selection logic
>   drm/etnaviv: add hwdb entry for gc400 found in STM32
> 
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c  | 18 ++++++++++-
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.h  |  6 ++--
>  drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 42 +++++++++++++++++++++++++-
>  drivers/gpu/drm/etnaviv/state_hi.xml.h | 29 +++++++++++-------
>  4 files changed, 79 insertions(+), 16 deletions(-)
> 
> -- 
> 2.24.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
