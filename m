Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A79DCC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F1F2089E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 14:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560177869;
	bh=VLfM+wWmxpE5AULiFHFYRojFpTMl7cMl/hwlGcegjgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G7iM64UsijY7r3pcDJD+VppNVvzRXZyyMdKOdngRkZ4S1bSJ1VKFwyRx6qu5NJjV1
	 1IRoyi9bOOH0CC6AYFgOa82SqQvthk5i14IWF3fJiVspYNmV4eqTklL0TTMcLSEzBm
	 /x1R5el56BOYjfA6P/ECEJ7kfFvU675+RlyQ142U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390940AbfFJOo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 10:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389055AbfFJOo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 10:44:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA36820862;
        Mon, 10 Jun 2019 14:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560177868;
        bh=VLfM+wWmxpE5AULiFHFYRojFpTMl7cMl/hwlGcegjgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jc2MaiVDg2758MmQoWZbjHHQJDc/Xa2e2UsmDtfUj/SenOvyC3fjdQIpnmFeOQ8qN
         IHz38ARkQSI65W0TV3vjf1uuZp67HKX02i5VcaZwUdA8Fx0pGwXVGVy63MRSNGVqlJ
         sEsvHguvSjm/gUXMZwT94Bp/Oc3PcxlFoxO6Z03o=
Date:   Mon, 10 Jun 2019 16:44:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, monstr@monstr.eu, johan@kernel.org,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] serial: xilinx_uartps: Fix warnings in the driver
Message-ID: <20190610144425.GC31086@kroah.com>
References: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6753260caf8b20cc002b15fcbf22b759c91d760.1560156294.git.michal.simek@xilinx.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:44:55AM +0200, Michal Simek wrote:
> From: Nava kishore Manne <nava.manne@xilinx.com>
> 
> This patch fixes the below warning
> 
>         -->Symbolic permissions 'S_IRUGO' are not preferred.
>            Consider using octal permissions '0444'.
>         -->macros should not use a trailing semicolon.
>         -->line over 80 characters.
>         -->void function return statements are not generally useful.
>         -->Prefer 'unsigned int' to bare use of 'unsigned'.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Happy to split it if needed.

Please split.  Do not do more than one "logical thing" per patch.

And the subject is not correct, there are no general "warnings", these
are all checkpatch warnings, not a build issue.

thanks,

greg k-h
