Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B566C06508
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFADE2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405122AbfFKPhF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:37:05 -0400
Received: from ms.lwn.net ([45.79.88.28]:51262 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405101AbfFKPhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:37:03 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id A356C382;
        Tue, 11 Jun 2019 15:37:02 +0000 (UTC)
Date:   Tue, 11 Jun 2019 09:37:01 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 33/33] docs: EDID/HOWTO.txt: convert it and rename to
 howto.rst
Message-ID: <20190611093701.44344d00@lwn.net>
In-Reply-To: <20190611060215.232af2bb@coco.lan>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
        <74bec0b5b7c32c8d84adbaf9ff208803475198e5.1560045490.git.mchehab+samsung@kernel.org>
        <20190611083731.GS21222@phenom.ffwll.local>
        <20190611060215.232af2bb@coco.lan>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2019 06:02:15 -0300
Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> Jon, please correct me if I' wrong, bu I guess the plan is to place them 
> somewhere under Documentation/admin-guide/.

That makes sense to me.

> If so, perhaps creating a Documentation/admin-guide/drm dir there and 
> place docs like EDID/HOWTO.txt, svga.txt, etc would work.

Maybe "graphics" or "display" rather than "drm", which may not entirely
applicable to all of those docs or as familiar to all admins?

> Btw, that's one of the reasons[1] why I opted to keep the files where they
> are: properly organizing the converted documents call for such kind
> of discussions. On my experience, discussing names and directory locations
> can generate warm discussions and take a lot of time to reach consensus.

Moving docs is a pain; my life would certainly be easier if I were happy
to just let everything lie where it fell :)  But it's far from the hardest
problem we solve in kernel development, I assume we can figure it out.

Thanks,

jon
