Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABABCA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 17:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B63F120848
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 17:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572801144;
	bh=PyxTSC1C5MxIjStz3/uFjvsyUByKR5YzlFl8BnqdxBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zrc9Zi3sEVhNnQW8cfYStuAnb6rn7XRKwZp0LorGKzuEkToxDQlGpQdE6udSpqf1G
	 EWqvV4zxZbAeBj4niCs/U5IOBfoZm4FLrdToYdilcQ157jJsORH9NyuLq+olOop7lh
	 f2Ip6TK8e6qKd70aS7+BBfPGTBCDRv2H3cyoiEVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfKCRMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 12:12:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:54318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbfKCRMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 12:12:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7690A20848;
        Sun,  3 Nov 2019 17:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572801137;
        bh=PyxTSC1C5MxIjStz3/uFjvsyUByKR5YzlFl8BnqdxBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wf45GPnt1R7oSD0IaUsepFyhAZZJvHoOp7O2ouB2374DuFmsVSiw02Y3PyZOaDKDn
         t8zEyeynYLFYman81XMjQYcxNiKHtaXsiHT2EFUgqmG59iD1LKON/xYVD5icDLXly+
         JTnAuXbPhYlTX+17QXDq8YdJcoYLcmq7Y/hhnaMg=
Date:   Sun, 3 Nov 2019 18:12:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: debugfs: Document debugfs helper for
 unsigned long values
Message-ID: <20191103171213.GA700196@kroah.com>
References: <20191021150645.32440-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021150645.32440-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 05:06:45PM +0200, Geert Uytterhoeven wrote:
> When debugfs_create_ulong() was added, it was not documented.
> 
> Fixes: c23fe83138ed7b11 ("debugfs: Add debugfs_create_ulong()")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/filesystems/debugfs.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Jon, I had to take this in my tree too as Geert sent a follow-on patch
that requires this.  Hopefully linux-next will not have many merge
issues with it.

thanks,

greg k-h
