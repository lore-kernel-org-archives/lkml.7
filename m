Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C12C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E00B206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 16:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567786462;
	bh=y9GtgGOwH4vNznSBvTW2uCxaFQvMH+B7QogTOs4ApYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TclZ3mNT4hRlKqDiCHujp2yZgg6LknDdu22MSOB5VI+BjU0kmn6gB/5GynVVywHxZ
	 eFl4zurCiVsTXy68kDT7IJBuxPzn07RZZ1JTl99jhNtwiO6kC7K4Zc3zH7EviUj/Ud
	 PseOr23rmtryLQk1UE7fK1I9TN3ukDetlXKr+S4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfIFQOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 12:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfIFQOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 12:14:21 -0400
Received: from localhost (unknown [89.248.140.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A2E22070C;
        Fri,  6 Sep 2019 16:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567786460;
        bh=y9GtgGOwH4vNznSBvTW2uCxaFQvMH+B7QogTOs4ApYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgK5JZzN0AcN+e3U9Mhn4Mz8GrRDto16mnkATSBxONcuQuo+4bNEbxTtjZPOQIY1D
         OGKmOxwofC5NqU4nxi2ETXx8uIARC0cu5oEqQWMdI7JXlzKaVTxFnaB6MztepULli+
         fQ7O/+fojkd3lyeR/uwWbsszmCDqPVgOJnXP9wMk=
Date:   Fri, 6 Sep 2019 18:13:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Sasha Levin <sashal@kernel.org>, tglx@linutronix.de,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.wilk@oracle.com, jkosina@suse.cz, tyhicks@canonical.com,
        linux-kernel@microsoft.com,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH] Documentation/process/embargoed-hardware-issues:
 Microsoft ambassador
Message-ID: <20190906161333.GB10547@kroah.com>
References: <20190906095852.23568-1-sashal@kernel.org>
 <20190906085728.15af96c3@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906085728.15af96c3@lwn.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 08:57:28AM -0600, Jonathan Corbet wrote:
> On Fri,  6 Sep 2019 05:58:52 -0400
> Sasha Levin <sashal@kernel.org> wrote:
> 
> > Add Sasha Levin as Microsoft's process ambassador.
> > 
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >  Documentation/process/embargoed-hardware-issues.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/process/embargoed-hardware-issues.rst b/Documentation/process/embargoed-hardware-issues.rst
> > index d37cbc502936d..9a92ccdbce74e 100644
> > --- a/Documentation/process/embargoed-hardware-issues.rst
> > +++ b/Documentation/process/embargoed-hardware-issues.rst
> > @@ -219,7 +219,7 @@ an involved disclosed party. The current ambassadors list:
> >    Intel
> >    Qualcomm
> >  
> > -  Microsoft
> > +  Microsoft	Sasha Levin <sashal@kernel.org>
> >    VMware
> >    XEN
> 
> This document went upstream via Greg's tree, so updates are awkward for
> me to apply without having to explain a late backmerge to Linus.  I can
> hold them until after the merge window, unless you (Greg) would like to
> take them sooner?

I already have 3 of these queued up in my tree to go to Linus in the
next few days, so no need to worry about them.

thanks,

greg k-h
