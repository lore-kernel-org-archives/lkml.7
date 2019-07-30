Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839B8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54F24206E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564525504;
	bh=EZ44k/sCpc+uxAS9CQv8KcvzYhn09rJBtgAtVNMkk40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vs2PmAsqpV7m+bkPsYNHQjvLYC9bfyT4hRfJR99MktFavTljB8yfLppvED7sH2egZ
	 8UQIrXReV5HYc6eiL9ZyRxdOYg7zhhV0oJen4XqoREKvCWUWkJxHVpbGwIFHUtKeFP
	 PcxtQ9IV9f2WrgPhoUQ+qzDZxIwExPj/ern4unfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbfG3WZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbfG3WZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:25:02 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCD4E206E0;
        Tue, 30 Jul 2019 22:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564525502;
        bh=EZ44k/sCpc+uxAS9CQv8KcvzYhn09rJBtgAtVNMkk40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jp4Aj20Ud3njZVz1FOAP+UNWkp08Kn3jyCe9wmROw2B6EdJBaIjluEyIjUuyN5v9D
         D1+Hdz2yBORvZO3KRWhJpUy20z5rOLNXDNChSIv8lnkTQ6KdSYB8z+oO0T8Cik8RKS
         NnNn+nis5chOqUYQUhhWz2Fkbqzk8Ju0MLHtrlEw=
Date:   Tue, 30 Jul 2019 18:25:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Adrian Vladu <avladu@cloudbasesolutions.com>
Cc:     Dexuan Cui <decui@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Alessandro Pilotti <apilotti@cloudbasesolutions.com>
Subject: Re: [PATCH v2] hv: tools: fixed Python pep8/flake8 warnings for
 lsvmbus
Message-ID: <20190730222500.GG29162@sasha-vm>
References: <20190506172737.18122-1-avladu@cloudbasesolutions.com>
 <20190506173331.18906-1-avladu@cloudbasesolutions.com>
 <PU1P153MB016957AD2B1C356FA1BFB1A8BF310@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20190509010941.GT1747@sasha-vm>
 <F5008595B06C564AB347C30B4FDE4BC559697F85@CBSEX1.cloudbase.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <F5008595B06C564AB347C30B4FDE4BC559697F85@CBSEX1.cloudbase.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2019 at 02:53:35PM +0000, Adrian Vladu wrote:
>Hello,
>
>There were two patches you have queued for hyperv-fixes a while ago, but I don't see them anymore in the hyperv-fixes tree:
>https://lore.kernel.org/patchwork/patch/1070848/
>https://lore.kernel.org/patchwork/patch/1070806/
>
>I have checked them and they can still be applied successfully on the latest master tree.
>Please let me know if I need to make some amends to get them merged.

They must have got lost when we dealt with the clocksource mess. I'll
re-queue these, thanks!

--
Thanks,
Sasha
