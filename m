Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A02C282E3
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EAE20883
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555771315;
	bh=PVnNhyRleDbEAV6UTinyiOeB/7TcxgpW5JYSjPeIj7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ktCfCuG31uoXbW4Dzl6HvWAggHXmvkDap5p6OTF+iewBbjnE2lmhbeH5JbCfgmwPw
	 mKivcAYR8iberHmobh+rmuPqbRlagQJf914zsbG944Qn29nWeKNZj2e8/JKsWrbGtB
	 9k8l/OuzagZPRf9SVdbuSnCSLnZV8EErXUEWLnOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbfDTOly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 10:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:53066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728214AbfDTOlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 10:41:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D50502087F;
        Sat, 20 Apr 2019 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555771313;
        bh=PVnNhyRleDbEAV6UTinyiOeB/7TcxgpW5JYSjPeIj7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FyznfWjoE7EIVcE4wIVePkDuu5tp4LSQEbsYLVULEJngcF5AP+LKH7u4c+N3OdXpm
         tDuX2n/Wpg9U/3f8MCXdCcrJFGdtKMSEsnFj3kVVAZwhf68AJZybPVHlPZvvoHoL0V
         6ng/B1btoY263+tc0TuiThnysDVAa3VliEC5hXLY=
Date:   Sat, 20 Apr 2019 16:41:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.0 00/93] 5.0.9-stable review
Message-ID: <20190420144151.GC12442@kroah.com>
References: <20190418160436.781762249@linuxfoundation.org>
 <20190420122823.GB18303@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190420122823.GB18303@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 05:58:23PM +0530, Bharath Vedartham wrote:
> Built and booted on my x86 machine.
> Observed no dmesg regressions.

Thanks for testing two of these and letting me know.

greg k-h
