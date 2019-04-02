Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FA5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59002082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 17:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfDBRzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:55:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58018 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbfDBRzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 13:55:24 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E4F11133FCD40;
        Tue,  2 Apr 2019 10:55:22 -0700 (PDT)
Date:   Tue, 02 Apr 2019 10:55:22 -0700 (PDT)
Message-Id: <20190402.105522.2070788862454259965.davem@davemloft.net>
To:     jmaxwell37@gmail.com
Cc:     siva.kallam@broadcom.com, prashant@broadcom.com,
        mchan@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmaxwell@redhat.com
Subject: Re: [net-next] tg3: allow ethtool -p to work for NICs in down state
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190402050756.20507-1-jmaxwell37@gmail.com>
References: <20190402050756.20507-1-jmaxwell37@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Apr 2019 10:55:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Maxwell <jmaxwell37@gmail.com>
Date: Tue,  2 Apr 2019 16:07:56 +1100

> Make tg3 behave like other drivers and let "ethtool -p" identify the
> NIC even when it's in the DOWN state. Before this patch it would get an 
> error as follows if the NIC was down:
> 
> # ip link set down dev em4
> # ethtool -p em4
> Cannot identify NIC: Resource temporarily unavailable
> 
> With this patch ethtool identify works regardless of whether the NIC is up
> or down as it does for other drivers.
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>

Applied, thanks Jon.
