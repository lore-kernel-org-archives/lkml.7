Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813E7C49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A9C20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568217003;
	bh=kXtkziQGWXBOfL538EtmdmNIZTcvB4FwDAz/sAqRLiY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=14WLJv+ggT4eu+kMNve8s2b6LPL+uUbBjUN04+SSkacxTPuIVLf13hdZtzNCSDD/B
	 n9FrP+WPcKms3KVnsLgIiQyKZdM7BEha4rNZaskQlMdZTdmAtS/guGSOFabHrWZQoq
	 1DG5VNO+wueXaEYZQYggp+TTV5BcFtMgUZrv/mYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfIKPuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 11:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:50036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728722AbfIKPuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 11:50:02 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 143252089F;
        Wed, 11 Sep 2019 15:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568217001;
        bh=kXtkziQGWXBOfL538EtmdmNIZTcvB4FwDAz/sAqRLiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lrKcxFNqtHhOmQ3jDbNmnZufE+8VqY6xFiROzEjnQrkk3u0By8egoiAeLUyYtmhIO
         rSd6YGBOsMbAcZi4r+XlEKP8OcWhotLOc4DBs8THEUA/uea5Wnmg9Q2oubWodnI63L
         mn3S4TZyVg0txz4wIU71FfAlf9+pA58G5DitvWaE=
Date:   Wed, 11 Sep 2019 16:49:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, sashal@kernel.org,
        ben@decadent.org.uk, tglx@linutronix.de, labbott@redhat.com,
        andrew.cooper3@citrix.com, tsoni@codeaurora.org,
        keescook@chromium.org, tony.luck@intel.com,
        linux-doc@vger.kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 3/4] Documentation/process: soften language around
 conference talk dates
Message-ID: <20190911154958.GB14152@kroah.com>
References: <20190910172644.4D2CDF0A@viggo.jf.intel.com>
 <20190910172651.D9F5C062@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910172651.D9F5C062@viggo.jf.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:26:51AM -0700, Dave Hansen wrote:
> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Both hardware companies and the kernel community prefer coordinated
> disclosure to the alternatives.  It is also obvious that sitting on
> ready-to-go mitigations for months is not so nice for kernel
> maintainers.
> 
> I want to ensure that the patched text can not be read as "the kernel
> does not wait for conference dates".  I'm also fairly sure that, so
> far, we *have* waited for a number of conference dates.

We have been "forced" to wait for conference dates.  That is much
different from what we are saying here (i.e. we do NOT want to have to
wait for that type of thing as that causes us all real work that is a
total waste of engineering effort.)

> Change the text to make it clear that waiting for conference dates
> is possible, but keep the grumbling about it being a burden.

I don't think we want that, waiting for long periods of time like we
have been (and are currently) is a royal pain.  We are glad to take
these on a case-by-case basis, but doing delays for no other reason than
a specific conference date 6 months in the future when we have fixes now
benifits no one at all, and in fact HURTS everyone involved, including
our users the most.

> While I think this is good for everyone, this patch represents my
> personal opinion and not that of my employer.

I appreciate the disclaimer :)

I know Thomas and others are totally busy with Plumbers right now (as am
I), so I'll hold on to this and your next patch in my "to-review" queue
to give others a chance to weigh in on the tweaks to see if anyone
disagrees with my comments above.

thanks,

greg k-h
