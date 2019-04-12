Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C314C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355AF218C3
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 17:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfDLRKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 13:10:45 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46924 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfDLRKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 13:10:44 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BDA6E133EB06B;
        Fri, 12 Apr 2019 10:10:43 -0700 (PDT)
Date:   Fri, 12 Apr 2019 10:10:41 -0700 (PDT)
Message-Id: <20190412.101041.259784853562829642.davem@davemloft.net>
To:     dongli.zhang@oracle.com
Cc:     xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.liu2@citrix.com,
        paul.durrant@citrix.com, joe.jin@oracle.com, junxiao.bi@oracle.com,
        jie.l.li@oracle.com
Subject: Re: [PATCH 1/1] xen-netback: add reference from xenvif to
 backend_info to facilitate coredump analysis
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1555052004-31855-1-git-send-email-dongli.zhang@oracle.com>
References: <1555052004-31855-1-git-send-email-dongli.zhang@oracle.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Apr 2019 10:10:44 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dongli Zhang <dongli.zhang@oracle.com>
Date: Fri, 12 Apr 2019 14:53:24 +0800

> During coredump analysis, it is not easy to obtain the address of
> backend_info in xen-netback.
> 
> So far there are two ways to obtain backend_info:
> 
> 1. Do what xenbus_device_find() does for vmcore to find the xenbus_device
> and then derive it from dev_get_drvdata().
> 
> 2. Extract backend_info from callstack of xenwatch (e.g., netback_remove()
> or frontend_changed()).
> 
> This patch adds a reference from xenvif to backend_info so that it would be
> much more easier to obtain backend_info during coredump analysis.
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>

Applied to net-next.
