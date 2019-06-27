Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9BAC48BD7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878042064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 17:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbfF0RbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 13:31:25 -0400
Received: from ms.lwn.net ([45.79.88.28]:56912 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfF0RbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 13:31:24 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F0B2C537;
        Thu, 27 Jun 2019 17:31:23 +0000 (UTC)
Date:   Thu, 27 Jun 2019 11:31:22 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: fix a reference for a renamed file: fb/modedb.rst
Message-ID: <20190627113122.34b46ee2@lwn.net>
In-Reply-To: <20190626212735.GY12905@phenom.ffwll.local>
References: <699d7618720e2808f9aa094a13ab2f3545c3c25c.1561565652.git.mchehab+samsung@kernel.org>
        <20190626212735.GY12905@phenom.ffwll.local>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jun 2019 23:27:35 +0200
Daniel Vetter <daniel@ffwll.ch> wrote:

> On Wed, Jun 26, 2019 at 01:14:13PM -0300, Mauro Carvalho Chehab wrote:
> > Due to two patches being applied about the same time, the
> > reference for modedb.rst file got wrong:
> > 
> > 	Documentation/fb/modedb.txt is now Documentation/fb/modedb.rst.
> > 
> > Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the commandline")
> > Fixes: ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> What's the merge plan here? doc-next? If so:
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

It doesn't really apply to docs-next, so that's probably not the best
path unless I hold it until after the merge window.  Seems like it needs
to go through the DRM tree to me.

Thanks,

jon
