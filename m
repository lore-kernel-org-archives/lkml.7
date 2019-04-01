Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCA7C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B6020896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 09:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="mtyddrmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDAJwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:52:36 -0400
Received: from mail.synology.com ([211.23.38.101]:42021 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725832AbfDAJwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 05:52:36 -0400
Received: from _ (localhost [127.0.0.1])
        by synology.com (Postfix) with ESMTPA id 8FE1D1AD5224D;
        Mon,  1 Apr 2019 17:52:34 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1554112354; bh=CrMdoGx2JkX8mfpYswWFNYtA1gFxV7UNoCKEm5M1kpk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=mtyddrmNcRL6tbbYDpZOzaAN6+k1ChHwegz4cLvbMY+3kNN0/fe2vMUz8JjTJgNqb
         Gye4bdmTXma6o7Zhm8ZqLjcyGBn3XHjrk3/aj4yDe1wP96sPzbQCSS1zgBry3roWv0
         eGwFmSCoZu5FnRPL434dI6VPmjQdHlrvQWJo5ku8=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 01 Apr 2019 17:52:34 +0800
From:   lifonghsu <lifonghsu@synology.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: fix routing encapsulated packets when binding a socket to a
 tunnel interface
In-Reply-To: <20190331.230123.1312457672309077256.davem@davemloft.net>
References: <6143cbeaab4f37bc2314caa3690063d4@synology.com>
 <20190329.104026.2135814725468775566.davem@davemloft.net>
 <e87a85a8c91d96951c4fa923d1563dcd@synology.com>
 <20190331.230123.1312457672309077256.davem@davemloft.net>
Message-ID: <6c73524bdddc66f9959243a5a4ce2827@synology.com>
X-Sender: lifonghsu@synology.com
User-Agent: Roundcube Webmail/1.1.2
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller 於 2019-04-01 14:01 寫到:
> From: lifonghsu <lifonghsu@synology.com>
> Date: Mon, 01 Apr 2019 11:00:22 +0800
> 
>> Since we are not sure whether there is any code referring to the
>> value of skb_iff in transmit site or not, it is risky to set an
>> invalid interface
> 
> If you are no confident in how the value is used on TX, then I can't
> consider your change with confidence either.
> 
> Think about what you are saying to me here.  You basically do not know
> whether you are adding a bug or not.

Indeed, we are not confident about the commit. Please drop it for now.
Thank you for help review the commit.

