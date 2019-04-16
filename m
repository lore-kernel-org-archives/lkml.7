Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9F2C10F12
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FC220830
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 00:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbfDPAWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 20:22:17 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59532 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfDPAWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 20:22:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 51F0A14E03FEC;
        Mon, 15 Apr 2019 17:22:16 -0700 (PDT)
Date:   Mon, 15 Apr 2019 17:22:15 -0700 (PDT)
Message-Id: <20190415.172215.1245391537925145089.davem@davemloft.net>
To:     m-karicheri2@ti.com
Cc:     arvid.brodin@alten.se, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 0/3] net: hsr: updates from internal tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190415153603.23110-1-m-karicheri2@ti.com>
References: <20190415153603.23110-1-m-karicheri2@ti.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 15 Apr 2019 17:22:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Murali Karicheri <m-karicheri2@ti.com>
Date: Mon, 15 Apr 2019 11:36:00 -0400

> This series picks commit from our internal kernel tree.
> Patch 1/3 fixes a file name issue introduced in my previous
> series.
> 
> History:
>   v2: fixed patch 3/3 by moving stats update to inside hsr_forward_skb()

Series applied, thanks.
