Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206E3C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE83B204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbfDJIQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:16:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44454 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbfDJIQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:16:32 -0400
Received: from 79.184.255.221.ipv4.supernova.orange.pl (79.184.255.221) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id dae130f1f40b40f8; Wed, 10 Apr 2019 10:16:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pavel Machek <pavel@ucw.cz>, Yangtao Li <tiny.windzz@gmail.com>
Cc:     len.brown@intel.com, gregkh@linuxfoundation.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PM / core: fix kerneldoc comment for dpm_watchdog_handler()
Date:   Wed, 10 Apr 2019 10:14:19 +0200
Message-ID: <3427737.Aay4R73sDK@aspire.rjw.lan>
In-Reply-To: <20190318121654.GF6101@amd>
References: <20190316033751.31323-1-tiny.windzz@gmail.com> <20190318121654.GF6101@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 18, 2019 1:16:54 PM CEST Pavel Machek wrote:
> 
> --w3uUfsyyY1Pqa/ej
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Fri 2019-03-15 23:37:51, Yangtao Li wrote:
> > This brings the kernel doc in line with the function signature.
> >=20
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Patch applied, thanks!

