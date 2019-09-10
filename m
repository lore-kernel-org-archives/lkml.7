Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29ABC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C075C21019
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 07:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391206AbfIJHpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 03:45:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52758 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfIJHpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 03:45:41 -0400
Received: from localhost (unknown [88.214.187.83])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A0DB715449D9E;
        Tue, 10 Sep 2019 00:45:38 -0700 (PDT)
Date:   Tue, 10 Sep 2019 09:45:37 +0200 (CEST)
Message-Id: <20190910.094537.964213793959104412.davem@davemloft.net>
To:     msuchanek@suse.de
Cc:     netdev@vger.kernel.org, julietk@linux.vnet.ibm.com,
        benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        tlfalcon@linux.ibm.com, jallen@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ibmvnic: Fix missing { in __ibmvnic_reset
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190909204451.7929-1-msuchanek@suse.de>
References: <20190907.173714.1400426487600521308.davem@davemloft.net>
        <20190909204451.7929-1-msuchanek@suse.de>
X-Mailer: Mew version 6.8 on Emacs 26.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 10 Sep 2019 00:45:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>
Date: Mon,  9 Sep 2019 22:44:51 +0200

> Commit 1c2977c09499 ("net/ibmvnic: free reset work of removed device from queue")
> adds a } without corresponding { causing build break.
> 
> Fixes: 1c2977c09499 ("net/ibmvnic: free reset work of removed device from queue")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>

Applied.
