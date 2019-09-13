Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952E7C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7229720692
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbfIMN5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:57:33 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44222 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388170AbfIMN5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:57:33 -0400
Received: from localhost (93-63-141-166.ip28.fastwebnet.it [93.63.141.166])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A43DE14C68421;
        Fri, 13 Sep 2019 06:57:31 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:57:30 +0100 (WEST)
Message-Id: <20190913.145730.1373154947483393005.davem@davemloft.net>
To:     felipe.balbi@linux.intel.com
Cc:     richardcochran@gmail.com, christopher.s.hall@intel.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PTP: add support for one-shot output
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190911061622.774006-2-felipe.balbi@linux.intel.com>
References: <20190911061622.774006-1-felipe.balbi@linux.intel.com>
        <20190911061622.774006-2-felipe.balbi@linux.intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 13 Sep 2019 06:57:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Felipe Balbi <felipe.balbi@linux.intel.com>
Date: Wed, 11 Sep 2019 09:16:22 +0300

> Some controllers allow for a one-shot output pulse, in contrast to
> periodic output. Now that we have extensible versions of our IOCTLs, we
> can finally make use of the 'flags' field to pass a bit telling driver
> that if we want one-shot pulse output.
> 
> Signed-off-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Applied.
