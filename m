Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAEFC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D352086A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555405025;
	bh=F4aZi0U9e+0xZp6j6HTykcPMYPh4SS6gN8AoYGv+DO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jNRIi8xgLZaUUtLSg8WPSpWgPZrB953km8FNUqo05aEVHdi5oJXy9srEf4dTsaSb/
	 4afmHjr4Fb2iAc4vyffPsOS8RXR4Dl9Mkn/SJrnyxQsR3vipN1SU6PPNg3FVL2lPcA
	 5nlH7MCRY61Aj3nyP1ypUJ6FIM99B6wEz5A7s0j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfDPI5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:57:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726576AbfDPI5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:57:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3822520868;
        Tue, 16 Apr 2019 08:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555405023;
        bh=F4aZi0U9e+0xZp6j6HTykcPMYPh4SS6gN8AoYGv+DO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EoSE4W7HifXen2ROFUSgunsBvgr0+B8boKXz8zW9LQS8AcApa6fel36DH08rnQrwv
         gUn563wR37VSqKScsS5bZNEhqF9fniALQwPCjzpEaqHIdhq7U6jeDcNaDHFIXtx4V6
         4pURMLMinmjYgNUtXNZnFpRTzDDOuwAhjLl1DNqw=
Date:   Tue, 16 Apr 2019 10:57:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     stable@vger.kernel.org,
        Subbu Seetharaman <subbu.seetharaman@broadcom.com>,
        Ketan Mukadam <ketan.mukadam@broadcom.com>,
        Jitendra Bhivare <jitendra.bhivare@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.14] scsi:be2iscsi: Fix a kernel address leakage in
 be_main.c
Message-ID: <20190416085701.GB4209@kroah.com>
References: <20190416070634.13421-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416070634.13421-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:06:34PM +0800, Fuqian Huang wrote:
> Outputting kernel addresses will reveal the locations of kernel code
> and data. And there is no need to print the address of a global object 
> beiscsi_iscsi_transport in beiscsi_module_init.
> This case is similar to CVE-2018-7273[1].
> Just remove the print statement.
> 
> [1] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-7273
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
