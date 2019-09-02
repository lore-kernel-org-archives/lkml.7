Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A10C3A5A8
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 06:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C6E233A2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 06:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567405881;
	bh=JpTBi+eqAB/T+NTDsWWgLTDY5Ffz4YYHHFLG5df3oMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OyvTuLleshwtXDFgvjn8zGEcVLrQ4vVSKIC2xRcqgURAIOAhmtuT9+K+jfsLOPhd+
	 /yyZ1AkO2GhZF8OZmjBQABxXskl0u9lPyO6tUv5x/O3STBo1k7mDBepdPdNi27Wm0D
	 +/JV7Y4HWmdn++8ycHsHsgDW2bHVE9MY2jDsYsF8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfIBGbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 02:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbfIBGbU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 02:31:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D65822D6D;
        Mon,  2 Sep 2019 06:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567405879;
        bh=JpTBi+eqAB/T+NTDsWWgLTDY5Ffz4YYHHFLG5df3oMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHuftYoYVuHOa6eTJX7Kljn/f7DDv9+fdE1kDsJY/yFSPZsTzCkEzqnVlcIa9c4JJ
         pDwBQhFfVx/0bw2rull/aVJW5RYna3H5iuifBvk4I1vm++tr86ZNrutGW5LN9EVg7N
         QzaVV9dK0bl9oU4JJzJTlJi9ZA6edtNZwWy2wQqg=
Date:   Mon, 2 Sep 2019 08:31:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] staging: move greybus core out of staging
Message-ID: <20190902063117.GA10402@kroah.com>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190901172303.GA1005@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901172303.GA1005@bug>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2019 at 07:23:03PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The Greybus code has long been "stable" but was living in the
> > drivers/staging/ directory to see if there really was going to be
> > devices using this protocol over the long-term.  With the success of
> > millions of phones with this hardware and code in it, and the recent
> 
> So, what phones do have this, for example?

The Motorola Z line, all of the "Moto Mods" use this interface to
communicate.

> Does that mean that there's large choice of phones well supported by the
> mainline?

I have no idea what kernel version they use, you will have to talk to
Motorola about that.

greg k-h
