Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BBAC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A7620679
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 21:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbfHLVCv convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 17:02:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51242 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfHLVCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 17:02:50 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 69FCC154D32A7;
        Mon, 12 Aug 2019 14:02:50 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:02:44 -0700 (PDT)
Message-Id: <20190812.140244.1191094093267734606.davem@davemloft.net>
To:     git@andred.net
Cc:     linux-kernel@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: at803x: stop switching phy delay config
 needlessly
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190809112025.27482-1-git@andred.net>
References: <20190809005754.23009-1-git@andred.net>
        <20190809112025.27482-1-git@andred.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 12 Aug 2019 14:02:50 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: André Draszik <git@andred.net>
Date: Fri,  9 Aug 2019 12:20:25 +0100

> This driver does a funny dance disabling and re-enabling
> RX and/or TX delays. In any of the RGMII-ID modes, it first
> disables the delays, just to re-enable them again right
> away. This looks like a needless exercise.
> 
> Just enable the respective delays when in any of the
> relevant 'id' modes, and disable them otherwise.
> 
> Also, remove comments which don't add anything that can't be
> seen by looking at the code.
> 
> Signed-off-by: André Draszik <git@andred.net>

Applied.
