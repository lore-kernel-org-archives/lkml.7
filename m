Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DF1C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2776020678
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 08:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388777AbfIQISY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 04:18:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732088AbfIQISU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 04:18:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D2391315C00D;
        Tue, 17 Sep 2019 08:18:19 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-47.ams2.redhat.com [10.36.116.47])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C14D5D9DC;
        Tue, 17 Sep 2019 08:18:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9D29217444; Tue, 17 Sep 2019 10:18:18 +0200 (CEST)
Date:   Tue, 17 Sep 2019 10:18:18 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Eric Anholt <eric@anholt.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] drm/shmem: drop DEFINE_DRM_GEM_SHMEM_FOPS
Message-ID: <20190917081818.4lumcpn4wf6jcuyt@sirius.home.kraxel.org>
References: <20190913122908.784-1-kraxel@redhat.com>
 <20190913122908.784-4-kraxel@redhat.com>
 <CAL_JsqJajCtM=vRgSDX2DQ6iJzDgMHicXgXgGqF7Bc-KdTUUQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJajCtM=vRgSDX2DQ6iJzDgMHicXgXgGqF7Bc-KdTUUQA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 17 Sep 2019 08:18:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 05:07:14PM -0500, Rob Herring wrote:
> On Fri, Sep 13, 2019 at 7:29 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> 
> Version? Pretty sure this is not v1.

Yep, was posted as part of a longer series before.

Splitted the long series into multiple smaller ones by cherry-picking
patches into new branches, which re-started the numbering.

Sorry for the confusion,
  Gerd

