Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC47CC2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 939F7214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576150691;
	bh=S1M0KtjHw82A46F/D4PJWuBCORKMxuz3V+WpTuJyyPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0E9kOFXph4LVnYnRA/JcqSoPMqEeM2xJjWKRKi9isylZrsfT2gokqSKiZO7a1tmEJ
	 FPNRyvQ2K7ndTvKt230TkkuqvQP4TAjB+oA9Dj16LrovrCGmL0ZDLQz5FZzT9Lah+g
	 MhAq7C6NpungU1Q7Yh7RK0OELZhm5RgmxbJfSJGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfLLLiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728501AbfLLLiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:38:10 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 038B320663;
        Thu, 12 Dec 2019 11:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576150689;
        bh=S1M0KtjHw82A46F/D4PJWuBCORKMxuz3V+WpTuJyyPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cd1nV5t7BeCIvOOeH8taeW+En+NnXmlbgU0Mc/G3z5YVLTfoJqRailVAlGmrODSjP
         Vd+MCKHyTpvoVficswk260Cq8hBApzEJ0tMVGp/N+/W9cLuuujGri1sIuD0WJY5Ia+
         BxHaoFHggmZ0JTxPjcVT46IQK4CzFGVXcDmJiuVQ=
Date:   Thu, 12 Dec 2019 19:37:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20191212113753.GI15858@dragon>
References: <20191212083556.1b98ece7@canb.auug.org.au>
 <20191212013323.GZ15858@dragon>
 <7e13626ae46b6241549e33c983695bed316e9a6f.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e13626ae46b6241549e33c983695bed316e9a6f.camel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 10:45:34AM +0100, Lucas Stach wrote:
> Hi Shawn,
> 
> On Do, 2019-12-12 at 09:33 +0800, Shawn Guo wrote:
> > Hi Stephen,
> > 
> > On Thu, Dec 12, 2019 at 08:35:56AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the imx-mxs tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > 
> > Sorry for the breakage.
> > 
> [...]
> > > The warning was (probably) introduced by commit
> > > 
> > >   e79295edf1df ("ARM: dts: imx6: RDU2: link eDP bridge to panel")
> > 
> > I have just taken these two commits out.
> 
> The commit message of this change should maybe have been clearer, but
> the warning is expected. The bootloader fixes the DT before passing it
> on to Linux by completing the other direction of link if eDP is
> enabled.
> 
> How do we want to handle this? If you totally dislike the warning I can
> get around it

Yes, please.  I do not like the warning.

Shawn
