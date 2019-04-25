Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00232C282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43B221908
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556186363;
	bh=jdQqa7Sf60L2sC2sHzY7dgwhy6jwDMony/OjebD6UGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i06j0TsxxD06mOSDFSMjeHi46r8fAUrwyi8uvkTosxRR/kajCgbu5TdoanfIOZNrM
	 Cr4JJ92DTXTw1FMeVEsFGVB5qStBgqfywUHxJiibm5AC98o2GHG4KEAiu6ZwHsihuo
	 X5E16hK2EmhvAmTLrMs30FSTp/2/N05e4zidY3jE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbfDYJ7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:59:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbfDYJ7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:59:22 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CE7B21908;
        Thu, 25 Apr 2019 09:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556186361;
        bh=jdQqa7Sf60L2sC2sHzY7dgwhy6jwDMony/OjebD6UGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ffnOENPetviFjeA88vNdyLhWnzFR+qceMU+u2niFw0U/HtPfmIKTqEpxwhdldDefg
         HimqxxzR87gx8HAGtPZp8406YkxhIIMszM9jdwleJ8s5pxoaod3DMilabi1pMzJb/6
         pOQN20MzpaSThNl0WCMwdCga4ji33MyIplB6lxE4=
Date:   Thu, 25 Apr 2019 11:59:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/3] stm class/intel_th: Fixes for v5.1
Message-ID: <20190425095919.GA8481@kroah.com>
References: <20190417073536.63014-1-alexander.shishkin@linux.intel.com>
 <8736m6za90.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736m6za90.fsf@ashishki-desk.ger.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 12:48:11PM +0300, Alexander Shishkin wrote:
> Alexander Shishkin <alexander.shishkin@linux.intel.com> writes:
> 
> > Hi Greg,
> 
> Hi Greg,
> 
> This seems to have fallen through the cracks. Unless you picked it up
> already, should I resend these as a part of my pull request for v5.2
> instead? Both fixes are not v5.1 specific and will have to go to stable
> either way.

I just picked these up a few hours ago :)

thanks,

greg k-h
