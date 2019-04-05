Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F56C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E8720700
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:47:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfDEQru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:47:50 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:40164 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730565AbfDEQru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:47:50 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hCS0I-0006wh-IS; Fri, 05 Apr 2019 18:47:46 +0200
Date:   Fri, 5 Apr 2019 18:47:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
Cc:     fw@strlen.de, shuah@kernel.org, pablo@netfilter.org,
        linu-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests : netfilter: Wrote a error and exit code for a
 command which needed veth kernel module.
Message-ID: <20190405164746.pfc6wxj4nrynjma4@breakpoint.cc>
References: <20190405163126.7278-1-jeffrin@rajagiritech.edu.in>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405163126.7278-1-jeffrin@rajagiritech.edu.in>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeffrin Jose T <jeffrin@rajagiritech.edu.in> wrote:
> A test for  the basic NAT functionality uses ip command which
> needs veth device.There is a condition where the kernel support
> for veth is not compiled into the kernel and the test script
> breaks.This patch contains code for reasonable error display
> and correct code exit.

Looks good to me, thanks for following up on this.

Acked-by: Florian Westphal <fw@strlen.de>
