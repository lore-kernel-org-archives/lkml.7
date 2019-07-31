Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A6AC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5522208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 16:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfGaQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 12:35:38 -0400
Received: from smtprelay0134.hostedemail.com ([216.40.44.134]:35456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726817AbfGaQfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:35:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C43F68368EF7;
        Wed, 31 Jul 2019 16:35:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hall11_87d69988b0f62
X-Filterd-Recvd-Size: 2454
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 31 Jul 2019 16:35:33 +0000 (UTC)
Message-ID: <b93bbb17b407e27bb1dc196af84e4f289d9dfd93.camel@perches.com>
Subject: Re: [PATCH] net: sctp: Rename fallthrough label to unhandled
From:   Joe Perches <joe@perches.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 31 Jul 2019 09:35:31 -0700
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
> > > > 
> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > > Are you referring to the __attribute__((fallthrough)) statement that gcc
> > > supports?  If so the compiler should by all rights be able to differentiate
> > > between a null statement attribute and a explicit goto and label without the
> > > need for renaming here.  Or are you referring to something else?
> > 
> > Hi.
> > 
> > I sent after this a patch that adds
> > 
> > # define fallthrough                    __attribute__((__fallthrough__))
> > 
> > https://lore.kernel.org/patchwork/patch/1108577/
> > 
> > So this rename is a prerequisite to adding this #define.
> > 
> why not just define __fallthrough instead, like we do for all the other
> attributes we alias (i.e. __read_mostly, __protected_by, __unused, __exception,
> etc)

Because it's not as intelligible when used as a statement.



