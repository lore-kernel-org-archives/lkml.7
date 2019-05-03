Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB9DC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3B1205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556869896;
	bh=sODAXR90bmNzUtNhBl2o3bkfs0Tpl/J2+I8eRtN37CM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H6rmlcLBs9FaepafQ8Q24K8Jx4rt+sS1cX9r6cy/VKbmIU2xtQ8axhGYdSADpTCEF
	 V72gIYl8St/OxZSg6aY+rY9gYmsRukwjy2/8s5fXYi7z3TA/KuMkEFYMsfBHaaeA0W
	 QWIXyoNryc1A9tbIAuXYxFqF0BqIJkl6KoZv+cqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfECHvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 03:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfECHvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 03:51:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6916E205F4;
        Fri,  3 May 2019 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556869894;
        bh=sODAXR90bmNzUtNhBl2o3bkfs0Tpl/J2+I8eRtN37CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zafgWLi96DaS3JjLCtYbmCWBcwJb84jp8uchpms88BF5SGicL6HAWj9wREngYyknu
         WtemRsZgQoqHkeWEUtfuOMIqwCPzo9sbwJ4OcQS7w5SQHGAy3v/+hzPagN5VTACPOJ
         A4gjc+CPEvigrejso/x1ylrVFBBxa5VRuSWH4DkA=
Date:   Fri, 3 May 2019 09:51:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs next second pull for 5.2
Message-ID: <20190503075131.GA9785@kroah.com>
References: <20190503073621.GA6992@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503073621.GA6992@ogabbay-VM>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 03, 2019 at 10:36:21AM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is the second pull request of habanalabs driver for kernel 5.2.
> 
> As the tag describes, all of the changes are either bug fixes or simple
> re-factoring of existing code, so they should all be relatively low-risk.
> 
> Thanks,
> Oded
> 
> The following changes since commit 78e6427b4e7b017951785982f7f97cf64e2d624b:
> 
>   coresight: funnel: Support static funnel (2019-05-02 19:12:21 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-05-03

Pulled and pushed out, thanks.  My tree is now closed for 5.2-rc1 stuff,
but feel free to queue up bugfixes for me if you want.

thanks,

greg k-h
