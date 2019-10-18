Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B2ECA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9775420640
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409366AbfJRRBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:01:16 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54958 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389333AbfJRRBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:01:16 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:5314:1b70:2a53:887e])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 470A814A8C7E0;
        Fri, 18 Oct 2019 10:01:15 -0700 (PDT)
Date:   Fri, 18 Oct 2019 13:01:14 -0400 (EDT)
Message-Id: <20191018.130114.1049813900782682005.davem@davemloft.net>
To:     opendmb@gmail.com
Cc:     f.fainelli@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/4] net: bcmgenet: restore internal EPHY support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1571267192-16720-1-git-send-email-opendmb@gmail.com>
References: <1571267192-16720-1-git-send-email-opendmb@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 18 Oct 2019 10:01:15 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>
Date: Wed, 16 Oct 2019 16:06:28 -0700

> I managed to get my hands on an old BCM97435SVMB board to do some
> testing with the latest kernel and uncovered a number of things
> that managed to get broken over the years (some by me ;).
> 
> This commit set attempts to correct the errors I observed in my
> testing.
> 
> The first commit applies to all internal PHYs to restore proper
> reporting of link status when a link comes up.
> 
> The second commit restores the soft reset to the initialization of
> the older internal EPHYs used by 40nm Set-Top Box devices.
> 
> The third corrects a bug I introduced when removing excessive soft
> resets by altering the initialization sequence in a way that keeps
> the GENETv3 MAC interface happy.
> 
> Finally, I observed a number of issues when manually configuring
> the network interface of the older EPHYs that appear to be resolved
> by the fourth commit.

Series applied and queued up for -stable.

Thanks.
