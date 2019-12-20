Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCB2C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F83B227BF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 02:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfLTCUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 21:20:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45370 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLTCUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 21:20:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 87870154193C7;
        Thu, 19 Dec 2019 18:13:41 -0800 (PST)
Date:   Thu, 19 Dec 2019 18:13:40 -0800 (PST)
Message-Id: <20191219.181340.347587126710452987.davem@davemloft.net>
To:     opendmb@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/8] net: bcmgenet: Turn on offloads by
 default
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1576630275-17591-1-git-send-email-opendmb@gmail.com>
References: <1576630275-17591-1-git-send-email-opendmb@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Dec 2019 18:13:41 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Berger <opendmb@gmail.com>
Date: Tue, 17 Dec 2019 16:51:07 -0800

> This commit stack is based on Florian's commit 4e8aedfe78c7 ("net: 
> systemport: Turn on offloads by default") and enables the offloads for
> the bcmgenet driver by default.
> 
> The first commit adds support for the HIGHDMA feature to the driver.
> 
> The second converts the Tx checksum implementation to use the generic
> hardware logic rather than the deprecated IP centric methods.
> 
> The third modifies the Rx checksum implementation to use the hardware
> offload to compute the complete checksum rather than filtering out bad
> packets detected by the hardware's IP centric implementation. This may
> increase processing load by passing bad packets to the network stack,
> but it provides for more flexible handling of packets by the network
> stack without requiring software computation of the checksum.
> 
> The remaining commits mirror the extensions Florian made to the sysport
> driver to retain symmetry with that driver and to make the benefits of
> the hardware offloads more ubiquitous.

Series applied, thanks.
