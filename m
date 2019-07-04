Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9D1C0650E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC84A218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 08:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562228549;
	bh=iv6iNCX9ODx5zCGbWnYFuEpC8RqXmFyg+eiO4nhk1sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nOQmgRoX3jedWfQjUcW2+7J0B5y73GQkix4H7dCnjCBovr8sy/eV+JXtmCFZRpu3+
	 ZrJrj/0BYQjSbpXmIWvUIfKDAP3WigGTwtiViqX+xAxZvVLFohhoIKzVJp1Cgm0mS1
	 g4llnjns664HAuZQEcm2Sn4s7QdHQUmKgWS1qPMA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbfGDIW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 04:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:42618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbfGDIW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 04:22:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBBB52133F;
        Thu,  4 Jul 2019 08:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562228546;
        bh=iv6iNCX9ODx5zCGbWnYFuEpC8RqXmFyg+eiO4nhk1sc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTHfUfdPDxNy4cp0QehMoYyO80YMImRu57G9P9Zn+V+mKZsnmka1Gigt9vurV6hM7
         3ryFTEh0JzTFed6kkxZKsLHR8XySfp5Rc9xJCltxDA9TG136xXgcQp8mFLhBUjBerA
         30ePGsuaKzCMNJlTt6nM/nWZLHylj2Fx9PysgNyo=
Date:   Thu, 4 Jul 2019 10:21:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull v2] habanalabs pull request for kernel 5.3
Message-ID: <20190704082152.GG6438@kroah.com>
References: <20190704065843.GA21559@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190704065843.GA21559@ogabbay-VM>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 04, 2019 at 09:58:43AM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is v2 of the pull request for habanalabs driver for kernel 5.3.
> 
> v2 contains the missing sign-off-by tags for the relevant commits.
> 
> The commits mostly contains improvements to the existing code base.
> Nothing too exciting this time.
> 
> Please see the tag message for details on what this pull request contains.
> 
> Thanks,
> Oded
> 
> The following changes since commit 60e8523e2ea18dc0c0cea69d6c1d69a065019062:
> 
>   ocxl: Allow contexts to be attached with a NULL mm (2019-07-03 21:29:47 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2019-07-04

Much nicer, now pushed out, thanks.

greg k-h
