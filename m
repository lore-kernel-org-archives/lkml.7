Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF835C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5659215EA
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567516612;
	bh=8PuZ6CIqZbdEBj3j4oeP67KLW98tynqyHAl8TbwhiXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FbPaLZuSzCPgQe5jpOwhMwLX58CjDqxyvXffnA9uruZPxE8Ehy688jJqqt5qWvBwJ
	 P3jYWCGU7ZgdicLFYpvKWqyBOjXJ2prZ6Cn8G5a8E1n3iOxQ/lfDg7abJKzRR4F+RX
	 g9BDfTpiLLaqXJL8Z9I7sovh+r8ooJZSkOSPEJ+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfICNQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 09:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbfICNQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 09:16:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 601472053B;
        Tue,  3 Sep 2019 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567516610;
        bh=8PuZ6CIqZbdEBj3j4oeP67KLW98tynqyHAl8TbwhiXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XJ5AeAZzeFeTCivD9ka2My05hXt3PIAQJcDC2hQCNv3XXtjnNEal5KPrGskU+aRkL
         Fb7mJGcameV9z/0jlgsFsA3xenw1vZrO962QjdE3qYdJ52pwevwvt68X/M97/NiNcr
         w68My8yDF7l0slRsIsy3dAxykLbCpUE+mmJs9Gow=
Date:   Tue, 3 Sep 2019 15:16:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: usb dma_mask fixups
Message-ID: <20190903131648.GA19335@kroah.com>
References: <20190903084615.19161-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190903084615.19161-1-hch@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 03, 2019 at 10:46:09AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> the first patch fixes the ohci-sm501 regression that Guenther reported
> due to the platform device dma_mask changes.  The second one ports that
> fix to another driver that works the same way.  The rest cleans up
> various loose ends left over from the dma related usb changes in the
> last two merge windows.

Thanks for these, all now queued up.

greg k-h
