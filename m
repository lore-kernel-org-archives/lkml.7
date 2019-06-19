Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEBEC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF03D2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 06:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560926867;
	bh=Lw51ETJCagdJjPcdiX//pROPxBVlyXwdRk48OK7aJUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u/ya1oEDqK4snISvWiDOy0C0dv68qOu54uQIZ7gddTdG9brdCLFzirayyI+dRnuGG
	 AaxlRHzj9EwuD5ipL7EUptw8W+JtWuxfK2kqGuLlOCbJ/uRaDozoBKUZ3blPPJmGIB
	 8ySZK0g3YLxAt6TCN2DOiIV5fzsIBguhLDcDZFlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfFSGrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 02:47:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfFSGrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 02:47:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B56C2084A;
        Wed, 19 Jun 2019 06:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560926864;
        bh=Lw51ETJCagdJjPcdiX//pROPxBVlyXwdRk48OK7aJUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMAOriz8CR4Mj7WHSmVXF2DYVl4C9P/ejNJdwEw8Ldzj5aFwd2HPFy8C/kRz9EMoq
         IO7vcajxnK178OYeC6WETJTm8AiRudQpQPM3PQhGZ/2qh+wv2Hf0D/4dhXoGqi/SAh
         dtJkPyPo1XRAH63fKw6KIhb+Ku426t5FTPu5okA4=
Date:   Wed, 19 Jun 2019 08:47:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Oliver Neukum <oneukum@suse.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Johan Hovold <johan@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Felipe Balbi <balbi@kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1 14/22] docs: usb: rename files to .rst and add them to
 drivers-api
Message-ID: <20190619064741.GB1082@kroah.com>
References: <cover.1560891322.git.mchehab+samsung@kernel.org>
 <c05aecb424e4f835e3f7872ecb5818e1d2f3267c.1560891322.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c05aecb424e4f835e3f7872ecb5818e1d2f3267c.1560891322.git.mchehab+samsung@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 06:05:38PM -0300, Mauro Carvalho Chehab wrote:
> While there are a mix of things here, most of the stuff
> were written from Kernel developer's PoV. So, add them to
> the driver-api book.
> 
> A follow up for this patch would be to move documents from
> there that are specific to sysadmins, adding them to the
> admin-guide.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

Ah,  I guess I can take this through my tree, will do that later today.

thanks,

greg k-h
