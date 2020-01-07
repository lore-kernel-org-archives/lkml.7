Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B97DC282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BBC2077B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 21:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgAGVvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 16:51:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:38578 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbgAGVvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:51:43 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 744F515A17608;
        Tue,  7 Jan 2020 13:51:42 -0800 (PST)
Date:   Tue, 07 Jan 2020 13:51:41 -0800 (PST)
Message-Id: <20200107.135141.2097652772096652883.davem@davemloft.net>
To:     vincent.cheng.xh@renesas.com
Cc:     richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 net-next 1/1] ptp: clockmatrix: Rework clockmatrix
 version information.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1578408477-4650-2-git-send-email-vincent.cheng.xh@renesas.com>
References: <1578408477-4650-1-git-send-email-vincent.cheng.xh@renesas.com>
        <1578408477-4650-2-git-send-email-vincent.cheng.xh@renesas.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 07 Jan 2020 13:51:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: vincent.cheng.xh@renesas.com
Date: Tue,  7 Jan 2020 09:47:57 -0500

> From: Vincent Cheng <vincent.cheng.xh@renesas.com>
> 
> Simplify and fix the version information displayed by the driver.
> The new info better relects what is needed to support the hardware.
> 
> Prev:
> Version: 4.8.0, Pipeline 22169 0x4001, Rev 0, Bond 5, CSR 311, IRQ 2
> 
> New:
> Version: 4.8.0, Id: 0x4001  Hw Rev: 5  OTP Config Select: 15
> 
> - Remove pipeline, CSR and IRQ because version x.y.z already incorporates
>   this information.
> - Remove bond number because it is not used.
> - Remove rev number because register was not implemented, always 0
> - Add HW Rev ID register to replace rev number
> - Add OTP config select to show the user configuration chosen by
>   the configurable GPIO pins on start-up
> 
> Signed-off-by: Vincent Cheng <vincent.cheng.xh@renesas.com>

Applied.
