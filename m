Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA6DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 21:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014F8205ED
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 21:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfD0VMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 17:12:13 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57458 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfD0VMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 17:12:12 -0400
Received: from localhost (unknown [12.154.31.190])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 692D414CF41C0;
        Sat, 27 Apr 2019 14:12:11 -0700 (PDT)
Date:   Sat, 27 Apr 2019 17:12:08 -0400 (EDT)
Message-Id: <20190427.171208.1923741550250297755.davem@davemloft.net>
To:     grygorii.strashko@ti.com
Cc:     netdev@vger.kernel.org, ilias.apalodimas@linaro.org,
        ivan.khoronzhuk@linaro.org, f.fainelli@gmail.com, andrew@lunn.ch,
        nsekhar@ti.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, m-karicheri2@ti.com
Subject: Re: [PATCH net-next v2 00/20] net: ethernet: ti: clean up and
 optimizations
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
References: <1556298762-8632-1-git-send-email-grygorii.strashko@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Apr 2019 14:12:12 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 26 Apr 2019 20:12:22 +0300

> This is a preparation series for introducing new switchbase TI CPSW driver which
> was originally introduced [1][2] by Ilias Apalodimas <ilias.apalodimas@linaro.org> 
> and also discussed in private mails and at Netdev x13 confernce.
 ...

Series applied, thank you.
