Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134B9C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7873206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbfDCK1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:27:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34042 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfDCK1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:27:42 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 409FB8552A;
        Wed,  3 Apr 2019 10:27:42 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-22.ams2.redhat.com [10.36.116.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0BB8100034B;
        Wed,  3 Apr 2019 10:27:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 0B93F16E30; Wed,  3 Apr 2019 12:27:41 +0200 (CEST)
Date:   Wed, 3 Apr 2019 12:27:40 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Dave Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH] drm/cirrus: rewrite and modernize driver.
Message-ID: <20190403102740.qc3hlfchd7eogx44@sirius.home.kraxel.org>
References: <20190403072318.31507-1-kraxel@redhat.com>
 <CAKMK7uGWh02L9n4etQC3V-RX3aWovJLpadNFe08LdWXRNz2yuw@mail.gmail.com>
 <20190403085341.2cxdgxqrjlwecx3n@sirius.home.kraxel.org>
 <0c959f3a-15e9-8295-dc11-2f6b9a4229ac@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c959f3a-15e9-8295-dc11-2f6b9a4229ac@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 03 Apr 2019 10:27:42 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > So I can just remove cirrus_fb_dirty() and hook up
> > drm_atomic_helper_dirtyfb() instead.  Easy ;)
> 
> You can even use drm_gem_fb_create_with_dirty() instead of
> drm_gem_fb_create_with_funcs().

Ah, cool.  /me happily continues removing code lines.

thanks,
  Gerd

PS: incremental fixups are at
    https://git.kraxel.org/cgit/linux/log/?h=drm-rewrite-cirrus

