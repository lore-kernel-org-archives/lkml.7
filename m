Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE62C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA752184D
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfH0Q7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:59:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:46366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbfH0Q7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:59:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B88072173E;
        Tue, 27 Aug 2019 16:59:50 +0000 (UTC)
Date:   Tue, 27 Aug 2019 18:59:48 +0200
From:   Greg KH <greg@kroah.com>
To:     Rui Miguel Silva <rmfrfs@gmail.com>
Cc:     driverdev-devel@linuxdriverproject.org, devel@driverdev.osuosl.org,
        elder@kernel.org, johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 0/9] staging: move greybus core out of staging
Message-ID: <20190827165948.GA16855@kroah.com>
References: <20190825055429.18547-1-gregkh@linuxfoundation.org>
 <20190827133611.GE23584@kadam>
 <20190827134557.GA25038@kroah.com>
 <m3d0gqisua.fsf@gmail.com>
 <20190827154308.GD534@kroah.com>
 <m3blwaiotb.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3blwaiotb.fsf@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2019 at 04:57:20PM +0100, Rui Miguel Silva wrote:
> Hi Greg,
> On Tue 27 Aug 2019 at 16:43, Greg KH wrote:
> > On Tue, Aug 27, 2019 at 03:30:21PM +0100, Rui Miguel Silva wrote:
> >> Hi,
> >> On Tue 27 Aug 2019 at 14:45, Greg Kroah-Hartman wrote:
> >> > On Tue, Aug 27, 2019 at 04:36:11PM +0300, Dan Carpenter wrote:
> >> >> I can't compile greybus so it's hard to run Smatch on it...  I have a
> >> >> Smatch thing which ignores missing includes and just tries its best.
> >> >> It mostly generates garbage output but a couple of these look like
> >> >> potential issues:
> >> >
> >> > Why can't you compile the code?
> >> >
> >>
> >> I think we are missing includes in some of the
> >> greybus header files.
> >
> > Really?  Where?  Builds fine here and passes 0-day :)
> >
> 
> Yeah; just sent a patch to fix it.

Thanks, now merged!

greg k-h
