Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8810C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC26E20651
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553711240;
	bh=ZxG7biS6bXpKRpflwMEfW1R/XgZKXgkCqbd68fspG9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u5jZ35xMvQjPAvAA0TleqUSAMSOykytjy3tWghXFG27YIf7QP6R6kuwMRcEQACe2S
	 +BqlrLIQaxbyMXPPLpyS+/w3WMsmlhCuNmNbDI4r3Svktcs0xajjOw1b7uvmiR32pq
	 pi0j9LJ461uszE0ahEWYtM0FmvL47CNHdOKpYKTc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391810AbfC0S1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391749AbfC0S0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:26:43 -0400
Received: from localhost (unknown [88.128.80.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C168020651;
        Wed, 27 Mar 2019 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553711203;
        bh=ZxG7biS6bXpKRpflwMEfW1R/XgZKXgkCqbd68fspG9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vGd14K9QvbqXhFP1weU0vh3ot6pYxUaKGdbcFoDjWbSDUPI2aCVOk5JY0rNlSHuqn
         gTFeQ/VVLrDn1pQ2FzJobtKLgoJDuMiDYZAFd1PPKgoXQg3ZMMZm931hIXsXXe45j3
         5p/edlfW9HNaLFJj1x7VS5bbIHLWxklhl4hdSaz4=
Date:   Thu, 28 Mar 2019 00:02:04 +0900
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mathieu Malaterre <malat@debian.org>
Cc:     trivial@kernel.org, Sarah Sharp <sarah.a.sharp@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB/xHCI: Remove returned value 'status' since never used
Message-ID: <20190327150204.GA22617@kroah.com>
References: <20190326201557.20388-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326201557.20388-1-malat@debian.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:15:57PM +0100, Mathieu Malaterre wrote:
> The returned value in status has never been used since
> commit 4296c70a5ec3 ("USB/xHCI: Enable USB 3.0 hub remote wakeup.")
> So remove 'status' completely.
> 
> Remove warning (W=1):
> 
>   drivers/usb/core/hub.c:3671:8: warning: variable 'status' set but not used [-Wunused-but-set-variable]
> 
> Cc: Sarah Sharp <sarah.a.sharp@intel.com>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  drivers/usb/core/hub.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Why do you have xhci in your subject line?  Shouldn't it be "USB: hub:"?

Please fix up, thanks.

greg k-h
