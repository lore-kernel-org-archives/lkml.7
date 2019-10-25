Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE9ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF6B821D7B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 02:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571971280;
	bh=9f/gp/YkGJW0WiL42yaYU2/xs6JBR+9HqT5XD0qf4GM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IVuTtU+AWhntsbcpnJpRxb9UV8yJylk9S8MNvs/AyCn4tkc5y1WfWnmLiMnUaH2OQ
	 XUS2Tv/D5pya2jYtwFupip4WIH6S7dJ96lCzOZssxWuRsIe8PEacg9rTuQ3s8pejp3
	 8zzrf1TeqlSSB9mLokXmrA0KmBMDXzm+zTEozj84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390567AbfJYClT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 22:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390411AbfJYClT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 22:41:19 -0400
Received: from localhost (unknown [38.98.37.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E50C2166E;
        Fri, 25 Oct 2019 02:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571971278;
        bh=9f/gp/YkGJW0WiL42yaYU2/xs6JBR+9HqT5XD0qf4GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=la1oZ+kEXMwHHIWOE8BIezTxFprLu/NOrFgzMAlbcxbgWXdlX7tkeNbx9mdg314E7
         LfotSZGvlCsKJ4qFQEsMZFlsQ6Lop+Upz3FCdbL5AEQXeszWoZCrxZ5FY2garrl0PH
         khZ5DMabTIhlgIQtASbz5WBplrfl8yqRF7oyQOLc=
Date:   Thu, 24 Oct 2019 22:35:51 -0400
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chandra Annamaneni <chandra627@gmail.com>
Cc:     gneukum1@gmail.com, dan.carpenter@oracle.com,
        michael.scheiderer@fau.de, fabian.krueger@fau.de, simon@nikanor.nu,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] staging: KPC2000: kpc2000_spi.c: Fix style issues
 (misaligned brace)
Message-ID: <20191025023551.GA307080@kroah.com>
References: <20191018070948.22279-1-chandra627@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018070948.22279-1-chandra627@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 12:09:48AM -0700, Chandra Annamaneni wrote:
> Resolved: ERROR: else should follow close brace '}'
> 
> Signed-off-by: Chandra Annamaneni <chandra627@gmail.com>
> ---
> Previous versions of these patches were not split into different 
> patches, did not have different patch numbers and did not have the
> keyword staging. The previous version of this patch had the wrong 
> description and subject.

Ok, but I only see 1 patch here.

Can you resend the whole series properly, with a "v2" showing what
changed?

thanks,

greg k-h
