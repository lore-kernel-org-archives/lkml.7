Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAA7C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4775F21738
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552821186;
	bh=Grx/eLllgVxchFm0EWFydoNmvdB8pMZB88Q6pfvDayA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bj2fq/IvqFfi1s3uLk1AckHfxC2RSSsA2WX+wiIWAQniMnWwFiB7ei0JDE4IxZ90v
	 OzDMIls3Td57CEcIfc7+YcIbo4HUSMegbSrZPJVwntUd+pG4P5k4IlPm5BGseH67bV
	 M4xDZvujEgmViTPWpxqILsMFJyKtc1Rn/7NaQmNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfCQLNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:53846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbfCQLNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:13:04 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19E6C21738;
        Sun, 17 Mar 2019 11:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552821183;
        bh=Grx/eLllgVxchFm0EWFydoNmvdB8pMZB88Q6pfvDayA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVDazoxznyynXqJC9DvNYcr4GB8ooQ6cw6wj1mFC/IHSciKieq+yD0yJwcZfZLxGb
         r8zvq6FKx/852m/Q0WX/D23UAUSV7TxS0l+IukbuWiZ1mvslVqpig9N94ytJ64qfh3
         9XNTjn6P510oGKzEUlifG3/FfpeqKqMV0Lw/pMLY=
Date:   Sun, 17 Mar 2019 12:13:01 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     devel@driverdev.osuosl.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Sabin Mihai Rapan <sabin.rapan@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] staging: rtlwifi: Fix potential NULL pointer dereference
Message-ID: <20190317111301.GC4614@kroah.com>
References: <20190313162914.20727-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190313162914.20727-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2019 at 11:29:12AM -0500, Aditya Pakki wrote:
> skb allocated via dev_alloc_skb can fail and return a NULL pointer.
> This patch avoids such a scenario and returns, consistent with other
> invocations.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/staging/rtlwifi/rtl8822be/fw.c | 3 +++
>  1 file changed, 3 insertions(+)

You sent 2 patches that did different things, with the same exact
subject line :(

please fix up, and send as a patch series.

thanks,

greg k-h
