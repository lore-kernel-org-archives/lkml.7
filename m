Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616C2CA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40DAC20650
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 18:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbfJaSBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 14:01:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:58466 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbfJaSBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 14:01:01 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:1e2::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0CB2514DE0AF7;
        Thu, 31 Oct 2019 11:01:01 -0700 (PDT)
Date:   Thu, 31 Oct 2019 11:01:00 -0700 (PDT)
Message-Id: <20191031.110100.985830325607594650.davem@davemloft.net>
To:     sheetal.tigadoli@broadcom.com
Cc:     zajec5@gmail.com, gregkh@linuxfoundation.org,
        michal.simek@xilinx.com, rajan.vaja@xilinx.com,
        scott.branden@broadcom.com, ray.jui@broadcom.com,
        vikram.prakash@broadcom.com, jens.wiklander@linaro.org,
        michael.chan@broadcom.com, vikas.gupta@broadcom.com,
        vasundhara-v.volam@broadcom.com, linux-kernel@vger.kernel.org,
        tee-dev@lists.linaro.org, bcm-kernel-feedback-list@broadcom.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next V5 0/3] Add OP-TEE based bnxt f/w manager
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1572516532-5977-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1572516532-5977-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 31 Oct 2019 11:01:01 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
Date: Thu, 31 Oct 2019 15:38:49 +0530

> This patch series adds support for TEE based BNXT firmware
> management module and the driver changes to invoke OP-TEE
> APIs to fastboot firmware and to collect crash dump.
> 
> Changes from v4:
>  - update Kconfig to reflect dependency on TEE driver

Series applied, thanks.
