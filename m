Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F236ACA9EC2
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C501320663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 08:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572336221;
	bh=VItppw3O8SrEKZD64Wi0dUhslsw5znQj7NIHpJn67Cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=j8/rTuh1pHDZW+nswbMCQjzsbytknx/HBBjKh52l3hLYQhS3uLFIDUuvfdM96ZlBj
	 U18c9Vk+vrvXSQlolwwJZ5vrI9MANmC7ZhiBuxLKMI4cNguxI73GvCe+IXE0/O+A4e
	 K1+yjjQ/3EHWXGKAXPsDyH3Q/J2roeK4XxPhu62M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbfJ2IDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 04:03:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfJ2IDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 04:03:40 -0400
Received: from localhost (unknown [91.217.168.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DF1D20663;
        Tue, 29 Oct 2019 08:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572336219;
        bh=VItppw3O8SrEKZD64Wi0dUhslsw5znQj7NIHpJn67Cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4Y8W4SEtb/4TCNNRCX+zR9YUgPxZHvmDq3kUWiLy7BPACcqsUr0hGvSundLwftVF
         hvexX7WiDnTL1aZmj6w6n9VKAwapJJDmswzlVr/BfNu/wD3HbzZqb6N1vYSajwZ0mV
         HUHmpE8Z3cjtVBcnRsY77lgl1a45ueab/bBIznLc=
Date:   Tue, 29 Oct 2019 09:03:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: fieldbus: make use of
 devm_platform_ioremap_resource
Message-ID: <20191029080336.GA493801@kroah.com>
References: <1570515056-23589-1-git-send-email-hariprasad.kelam@gmail.com>
 <CAGngYiX0zoAQB=SEoXfoMm9u_JzHu3eLErj4zmTYtSAoDwkp6Q@mail.gmail.com>
 <CAGngYiXxagQMiHA-pZupTPHfyFz4kU=QOrvM28L_jSV1VGw=jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXxagQMiHA-pZupTPHfyFz4kU=QOrvM28L_jSV1VGw=jQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 05:11:26PM -0400, Sven Van Asbroeck wrote:
> Hi Greg, friendly reminder... Did you miss the patch review below, or
> is there a reason
> why this isn't getting queued?
> 
> There seems to be a crowd chasing down this type of warnings, resulting
> in multiple duplicates.

This has been in my tree already for a while, can you verify it is all
ok?

thanks,

greg k-h
