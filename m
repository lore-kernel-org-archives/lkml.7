Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF9BC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2624C20835
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfD3WNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 18:13:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbfD3WNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 18:13:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A679A36887;
        Tue, 30 Apr 2019 22:13:20 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 38D6762661;
        Tue, 30 Apr 2019 22:13:20 +0000 (UTC)
Subject: Re: linux-next: Fixes tag needs some work in the modules tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190501081054.387820b2@canb.auug.org.au>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <fab23e00-5623-6fd0-18dd-f063dc1658ba@redhat.com>
Date:   Tue, 30 Apr 2019 18:13:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501081054.387820b2@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 30 Apr 2019 22:13:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/19 6:10 PM, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   7e470ea99bcd ("kernel/module: Reschedule while waiting for modules to finish loading")
> 
> Fixes tag
> 
>   Fixes: linux-next commit f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
> 
> has these problem(s):
> 
>   - the "linux-next commit" is unexpected (and not really meaningful
>     once this is merged into Linus' tree)
> 

Stephen, I will send out an updated patch now.

P.
