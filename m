Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A84C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB435233A1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 10:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567591224;
	bh=5/PwM0o9LxuZZilmoCSNsDGRTChIxEaGEQJWKTq/Ovo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vth0jeJQsVXnWTEIx0dd0C5IM4YjsfYv1idsrGC8KsdX+LK5PF2x8OWvtG6JmA/Kj
	 HjFEurt3dGEaD3bAMQIOrOZHNSiia1IIdre0cnExfenP6w8SIEZOmAz6Vt+oAfvH1N
	 P7I7ry1pIEbEEhqVG7XaWgvGHivw9wq8oN0XKovQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfIDKAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 06:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfIDKAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 06:00:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BDF22339E;
        Wed,  4 Sep 2019 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567591222;
        bh=5/PwM0o9LxuZZilmoCSNsDGRTChIxEaGEQJWKTq/Ovo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CttzYDrc/HgLAawFgOF7jarM0w81UzFv/BYjyhyDLd9zvBaCPRKGM54u+vcZriMko
         Od3dVg8FVFMRVcmduv12ZFc0LRw91t1dGxJnrrSZwt2RozlEhADlAIdi2qXzI56PcT
         49C0lSZeUNjLcr6khk8wn8Cf0FALXuknQHyPHohI=
Date:   Wed, 4 Sep 2019 12:00:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: usb dma_mask fixups
Message-ID: <20190904100019.GA9615@kroah.com>
References: <20190903084615.19161-1-hch@lst.de>
 <20190903131648.GA19335@kroah.com>
 <20190904085736.GH26880@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904085736.GH26880@dell>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:57:36AM +0100, Lee Jones wrote:
> On Tue, 03 Sep 2019, Greg Kroah-Hartman wrote:
> 
> > On Tue, Sep 03, 2019 at 10:46:09AM +0200, Christoph Hellwig wrote:
> > > Hi all,
> > > 
> > > the first patch fixes the ohci-sm501 regression that Guenther reported
> > > due to the platform device dma_mask changes.  The second one ports that
> > > fix to another driver that works the same way.  The rest cleans up
> > > various loose ends left over from the dma related usb changes in the
> > > last two merge windows.
> > 
> > Thanks for these, all now queued up.
> 
> Did you queue the MFD patch too?
> 
> If so (and you can rebase ;) ), please feel free to add my:
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> If not, no sweat.

I already applied it, and no, sorry, I can't rebase.  But thanks for the
review!

greg k-h
