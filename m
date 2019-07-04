Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD6DC0651F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F18F218AD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 14:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562250313;
	bh=YNYw30ZVRlvSXlhha1iaUul82x3IIo+1lrXf//2abOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q2sBsxGNLlhWI+8umETnel18G+5CtNYpb46PG7SEmFVj9ry2rPsx3uDlkmzcLlumq
	 1PxrpFQ2uIkB716ycsbXcPLUbwXIdeMBgj4Do9TuDlFnBUJCV/YNjoRQ/PJVk5qV0h
	 FCsp5xjEu0yxF3i9nHTYywktsi1fdsE6nEtF3OoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727547AbfGDOZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 10:25:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:43180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbfGDOZL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 10:25:11 -0400
Received: from localhost (unknown [89.205.128.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4967E218A3;
        Thu,  4 Jul 2019 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562250311;
        bh=YNYw30ZVRlvSXlhha1iaUul82x3IIo+1lrXf//2abOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Oo/jkE8+dnGJi+YGHcijQbUniSloC9wglBX3jzYh2paIAa9EoZkw3Gj/OIaBcWY+M
         fXD1BRDIyfGHjlxpDtiKlEr0qiOTxCZ1G2iNkxYeVlbPDU3MOonERZbZUvQECt5TNN
         B/xS/olzhTPXzCvr/2GjMjVKvfcIg4xt4tH/jca0=
Date:   Thu, 4 Jul 2019 16:25:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH 07/11] video: fbdev: wm8505fb: convert platform driver to
 use dev_groups
Message-ID: <20190704142507.GA6281@kroah.com>
References: <20190704084617.3602-1-gregkh@linuxfoundation.org>
 <20190704084617.3602-8-gregkh@linuxfoundation.org>
 <CAHp75Vd7+Kg0paJ-eMNR2_AViW3mYgOCUqqPXS=eT8eY_J6xZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vd7+Kg0paJ-eMNR2_AViW3mYgOCUqqPXS=eT8eY_J6xZA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 04:29:40PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 4, 2019 at 11:47 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Platform drivers now have the option to have the platform core create
> > and remove any needed sysfs attribute files.  So take advantage of that
> > and do not register "by hand" a sysfs file.
> >
> > Cc: Darren Hart <dvhart@infradead.org>
> > Cc: Andy Shevchenko <andy@infradead.org>
> > Cc: platform-driver-x86@vger.kernel.org
> 
> Is it correct Cc list? Looks like a typo to me.

Ugh, wrong mapping of patch to maintainers, my scripts failed me :(

I'll resend this with the proper one, thanks.

greg k-h
