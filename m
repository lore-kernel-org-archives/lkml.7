Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B129CC04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D7552087F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfEFI5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbfEFI5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:57:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0FBEE81E0D;
        Mon,  6 May 2019 08:57:00 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A38D67C421;
        Mon,  6 May 2019 08:56:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A5A1F16E0A; Mon,  6 May 2019 10:56:58 +0200 (CEST)
Date:   Mon, 6 May 2019 10:56:58 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Robert Foss <robert.foss@collabora.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Chia-I Wu <olvaffe@gmail.com>,
        Emil Velikov <emil.velikov@collabora.com>
Subject: Re: [PATCH] drm/virtio: Remove redundant return type
Message-ID: <20190506085658.bgbzefnvpez2k6zm@sirius.home.kraxel.org>
References: <20190503163804.31922-1-robert.foss@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503163804.31922-1-robert.foss@collabora.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 06 May 2019 08:57:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 06:38:04PM +0200, Robert Foss wrote:
> virtio_gpu_fence_emit() always returns 0, since it
> has no error paths.
> 
> Consequently no calls for virtio_gpu_fence_emit()
> use the return value, and it can be removed.
> 
> Signed-off-by: Robert Foss <robert.foss@collabora.com>
> Suggested-by: Emil Velikov <emil.velikov@collabora.com>

Doesn't apply cleanly to drm-misc-next, probably conflicts with one of
the other virtio fence patches just pushed.  Can you rebase and resend?

thanks,
  Gerd

