Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1902CC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1A72133D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554204459;
	bh=68BAXmoqDha5YNbW5PnT23iUl33id47GIPWvMi1Angw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hlpZxt4z6Xg0qMD+leqC3VYaIm/NMiErd5JGaqf4c0yGnsNcJTwW2MIc9RgBH/wB8
	 wgDHhYgrUTGm5SDJTpDP/Q/oLQgTokksbLYlhUqu+L5CxujohulpltohABTUmIq7iU
	 yILbbl8bIpuyqViczzEnHgZujRpPu5+sp3KOP4b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbfDBL1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbfDBL1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:27:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20C3620856;
        Tue,  2 Apr 2019 11:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554204457;
        bh=68BAXmoqDha5YNbW5PnT23iUl33id47GIPWvMi1Angw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g1GMC1i8PLxcX5DowzgUWGfGVytRJueYiY8uS0ZRgXEznxghnEYjwIcDRgykfzsMf
         H3OyZzLL/37PM5Ii8wsfG56S6PydHj5nzyct4GlTdS5+HvI1qWdSHyef20y45FRhxs
         hRzrU4NCEmq79+6Rz4UuevcYkp7JvAyj1MPMbUfU=
Date:   Tue, 2 Apr 2019 13:27:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        NeilBrown <neil@brown.name>,
        Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Sergej Perschin <ser.perschin@gmail.com>,
        John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 03/16] staging: m57621-mmc: delete driver from the tree.
Message-ID: <20190402112735.GA20395@kroah.com>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-4-gregkh@linuxfoundation.org>
 <CACmrr9hZRiw10dDVcvFUFB7ZFzFq-WfELRXnTLOM_j5LoNnw3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACmrr9hZRiw10dDVcvFUFB7ZFzFq-WfELRXnTLOM_j5LoNnw3A@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:16:47AM -0500, George Hilliard wrote:
> On Tue, Apr 2, 2019, 5:32 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> wrote:
> 
> > The license text in this driver is "interesting" and not really obvious
> > that it is supposed to be able to be distributed in the kernel source
> > tree.  Yes, the MODULE_LICENSE() text says GPL, so it's probably ok, but
> > to be safe, I am deleting this driver.  I will be glad to add it back if
> > the license is properly sorted out, but for now, this isn't worth the
> > potential risk, I should have never taken it in the first place.
> >
> 
> So, for what it's worth, this driver has an obvious heritage of having been
> modified from the main Mediatek MMC driver. Now, of course it's *possible*
> to distribute GPL-incompatible changes to a GPL program, but the only
> *compliant* way to distribute these changes would have been the GPL.
> 
> So there's a very good chance that it's intended to be GPL.  (Which is
> good, because I need this driver!)  I suppose we need to reach out to the
> original contributor.

I agree that the intent is probably GPL, especially given the
MODULE_LICENSE string, and in general how mediatek handles their kernel
code (they properly opensource it all.)  I think that someone got a
little bit "heavy handed" on the comment blocks at the top of all of
these files though, and that is what makes this whole thing questionable
and needs to be addressed.

thanks,

greg k-h
