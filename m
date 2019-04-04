Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B1AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEBD206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 11:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbfDDLph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 07:45:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDDLpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 07:45:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 645E281E19;
        Thu,  4 Apr 2019 11:45:36 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25808983B;
        Thu,  4 Apr 2019 11:45:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 3A4A416E30; Thu,  4 Apr 2019 13:45:35 +0200 (CEST)
Date:   Thu, 4 Apr 2019 13:45:35 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@redhat.com>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Message-ID: <20190404114535.i5wh2rqtno3n54fh@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
 <CAMwc25o=DZSVE5Qf5mow6es06Gk3=+6+8offXPY-JPgUkG_Shw@mail.gmail.com>
 <20190404055056.ddc2bdgjbgjj7tby@sirius.home.kraxel.org>
 <CAKMK7uFbLcziLXrwds9QZBBPFiBDC_O+X9fiuutNjsutaPW+sQ@mail.gmail.com>
 <20190404083034.f7vrvukzqx5v7qju@sirius.home.kraxel.org>
 <CAKMK7uHiWu-kOa6SP0ZRstnrwdYR0MHgtHdHZPLWLXxWaQVPrQ@mail.gmail.com>
 <2866e37e-8563-1f1e-8f16-1119f70d52e1@tronnes.org>
 <20190404102722.w6c7aoxzcrhn5xhi@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404102722.w6c7aoxzcrhn5xhi@sirius.home.kraxel.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 04 Apr 2019 11:45:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> So I guess I have to add a dest_clip bool parameter when moving them.
> /me looks for a good place.  drm_fb_helpers.c I think.

https://git.kraxel.org/cgit/linux/log/?h=drm-rewrite-cirrus updated.

v2 series will follow later today or tomorrow.

cheers,
  Gerd

