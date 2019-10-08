Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F5AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E283420815
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570547753;
	bh=14pGX9PvbF+akybdQEtzMfsaYMZBPxv3t73fc4rSR1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lskElpdCbaYJKlUYCWse7NntSfSgfvgHJEfSMNS4+hybl3g65W6mrIlvKPxsTU1hD
	 HyVSJvHIUPIh8dexlNvkiiGMXJmcOGmaT/knWX5DoZJOBAn0AwMPuttwsryJdaVx+4
	 Rzge+/20oNPF3M0YkH+PV2HVbuCzDkgGIuZ+QtJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfJHPPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfJHPPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:15:51 -0400
Received: from localhost (unknown [89.205.136.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17ED20679;
        Tue,  8 Oct 2019 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570547751;
        bh=14pGX9PvbF+akybdQEtzMfsaYMZBPxv3t73fc4rSR1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dD0f4/Z5w+0yDxR21yp+DBWrDToCk0WdffreftjEXgmXWBmbOGKpMREZAX8+0CUC5
         v2DPKAbAyvHTJyNq4Kw8+v/wgKwA8I5FELERJD97xvmb4FEYc2TvWQHc2zquFVl923
         G5CZH3Bgwdd2iA2v4L7suNTZzttz8DbGtJ90luLc=
Date:   Tue, 8 Oct 2019 17:15:47 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Matteo Croce <mcroce@redhat.com>, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Anholt <eric@anholt.net>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH] staging: vchiq: don't leak kernel address
Message-ID: <20191008151547.GA2864822@kroah.com>
References: <20191008123346.3931-1-mcroce@redhat.com>
 <20191008131518.GH25098@kadam>
 <CAGnkfhxefH+3YKDWQMCOYoj1skcq6rUmHuiHZQ-76YixFqbQjg@mail.gmail.com>
 <20191008142517.GO21515@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008142517.GO21515@kadam>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 05:25:17PM +0300, Dan Carpenter wrote:
> On Tue, Oct 08, 2019 at 04:21:54PM +0200, Matteo Croce wrote:
> > On Tue, Oct 8, 2019 at 3:16 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > The subject doesn't match the patch.  It should just be "remove useless
> > > printk".
> > >
> > > regards,
> > > dan carpenter
> > >
> > 
> > Well, it avoids leaking an address by removing an useless printk.
> > It seems that GKH already picked the patch in his staging tree, but
> > I'm fine with both subjects, really,
> 
> The address wasn't leaked because it was already %pK.  The subject
> says there is an info leak security problem, when the opposite is true.

I've edited the subject line now.

thanks,

greg k-h
