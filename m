Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E25C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A8F21726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="KovUP4aD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EEngdNxw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfEQSIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:08:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34372 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfEQSIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:08:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D6EBC60E3E; Fri, 17 May 2019 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558116481;
        bh=JcHdYICXH9h1XJyzH5vRUun1o9WHh8O7S5STCrF39C8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KovUP4aDMIsmyad+xyGJBgfVr5ECJa4GoaTF/D0txY7LdK+xBwmgg2/5wy+BA3jb9
         z4gdztjmoZOvrLqiKRgcnuolEGxqM98HlYMJzvyBsD+4njfOcZI2AOH63IIQza4cJS
         GxmrArlp6LCNofNT53PoppZM600a2FklWhfiOL94=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id CE37F60590;
        Fri, 17 May 2019 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1558116480;
        bh=JcHdYICXH9h1XJyzH5vRUun1o9WHh8O7S5STCrF39C8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EEngdNxwjLTppzTVzZju1pznbj2UP20s5lEhxJuDw1uJ+weniubJxR+4CAhhnVoCn
         QBJgMQSPfRFxIU1Dm3LX+84Q0Z0lM0q6Tbh0NWgSbIJhPPMCawQC4W6qUYIQe1I8tD
         Hq500J9sNx9JngJ/j9KragLNWpbd7GCj+RjjjwSY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 May 2019 12:08:00 -0600
From:   Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
To:     Alex Elder <elder@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        stranche@codeaurora.org, YueHaibing <yuehaibing@huawei.com>,
        Joe Perches <joe@perches.com>, syadagir@codeaurora.org,
        mjavid@codeaurora.org, evgreen@chromium.org, benchan@google.com,
        ejcaruso@google.com, abhishek.esse@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/18] soc: qcom: create "include/soc/qcom/rmnet.h"
In-Reply-To: <eca367f2-e019-f785-509d-5662ed7b7398@linaro.org>
References: <20190512012508.10608-1-elder@linaro.org>
 <20190512012508.10608-3-elder@linaro.org>
 <CAK8P3a16HpKEUB7_6G_W_RKkyVeVBW_rofLbdhC2QmWjVOAHMg@mail.gmail.com>
 <9cae00c4-29ab-6c3e-7437-6ed878a3061f@linaro.org>
 <005ae8fb4ea9ba86fd0924b1719f1753@codeaurora.org>
 <eca367f2-e019-f785-509d-5662ed7b7398@linaro.org>
Message-ID: <5ea0235d9fb24322681303591450b02a@codeaurora.org>
X-Sender: subashab@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-17 11:27, Alex Elder wrote:
> On 5/15/19 8:09 PM, Subash Abhinov Kasiviswanathan wrote:
> . . .
>> Hi Alex
>> 
>> Could we instead have the rmnet header definition in
>> include/linux/if_rmnet.h
> 
> I have no objection to that, but I don't actually know what
> the criteria are for putting a file in that directory.
> 
> Glancing at other "if_*" files there it seems sensible, but
> because I don't know, I'd like to have a little better
> justification.
> 
> Can you provide a good explanation about why these
> definitions belong in "include/linux/if_rmnet.h" instead
> of "include/soc/qcom/rmnet.h"?
> 
> Thanks.
> 
> 					-Alex

rmnet was designed similar to vlan / macvlan / ipvlan / bridge.
These drivers support creation of virtual netdevices,
define custom rtnl_link_ops, expose netlink attributes to
uapi via if_link.h and register rx_handlers.

They expose some common structs and helpers via if_vlan.h /
if_macvlan.h / if_bridge.h. I would prefer rmnet to use if_rmnet.h
similar to them.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
