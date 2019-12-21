Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D4C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 05:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4728521D7D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 05:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbfLUFRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 00:17:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:56854 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfLUFRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 00:17:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 50522153CAB2E;
        Fri, 20 Dec 2019 21:17:34 -0800 (PST)
Date:   Fri, 20 Dec 2019 21:17:33 -0800 (PST)
Message-Id: <20191220.211733.1421052503969423092.davem@davemloft.net>
To:     vincent.cheng.xh@renesas.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, richardcochran@gmail.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 1/1] ptp: clockmatrix: Rework clockmatrix
 version information.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1576725697-11828-2-git-send-email-vincent.cheng.xh@renesas.com>
References: <1576725697-11828-1-git-send-email-vincent.cheng.xh@renesas.com>
        <1576725697-11828-2-git-send-email-vincent.cheng.xh@renesas.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 20 Dec 2019 21:17:34 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: vincent.cheng.xh@renesas.com
Date: Wed, 18 Dec 2019 22:21:37 -0500

> From: Vincent Cheng <vincent.cheng.xh@renesas.com>
> 
> Remove pipeline id, bond id, csr id, and irq id.
> Changes source register for reading HW rev id.
> Add OTP config select.
> 
> Signed-off-by: Vincent Cheng <vincent.cheng.xh@renesas.com>

Nothing in this commit message explains why this change is being made.

What is wrong with the existing version code?  What is better about the
new code?

You always must explain why a change is being made and give as much
information and details and background as possible.

Thank you.
