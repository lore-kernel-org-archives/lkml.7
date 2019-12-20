Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2A6C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 223DA24676
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 01:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfLTBdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 20:33:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45002 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfLTBdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 20:33:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id E84ED1540B59E;
        Thu, 19 Dec 2019 17:33:35 -0800 (PST)
Date:   Thu, 19 Dec 2019 17:33:35 -0800 (PST)
Message-Id: <20191219.173335.447023512566099980.davem@davemloft.net>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, r.baldyga@samsung.com, k.opasiak@samsung.com,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nfc: s3fwrn5: replace the assertion with a WARN_ON
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20191217204300.28616-1-pakki001@umn.edu>
References: <20191217204300.28616-1-pakki001@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 19 Dec 2019 17:33:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>
Date: Tue, 17 Dec 2019 14:43:00 -0600

> In s3fwrn5_fw_recv_frame, if fw_info->rsp is not empty, the
> current code causes a crash via BUG_ON. However, s3fwrn5_fw_send_msg
> does not crash in such a scenario. The patch replaces the BUG_ON
> by returning the error to the callers and frees up skb.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied.
