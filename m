Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A9FC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE832084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561099228;
	bh=Zfa1992xQy1PpHPZtZsq8tisQMOVhaEUB6rRbcZKniQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WwdqX9TvEl07HQGuqHOZRFcrLtIj/uO8TSfL96tW0ljyKk1KvjYsWrQ/VzUZFRpiC
	 UmXrwXof2Xe4cn5vV/2yvPkrIaQitwv9rZVLSW2PYZ/qg+K9JpjTIyG8op6O0CI0ea
	 NIRREZYMsOVeUkFul8zuzTjgx59hDB5qzl3uaNi4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfFUGkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 02:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfFUGkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 02:40:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23B932084E;
        Fri, 21 Jun 2019 06:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561099221;
        bh=Zfa1992xQy1PpHPZtZsq8tisQMOVhaEUB6rRbcZKniQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWBC0/f0lztuSe71p5Gb74hYWJ/JwLGRfB2p8mO3HbieOba6bwGAdNW73mpesrE02
         dkANIHfJzu5TNNbN8TqBqA6KhMXHXU8kFPKtCcWzNbTntBGu41QVxugU6jRyguIx93
         h8GpSkLPPmJny8cNsngp9K1t5A4op6RyXK5EzXxU=
Date:   Fri, 21 Jun 2019 08:40:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] PHY: for 5.2-rc
Message-ID: <20190621064019.GA12643@kroah.com>
References: <20190612102803.25398-1-kishon@ti.com>
 <3c16d177-adb3-5c42-7e90-49ddae9723cb@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c16d177-adb3-5c42-7e90-49ddae9723cb@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 11:41:26AM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> On 12/06/19 3:57 PM, Kishon Vijay Abraham I wrote:
> > Hi Greg,
> > 
> > Please find the updated pull request for 5.2 -rc cycle. Here I dropped
> > the patch that added "static" for a function to fix sparse warning.
> > 
> > I'm also sending the patches along with this pull request in case you'd
> > like to look them.
> > 
> > Consider merging it in this -rc cycle and let me know if you want me
> > to make any further changes.
> 
> Are you planning to merge this?

Ugh, fell through the cracks of my huge TODO mbox at the moment, sorry.
It's still there, should get to it next week...

thanks,

greg k-h
