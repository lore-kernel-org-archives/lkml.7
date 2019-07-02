Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05EBC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B686C21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 17:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562090370;
	bh=jldOSORjTXuV/e+V0eHEheGdoG2uE9kVM1Mc0/gseU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WAbBqhjsb6iutDvAuNS7AIBLOIM1d8CPOyeay0kPmAZHD3IGtEDTFTCeUMnxDak01
	 XYX8r5KH2WAdkvu/ixXaddGD/2mJgsKnZD1W5obKxokYU9TCcpEpw1y+Zwkk99/9ZX
	 W2bN0eddmA5+4utzZjKZi1xyAMzwmXa2AmZAUoHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfGBR73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 13:59:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGBR73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 13:59:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53BAF2089C;
        Tue,  2 Jul 2019 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562090368;
        bh=jldOSORjTXuV/e+V0eHEheGdoG2uE9kVM1Mc0/gseU8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MMJxnI+oKrOaX7UXDex/RrGc4wTuulzbRR5SePPm6B+euF/XT5o0vXXvN+avPrbsD
         OZny2AqNPaPzl+N+wkXePhb4m5UEI9mrDnFVFs2daxv+mDiYwvw4gB6i1wCQ7j8dy3
         YHYi7fRFryZwCe1AGoDGIrds0kd97X2t5cwcTJec=
Date:   Tue, 2 Jul 2019 19:59:24 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        kernel-janitors@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] openpromfs: Adjust three seq_printf() calls in
 property_show()
Message-ID: <20190702175924.GA20949@kroah.com>
References: <22563348-fefa-8540-9d71-de37764f0596@web.de>
 <c26343465261e636ef029b8d0d7cb46183a23d23.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26343465261e636ef029b8d0d7cb46183a23d23.camel@perches.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02, 2019 at 09:08:04AM -0700, Joe Perches wrote:
> On Tue, 2019-07-02 at 17:40 +0200, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Tue, 2 Jul 2019 17:24:27 +0200
> > 
> > A bit of information should be put into a sequence.
> > Thus improve the execution speed for this data output by better usage
> > of corresponding functions.
> > 
> > This issue was detected by using the Coccinelle software.
> 
> (wasn't Markus perma-banned?)

He's in my kill-file, I recommend you doing the same, it's much easier
that way :)

thanks,

greg k-h
