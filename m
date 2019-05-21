Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BE8C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC27213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 00:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfEUAxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 20:53:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60222 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfEUAxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 20:53:17 -0400
Received: from localhost (50-78-161-185-static.hfc.comcastbusiness.net [50.78.161.185])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 07C13140F844A;
        Mon, 20 May 2019 17:53:16 -0700 (PDT)
Date:   Mon, 20 May 2019 20:53:16 -0400 (EDT)
Message-Id: <20190520.205316.2191376307434511568.davem@davemloft.net>
To:     bjorn.andersson@linaro.org
Cc:     aneela@codeaurora.org, hofrat@osadl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: Fix message type of outgoing packets
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190520235156.28902-1-bjorn.andersson@linaro.org>
References: <20190520235156.28902-1-bjorn.andersson@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 May 2019 17:53:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>
Date: Mon, 20 May 2019 16:51:56 -0700

> QRTR packets has a message type in the header, which is repeated in the
> control header. For control packets we therefor copy the type from
> beginning of the outgoing payload and use that as message type.
> 
> For non-control messages an endianness fix introduced in v5.2-rc1 caused the
> type to be 0, rather than QRTR_TYPE_DATA, causing all messages to be dropped by
> the receiver. Fix this by converting and using qrtr_type, which will remain
> QRTR_TYPE_DATA for non-control messages.
> 
> Fixes: 8f5e24514cbd ("net: qrtr: use protocol endiannes variable")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied, thank you.
