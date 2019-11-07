Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AA3C5DF61
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F38921882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573135969;
	bh=oCGRslHe9Ygu7scxwnjJrxwGU0pwKMwcwqz796hhE94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i7NdM5hSF8NOs83Z42cwUe0rYY42D2LYGiiAZrV8K4lzwz6o+r7kEB2ZCiGuWeQZd
	 0aeknAYPa6Llh/HCWS0u1/YJKeCV2tFAhTk+5JrN+alwINNXWdj60nC5y/7lG2QQdz
	 Qxsqn3vXW+ylHzVWDGn2C2EUrDh5OVfubrxx1pGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfKGOMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 09:12:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbfKGOMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 09:12:47 -0500
Received: from linux-8ccs (x2f7fd33.dyn.telefonica.de [2.247.253.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A942178F;
        Thu,  7 Nov 2019 14:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573135967;
        bh=oCGRslHe9Ygu7scxwnjJrxwGU0pwKMwcwqz796hhE94=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AYDIsmPuwTTimYGQfgQDHrjugb4vtMt2yFMPh7HOOcJDg2Xc533pQBCESwGRJKdEk
         bgaOLA3b3hNTcIFy7uoGt2XGkwAKe3sUAXGqKgvwlHijTT0V3UQDCG25E13BCJdZWY
         zSAlgCG2idesSoqfINqubWdhg8p+n/xsuIUP6DiA=
Date:   Thu, 7 Nov 2019 15:12:40 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Zhenzhong Duan <zhenzhong.duan@oracle.com>
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        gladkov.alexey@gmail.com, rusty@rustcorp.com.au
Subject: Re: [PATCH] moduleparam: fix parameter description mismatch
Message-ID: <20191107141240.GA6515@linux-8ccs>
References: <1572858577-8349-1-git-send-email-zhenzhong.duan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1572858577-8349-1-git-send-email-zhenzhong.duan@oracle.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Zhenzhong Duan [04/11/19 17:09 +0800]:
>The first parameter of module_param is @name, but @value is used
>in description. Fix it.
>
>Fixes: 546970bc6afc ("param: add kerneldoc to moduleparam.h")
>Signed-off-by: Zhenzhong Duan <zhenzhong.duan@oracle.com>

Applied, thanks.

Jessica

