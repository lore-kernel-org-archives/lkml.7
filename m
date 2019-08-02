Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFF2C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655BB20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564729055;
	bh=ffM+LICWllxWJE/vQvAaeiAc+X9tSUkA68IQmo2LQ9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WHrmWpXC1KtLy83nv4QxzThpPwjUmeOnIZEIGn8AhuRvpIlTUrI45UU+mhOdjsUKW
	 t5M2U45HqDA3JYxrvKFBcmlf6oVhCT1pfGmgchs4wLs0zIxvFarS4huV+pnaQLxugz
	 H6hzncmZYY80lt6xlvKSlqmEO2SCNdHrj6A9v50M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbfHBG5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:57:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389177AbfHBG5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:57:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C82FC2086A;
        Fri,  2 Aug 2019 06:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564729052;
        bh=ffM+LICWllxWJE/vQvAaeiAc+X9tSUkA68IQmo2LQ9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fAItImq9S90rX9l+DgsGbTRR+l8aOgIVns7ZwcBkAamUtiBQjgh6/Za1osWY0q23I
         aYBBMz53C9J2HvskmWRFcNgWGgE+V9kj6KVbnQ2GwvB2sVM+W884Bm8B/yqdlp8uCA
         TcTJFAPXluoI+zaj5nOyt7BgxDxEdzs/MgG2LCA8=
Date:   Fri, 2 Aug 2019 08:57:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, security@kernel.org,
        linux-doc@vger.kernel.org, Jiri Kosina <jkosina@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH] Documentation/admin-guide: Embargoed hardware security
 issues
Message-ID: <20190802065729.GA24024@kroah.com>
References: <20190725130113.GA12932@kroah.com>
 <20190802044908.GA12834@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802044908.GA12834@1wt.eu>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 06:49:08AM +0200, Willy Tarreau wrote:
> Hi Greg, Thomas,
> 
> On Thu, Jul 25, 2019 at 03:01:13PM +0200, Greg Kroah-Hartman wrote:
> > +The list is encrypted and email to the list can be sent by either PGP or
> > +S/MIME encrypted and must be signed with the reporter's PGP key or S/MIME
> > +certificate. The list's PGP key and S/MIME certificate are available from
> > +https://www.kernel.org/....
> 
> Just thinking, wouldn't it be useful to strongly encourage that the
> document should be in plain text format ? Otherwise the door remains open
> for sending you a self-extractable EXE file which contains an encrypted
> Word doc, which is not the most useful to handle especially to copy-paste
> mitigation code nor to comment on. Even some occasional PDFs we've seen
> on the sec@k.o list were sometimes quite detailed but less convenient
> than the vast majority of plain text ones, particularly when it comes
> to quoting some parts.

What document are you referring to here?  This just describes how the
encrypted mailing list is going to work, not anything else.

But yes, we have had some "encrypted pdfs" be sent to us recently that
no one can decrypt unless they run Windows or do some really crazy hacks
with the gstreamer pipeline.  But that's separate from this specific
mailing list, we can always just tell people to not do foolish things if
that happens again (like we did in this case.)

thanks,

greg k-h
