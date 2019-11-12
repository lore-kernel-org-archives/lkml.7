Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8806FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BDB621925
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 05:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573536760;
	bh=RG1oWiggXdSe9vO5CCDyrPIbTcHDIldhXDw4m678LhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aBrvllJpmNOIX7pdkp7HpMpKciLVuHhl+PU2Xqkeiza+Ra6y73B5rgC1yzVHm/89Y
	 tnbUddh/elONe48MIo8xny3rriv66u+Pic9xahCM2y1yvFT+plBjmKOoqtXKx4MVwa
	 RQEnkqs7HEGBOE5Ai9SoIeuj4L6338lBitjBNrIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfKLFci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 00:32:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:60430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfKLFcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 00:32:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DE8F2084F;
        Tue, 12 Nov 2019 05:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573536753;
        bh=RG1oWiggXdSe9vO5CCDyrPIbTcHDIldhXDw4m678LhI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhCIAd3gQ1jSS+ceZbGGaQeeYR7I5oVDWip9i7bMdhG5MtvQGGkuQ772OjD80XCnk
         ACpZKKLbwn+FOxsIQ3rdlYA3smwDrjk1DDDVIGChKALljwjd5a32zwjvfY7joCbhJt
         y+e21gat7nW7hxZiBWcNJxK31ImFRuu/ntCLqZv4=
Date:   Tue, 12 Nov 2019 06:27:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/65] 4.9.201-stable review
Message-ID: <20191112052759.GB1208865@kroah.com>
References: <20191111181331.917659011@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191111181331.917659011@linuxfoundation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 07:28:00PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.201 release.
> There are 65 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Nov 2019 18:08:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.201-rc1.gz

There is now an -rc2:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.201-rc2.gz
