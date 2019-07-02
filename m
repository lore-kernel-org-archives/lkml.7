Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1ADC5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BB0206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbfGBC3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:29:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54200 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfGBC3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:29:47 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D1A4B14DEC5E9;
        Mon,  1 Jul 2019 19:29:46 -0700 (PDT)
Date:   Mon, 01 Jul 2019 19:29:46 -0700 (PDT)
Message-Id: <20190701.192946.619458933774688152.davem@davemloft.net>
To:     hariprasad.kelam@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        andrew@lunn.ch, gregkh@linuxfoundation.org, yuehaibing@huawei.com,
        tglx@linutronix.de, mcgrof@kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: broadcom: bcm63xx_enet: Remove unneeded
 memset
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190630142949.GA7422@hari-Inspiron-1545>
References: <20190630142949.GA7422@hari-Inspiron-1545>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Jul 2019 19:29:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Date: Sun, 30 Jun 2019 19:59:49 +0530

> Remove unneeded memset as alloc_etherdev is using kvzalloc which uses
> __GFP_ZERO flag
> 
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

Applied to net-next, thanks.
