Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C34CC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123D0217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558529217;
	bh=4U9I/NIQVI//8jEbd8ZkohshHTF1sn59PS/Bq9njMLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X5TMyjt+SH5E1LEq/HZr2YfgK1hYES3vdoRR0bjVuMjgopKoq1ow8OUfoDYpDx36d
	 wnCeWDe/Bvi6CqXdmnaOKMpKwgh2bp5L5ro1ZZYoE9ls3l2c0zmWOnohvMspnQFDlh
	 UfgtwYpOR4r3XlyHJVPQIS5mxDKIpUZifDYN8K60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfEVMq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 08:46:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:39736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbfEVMqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 08:46:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1E821773;
        Wed, 22 May 2019 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558529215;
        bh=4U9I/NIQVI//8jEbd8ZkohshHTF1sn59PS/Bq9njMLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AudOvINVOGb4x2bKnHS0cL/0I2MQxsxZE0I1RGx+QCjXy8AgPOMX/H5z7/buVmllm
         YkOmvkLJwOYL39HC4UDzkQBw6bB/PlYXxH1eyMZePkHjE1Iz1vXav5ennBIQogRzQp
         nQqso7OYwuKP2oQP4DsBFyS/tZHic/LM81X+f4o8=
Date:   Wed, 22 May 2019 14:46:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geordan Neukum <gneukum1@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Matt Sickler <Matt.Sickler@daktronics.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 3/6] staging: kpc2000: kpc_i2c: newline fixups to meet
 linux style guide
Message-ID: <20190522124652.GB22148@kroah.com>
References: <cover.1558526487.git.gneukum1@gmail.com>
 <1c1b8428a502e79f19af7bc2a98787ecc6a1ed5a.1558526487.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1b8428a502e79f19af7bc2a98787ecc6a1ed5a.1558526487.git.gneukum1@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 12:13:59PM +0000, Geordan Neukum wrote:
> The linux coding style document states:
> 
>   1) That braces should not be used where a single single statement
>      will do. Therefore all instances of single block statements
>      wrapped in braces that do not meet the qualifications of any
>      of the exceptions to the rule should be fixed up.
> 
>   2) That the declaration of variables local to a given function
>      should be immediately followed by a blank newline. Therefore,
>      the single instance of this in kpc2000_i2c.c should be fixed
>      up.

This really should be 2 different patches, but given that this file is
so messy, I'll take it for now :)

thanks,

greg k-h
