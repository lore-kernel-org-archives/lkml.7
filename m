Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43DDC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2E720674
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 08:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbfDDIag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:30:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47724 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbfDDIaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 04:30:35 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A416C2CE963;
        Thu,  4 Apr 2019 08:30:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1C1C71001E8B;
        Thu,  4 Apr 2019 08:30:35 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 52A5E16E31; Thu,  4 Apr 2019 10:30:34 +0200 (CEST)
Date:   Thu, 4 Apr 2019 10:30:34 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Message-ID: <20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
 <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
 <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
 <CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 04 Apr 2019 08:30:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Speaking of wayland:  Seems at least gnome-shell insists on using XR24.
> 
> Yeah XR24 is pretty much mandatory. Noralf added a few helpers to
> convert XR24 to other formats, for display not supporting anything
> else. Because userspace.

Have a pointer to these helpers?  grepping around in drm didn't turn up
anything so far ...

thanks,
  Gerd

