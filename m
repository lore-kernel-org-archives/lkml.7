Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DF0C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D25217D6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568890481;
	bh=rDgR/IXI3/KNnIOSsNKvBH94J0iAuZUG/sc3vnyuGDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0lpuXIm5JFJFlL6F8pSmCFHtMgKzvAKY7T8FIKZYiZ1jCzQNwa0X+lz4LNjcMGzv6
	 c6USq8+89t/Y2NVB72W/+/FqF0IyumeVaCL07OkDKrG/5cm6Hv/f6iJikRh5YPe0lZ
	 dkvijbIVmfP3JDlaD2h3Z7Z4WBPhczRTQAy0lVNw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389750AbfISKyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:54:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387712AbfISKyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:54:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E30DB21929;
        Thu, 19 Sep 2019 10:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568890475;
        bh=rDgR/IXI3/KNnIOSsNKvBH94J0iAuZUG/sc3vnyuGDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dL6NBBtdFOWNrEbiDMF7SAJ9/pmUh23uKcYzLxzNFIaTS1IBCOLPeSXqKuX8zudBn
         JWOf1PtaVG6zMj+/KCuzk458potLQmEdee6I+Yxm5jpR8bOKoaxygZrU6pBmO9Y9j+
         hZAky9zbjDHx0D8rC/Mq4PnsKuxlc7o5XHrdZl7Y=
Date:   Thu, 19 Sep 2019 12:54:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vineet Gupta <vineetg76@gmail.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild test robot <lkp@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: stable backport for dc8635b78cd8669
Message-ID: <20190919105432.GA2809200@kroah.com>
References: <efb68643-3750-e94b-8387-6e4cacb3a82a@gmail.com>
 <20190918185633.GB1944551@kroah.com>
 <6bcb935a-4dae-48cc-ad1e-88a51b9d6a5c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bcb935a-4dae-48cc-ad1e-88a51b9d6a5c@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 01:10:04PM -0700, Vineet Gupta wrote:
> On 9/18/19 11:56 AM, Greg Kroah-Hartman wrote:
> > So is this only needed in 4.9.y and 4.4.y?
> 
> Yes indeed !

It doesn't apply there at all, can you provide a working backport for
those kernels so that I can queue it up?

thanks,

greg k-h
