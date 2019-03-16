Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8FCC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 23:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81984218D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552779618;
	bh=Me36TdrBigGAiq2BwUvE7lAFhhvBMzkOwanTiXoh0D0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=H8xUJzGNzBUfEtSZaklrB9WmtlMHWHNJ1RWBRws32LUbaLkd6sjXrKC+I7f/YwVup
	 4TlRmR0u6LjCeRJ1rB6vEBTxAlhfWV4p4480O9l2eaKdroJHK4BBVs1gsznupL+yMe
	 KZygtPNMNfFyN2bC49ygEh60ubPFBxaqF05JSS5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfCPXkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 19:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfCPXkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 19:40:09 -0400
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BD3D218D0;
        Sat, 16 Mar 2019 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552779608;
        bh=Me36TdrBigGAiq2BwUvE7lAFhhvBMzkOwanTiXoh0D0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GswxlH0iNI785tl9fGyvMWAuHO2c5zuH+QpAqtmXnUKIrztOOX/+v8OAbnwqIokY1
         gJ7llq+xYsKw7pgsQx09uxfYZZ5EBeOe69YMhT+1WfV42RhtyktItoDiFJvLf7TYJO
         Zdod8usN7bsis6Grg1Suja3rPeX0qdly7PNsIyxg=
Subject: Re: [PATCH] tools: usb: usbip: adding support for older kernel
 versions
To:     David Valleau <valleau@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     briannorris@chromium.org, linux-usb@vger.kernel.org,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>
References: <20190306214730.6545-1-valleau@chromium.org>
From:   shuah <shuah@kernel.org>
Message-ID: <44e151af-b6c4-d0af-3ef1-a5632d079915@kernel.org>
Date:   Sat, 16 Mar 2019 17:39:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306214730.6545-1-valleau@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 3/6/19 2:47 PM, David Valleau wrote:
> The current usbip tool relies on the behavior of the vhci-hcd driver in
> order to work correctly. In instances where a newer version of the tool
> is used with an older version of the kernel, there are incompatibilities
> that can sometimes result in failure.

usbip tool is tied to the kernel version. This is reason why it is
co-located with the usbip driver in the kernel sources. This is not
a typical tool scenario to be able to use new tool on old kernels.

I would like to understand the reasons for wanting to run new tool on
old kernels.

thanks,
-- Shuah
