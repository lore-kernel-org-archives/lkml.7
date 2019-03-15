Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768CCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436042077B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="L5W9YNfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfCOLwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:52:09 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:35639 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727441AbfCOLwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:52:05 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 035AB25BE91;
        Fri, 15 Mar 2019 22:52:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1552650723; bh=ypoihoSKZJ+hR6Nh7uYAIM0vzQb9T02TzzKSc2tfLi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5W9YNfIwOWPTjXoPwJk1aGlMGlfNZILkXhPXqgPFthrOLlnN6Qsd8M21MJlc5Rwz
         VWhFy9s/KpO2KxDmXW7Q22eujsc+x7ePqitB2aLwufaQ5n1tzOaj4xaAm3d+6i8Y7x
         pFUtfO0YJ0wobeMQha+9gjHH3zqb9esflF8gKyqk=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 106A79403F2; Fri, 15 Mar 2019 12:52:01 +0100 (CET)
Date:   Fri, 15 Mar 2019 12:52:01 +0100
From:   Simon Horman <horms@verge.net.au>
To:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     linux-renesas-soc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/3] drm: rcar-du: Remove unused prototypes
Message-ID: <20190315115200.zj2zqub3ghjxtpm3@verge.net.au>
References: <20190314220420.32487-1-kieran.bingham+renesas@ideasonboard.com>
 <20190314220420.32487-4-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314220420.32487-4-kieran.bingham+renesas@ideasonboard.com>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 10:04:20PM +0000, Kieran Bingham wrote:
> The CRTC suspend and resume functions have been replaced, but the
> prototypes were not removed.
> 
> Remove the redundant definitions.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

