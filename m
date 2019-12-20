Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63439C2D0C8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B648206D3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 17:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576861773;
	bh=XyJ1AeaC2SJO3yNM00L+SzFRZr0LtbTBoQMsv5kLx4Q=;
	h=To:Subject:Date:From:Cc:In-Reply-To:References:List-ID:From;
	b=Hp8L3NqN9OwGBLO4QsHaxu2uMJFQxVNLwoUBVXQ+l6sMkGmFagClWY3O8ZCQJNQ5O
	 epXsOpgR0MPANTFqf6c1mRHSLnBULFDM+5Oa3cmLfriHumGBPJCfIiNoNuu+2Gm+2d
	 gT39KARtMACrlDup7vkE1U/2c17CRJqUtevF3dy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLTRJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:09:32 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:35028 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727362AbfLTRJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 12:09:31 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iiLmK-0002Xe-G3; Fri, 20 Dec 2019 18:09:28 +0100
To:     Paul Cercueil <paul@crapouillou.net>
Subject: Re: [BUG] CI20: interrupt-controller@10001000 didn't like hwirq-0x0  to VIRQ8 mapping =?UTF-8?Q?=28rc=3D-=31=39=29?=
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Dec 2019 17:09:28 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-mips@vger.kernel.org>,
        MIPS Creator CI20 Development 
        <mips-creator-ci20-dev@googlegroups.com>,
        Zhou Yanjie <zhouyanjie@zoho.com>
In-Reply-To: <1576861276.3.1@crapouillou.net>
References: <8BA39E30-53CB-47DB-8890-465ACB760402@goldelico.com>
 <1576861276.3.1@crapouillou.net>
Message-ID: <4ea8fd0952b940b37a174fded9b5ebda@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: paul@crapouillou.net, hns@goldelico.com, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, mips-creator-ci20-dev@googlegroups.com, zhouyanjie@zoho.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-12-20 17:01, Paul Cercueil wrote:
> Hi Nikolaus,
>
> Try with this: https://lkml.org/lkml/2019/11/22/1831
>
> And don't hesitate to add your Tested-by :)

Is that an actual fix? It wasn't tagged as such, which is why
I didn't send it right away... It'd  be good to find out.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
