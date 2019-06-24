Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCF6C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE7C02133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 14:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfFXO1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 10:27:51 -0400
Received: from smtprelay0176.hostedemail.com ([216.40.44.176]:58485 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727742AbfFXO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 10:27:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2872E180A68A0;
        Mon, 24 Jun 2019 14:27:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: music70_444d31ab65a3e
X-Filterd-Recvd-Size: 1449
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Jun 2019 14:27:49 +0000 (UTC)
Message-ID: <9528bb2c4455db9e130576120c8b985b9dd94e3d.camel@perches.com>
Subject: Re: [PATCH] get_maintainer: Add --cc option
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 24 Jun 2019 07:27:47 -0700
In-Reply-To: <20190624133333.GW3419@hirez.programming.kicks-ass.net>
References: <20190624130323.14137-1-bigeasy@linutronix.de>
         <20190624133333.GW3419@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-06-24 at 15:33 +0200, Peter Zijlstra wrote:
> On Mon, Jun 24, 2019 at 03:03:23PM +0200, Sebastian Andrzej Siewior wrote:
> > The --cc adds a Cc: prefix infront of the email address so it can be
> > used by other Scripts directly instead of adding another wrapper for
> > this.

Not sure I like the "--cc" option naming.
Maybe "--prefix [string]" to be a bit more generic.

> Would it make sense to make '--cc' imply --no-roles --no-rolestats ?

Maybe.

It's also unlikely to be sensibly used with mailing
lists so maybe --nol too.


