Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF8AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DC52081B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 22:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfCHWqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 17:46:09 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40992 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfCHWqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 17:46:09 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6B37514B72814;
        Fri,  8 Mar 2019 14:46:08 -0800 (PST)
Date:   Fri, 08 Mar 2019 14:46:07 -0800 (PST)
Message-Id: <20190308.144607.2073864110868935320.davem@davemloft.net>
To:     jiaolitao@raisecom.com
Cc:     petrm@mellanox.com, idosch@mellanox.com, roopa@cumulusnetworks.com,
        sd@queasysnail.net, sbrivio@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vxlan: do not need BH again in vxlan_cleanup()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1551844908-8152-1-git-send-email-jiaolitao@raisecom.com>
References: <1551844908-8152-1-git-send-email-jiaolitao@raisecom.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 08 Mar 2019 14:46:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Litao Jiao <jiaolitao@raisecom.com>
Date: Wed,  6 Mar 2019 12:01:48 +0800

> vxlan_cleanup() is a timer callback, it is already
> and only running in BH context.
> 
> Signed-off-by: Litao Jiao <jiaolitao@raisecom.com>

Agree with your analysis, applied, thanks.
