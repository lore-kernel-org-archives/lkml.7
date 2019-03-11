Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9976C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B3120643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfCKRwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:52:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39632 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727514AbfCKRwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:52:05 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 469F414C614EB;
        Mon, 11 Mar 2019 10:52:04 -0700 (PDT)
Date:   Mon, 11 Mar 2019 10:52:03 -0700 (PDT)
Message-Id: <20190311.105203.2225467966650056784.davem@davemloft.net>
To:     sergei.shtylyov@cogentembedded.com
Cc:     kjlu@umn.edu, pakki001@umn.edu, vladimir_zapolskiy@mentor.com,
        geert+renesas@glider.be, horms+renesas@verge.net.au,
        chris.brandt@renesas.com, netdev@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: renesas: fix a missing check of of_get_phy_mode
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20c5cfde-3c2d-43cb-efc4-be9782b7eb2e@cogentembedded.com>
References: <20190311074939.517-1-kjlu@umn.edu>
        <20c5cfde-3c2d-43cb-efc4-be9782b7eb2e@cogentembedded.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 11 Mar 2019 10:52:04 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 11 Mar 2019 13:29:10 +0300

> Hello!
> 
> On 03/11/2019 10:49 AM, Kangjie Lu wrote:
> 
>> of_get_phy_mode may fail and return a negative error code;
>> the fix checks the return value of of_get_phy_mode and
>> returns NULL of it fails.
> 
>   Sorry, I overlooked this issue.
> 
>> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> 
> Fixes: b356e978e92f ("sh_eth: add device tree support")
> Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
>> ---
>>  drivers/net/ethernet/renesas/sh_eth.c | 2 ++
>>  1 file changed, 2 insertions(+)
> 
>    Why are you not fixing ravb_main.c as well? Especially as you have "renesas:"
> in your subject, not "sh_eth:"? :-/

Kangjie please fix the subject line and incorporate Sergei's Fixes and
Reviewed-by tags.

Thanks.
