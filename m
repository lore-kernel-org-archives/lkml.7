Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05853C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF01E20675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556184537;
	bh=URCqkzVldPf84U1FbE7p8afUIm+YhFpMisQ0TUtUsPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aUPDMrLcD1PDvckgKAuY+3Bmxl30ax0+Eoy1r23Wz3+irKi74cTGmSaPRkNNQAQkj
	 W/JXywuWNp8E4VeiLHH5ViIpMSBcBDgfaOiSL10SxiAoHYeSLUPLE7lXJdbJ25P5qw
	 9qDXf0jYdtUpBomVPVWhsKHfQar9AWQU2VjC9Ba0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfDYJ24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:28:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbfDYJ2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:28:55 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA73920675;
        Thu, 25 Apr 2019 09:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556184535;
        bh=URCqkzVldPf84U1FbE7p8afUIm+YhFpMisQ0TUtUsPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r4SXNu5632SmfB6+ebDSTh8O/U9kEpckCWXg4nPe6xejce45cVeeiOPY2iy+gZjxI
         IsTHH+LLWmFDTp+fdbiFuzFcM4lkWvCh+FjqG8MbeemrAvL2bR3aww31lNOPlciYpY
         S4+m+zwkhM3PwohxwVKBwc9Xy/lcvFX8BA2ZTCac=
Date:   Thu, 25 Apr 2019 11:28:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] PHY: For 5.1 -rc
Message-ID: <20190425092836.GB5959@kroah.com>
References: <20190417125758.5742-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417125758.5742-1-kishon@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 06:27:58PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> Please find the updated pull request for 5.1 -rc.
> 
> I've removed the lengthy ti-pipe3 PHY driver changes to follow the TRM
> sequence. This will be included in 5.2 -rc1 pull request.
> 
> I've also added an additional patch to fix gadget mode working in
> Allwinner's sun4i-usb PHY driver.

Now pulled and pushed out, thanks.

greg k-h
