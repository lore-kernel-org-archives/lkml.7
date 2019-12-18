Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BFC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78AE3227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576660180;
	bh=7p1OzltEZEmB0CiHFlkfl9O1s0FHcf0C4bMyS+2zgBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DAMvQxFGkSyttcobK3F2Q/iPF7WIjZqnF+AgCOXpnYLA9ZusWHKT/VIHjy98U6XIq
	 x0yMG61JDw+EbYWEfRou1KjQ+Liew41hKJFLyjW4PRFLOEST/kxBoMVuWN0MNajuyL
	 06rwEBX8DWaNCToW4yz0BtjfeF0pZ8dXJL9gyrto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfLRJJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbfLRJJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:09:39 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5759A20717;
        Wed, 18 Dec 2019 09:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576660178;
        bh=7p1OzltEZEmB0CiHFlkfl9O1s0FHcf0C4bMyS+2zgBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3Qmls+3oGDEQhywVUrCCKEOeKinH1e2EimPPT29RqOwaajYXguON53TGXGlPXSUF
         equvOmN5ftMPc58DJZYz9M9yEOb1xIy3td/nuNDreNLt3m/+GitQdVmkk/n5lDij27
         0yd/eZmYEAgbU9w2vkczNbZfoK+ONs7npCr65h+U=
Date:   Wed, 18 Dec 2019 09:09:32 +0000
From:   Will Deacon <will@kernel.org>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com,
        james.morse@arm.com, dyoung@redhat.com, bhsharma@redhat.com,
        horms@verge.net.au, guohanjun@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [PATCH v6 0/4] support reserving crashkernel above 4G on arm64
 kdump
Message-ID: <20191218090932.GA14061@willie-the-truck>
References: <20190830071200.56169-1-chenzhou10@huawei.com>
 <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a97b296-59e7-0a26-84fa-e2ddcd7987b6@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2019 at 10:07:59AM +0800, Chen Zhou wrote:
> Friendly ping...

You broke the build:

https://lore.kernel.org/lkml/201909010744.CDe940pv%lkp@intel.com
https://lore.kernel.org/lkml/201909010704.4m9y2sg7%lkp@intel.com

So I doubt anybody will seriously look at this.

Will
