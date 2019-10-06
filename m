Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33937C4740A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9A4222CB
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 00:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570322787;
	bh=mDMXJWH/nFeJNJwCLSbJe1N6n7x5kCnrUMEyt+durkA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2sH3bl1huB6CTwTIenYIy/X1eJXtkmWgbZwdDRu+J7iDID8cmVMxnxQ1zOtS9aN7d
	 ZHJRnn4fmMIUcO1jQDhg/pYTp8a5OGd9z/bPMFDWtdZmVDTzBq9ygnvCVir+Kjd/6t
	 Rn+dc1D2ZblOiAQ49G7vzGL6wMFxf8tUOO9Llg70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfJFAq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Oct 2019 20:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbfJFAq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Oct 2019 20:46:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20987222C0;
        Sun,  6 Oct 2019 00:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570322785;
        bh=mDMXJWH/nFeJNJwCLSbJe1N6n7x5kCnrUMEyt+durkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=somadfab2V4QHz/ZiMbEFMT0P+UUp3PyP4gF3k6a6e1C7ay80JzefelirS/RG3OoV
         /TXKEfRaxJwYQklwaHiaDbKlRHYsDJXtUIYWX3q1ttspvBrTeLvwL98CzfLIAX5//h
         nDXRRQMxAN+b+8HTvTljrKGE+e7wQJmfDLqVeJck=
Date:   Sat, 5 Oct 2019 20:46:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-stable@vger.kernel.org, linux-integrity@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Vadim Sukhomlinov <sukhomlinov@google.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] tpm: Fix TPM 1.2 Shutdown sequence to prevent
 future TPM operations
Message-ID: <20191006004624.GG25255@sasha-vm>
References: <20191003184623.25580-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191003184623.25580-1-jarkko.sakkinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 09:46:20PM +0300, Jarkko Sakkinen wrote:
>commit db4d8cb9c9f2af71c4d087817160d866ed572cc9 upstream
>
>This backport is for v4.14 and v4.19 The backport requires non-racy
>behaviour from TPM 1.x sysfs code. Thus, the dependecies for that
>are included.
>
>NOTE: 1/3 is only needed for v4.14.

I've queued these for 4.19 and 4.14, thanks!

-- 
Thanks,
Sasha
