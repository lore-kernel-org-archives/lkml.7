Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7969CC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547E220675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfEERb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 13:31:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52938 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbfEERbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 13:31:55 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A963714DA6474;
        Sun,  5 May 2019 10:31:54 -0700 (PDT)
Date:   Sun, 05 May 2019 10:31:54 -0700 (PDT)
Message-Id: <20190505.103154.823912444487756109.davem@davemloft.net>
To:     laurentiu.tudor@nxp.com
Cc:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        Joakim.Tjernlund@infinera.com,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] dpaa_eth: fix SG frame cleanup
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190503130311.9914-1-laurentiu.tudor@nxp.com>
References: <20190503130311.9914-1-laurentiu.tudor@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 05 May 2019 10:31:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: laurentiu.tudor@nxp.com
Date: Fri,  3 May 2019 16:03:11 +0300

> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> 
> Fix issue with the entry indexing in the sg frame cleanup code being
> off-by-1. This problem showed up when doing some basic iperf tests and
> manifested in traffic coming to a halt.
> 
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Acked-by: Madalin Bucur <madalin.bucur@nxp.com>

Applied and queued up for -stable.
