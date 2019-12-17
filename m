Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71223C2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4855524655
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576592856;
	bh=iZjkgq9/QmKBzabYzEZ/ruigHyZa9DwU98Twta3Vnrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N+XaIxzkJwvmCUnfmlwl0kd/gigA1+SUU6TfSF6dGd/yU2TuZaUFkNdwCAxhqB2q4
	 JZWrn0sVjDOZ48n1LAlfNZQjJXniVJOpPa5HAKVhQWRaT2XwDC+VuhVQoBEDNuQM34
	 GI83ZGKfZ01XHAuNvXgFn8ZAOY6icsAWMAl1UdQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbfLQO1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 09:27:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:59228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728903AbfLQO1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 09:27:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D8EC2176D;
        Tue, 17 Dec 2019 14:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576592854;
        bh=iZjkgq9/QmKBzabYzEZ/ruigHyZa9DwU98Twta3Vnrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XK8NM9wu1K1zy/gtOgOZY3rLP5S2GkedSGfmoOogGp6rfywsQMjNsPKggRlzAY87K
         CLSLm8eqe7Xb4oMnOJnx3oWs8vWB9/LY8GEW+Rc5VCYZp487Vt5p1YN+xAEzfXr7mt
         TS+2v8MVPb7OLiQNfxYNlWEqeBtZziLpm5AIvw+4=
Date:   Tue, 17 Dec 2019 15:27:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 54/58] serial_core: Remove SUPPORT_SYSRQ ifdeffery
Message-ID: <20191217142732.GA3623513@kroah.com>
References: <20191213000657.931618-1-dima@arista.com>
 <20191213000657.931618-55-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213000657.931618-55-dima@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2019 at 12:06:53AM +0000, Dmitry Safonov wrote:
> No one defines it anymore.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/serial_core.h | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

I've applied this series up to here, skipping the usb-serial driver
patch that Johan called out.

Can you rebase your series and resend the remaining based on my tty-next
tree, after these patches move there (give them 24 hours to get through
0-day testing.)

thanks,

greg k-h
