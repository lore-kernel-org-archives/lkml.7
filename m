Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A82C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE69A20673
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 17:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfFURm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 13:42:26 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:33016 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfFURm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 13:42:26 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 4044F20020;
        Fri, 21 Jun 2019 19:42:22 +0200 (CEST)
Date:   Fri, 21 Jun 2019 19:42:15 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, thierry.reding@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] MSM8998 MTP Display
Message-ID: <20190621174215.GA16409@ravnborg.org>
References: <20190614185547.34518-1-jeffrey.l.hugo@gmail.com>
 <CAOCk7NoaP=DkNLgdiUw5M0JYRGEGGCFQkn1sCO9dqtexMPC9dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOCk7NoaP=DkNLgdiUw5M0JYRGEGGCFQkn1sCO9dqtexMPC9dQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8
        a=_aGGFSCzEicpxybLgu0A:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey.

On Fri, Jun 21, 2019 at 11:31:50AM -0600, Jeffrey Hugo wrote:
> On Fri, Jun 14, 2019 at 12:55 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
> >
> > Since we are trying to get the GPU and display hardware in the SoC
> > supported, it would be nice to be able to put the output on the
> > integrated panel for the reference platform.  To do so, we need support
> > in the Truly driver to support the specific panel variant for the
> > MSM8998 MTP.  This series adds taht support.
> >
> > Jeffrey Hugo (2):
> >   dt-bindings: display: truly: Add MSM8998 MTP panel
> >   drm/panel: truly: Add MSM8998 MTP support
> 
> Lets actually hold off on this series.  I thought I could solve an
> issue in the DSI driver, but thats not working out like how I'd hoped.
> I may need to rework this.

Thanks for the heads up, and good luck with it.
Despite the missing response on this patchset please do not hesitate
to post an updated version or another patchset in the future.

	Sam
