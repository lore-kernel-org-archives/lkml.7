Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F3EC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EB620693
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555482538;
	bh=dbDJijC8bPLoYTnNYEMLhWc1DiibE+jV3Yh6IlpDZRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Czj9dQUSWhB9uAJb+krrl4wiE2VJPzWeZ2e698MEGc5H5l8lQ5aqosCbGrvTX4Hll
	 22ZJjZ9M8ukl8oUivok0uMDWmwOyduozHrFdgtKkTK7GTA/z8qQkh4jqq/C2AbGDZs
	 SBXZHi9ltJyrI9pJuL8izY6h0067TSdO8wwD3ORY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbfDQG25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfDQG25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:28:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D4E720693;
        Wed, 17 Apr 2019 06:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555482536;
        bh=dbDJijC8bPLoYTnNYEMLhWc1DiibE+jV3Yh6IlpDZRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltPqZ8VpMsqFfFwndhnnycogq5ss1AvWZJRz0H5LrVdA0B6IzXuziUmEiCRkhjjM4
         CixD/Bcvtu23hBylvbDJhqNIJg3t8zzWXGTToyCscCcSZyMMgC+FIEhKrlb7KC5LAY
         luptiGPo7L1Aj/Fzew4u4wn1FBEMyGwtIg8m8B60=
Date:   Wed, 17 Apr 2019 08:28:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@microsoft.com, linux-hyperv@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Hyper-V commits for 5.1
Message-ID: <20190417062854.GA24045@kroah.com>
References: <20190417013452.438FA20821@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417013452.438FA20821@mail.kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 09:34:51PM -0400, Sasha Levin wrote:
>  2. Fix to show monitor data only when monitor pages are actually
> allocated, also by Kimberly Brown.

That's not really a "fix", more like a "new feature", right?

>  drivers/hv/vmbus_drv.c                   | 166 +++++++++++++++++++++++++------

A patch this big so late in the release cycle is not good.

Can you drop this one and resend the others?  If you sent this as a
patch series, I could have done it that way on my own :)

thanks,

greg k-h
