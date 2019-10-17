Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968AEC4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3BF20872
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 07:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438444AbfJQHkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 03:40:47 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46005 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389017AbfJQHkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 03:40:46 -0400
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iL0On-0005XG-Le; Thu, 17 Oct 2019 08:40:41 +0100
Subject: Re: [PATCH] net: stmmac: fix argument to stmmac_pcs_ctrl_ane()
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@lists.codethink.co.uk, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20191016082205.26899-1-ben.dooks@codethink.co.uk>
 <20191016.132805.1945227679877403030.davem@davemloft.net>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <f351aba0-e55b-edf3-e917-945715beaaf7@codethink.co.uk>
Date:   Thu, 17 Oct 2019 08:40:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191016.132805.1945227679877403030.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2019 21:28, David Miller wrote:
> From: "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>
> Date: Wed, 16 Oct 2019 09:22:05 +0100
> 
>> The stmmac_pcs_ctrl_ane() expects a register address as
>> argument 1, but for some reason the mac_device_info is
>> being passed.
>>
>> Fix the warning (and possible bug) from sparse:
>>
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2613:17: warning: incorrect type in argument 1 (different address spaces)
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2613:17:    expected void [noderef] <asn:2> *ioaddr
>> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:2613:17:    got struct mac_device_info *hw
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> I'm still reviewing this but FYI you did not have to send this
> twice.

Yes, I accidentally sent the wrong patch out (already apologised
on the re-send as I noticed it about 10 minutes after sending).

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
