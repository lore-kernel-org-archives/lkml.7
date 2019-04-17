Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6976DC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 378C920675
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 06:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555481779;
	bh=z0vazYtEo45DO7Bi0TAAbeDFnidlsHaTRkGeU+2g8VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iypzb58JxsRTHQ+zMaDHy9NmLCMRIebUaVcG6LcDZiLvupS7ImB/mIMv1exg4blAI
	 V4dxC/22kPZiZrTkia/6k1XpRSsbl+E+Fe7oFKQKWNf2jWvMU1GqxpkbdLsCCqlqcC
	 36o/xGZlOeL9cdYLsk4i9XviQ6P/+fpyHzoJVljI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730764AbfDQGQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 02:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:59744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729906AbfDQGQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 02:16:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15AB520835;
        Wed, 17 Apr 2019 06:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555481777;
        bh=z0vazYtEo45DO7Bi0TAAbeDFnidlsHaTRkGeU+2g8VE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xxRgWwWq5hg84dqSInhnsepAA8T0x05N/3UE7AlRA3C2dI1y+NRWUm5uO/pQ6qLZQ
         5UhO0g/1i/f/24mcbFdZTkRyKKZ1Lwd+LT6KkfeREMQ3vD8RkUjHY+pXgeb63lhWbL
         64zhixyduTHhoHdchDTSGb7JiDohoPwtP5dcB/u0=
Date:   Wed, 17 Apr 2019 08:16:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.19 000/101] 4.19.35-stable review
Message-ID: <20190417061615.GE18320@kroah.com>
References: <20190415183740.341577907@linuxfoundation.org>
 <20190416221609.GB3502@bharath12345-Inspiron-5559>
 <20190417061556.GD18320@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417061556.GD18320@kroah.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 08:15:56AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 17, 2019 at 03:46:09AM +0530, Bharath Vedartham wrote:
> > Compiled and Booted(defconfig) on my x86 machine. No dmesg regressions.
> 
> Thanks for testing 2 of these and letting me know.

Oops, you tested 3, thanks for that :)
