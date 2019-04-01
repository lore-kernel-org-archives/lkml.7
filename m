Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0308AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8BA2082C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 21:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbfDAV57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 17:57:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:38754 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfDAV57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 17:57:59 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D611E108DB216;
        Mon,  1 Apr 2019 14:57:58 -0700 (PDT)
Date:   Mon, 01 Apr 2019 14:57:58 -0700 (PDT)
Message-Id: <20190401.145758.1217078322453821754.davem@davemloft.net>
To:     vkoul@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        xiaofeis@codeaurora.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: dsa: read mac address from DT for slave device
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190329053458.11891-1-vkoul@kernel.org>
References: <20190329053458.11891-1-vkoul@kernel.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 01 Apr 2019 14:57:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>
Date: Fri, 29 Mar 2019 11:04:58 +0530

> From: Xiaofei Shen <xiaofeis@codeaurora.org>
> 
> Before creating a slave netdevice, get the mac address from DTS and
> apply in case it is valid.
> 
> Signed-off-by: Xiaofei Shen <xiaofeis@codeaurora.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> v2: Rebase on net-next. The binding patch is already merged

Applied.
