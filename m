Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AA5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF75C222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 02:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573181859;
	bh=CQxQebx01rfyxWBjyBuBcT8jN9KYZVzIqhaOBlm21U0=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=sf3AlZ1oykeBEcEmthxNdSJrWkEXm0hsY4hE5DiLwj06fEB/fL1jJX7YlURgeAv+5
	 VOMqz43mJOaauWP+szorfsGPL5r2teaY1PtQ24xNFLOZk+aB1lktEAgCr0/ArnbjC/
	 m7UMcb6KkN1XVuH37C79zLAhjplFAs9iSKlwBXls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbfKHC5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 21:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbfKHC5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 21:57:37 -0500
Received: from [192.168.1.20] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EA42084C;
        Fri,  8 Nov 2019 02:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573181855;
        bh=CQxQebx01rfyxWBjyBuBcT8jN9KYZVzIqhaOBlm21U0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Rfc4yF2gnMhTfT+o6yP2RkaqpUTOX8Xes/O4h90kfw6d0462bX7+n1Qs/7PbL9wCu
         UJ+ed34JvTN3rmfzSjPWicytH0MTwykymoEmqYhEUKLTQALmd+diBVSVBW/UEy5ctQ
         PHbkxbrFEO4WJFEC7rEpAYcIw4JcYfcBlzxIrOg4=
Subject: Re: [PATCH net-next 2/2] net: qcom/emac: Demote MTU change print to
 debug
To:     Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org
Cc:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191107223537.23440-1-f.fainelli@gmail.com>
 <20191107223537.23440-3-f.fainelli@gmail.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <dfd60aa0-59e1-5b68-d8ea-61dc3a29ff8e@kernel.org>
Date:   Thu, 7 Nov 2019 20:57:33 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107223537.23440-3-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/19 4:35 PM, Florian Fainelli wrote:
> Changing the MTU can be a frequent operation and it is already clear
> when (or not) a MTU change is successful, demote prints to debug prints.
> 
> Signed-off-by: Florian Fainelli<f.fainelli@gmail.com>

Acked-by: Timur Tabi <timur@kernel.org>

