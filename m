Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEA0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFF220882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554282400;
	bh=A6Nm0q7HTaFHeoEbxeJ31deY+pAB4tvx7dB1m9NOa2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LkDUFlU66vMIrcBDcOyqaA4vAM7N7r5UNYtIO78NIgy0NvxKxUn4OTiqDomKaH2LE
	 SiKgimYBkRNsCT7jmZtMxxR7CcdqLT7aZSUloFjy7lMNn1pDChYgXoDv6GONrpMSxj
	 NCu3k/2xexmWJGvi/6VQIHlCU2Hg3F5TH3JXfg3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfDCJGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDCJGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:06:38 -0400
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA90A20882;
        Wed,  3 Apr 2019 09:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554282398;
        bh=A6Nm0q7HTaFHeoEbxeJ31deY+pAB4tvx7dB1m9NOa2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bf+Jj6BV3L031DDOYZq+48N9LxToiNVDHPIu/iuLiOwPmnXCYamrXZlYZLFpUKj1W
         /M+jAFSAjC4+5tcWEr655Da6J18qTBhjkCeq8qiF9ZrNHBo+A+oHCiEuJMk5kpMt96
         lGeCcpyem6bVBuS8Q4oiAQE0iMqVvwKA22Gmduzs=
Date:   Wed, 3 Apr 2019 11:06:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] staging: add missing SPDX lines to Makefile files
Message-ID: <20190403090635.GA23934@kroah.com>
References: <20190402103203.14959-1-gregkh@linuxfoundation.org>
 <20190402103203.14959-3-gregkh@linuxfoundation.org>
 <78c7ffbe-0e2b-8dbd-021a-d05a84d3f88c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78c7ffbe-0e2b-8dbd-021a-d05a84d3f88c@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 05:36:20PM +0530, Mukesh Ojha wrote:
> 
> On 4/2/2019 4:01 PM, Greg Kroah-Hartman wrote:
> > There are a few remaining drivers/staging/*/Makefile files that do not
> > have SPDX identifiers in them.  Add the correct GPL-2.0 identifier to
> > them to make scanning tools happy.
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Lesson learnt :-)

Heh :)

> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

thanks for the review.

greg k-h
