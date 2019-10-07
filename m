Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1875AC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D508821721
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570454152;
	bh=yaGiBdsMqATrOurcaKLKqrYg43AY7Q6N3F9F+dL0RI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aQwSCwi8DXq/N7+4TzDsvvlczvXtFabEmGgxjTPGVO+ERQkFtqQu2xd0yTgqXobuZ
	 l7Mkw36vyFjB534gT6HAYegOpKKxpRjh/o20BjjaC3p14RFUQpjy4nb9gVYIvwGwp3
	 DnERYr5/MXHpni4alT1jSn5scEv2uAmy/xTTD4vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfJGNPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfJGNPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:15:51 -0400
Received: from linux-8ccs (ip5f5ade87.dynamic.kabel-deutschland.de [95.90.222.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07A032084D;
        Mon,  7 Oct 2019 13:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570454151;
        bh=yaGiBdsMqATrOurcaKLKqrYg43AY7Q6N3F9F+dL0RI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=thZqMFMsagBTGSCXcSjKL/6nXbiyrTIcKSMg69+btrs+dfxzO9yHnezGb63jHXhoy
         mUcG0ZUANN3GoFS44ixg7JzGIi+XqRgMCarou3TuSu8lzwOf45KQui+OnokRmvQ8Ti
         O4ZsT2wgXBbV2Gf/rAVBpXVqrca2xB+GncwUKGTs=
Date:   Mon, 7 Oct 2019 15:15:42 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Julia.Lawall@lip6.fr, Gilles.Muller@lip6.fr, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, maennich@google.com,
        gregkh@linuxfoundation.org, yamada.masahiro@socionext.com,
        Markus.Elfring@web.de, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: add_namespace: Fix coccicheck failed
Message-ID: <20191007131542.GA30078@linux-8ccs>
References: <CAK7LNAS2K6i+s2A_xTyRq730M6_=tyjtfwHAnEHF37_nrJa4Eg@mail.gmail.com>
 <20191006044456.57608-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191006044456.57608-1-yuehaibing@huawei.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.28-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ YueHaibing [06/10/19 12:44 +0800]:
>Now all scripts in scripts/coccinelle to be automatically called
>by coccicheck. However new adding add_namespace.cocci does not
>support report mode, which make coccicheck failed.
>This add "virtual report" to  make the coccicheck go ahead smoothly.
>
>Fixes: eb8305aecb95 ("scripts: Coccinelle script for namespace dependencies.")
>Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the fix!

If there are no complaints, I'll queue this up in the modules tree for -rc3.

Jessica
