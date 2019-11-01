Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9777CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AB752067D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 21:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="fCkfsPf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfKAVkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 17:40:49 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:42212 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfKAVks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 17:40:48 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 656935C35E6;
        Fri,  1 Nov 2019 22:40:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1572644446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UQ0Zt0OUXYdDbK7jxc5SzMQz2nIcNAjdmM4xf+Xj0xg=;
        b=fCkfsPf1F5hA9GJWCThZmjWj1+FNW5GZKdKpnKUwT5LWRVCdsb/CIVe7yEpxO2FlY037AN
        jxLcritbSksusfUPz6luuuHmdYErc8fluMSWjV5+KAhmXzV4X+QvdDwqrjtcoLQLXJtTpR
        NV5kDvWJBlXpbA9NcjAa+g8yI+ZPij0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Nov 2019 22:40:46 +0100
From:   Stefan Agner <stefan@agner.ch>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     s.hauer@pengutronix.de, linux@armlinux.org.uk,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: imx: use generic function to exit coherency
In-Reply-To: <20190416042337.GA4690@X250.skyworth_vap>
References: <3f58c55e48c28f41e92883e81c675b8478af6a5e.1554937960.git.stefan@agner.ch>
 <20190416042337.GA4690@X250.skyworth_vap>
Message-ID: <a99b439b8c8deb247f7ba2e6b598e808@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

On 2019-04-16 07:46, Shawn Guo wrote:
> On Thu, Apr 11, 2019 at 01:14:12AM +0200, Stefan Agner wrote:
>> The common ARM architecture code provides a generic function to exit
>> coherency called v7_exit_coherency_flush(). Replace the machine
>> specific implementation using the generic function.
>>
>> Tested on a i.MX 6Dual by hotplugging the secondary CPU under load
>> through sysfs several 1000 times.
>>
>> Tested-by: Stefan Agner <stefan@agner.ch>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> 
> Applied, thanks.

It seems like this patch never made it upstream. Any specific reason?

--
Stefan
