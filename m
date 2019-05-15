Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350B9C04E84
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F052420862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 15:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557933192;
	bh=N0JP/I9yeESWU0sXjEb4CmutaTbQZ5eMVKu9BYHyjec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VYULgN+sy3IcCtBJvDjuGmgJZwBTkUrigtDniURL8tGHZ5CkNf8x4OlIp2ADfTESn
	 vGhA2PqZ2Iwi9luX3td2YrpyrOq4grzg3uGugBpMpsQHrQN3SFPRIZIOKtHOzTEFnY
	 j6LV5j3T9ovICwg8VR6bhlW61y0u5IVKJ6iCR+qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfEOPNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 11:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726572AbfEOPNK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 11:13:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FCF2084E;
        Wed, 15 May 2019 15:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557933189;
        bh=N0JP/I9yeESWU0sXjEb4CmutaTbQZ5eMVKu9BYHyjec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kOn0nx4AQgrset3TQ7UQ1Sla6KXTFWqbyx3JAmfkNaX/bju8Zmafb/C2hAjA0hZU2
         WI3GjTTnNOtFEGm+f6/xSoLEhmZAh70QKcLgNkIcy+6Y0f18AswlvGIaCrBrZ5+T44
         g/7vmkhysGUje0ac+JIUw9iYfnveT54atptpxCvA=
Date:   Wed, 15 May 2019 17:13:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/266] 4.4.180-stable review
Message-ID: <20190515151307.GA23599@kroah.com>
References: <20190515090722.696531131@linuxfoundation.org>
 <5cdc2691.1c69fb81.bd8d8.7247@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cdc2691.1c69fb81.bd8d8.7247@mx.google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 07:47:45AM -0700, kernelci.org bot wrote:
> stable-rc/linux-4.4.y boot: 98 boots: 1 failed, 92 passed with 3 offline, 1 untried/unknown, 1 conflict (v4.4.179-267-gbe756dada5b7)
> 
> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-4.4.y/kernel/v4.4.179-267-gbe756dada5b7/
> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y/kernel/v4.4.179-267-gbe756dada5b7/
> 
> Tree: stable-rc
> Branch: linux-4.4.y
> Git Describe: v4.4.179-267-gbe756dada5b7
> Git Commit: be756dada5b771fe51be37a77ad0bdfba543fdae
> Git URL: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> Tested: 44 unique boards, 21 SoC families, 14 builds out of 190
> 
> Boot Regressions Detected:
> 
> arm:
> 
>     omap2plus_defconfig:
>         gcc-8:
>           omap4-panda:
>               lab-baylibre: new failure (last pass: v4.4.179-254-gce69be0d452a)

Odd, is this specific to this release?

