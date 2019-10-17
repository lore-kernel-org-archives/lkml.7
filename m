Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A7EFA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782E021848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 16:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SK8J2NQ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502091AbfJQQRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:17:33 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:50818 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390456AbfJQQRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 12:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hWsCtqoArOgNErY48M2iOin53oYnCZbWFLPfHGmnMVo=; b=SK8J2NQ6JYkFN81PSHbyMCtvbV
        RgyBT217Q9tdQEKFwVpb2MA2TyKL8D9g63yJaHu5l/04MBhRtUNM9I4S5gIDxXyZJKGpuZWrzX8KT
        tO37524+UhSqlDAKmVkdA4aea7TD3iwy8zjGMH4F2bg0icqzaNmiGBTlH0CLEHG+Kw8k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iL8Sg-0005CA-8y; Thu, 17 Oct 2019 18:17:14 +0200
Date:   Thu, 17 Oct 2019 18:17:14 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     igor.russkikh@aquantia.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: aquantia: add an error handling in
 aq_nic_set_multicast_list
Message-ID: <20191017161714.GQ17013@lunn.ch>
References: <1571279116-4421-1-git-send-email-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571279116-4421-1-git-send-email-chenwandun@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:25:16AM +0800, Chen Wandun wrote:
> From: Chenwandun <chenwandun@huawei.com>

Hi Chen

There needs to be some sort of commit message. What [problems are you
seeing? That does this fix?

Thanks
	Andrew
