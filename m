Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F614C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0176F218C3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 09:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfGEJqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 05:46:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64049 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727477AbfGEJqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 05:46:55 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id bb9bb51f507f0fb5; Fri, 5 Jul 2019 11:46:52 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PM: Unexport acpi_device_get_power()
Date:   Fri, 05 Jul 2019 11:46:52 +0200
Message-ID: <2054223.OgheZKOciF@kreacher>
In-Reply-To: <20190704074640.GF2640@lahna.fi.intel.com>
References: <1970901.ZntFDt4DbR@kreacher> <20190704074640.GF2640@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 4, 2019 9:46:40 AM CEST Mika Westerberg wrote:
> On Thu, Jul 04, 2019 at 01:02:49AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Using acpi_device_get_power() outside of ACPI device initialization
> > and ACPI sysfs is problematic due to the way in which power resources
> > are handled by it, so unexport it and add a paragraph explaining the
> > pitfalls to its kerneldoc comment.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> 
> Makes perfect sense!
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 

Thanks!

I've queued this one for 5.3.




