Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06866C00319
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16F320842
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 07:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551772731;
	bh=gKc9dAuoYo2pmN1uzNOkM2/ca84oMg5i953TGWgIee8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DXNvhyqJmIE6197N5N55jK1SfXqFT7fEQ18vlgGc9a9favij1XXuSX2gZXIL/PQ4r
	 M99/DUNEjHAsmbLakjhlfrrZX+H3dEKetsirYBzOepPFVTwjsIxk99zsI+FBRfmH7p
	 DqH+DzgpEluhDYVgDIJX4P3LSVWu/WHOzAgEdu3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfCEH6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 02:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:39466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfCEH6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 02:58:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0390520675;
        Tue,  5 Mar 2019 07:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551772729;
        bh=gKc9dAuoYo2pmN1uzNOkM2/ca84oMg5i953TGWgIee8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nxpHPhV3sSGuOz8wuBGpMmD7pdR8R4NdPv6X+fwGrRZfNkVuXDbcju3KksLy/mcJ7
         pFr/QvTf9Hq4nm6e69CeJJ4rtBdN9gtiyEVw/CRbsG28wP6SiY2Nl8CQD+eRGMlo08
         6e1qTKFsbDYc0eJ/UOQVWmNzAKcCffM0GrUZSR74=
Date:   Tue, 5 Mar 2019 08:58:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.20 00/88] 4.20.14-stable review
Message-ID: <20190305075847.GB5726@kroah.com>
References: <20190304081630.610632175@linuxfoundation.org>
 <85d11f50-7dde-54f4-9f4a-db37c56d063c@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85d11f50-7dde-54f4-9f4a-db37c56d063c@roeck-us.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2019 at 07:39:48PM -0800, Guenter Roeck wrote:
> On 3/4/19 12:21 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.20.14 release.
> > There are 88 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar  6 08:16:03 UTC 2019.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 159 pass: 159 fail: 0
> Qemu test results:
> 	total: 343 pass: 343 fail: 0

Great, thanks for testing these and letting me know.

greg k-h
