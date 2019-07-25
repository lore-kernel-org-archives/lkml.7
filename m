Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7071BC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E8E22CB8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564064499;
	bh=pxReWaEST95lk565mK1Mw+8MWIZHmNlYX5ldtarOjvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mao2w9j05Bs23hCvwIK3OEQld5CfskCVMfv2Ebwdtsbsqz93Naez8kPQJimszovC2
	 10rF4zAqOjdUKhSvNImVQ/H5JXlURa8rHnx/LuSgegkb4jYwhGMMaLVYao4ro/O7+p
	 suZ5xJTzZafqRfDDJa1feOIvnqrP2hsE7oz/A3MI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbfGYOVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 10:21:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387419AbfGYOVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 10:21:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 992B222C7B;
        Thu, 25 Jul 2019 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564064496;
        bh=pxReWaEST95lk565mK1Mw+8MWIZHmNlYX5ldtarOjvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MYGCqmiYLdCxJiHwW+7Jfsk9vU8NlsVpS9UKp/yfqWBKGgvoTs4XDlDiNEa+ET/nf
         dE7/+pSOVqwaGTLLQ6xlBE5NwXcUL5cln+28UBayTyuMR9pJZ+4TtKqwbKN48XaFzo
         PmqVxDnNz5A2Wlw7scGSMA9tPLPK/PFUycvduEcs=
Date:   Thu, 25 Jul 2019 16:21:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Huth <thuth@redhat.com>
Cc:     linux-kernel@vger.kernel.org, trivial@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] kernel/configs: Replace GPL boilerplate code with SPDX
 identifier
Message-ID: <20190725142133.GB15480@kroah.com>
References: <20190722092008.15403-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722092008.15403-1-thuth@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 11:20:08AM +0200, Thomas Huth wrote:
> The FSF does not reside in "675 Mass Ave, Cambridge" anymore...
> let's replace the old GPL boilerplate code with a proper SPDX
> identifier instead.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  kernel/configs.c | 16 +---------------
>  1 file changed, 1 insertion(+), 15 deletions(-)

Thanks for this, I can take this through the spdx tree.

greg k-h
