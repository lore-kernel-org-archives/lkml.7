Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6913C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A09CE20857
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 11:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727359AbfCRLfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 07:35:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726493AbfCRLfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 07:35:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EA142D7F5;
        Mon, 18 Mar 2019 11:35:05 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-24.ams2.redhat.com [10.36.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51ACF1001DFE;
        Mon, 18 Mar 2019 11:35:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9A86A11A86; Mon, 18 Mar 2019 12:35:04 +0100 (CET)
Date:   Mon, 18 Mar 2019 12:35:04 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Gurchetan Singh <gurchetansingh@chromium.org>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2 5/6] drm/virtio: drop fencing in
 virtio_gpu_resource_create_ioctl
Message-ID: <20190318113504.hm5i76n6467vcy7g@sirius.home.kraxel.org>
References: <20190130094338.14203-1-kraxel@redhat.com>
 <20190130094338.14203-6-kraxel@redhat.com>
 <CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAfnVB=z36CtTsCiEy1uVTNvE9DVuSDKLNdMVFO+tBJqiQ7s1A@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 18 Mar 2019 11:35:05 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> virtio_gpu_execbuffer_ioctl
> virtio_gpu_resource_create_ioctl with fence resource
> virtio_gpu_wait_ioctl with that fence resource --> associated with a
> GL wait on the host side

After a long break (sidetracked with other stuff) I've finally sent v3
which should address this.

cheers,
  Gerd

