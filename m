Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BFBCA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 00:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 882C620862
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 00:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfJ3A5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 20:57:35 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33848 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfJ3A5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 20:57:35 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 9E004140F6FBE;
        Tue, 29 Oct 2019 17:57:34 -0700 (PDT)
Date:   Tue, 29 Oct 2019 17:57:34 -0700 (PDT)
Message-Id: <20191029.175734.1356331205705402957.davem@davemloft.net>
To:     Anson.Huang@nxp.com
Cc:     fugang.duan@nxp.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH RESEND 2/2] net: fec_ptp: Use
 platform_get_irq_xxx_optional() to avoid error message
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1572313999-23317-2-git-send-email-Anson.Huang@nxp.com>
References: <1572313999-23317-1-git-send-email-Anson.Huang@nxp.com>
        <1572313999-23317-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 29 Oct 2019 17:57:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>
Date: Tue, 29 Oct 2019 09:53:19 +0800

> Use platform_get_irq_byname_optional() and platform_get_irq_optional()
> instead of platform_get_irq_byname() and platform_get_irq() for optional
> IRQs to avoid below error message during probe:
> 
> [    0.795803] fec 30be0000.ethernet: IRQ pps not found
> [    0.800787] fec 30be0000.ethernet: IRQ index 3 not found
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Applied.
