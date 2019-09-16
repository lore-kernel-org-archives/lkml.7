Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8CCC49ED7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28756206A4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 07:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbfIPHQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 03:16:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44414 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfIPHQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:16:26 -0400
Received: from localhost (unknown [85.119.46.8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54E93151F4914;
        Mon, 16 Sep 2019 00:16:24 -0700 (PDT)
Date:   Mon, 16 Sep 2019 09:16:22 +0200 (CEST)
Message-Id: <20190916.091622.1261717371479832738.davem@davemloft.net>
To:     rain.1986.08.12@gmail.com
Cc:     mchehab+samsung@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: update FORCEDETH MAINTAINERS info
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190913134345.28318-1-rain.1986.08.12@gmail.com>
References: <20190913134345.28318-1-rain.1986.08.12@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Sep 2019 00:16:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: rain.1986.08.12@gmail.com
Date: Fri, 13 Sep 2019 21:43:45 +0800

> From: Rain River <rain.1986.08.12@gmail.com>
> 
> Many FORCEDETH NICs are used in our hosts. Several bugs are fixed and
> some features are developed for FORCEDETH NICs. And I have been
> reviewing patches for FORCEDETH NIC for several months. Mark me as the
> FORCEDETH NIC maintainer. I will send out the patches and maintain
> FORCEDETH NIC.
> 
> Signed-off-by: Rain River <rain.1986.08.12@gmail.com>

Applied.
