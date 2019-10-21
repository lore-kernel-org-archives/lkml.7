Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16517CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84932086D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 19:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbfJUTHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:07:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38882 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbfJUTHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 15:07:24 -0400
Received: from localhost (unknown [4.14.35.89])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2F110142C0124;
        Mon, 21 Oct 2019 12:07:24 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:07:21 -0700 (PDT)
Message-Id: <20191021.120721.11426412660322521.davem@davemloft.net>
To:     noguchi.kazutosi@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] r8152: add device id for Lenovo ThinkPad USB-C Dock
 Gen 2
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191020150306.11902-1-noguchi.kazutosi@gmail.com>
References: <20191020150306.11902-1-noguchi.kazutosi@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 21 Oct 2019 12:07:24 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kazutoshi Noguchi <noguchi.kazutosi@gmail.com>
Date: Mon, 21 Oct 2019 00:03:07 +0900

> This device is sold as 'ThinkPad USB-C Dock Gen 2 (40AS)'.
> Chipset is RTL8153 and works with r8152.
> Without this, the generic cdc_ether grabs the device, and the device jam
> connected networks up when the machine suspends.
> 
> Signed-off-by: Kazutoshi Noguchi <noguchi.kazutosi@gmail.com>

Applied and queued up for -stable, thanks.
