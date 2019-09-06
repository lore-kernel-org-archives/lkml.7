Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473B3C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C47A20674
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 19:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZcY8rBbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393380AbfIFTk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 15:40:56 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:60450 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732554AbfIFTkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mOCwqbFB7vKSRBhomaXxUqeJyEFFfN1wyA9xBhT61V0=; b=ZcY8rBbzBNpiMS57Uqs5UEmfKO
        woVzYLamMCeN3cnsH9EnjpreeFZ+UvjDegqwjvOzdu8j+I35987RhwVHbF8MmBGpDWg1/wChe/O+Y
        JcS51ULjP20OoocoE6XFUienDGyserFRKao7rGl9eV4/KYqXOZ+EWTZaA9PfUOe/skA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1i6K6E-0000zz-OA; Fri, 06 Sep 2019 21:40:50 +0200
Date:   Fri, 6 Sep 2019 21:40:50 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     davem@davemloft.net, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ethernet: micrel: Use DIV_ROUND_CLOSEST directly to make
 it readable
Message-ID: <20190906194050.GB2339@lunn.ch>
References: <1567698828-26825-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567698828-26825-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 11:53:48PM +0800, zhong jiang wrote:
> The kernel.h macro DIV_ROUND_CLOSEST performs the computation (x + d/2)/d
> but is perhaps more readable.

Hi Zhong

Did you find this by hand, or did you use a tool. If a tool is used,
it is normal to give some credit to the tool.

Thanks
	Andrew
