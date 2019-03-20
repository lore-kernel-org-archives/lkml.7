Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 453F7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1355D2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfCTK1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:27:22 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40881 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTK1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:27:22 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1h6YRJ-0006hP-BB; Wed, 20 Mar 2019 11:27:17 +0100
Message-ID: <1553077636.7071.3.camel@pengutronix.de>
Subject: Re: [PATCH 2/5] reset: Add acquired flag to
 of_reset_control_array_get()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Felipe Balbi <balbi@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Date:   Wed, 20 Mar 2019 11:27:16 +0100
In-Reply-To: <87tvfyujgp.fsf@linux.intel.com>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
         <20190221152557.8534-2-thierry.reding@gmail.com>
         <1553013476.6482.6.camel@pengutronix.de> <87tvfyujgp.fsf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-03-20 at 08:51 +0200, Felipe Balbi wrote:
> Philipp Zabel <p.zabel@pengutronix.de> writes:
[...]
> > Felipe, could I get your acked-by to merge this through the reset tree?
> > 
> > dwc3-of-simple is a bit of a special case because it calls
> > of_reset_control_array_get directly instead of through the
> > of_reset_control_array_get_shared/exclusive wrappers.
> 
> Sure thing:
> 
> Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>

Thank you, I've added patches 1-3 to reset/next and named a stable
branch that could be used as a dependency for patches 4-5:

  git://git.pengutronix.de/pza/linux reset/acquire

regards
Philipp
