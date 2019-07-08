Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18687C606C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E722A21479
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 17:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562606154;
	bh=Kqv2Ui7O5cUGL9J6mkg9AMIciu2U6pD5nvGQlDoz+As=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dJH+9OrP0LbP6Nn7YcBvswt7c2Geiv0INYfJ6caORoIoq6X5CB7OkqOTU2JT1x4tL
	 0y8M6fBbqKm8VpAHGKPgigi+3rCLMcZr8OM4Q2emowos0GWEavsfC8pS4UvKnbzvDp
	 4DIF0cTGaKyIL13MBdDkPyMR3016/KPfnx96rJeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732434AbfGHRPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 13:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727373AbfGHRPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 13:15:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D2721479;
        Mon,  8 Jul 2019 17:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562606149;
        bh=Kqv2Ui7O5cUGL9J6mkg9AMIciu2U6pD5nvGQlDoz+As=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rxs57saZcKQwk+qOA7j1lnrbjw1GjQ52hlIfFX9u7wQWpwhtAcCI0R0VJTVd1bzp1
         CeZuwdk0P/enR9x29GH8BH3/Liz+SVAdouwcdHSAiCNrVlRTTYUa9AXWXsv7sHd/bH
         5eT83pR5u6/Dgt2XtD+A2J1uCUxi03VvbWZdXxOI=
Date:   Mon, 8 Jul 2019 17:16:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, mchehab@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: usb: convert usb-help to rst
Message-ID: <20190708151605.GA14040@kroah.com>
References: <20190705185519.31033-1-tranmanphong@gmail.com>
 <20190708075255.0f337b28@lwn.net>
 <CAD3AR6EN7n5KXnJqW0UdgB_eQjuTedB6KdC8sJ_h+MJNKB6ZmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD3AR6EN7n5KXnJqW0UdgB_eQjuTedB6KdC8sJ_h+MJNKB6ZmA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 10:01:13PM +0700, Phong Tran wrote:
> On Mon, Jul 8, 2019 at 8:52 PM Jonathan Corbet <corbet@lwn.net> wrote:
> >
> > On Sat,  6 Jul 2019 01:55:19 +0700
> > Phong Tran <tranmanphong@gmail.com> wrote:
> >
> > > Add new index.rst and change usb-help.txt format
> > > to rst.
> > >
> > > Signed-off-by: Phong Tran <tranmanphong@gmail.com>
> >
> > Thank you for working to make the kernel's documentation better.  That
> > said, I really don't think there is value in keeping this document.  It
> > hasn't been updated in any useful way in decades, contains broken links,
> > and the links that still work are full of obsolete information.  Honestly,
> > a better patch would, IMO, just delete this file.
> >
> @Jonathan Corbet  it's fine to me.
> 
> Need ack from you @Greg Kroah-Hartman
> if yes, I will send the cleanup patch.

All of the USB documentation needs a refresh and look again at where it
is and what it contains.  After 5.3-rc1 I would recommend doing that (as
that is when all of the recent pending documentation changes will be
merged).

thanks,

greg k-h
