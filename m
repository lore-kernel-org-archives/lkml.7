Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2670DC0030B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00FF21871
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 18:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567882036;
	bh=ETlwQ/jDA2N/DocT9nVHq8Y/UgXTj0x2ZCKwFEuLirk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v7e/8ja90zHY7Jq9rI5/i1RSqBLAxRI8z2Yw3/4vq6f37fvaPCzat+DyRPRpoCreM
	 MHM7JPUAlO93Ms6RQLFTStr95mwnZYwbEJxkCKVOm+rMdyMx03TK998Vox0UAggc+6
	 W3I5FrUN6Ew63SM1FRo2numHGTi6ZzJW47dqdRoQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394332AbfIGSrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 14:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729261AbfIGSrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 14:47:15 -0400
Received: from localhost (unknown [80.251.162.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEE82208C3;
        Sat,  7 Sep 2019 18:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567882034;
        bh=ETlwQ/jDA2N/DocT9nVHq8Y/UgXTj0x2ZCKwFEuLirk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d7lhWhd3bM0O9T6OXqLR+D+sy4YnWKGTzPUhmGx3IkD1+rtUZte3doy/Va48GtOs/
         +zkSqCS2GA5vzm35V7WOhaJjpj7Phxgp7RXUp5ZGpXcMMxQ8zzMFQIgFAat2geji0y
         U65bTTi55rNld7a+p+dw/jaNgyAHfN93goAV+yWM=
Date:   Sat, 7 Sep 2019 19:47:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Francois Rigault <rigault.francois@gmail.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Adit Ranadive <aditr@vmware.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Vishnu DASA <vdasa@vmware.com>, stable@vger.kernel.org
Subject: Re: [PATCH] VMCI: Release resource if the work is already queued
Message-ID: <20190907184711.GA30206@kroah.com>
References: <20190820202638.49003-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190820202638.49003-1-namit@vmware.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 01:26:38PM -0700, Nadav Amit wrote:
> Francois reported that VMware balloon gets stuck after a balloon reset,
> when the VMCI doorbell is removed. A similar error can occur when the
> balloon driver is removed with the following splat:

<snip>

Note, google thinks your email is spam as you are not sending this from
a valid vmware.com email server.  Please fix this up if you want to make
sure your patches actually make it through...

thanks,

greg k-h
