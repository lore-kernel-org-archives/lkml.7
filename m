Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A18C7618F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2D6208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390515AbfGRSqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:46:40 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53992 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRSqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:46:39 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 13C831527D7E1;
        Thu, 18 Jul 2019 11:46:39 -0700 (PDT)
Date:   Thu, 18 Jul 2019 11:46:38 -0700 (PDT)
Message-Id: <20190718.114638.2086531826521437029.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     justinpopo6@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, opendmb@gmail.com
Subject: Re: [PATCH] net: bcmgenet: use promisc for unsupported filters
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5f6422b5-e839-1600-6749-048a7e31ea96@gmail.com>
References: <1563400733-39451-1-git-send-email-justinpopo6@gmail.com>
        <5f6422b5-e839-1600-6749-048a7e31ea96@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 18 Jul 2019 11:46:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Wed, 17 Jul 2019 20:38:47 -0700

> 
> 
> On 7/17/2019 2:58 PM, justinpopo6@gmail.com wrote:
>> From: Justin Chen <justinpopo6@gmail.com>
>> 
>> Currently we silently ignore filters if we cannot meet the filter
>> requirements. This will lead to the MAC dropping packets that are
>> expected to pass. A better solution would be to set the NIC to promisc
>> mode when the required filters cannot be met.
>> 
>> Also correct the number of MDF filters supported. It should be 17,
>> not 16.
>> 
>> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for -stable.
