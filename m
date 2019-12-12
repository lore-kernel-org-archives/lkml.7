Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FEEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49BE24654
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 09:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576141818;
	bh=U+hnRel9S6Skp+ZSiYAzCk3/MIe6mhHCJAubBiZdSuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KYTHPD0Bl+Uwh/1IzeWzi4Rg0eHwc6iv2fLitoIKprnYAoNq/hjdFc8GR6SgTQX5C
	 QHDSAyDBuxFJwg12AQiUpzH67FY2iE/EUaaYnKKqZkACNBWXTIjUrCCoG+BV8eslTo
	 lVg0Fx/CV4M+dfexO81KZ18kxa9xxWoa2bjGKhnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbfLLJKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 04:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfLLJKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 04:10:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC36214AF;
        Thu, 12 Dec 2019 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576141805;
        bh=U+hnRel9S6Skp+ZSiYAzCk3/MIe6mhHCJAubBiZdSuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OuyJSdI6Y8Ym84Nw+GWZhDR7OrdKBFLKKpcKsml8JIHCOiP28dRjTzPNmPTnv/KdE
         es4s45Hiaqp3iKqQa3LfCe59WLrsY2Wju4jLjLcARXxkAuy8+Q0qAqFtfORKs+qwF4
         30BgSCsUZT6MGXY1PQZ06GdolaOhfASyhr7Ajoos=
Date:   Thu, 12 Dec 2019 10:10:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeffrin Jose <jeffrin@rajagiritech.edu.in>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.4 00/92] 5.4.3-stable review
Message-ID: <20191212091002.GA1372814@kroah.com>
References: <20191211150221.977775294@linuxfoundation.org>
 <20191212082729.GA3268@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212082729.GA3268@debian>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 01:57:29PM +0530, Jeffrin Jose wrote:
> On Wed, Dec 11, 2019 at 04:04:51PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.3 release.
> > There are 92 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 13 Dec 2019 14:56:06 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.3-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> > and the diffstat can be found below.
> 
> No new errors from "sudo dmesg -l err".

great, thanks for testing.

greg k-h
