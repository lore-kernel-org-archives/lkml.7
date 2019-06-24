Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8C7C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9942A20665
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="ez2ClL82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfFXU27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:28:59 -0400
Received: from vps.xff.cz ([195.181.215.36]:55264 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfFXU26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1561408136; bh=ebij2iMd2+jfNT2RnrG0rfsvu6bgvrUaIhcBD+2uT8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ez2ClL820tax9ruDyvFd7tjrHWXeaFMT3WQ70YRkAuZXuooYJaI0bHitWPVD4PtYk
         crqCMMgvP5GhR51NkheM4lNM8F0KrnDcTmtkA5LgSRKjeMhAxcb0fGDyr5mOsWO3XB
         s/6tcRDgFEoJpxyemaGnaucncUPtp060iDqxi4N0=
Date:   Mon, 24 Jun 2019 22:28:56 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com,
        wens@csie.org, robh+dt@kernel.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v7 0/6] Add support for Orange Pi 3
Message-ID: <20190624202856.ij4ujey2z6j5doxj@core.my.home>
Mail-Followup-To: David Miller <davem@davemloft.net>,
        linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com,
        wens@csie.org, robh+dt@kernel.org, jernej.skrabec@gmail.com,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20190620134748.17866-1-megous@megous.com>
 <20190624.102927.1268781741493594465.davem@davemloft.net>
 <20190624174637.6sznc5ifiuh4c3sm@core.my.home>
 <20190624.132456.2013417744691373807.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190624.132456.2013417744691373807.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 01:24:56PM -0700, David Miller wrote:
> From: Ondřej Jirman <megous@megous.com>
> Date: Mon, 24 Jun 2019 19:46:37 +0200
> 
> > This series was even longer before, with patches all around for various
> > maintainers. I'd expect that relevant maintainers pick the range of patches
> > meant for them. I don't know who's exactly responsible for what, but I think,
> > this should work:
> > 
> > - 2 stmmac patches should go together via some networking tree (is there
> >   something specific for stmmac?)
> > - all DTS patches should go via sunxi
> > - hdmi patches via some drm tree
> 
> Thank you.  So I'll merge the first two patches that touch the stmmac
> driver via my net-next tree.

Thank you.

regards,
	Ondrej
