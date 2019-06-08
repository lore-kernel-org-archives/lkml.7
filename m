Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54115C28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 22:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3022A21873
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 22:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbfFHWVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 18:21:09 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60912 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfFHWVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:21:08 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C8D45151CE516;
        Sat,  8 Jun 2019 15:21:07 -0700 (PDT)
Date:   Sat, 08 Jun 2019 15:21:02 -0700 (PDT)
Message-Id: <20190608.152102.1183911048932398037.davem@davemloft.net>
To:     olteanv@gmail.com
Cc:     f.fainelli@gmail.com, vivien.didelot@gmail.com, andrew@lunn.ch,
        richardcochran@gmail.com, john.stultz@linaro.org,
        tglx@linutronix.de, sboyd@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v4 net-next 00/17] PTP support for the SJA1105 DSA
 driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190608120443.21889-1-olteanv@gmail.com>
References: <20190608120443.21889-1-olteanv@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 08 Jun 2019 15:21:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Oltean <olteanv@gmail.com>
Date: Sat,  8 Jun 2019 15:04:26 +0300

> This patchset adds the following:
> 
>  - A timecounter/cyclecounter based PHC for the free-running
>    timestamping clock of this switch.
> 
>  - A state machine implemented in the DSA tagger for SJA1105, which
>    keeps track of metadata follow-up Ethernet frames (the switch's way
>    of transmitting RX timestamps).
> 
> Clock manipulations on the actual hardware PTP clock will have to be
> implemented anyway, for the TTEthernet block and the time-based ingress
> policer.

Series applied, let's see how the build goes this time :-)

Thanks.
