Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5504C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D09F20850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfCTRQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:16:30 -0400
Received: from a.mx.secunet.com ([62.96.220.36]:33898 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726529AbfCTRQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:16:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id 41F2A20184;
        Wed, 20 Mar 2019 18:16:27 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id I9kNGSrCEPPJ; Wed, 20 Mar 2019 18:16:23 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id B86D6200A7;
        Wed, 20 Mar 2019 18:16:23 +0100 (CET)
Received: from gauss2.secunet.de (10.182.7.193) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server id 14.3.439.0; Wed, 20 Mar 2019
 18:16:22 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)      id 03272318050E;
 Wed, 20 Mar 2019 18:16:23 +0100 (CET)
Date:   Wed, 20 Mar 2019 18:16:22 +0100
From:   Steffen Klassert <steffen.klassert@secunet.com>
To:     "Su Yanjun <suyj.fnst@cn.fujitsu.com>" <suyj.fnst@cn.fujitsu.com>
CC:     Eric Dumazet <eric.dumazet@gmail.com>, <davem@davemloft.net>,
        <fw@strlen.de>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: xfrm: Add '_rcu' tag for rcu protected pointer
 in netns_xfrm
Message-ID: <20190320171622.GA6035@gauss3.secunet.de>
References: <1551923648-17656-1-git-send-email-suyj.fnst@cn.fujitsu.com>
 <20190311101006.GK3758@gauss3.secunet.de>
 <b2beff03-f789-5c8b-bd69-57ece92372f8@gmail.com>
 <20190319151503.GW6035@gauss3.secunet.de>
 <91cf303a-7d44-2c15-8b7a-8b2eb797a234@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <91cf303a-7d44-2c15-8b7a-8b2eb797a234@cn.fujitsu.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 181D3464-E827-464D-B547-5AEC87B90C9B
X-G-Data-MailSecurity-for-Exchange-ProcessedOnRouted: True
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 08:53:54AM +0800, Su Yanjun <suyj.fnst@cn.fujitsu.com> wrote:
> 
> Firs of all, I didn't produce it on my test machine.

First of all, you should provide better quality patches.

All of your recent patches had issues, some were sorted 
out before applying other not. Bugs happen, but it is
not acceptable that all your patches are buggy.

I've reverted this patch like Eric suggested.
