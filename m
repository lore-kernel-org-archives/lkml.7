Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B180C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115842183F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 17:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436511AbfHBRrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 13:47:41 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:45469 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403848AbfHBRrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 13:47:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id CD337182CED28;
        Fri,  2 Aug 2019 17:47:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: can20_824817fd5037
X-Filterd-Recvd-Size: 1668
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Aug 2019 17:47:35 +0000 (UTC)
Message-ID: <a03a23728d3b468942a20b55f70babceaec587ee.camel@perches.com>
Subject: Re: [PATCH] net: sctp: Rename fallthrough label to unhandled
From:   Joe Perches <joe@perches.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 02 Aug 2019 10:47:34 -0700
In-Reply-To: <20190731121646.GD9823@hmswarspite.think-freely.org>
References: <e0dd3af448e38e342c1ac6e7c0c802696eb77fd6.1564549413.git.joe@perches.com>
         <20190731111932.GA9823@hmswarspite.think-freely.org>
         <eac3fe457d553a2b366e1c1898d47ae8c048087c.camel@perches.com>
         <20190731121646.GD9823@hmswarspite.think-freely.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-07-31 at 08:16 -0400, Neil Horman wrote:
> On Wed, Jul 31, 2019 at 04:32:43AM -0700, Joe Perches wrote:
> > On Wed, 2019-07-31 at 07:19 -0400, Neil Horman wrote:
> > > On Tue, Jul 30, 2019 at 10:04:37PM -0700, Joe Perches wrote:
> > > > fallthrough may become a pseudo reserved keyword so this only use of
> > > > fallthrough is better renamed to allow it.

Can you or any other maintainer apply this patch
or ack it so David Miller can apply it?

Thanks.

