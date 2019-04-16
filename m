Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF89EC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9BAE20821
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 15:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555428111;
	bh=kDE6LsgOQakIDdiu4qHhRwU77GOGYrkQmkOZsTSL0xQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NcjyG+DWMc32n4Taglzte0EBXcNtd6/5yV1zmh6akaBHqtyvBwyAuHZ6dPS7cgVqp
	 zfbISrSqTpF4nBUO8krmwiZVINxspoDXwcKAnP6ISkhsVxN1W8NW0jKLYQTWQF5Y2G
	 9fiw1iHz+BOcdofzoNYXTM8R7/uFksJ/O7YjqvjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfDPPVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 11:21:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfDPPVu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 11:21:50 -0400
Received: from linux-8ccs (ip5f5adea9.dynamic.kabel-deutschland.de [95.90.222.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DD3320656;
        Tue, 16 Apr 2019 15:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555428109;
        bh=kDE6LsgOQakIDdiu4qHhRwU77GOGYrkQmkOZsTSL0xQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmkqwTBXCZQy197ssiG0bWuAIFQvdRgsiCFz8hBDpIz9wwsLgu3j11pdge0dAAhBu
         NlTDpZYSqqB3RlIEwt6mVfqXtAuKnTtBWPU5mLGjkIp37lYfl3P3nYrOtMzfqvSjcm
         pGdc+6ZEbcdbJiV4GXY379PngiwMUIZq+vlsBhwY=
Date:   Tue, 16 Apr 2019 17:21:44 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Tri Vo <trong@android.com>
Cc:     ndesaulniers@google.com, ghackmann@android.com, linux-mm@kvack.org,
        kbuild-all@01.org, rdunlap@infradead.org, lkp@intel.com,
        linux-kernel@vger.kernel.org, pgynther@google.com,
        willy@infradead.org, oberpar@linux.ibm.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2] module: add stubs for within_module functions
Message-ID: <20190416152144.GA1419@linux-8ccs>
References: <20190415142229.GA14330@linux-8ccs>
 <20190415181833.101222-1-trong@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190415181833.101222-1-trong@android.com>
X-OS:   Linux linux-8ccs 5.1.0-rc1-lp150.12.28-default+ x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Tri Vo [15/04/19 11:18 -0700]:
>Provide stubs for within_module_core(), within_module_init(), and
>within_module() to prevent build errors when !CONFIG_MODULES.
>
>v2:
>- Generalized commit message, as per Jessica.
>- Stubs for within_module_core() and within_module_init(), as per Nick.
>
>Suggested-by: Matthew Wilcox <willy@infradead.org>
>Reported-by: Randy Dunlap <rdunlap@infradead.org>
>Reported-by: kbuild test robot <lkp@intel.com>
>Link: https://marc.info/?l=linux-mm&m=155384681109231&w=2
>Signed-off-by: Tri Vo <trong@android.com>

Applied, thanks!

Jessica

