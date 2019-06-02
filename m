Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC21C282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3290827917
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 16:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFBQRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 12:17:02 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:46926 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbfFBQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 12:17:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7C1AF100E86C4;
        Sun,  2 Jun 2019 16:17:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fifth40_1fde44ffb2025
X-Filterd-Recvd-Size: 1610
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun,  2 Jun 2019 16:16:58 +0000 (UTC)
Message-ID: <16f2f9c2e34d59cdf9a7bf0f5111251c284e0a3b.camel@perches.com>
Subject: Re: [PATCH] pci: hotplug: ibmphp: Add white space to Debug Message
From:   Joe Perches <joe@perches.com>
To:     benniciemanuel78@gmail.com, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 02 Jun 2019 09:16:57 -0700
In-Reply-To: <20190602160007.24684-1-benniciemanuel78@gmail.com>
References: <20190602160007.24684-1-benniciemanuel78@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-06-02 at 18:00 +0200, Emanuel Bennici wrote:
> Add a Whitespace between '-' and 'Exit' to keep the log messages consistent
[]
> diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
[]
> @@ -890,7 +890,7 @@ static int set_bus(struct slot *slot_cur)
>  	/* This is for x440, once Brandon fixes the firmware,
>  	will not need this delay */
>  	msleep(1000);
> -	debug("%s -Exit\n", __func__);
> +	debug("%s - Exit\n", __func__);

These sorts of messages should just be deleted
and the function tracer (ftrace) used instead.


