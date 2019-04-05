Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF38A21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 09:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfDEJmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 05:42:46 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:42466 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfDEJmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 05:42:46 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-66-98-nat.elisa-mobile.fi [85.76.66.98])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 65BA920088;
        Fri,  5 Apr 2019 12:42:43 +0300 (EEST)
Date:   Fri, 5 Apr 2019 12:42:43 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     saiprakash.ranjan@codeaurora.org,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v2] drivers: firmware: psci: add support for warm reset
Message-ID: <20190405094242.GB17115@darkstar.musicnaut.iki.fi>
References: <20190403185123.15873-1-aaro.koskinen@iki.fi>
 <39242b1d62b639f8fdc92029d737b5e0@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39242b1d62b639f8fdc92029d737b5e0@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 05, 2019 at 08:58:30AM +0530, saiprakash.ranjan@codeaurora.org wrote:
> On 2019-04-04 00:21, Aaro Koskinen wrote:
> >From: Aaro Koskinen <aaro.koskinen@nokia.com>
> >
> >Add support for warm reset using SYSTEM_RESET2 introduced in PSCI
> >1.1 specification.
> >
> 
> There is already a patch sent by Sudeep for this support.
> 
> - https://lore.kernel.org/lkml/1525257003-8608-1-git-send-email-sudeep.holla@arm.com/

OK, I have missed that. Sudeep, are you planning to send a new version
of this patch? Looks like the last was sent almost a year ago.

A.
