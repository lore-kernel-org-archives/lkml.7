Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BDDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6346E20850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfCAFvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:51:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfCAFvh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:51:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2491731408EC;
        Fri,  1 Mar 2019 05:51:37 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-211.ams2.redhat.com [10.36.116.211])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6B8B5D6A9;
        Fri,  1 Mar 2019 05:51:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A217811AA4; Fri,  1 Mar 2019 06:51:35 +0100 (CET)
Date:   Fri, 1 Mar 2019 06:51:35 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Joshua Watt <jpewhacker@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: Allow userspace to mmap() framebuffer
Message-ID: <20190301055135.qqph6ggypjvhuoan@sirius.home.kraxel.org>
References: <20190228164741.15590-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190228164741.15590-1-JPEWhacker@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 01 Mar 2019 05:51:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 10:47:41AM -0600, Joshua Watt wrote:
> Reports the size of the virtgpu framebuffer to userspace and installs
> the deferred I/O handlers so that userspace can mmap() and write to it.

Fixed already, as side effect of switching virtio to the generic fbdev
emulation.  Patches are in the drm-misc-next branch and should land
upstream in the 5.1 merge window.

cheers,
  Gerd

