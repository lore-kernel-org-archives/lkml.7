Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE925C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB4221655
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556373040;
	bh=e6L6MmMlieAHJPgRCy3+wAmTTyNMNMNoEwj07ORqlAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lgLSN7RITFzpHgz8BnlNk1bi7H5Tj1rMveODKXKqCjmj5d0YczLMs8ct0gmsEd3Om
	 Bk7qKYP5/dfVtieVsAVQjCZCTKNhwDC378wp1UsaFvXqz6Cb4ycrOVMgA1an95xAUr
	 PDvlrmXCggmBQqgOsednGYE4rTN5ogchaCHW8T3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfD0Nue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 09:50:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfD0Nud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 09:50:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E89214C6;
        Sat, 27 Apr 2019 13:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556373033;
        bh=e6L6MmMlieAHJPgRCy3+wAmTTyNMNMNoEwj07ORqlAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i18E+XGCiJQEb6QwOiaj2tDlcMj8fhLmSqWBp/IPdQUCn7C7K16YU6x3wZ6LFSscD
         fodr9zu1EAULE7zivk7C+84v78AKaMbgT0t0xWRyHXCZSHA3Q+O6Gq0tbLeTQVxWL5
         IuLmSvRbAUo7kweePqCyz4vZ87ycPZWQdz+QJo7E=
Date:   Sat, 27 Apr 2019 15:49:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Thunderbolt changes for v5.2
Message-ID: <20190427134927.GA30374@kroah.com>
References: <20190426113727.GQ2583@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426113727.GQ2583@lahna.fi.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 02:37:27PM +0300, Mika Westerberg wrote:
> Hi Greg,
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git tags/thunderbolt-for-v5.2

Now pulled and pushed out, thanks.

greg k-h
