Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BBAC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4075D206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 11:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfKNLBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 06:01:31 -0500
Received: from foss.arm.com ([217.140.110.172]:40488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfKNLBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 06:01:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 527BC31B;
        Thu, 14 Nov 2019 03:01:30 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4CA033F6C4;
        Thu, 14 Nov 2019 03:01:29 -0800 (PST)
Date:   Thu, 14 Nov 2019 11:01:23 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: linux-next: Fixes tag needs some work in the arm-soc tree
Message-ID: <20191114110123.GA18036@bogus>
References: <20191114202122.0f38eab6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191114202122.0f38eab6@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 08:21:22PM +1100, Stephen Rothwell wrote:
> Hi all,
>
> n commit
>
>   9a6edfe32f37 ("firmware: arm_scmi: Fix doorbell ring logic for !CONFIG_64BIT")
>
> Fixes tag
>
>   Fixes: 823839571d76 ("firmware: arm_scmi: Make use SCMI v2.0 fastchannel
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more than one line.
>

My bad, and sorry for that, it was too long and hence I split it into 2 lines.

--
Regards,
Sudeep

