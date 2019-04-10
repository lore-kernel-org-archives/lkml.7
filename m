Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D70C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CD0820820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfDJLmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:42:20 -0400
Received: from foss.arm.com ([217.140.101.70]:53028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbfDJLmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:42:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EADB80D;
        Wed, 10 Apr 2019 04:42:19 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88DD3F68F;
        Wed, 10 Apr 2019 04:42:17 -0700 (PDT)
Date:   Wed, 10 Apr 2019 12:42:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     saiprakash.ranjan@codeaurora.org,
        Michal Simek <michal.simek@xilinx.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: [PATCH v2] drivers: firmware: psci: add support for warm reset
Message-ID: <20190410114211.GA31173@e107155-lin>
References: <20190403185123.15873-1-aaro.koskinen@iki.fi>
 <39242b1d62b639f8fdc92029d737b5e0@codeaurora.org>
 <20190405094242.GB17115@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405094242.GB17115@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 12:42:43PM +0300, Aaro Koskinen wrote:
> Hi,
>
> On Fri, Apr 05, 2019 at 08:58:30AM +0530, saiprakash.ranjan@codeaurora.org wrote:
> > On 2019-04-04 00:21, Aaro Koskinen wrote:
> > >From: Aaro Koskinen <aaro.koskinen@nokia.com>
> > >
> > >Add support for warm reset using SYSTEM_RESET2 introduced in PSCI
> > >1.1 specification.
> > >
> >
> > There is already a patch sent by Sudeep for this support.
> >
> > - https://lore.kernel.org/lkml/1525257003-8608-1-git-send-email-sudeep.holla@arm.com/
>
> OK, I have missed that. Sudeep, are you planning to send a new version
> of this patch? Looks like the last was sent almost a year ago.
>

Sure I can, if there's a requirement and someone can test it.

--
Regards,
Sudeep

