Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90ED4C04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C299208C4
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557255542;
	bh=7a2ZC1Xil9Kl6OEy8H8UAMoaH5NenYZzPr2YvQkz/1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u/3KjPEl8Rc4NUHGPDd6GORmVASYTmTd6Va9cpVKcIvRIOQ4mIjEJ9h0OA9c9DocH
	 llzxRgDI+ZDTCVPtIMy/kvaPFwx+ADf0Wf4ce9NCxl1bdtodZDiEd2o3BNOzNQDzxp
	 +6YtY1ArwKt4vNb8tHghv5wWZBNkgDkNlB9wQLD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfEGS7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:59:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfEGS7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:59:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D6020578;
        Tue,  7 May 2019 18:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557255540;
        bh=7a2ZC1Xil9Kl6OEy8H8UAMoaH5NenYZzPr2YvQkz/1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W1e4WeGn7M7ACK8Gc/MfIINB6UAIMhVVmdrIym5zmkxnIpAGbVTF1KIuZatbrhQwJ
         xJLqPk7lgNKeXuiXEgojULyNsFewTYNTYhNK594zncbb+O6cKGtOos87blmtMGUflu
         GrE4a+UifAipu5ZQ4+xE9MhNF0uAHOKOsieQU8Yo=
Date:   Tue, 7 May 2019 20:58:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.0 000/122] 5.0.14-stable review
Message-ID: <20190507185858.GD17205@kroah.com>
References: <20190506143054.670334917@linuxfoundation.org>
 <20190507183941.GD30225@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507183941.GD30225@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 11:39:41AM -0700, Guenter Roeck wrote:
> On Mon, May 06, 2019 at 04:30:58PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.0.14 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed 08 May 2019 02:29:09 PM UTC.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 349 pass: 349 fail: 0

Wonderful, thanks for testing all of these and letting me know.

greg k-h
