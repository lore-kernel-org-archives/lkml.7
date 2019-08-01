Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE15C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:42:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5CCC206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 17:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387690AbfHARmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 13:42:35 -0400
Received: from smtprelay0128.hostedemail.com ([216.40.44.128]:55430 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731372AbfHARmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 13:42:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A968A181D3377;
        Thu,  1 Aug 2019 17:42:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: feast32_3347d10424416
X-Filterd-Recvd-Size: 2235
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Aug 2019 17:42:32 +0000 (UTC)
Message-ID: <a9d003ddd0d59fb144db3ecda3453b3d9c0cb139.camel@perches.com>
Subject: Re: [PATCH] net: sctp: Rename fallthrough label to unhandled
From:   Joe Perches <joe@perches.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Aug 2019 10:42:31 -0700
In-Reply-To: <20190801105051.GA11487@hmswarspite.think-freely.org>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <20190731111932.GA9823@hmswarspite.think-freely.org>
         <eac3fe457d553a2b366e1c1898d47ae8c048087c.camel@perches.com>
         <20190731121646.GD9823@hmswarspite.think-freely.org>
         <b93bbb17b407e27bb1dc196af84e4f289d9dfd93.camel@perches.com>
         <20190731205804.GE9823@hmswarspite.think-freely.org>
         <d68403ce9f7e8a68fff09d6b17e5d1327eb1e12d.camel@perches.com>
         <20190801105051.GA11487@hmswarspite.think-freely.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-08-01 at 06:50 -0400, Neil Horman wrote:
> On Wed, Jul 31, 2019 at 03:23:46PM -0700, Joe Perches wrote:
[]
> You can say that if you want, but you made the point that your think the macro
> as you have written is more readable.  You example illustrates though that /*
> fallthrough */ is a pretty common comment, and not prefixing it makes it look
> like someone didn't add a comment that they meant to.  The __ prefix is standard
> practice for defining macros to attributes (212 instances of it by my count).  I
> don't mind rewriting the goto labels at all, but I think consistency is
> valuable.

Hey Neil.

Perhaps you want to make this argument on the RFC patch thread
that introduces the fallthrough pseudo-keyword.

https://lore.kernel.org/patchwork/patch/1108577/


