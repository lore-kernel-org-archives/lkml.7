Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28642C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0273323774
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567517226;
	bh=haTpkUOUatPzczAlhDd4FPo7PLw0VKU7P6K7K6xTcGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vn2ucpKwg1IC4YJQfONzNIoWSOcu4rgZy3EzkXGscRwGSIKvzHx1loAXAgkMK+10/
	 k5IF7IRsxAGGaPWCyEqi1fFmJjqrnS6lMwVir7GhJ17URXWgD2nDt+WGJ934zSu+rV
	 BGvutqnvXPYmRktnzdNdMCJLwbNLeMbkgTj0jiaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfICN1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:27:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728538AbfICN1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:27:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9010C23402;
        Tue,  3 Sep 2019 13:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567517223;
        bh=haTpkUOUatPzczAlhDd4FPo7PLw0VKU7P6K7K6xTcGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzyZJNInjuePV+FilxaGy6VwkAvtPu9MzSqASQkJm8pcS5NllLDbDCZGyqgKztfWU
         +dE/3Hk6pPvmsi/qPGKR3DypnZXSFWtid0O1mE9ZXAk0E49LzTxnz7wr2JOsQ4w2f8
         2G9Hna5WKh1uGUNIVCABKezJyBipt5O0CQHkmqF0=
Date:   Tue, 3 Sep 2019 15:27:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] usb/ohci-sm501: remove the HCD_DMA flag
Message-ID: <20190903132700.GA15835@kroah.com>
References: <20190903084615.19161-1-hch@lst.de>
 <20190903084615.19161-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903084615.19161-2-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:46:10AM +0200, Christoph Hellwig wrote:
> This driver doesn't support normal DMA, only direct access to its
> local memory.  Remove the HCD_DMA flag to properly express that fact.
> 
> Fixes: 1e4946c4412e ("usb: add a HCD_DMA flag instead of guestimating DMA capabilities")

Wrong sha1.  I fixed it up in my tree.

