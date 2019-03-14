Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE78AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A48C12184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 18:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfCNSB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 14:01:26 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:45315 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbfCNSBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 14:01:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 5B84CFB03;
        Thu, 14 Mar 2019 19:01:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Rml9bMno1paS; Thu, 14 Mar 2019 19:01:22 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 77EA74762A; Thu, 14 Mar 2019 19:01:21 +0100 (CET)
Date:   Thu, 14 Mar 2019 19:01:21 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 0/3] drm/panel: Support Rocktech jh057n00900 DSI panel
Message-ID: <20190314180121.GA5220@bogon.m.sigxcpu.org>
References: <cover.1551710977.git.agx@sigxcpu.org>
 <20190304180552.GA12072@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304180552.GA12072@ravnborg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Mar 04, 2019 at 07:05:52PM +0100, Sam Ravnborg wrote:
> Hi Thierry.
> 
> > Changes from v2
> > * As per review comments from Sam Ravnborg
> >   * Lowercase sentinel
> >   * Drop '_panel' postfix
> >   * DRM_DEV_ logging instead of plain DRM_
> > * Add Sam's Reviewed-by:
> > * Add "panel-rocktech-" to the driver name following
> >   the pattern from other drm panel drivers.
> 
> With the changes done in v2 the patch series is IMO
> ready to be applied.

Thanks a lot for the review. Is there anything I can do to get it
applied?
Cheers,
 -- Guido
