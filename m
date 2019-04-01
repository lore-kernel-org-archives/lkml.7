Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25837C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D716F20830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="bJzdkW1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387853AbfDARq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:46:26 -0400
Received: from tomli.me ([153.92.126.73]:32936 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfDARdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:33:25 -0400
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 5c86214b;
        Mon, 1 Apr 2019 17:33:23 +0000 (UTC)
X-HELO: localhost.localdomain
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.localdomain) (2402:f000:1:1501:200:5efe:ddd9:ae88)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 01 Apr 2019 17:33:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=1490979754; bh=zMhlJfN/WwRfvlb2RwxlNCCABgPSZaaCVPuFHxJl/g0=; b=bJzdkW1vc5UeJPYSLsoFZCbX11wWbWJcfvMkgI6WicW3Bv27mzGt56aa8z6R7YPt6p7kQc8zDIjWCqwRXzJA32IhpH1RkjD0szrqDyXinUE0V1e27/M7XJ8ywUaQgnOfiLjP2M28j1gqZsi6l5szWy6BD+kpIDvDZmOzMeSPoGzg8tzOdAPceehJ5OZzlxUOXiVeCBCN7Q+2lzg6+l833DA2AHU8CntEqc0BBorFdedT6LUGX3Jb9R/5l50HRYgKn1X8hPzlFW10iM8BD7PucFyo7ilHSYREG8Dt4n0JVW8k388SZGviaBPs7DtNDpcYeLOiuYz0c8o6/cI7HVZgKw==
Date:   Tue, 2 Apr 2019 01:33:14 +0800
From:   Tom Li <tomli@tomli.me>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-kernel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 6/7] fbdev: sm712fb: Kconfig: add information about
 docs.
Message-ID: <20190401173314.GE15736@localhost.localdomain>
References: <20190322051759.15007-1-tomli@tomli.me>
 <20190322051759.15007-7-tomli@tomli.me>
 <20190331190118.3kaf7erdbk25yd5n@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190331190118.3kaf7erdbk25yd5n@debian>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 08:01:18PM +0100, Sudip Mukherjee wrote:
> On Fri, Mar 22, 2019 at 01:17:58PM +0800, Yifeng Li wrote:
> > @@ -18,9 +18,10 @@ and it was also an inexpensive platform for non-x86 hobbyists to explore.
> >  How to use it?
> >  ==============
> >  
> > -You should not compile-in vesafb, since SM7xx can be used in a VGA
> > -compatible mode, resulting conflicts with this driver. In addition,
> > -the VGA compatible mode was never tested by the maintainers.
> > +SM7xx can be used in a VGA compatible mode and a native framebuffer mode,
> > +this driver is a native driver. By default, it has no problem taking over
> > +the VGA driver automatically, but you should not attempt to use both at
> > +the same time.
> 
> You added this in the documentation with just the previous patch.

Oops, this mistake was introduced during "git rebase", it should have been
squashed into the previous patch, not this one. Thanks for spotting it.

> > -	* 2D acceleration on SM720 and Big-Endian CPUs.
> > +	* 2D acceleration on Big-Endian CPUs.
> >  	* More VGA modes.
> >  	* dual-head support
> >  	* hardware cursor support
> 
> You might want to squash the two patches for documentation instead of
> having a separate patch to fix what you added in a previous patch.

Same as above, it will be fixed in PATCH v3.

Thanks,
Tom Li
