Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C250EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:41:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2CD2166E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 09:41:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbfEQJlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 05:41:36 -0400
Received: from relay.sw.ru ([185.231.240.75]:36768 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727338AbfEQJlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 05:41:35 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hRZMo-0003eQ-PP; Fri, 17 May 2019 12:41:30 +0300
Subject: Re: linux-next: Tree for May 17
To:     Stephen Rothwell <sfr@canb.auug.org.au>, atish.patra@wdc.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190517142152.588edb6e@canb.auug.org.au>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <a119ca58-6771-cc36-fe5a-187ba500010a@virtuozzo.com>
Date:   Fri, 17 May 2019 12:41:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517142152.588edb6e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2019 07:21, Stephen Rothwell wrote:
> Hi all,
> 
> Please do not add any v5.3 material to your linux-next included
> trees/branches until after v5.2-rc1 has been released.
> 
> Changes since 20190516:
> 
> The kvm tree gained conflicts against Linus' tree.
> 
> Non-merge commits (relative to Linus' tree): 1023
>  1119 files changed, 27058 insertions(+), 7629 deletions(-)

Binary file was added:

~/linux-next$ git log --oneline ./modules.builtin.modinfo
4cbb0d07b4d1 RISC-V: Support nr_cpus command line option.

Kirill
