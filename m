Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C53C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A4A215F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 01:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="t9GPUKIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfK1Bu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:50:58 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:41174 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbfK1Bu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 20:50:58 -0500
Received: from pendragon.ideasonboard.com (unknown [104.132.253.101])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AB0FF4FF;
        Thu, 28 Nov 2019 02:50:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1574905855;
        bh=UZ6ggFBgzZuX2+D3oNGNdZPRR6WVAycMBJ8RY8d+ymk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9GPUKIeQrjeJLIeZS9jGzPqGzY99zDh5ccnMwPkF4WJde46R2sSURIlzPlFwwT48
         Hmo2GJF3DMoVkpgbKXEtZ0P3yZIzekR8hCmCiVGnfzJb6XJRe6aJk/RdR7EFGbsOik
         scbNW64T2s0//DvmZ4j3rCEm8uADY6iCPIa33ZB4=
Date:   Thu, 28 Nov 2019 03:50:45 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Simon Horman <horms@verge.net.au>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 2/7] dt-bindings: display, renesas,du: Document cmms
 property
Message-ID: <20191128015045.GA13942@pendragon.ideasonboard.com>
References: <20191113100556.15616-1-jacopo+renesas@jmondi.org>
 <20191113100556.15616-3-jacopo+renesas@jmondi.org>
 <CAMuHMdWAvFfL5gWZVkfan=o2pRygxCKaNwCf=7AbiPJS1r8nAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdWAvFfL5gWZVkfan=o2pRygxCKaNwCf=7AbiPJS1r8nAA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 02:34:27PM +0100, Geert Uytterhoeven wrote:
> Hi Jacopo,
> 
> Sorry for spoiling your v7 ;-)
> 
> On Wed, Nov 13, 2019 at 11:04 AM Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Document the newly added 'cmms' property which accepts a list of phandle
> 
> renesas,cmms

Fix applied to my branch.

> > and channel index pairs that point to the CMM units available for each
> > Display Unit output video channel.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

-- 
Regards,

Laurent Pinchart
