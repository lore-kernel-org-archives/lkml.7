Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEC0C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 489DB2085A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 07:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556781610;
	bh=otilETRd29CkIhyLirC9XZ6k4DP9hiNq+U0b66iznaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qYC+maJIFp2xHSqIbM6MlZV+wjFEwMHwG63fTSvG6D9ylZhFb8nFJrz6hH0R6KjX4
	 WihLGnc3/qB5EbAvrSzpY938sT9asYYPjTmYzZR95n81t78WoDSMjS4bSAawz3tzaA
	 1lWNKvrk5DHIxDSMH3gPJTnMZyECeDpPxQ8QBqd4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfEBHUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 03:20:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbfEBHUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 03:20:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954002085A;
        Thu,  2 May 2019 07:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556781608;
        bh=otilETRd29CkIhyLirC9XZ6k4DP9hiNq+U0b66iznaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwZe7aQlz+VB2W8iPsolYzOeFs3Qzs9CkjaJgC1FlAuyDlFLJKyKsQ6f/yLQlJrcG
         RoSWtNoSs9al0h3vaf7tnpQcYU7Yup2VtghMxrNRgSf4f8pKULG+L2u8L8HxTUK3I1
         QWUaSCKQSsaHwKrDa5SM5TjasCIwDhM9w16cIlK8=
Date:   Thu, 2 May 2019 09:20:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] kobject: Fix kernel-doc comment first line
Message-ID: <20190502072005.GE16247@kroah.com>
References: <20190502023142.20139-1-tobin@kernel.org>
 <20190502023142.20139-4-tobin@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190502023142.20139-4-tobin@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 02, 2019 at 12:31:40PM +1000, Tobin C. Harding wrote:
> kernel-doc comments have a prescribed format.  This includes parenthesis
> on the function name.  To be _particularly_ correct we should also
> capitalise the brief description and terminate it with a period.

Ah, I didn't know that, sorry about that, my fault.  I'll take patch 2
and 3 now in my tree, thanks!

greg k-h
