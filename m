Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE39C18E7C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E882184B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 05:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558503305;
	bh=rIW/GsA7284cux8meon4p2hWkblm9vX45SryQZ+Jp9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H2Uk4CLd0WLgsu9CejEuVNn3p1OtiAgTf0AMHZzFgUcmoDWctjC/jIBulobtON0MQ
	 JvkcwczuIpUTkOtfWM0+Rq34eh4FiIaoT1lkWjNwX6juxqsT0AusDdqP3ljL4dxQ+9
	 iEQbMMObwQm9Nb2E4e1qJWHQO4n/6w/woUTW7ZxQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfEVFfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 01:35:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbfEVFfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 01:35:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E285D20862;
        Wed, 22 May 2019 05:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558503303;
        bh=rIW/GsA7284cux8meon4p2hWkblm9vX45SryQZ+Jp9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdxrYqxkoAtThalF5cIgBOTxjX9FGo8ft5rR4+X12Hbtw06DYwMvrvkmveKh3PxAk
         ZY1aObdbVvlwfozSXA6If7kDAExRE7HbLhPOT53umeeRNHZ1lnTBlktkATLr8bJ8SY
         8mOhdkYGbk4SjPOzZ77uNNxqIXgF7JyTQsjCfm7U=
Date:   Wed, 22 May 2019 07:35:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.1 000/128] 5.1.4-stable review
Message-ID: <20190522053500.GA16977@kroah.com>
References: <20190520115249.449077487@linuxfoundation.org>
 <0c574740-e2be-b2ee-4b0e-f17e5b08d342@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c574740-e2be-b2ee-4b0e-f17e5b08d342@kernel.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 03:11:15PM -0600, shuah wrote:
> On 5/20/19 6:13 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.1.4 release.
> > There are 128 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed 22 May 2019 11:50:41 AM UTC.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.1.4-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.1.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on the test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
