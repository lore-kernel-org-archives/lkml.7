Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967D1C3A59C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5952E2133F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565903067;
	bh=NNekQusaEPP5YPk53Rxg5OC3GdiRn8lGF9xopo7eZIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kKsEx6KWKHBub0gt+2bJrHbrwNVh9AR7LYEKi3rIV3hYSVQegsHj5BCQ8gfckQ9at
	 txC3+QD805E2zZ+2zc5DwhbalqKWBIictRR2dGDnWhgKmCQ0NfbQA79dlu/bpZ+BhY
	 oxP+P/baVomt/fF+XX7h4hhg5MoQZDhZv/pjumeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733118AbfHOVEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733090AbfHOVEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:04:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A27A22063F;
        Thu, 15 Aug 2019 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565903063;
        bh=NNekQusaEPP5YPk53Rxg5OC3GdiRn8lGF9xopo7eZIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ciLYl7u9ipJ7DsIf3xV/9jK89JpQEv5tzAAn7FX0GZMJqyiO7gk+CKuKuRXQSUlWX
         nt5bP2O6S+xImvSCQPStYL8Rjg0FPSNfKlYaGG5Je3RXTnkrbW2le5HKg74l8QVq09
         WwoqMjObF3zUfpviodqHoGLcuY8JQZj9wdA9vMV0=
Date:   Thu, 15 Aug 2019 23:04:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        security@kernel.org, linux-doc@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
Message-ID: <20190815210420.GA12041@kroah.com>
References: <20190725130113.GA12932@kroah.com>
 <nycvar.YFH.7.76.1908040214090.5899@cbobk.fhfr.pm>
 <20190805151244.GA28296@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805151244.GA28296@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 05, 2019 at 05:12:44PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Aug 04, 2019 at 02:17:00AM +0200, Jiri Kosina wrote:
> > On Thu, 25 Jul 2019, Greg Kroah-Hartman wrote:
> > 
> > > To address the requirements of embargoed hardware issues, like Meltdown,
> > > Spectre, L1TF, etc. it is necessary to define and document a process for
> > > handling embargoed hardware security issues.
> > 
> > I don't know what exactly went wrong, but there is a much more up-to-date 
> > version of that document (especially when it comes to vendor contacts), 
> > which I sent around on Thu, 2 May 2019 20:23:48 +0200 (CEST) already. 
> > Please find it below.
> 
> Ah, sorry, don't know what happened here, we had too many different
> versions floating around.
> 
> I'll take your version, make the edits recommended and send out a new
> one in a few days, thanks!

Looks like your version only had the difference being the list of
ambassadors and a bunch of people who reviewed the document.  No
text changes in the document itself, which was good to see we all agreed
on the correct wording  :)

thanks,

greg k-h
