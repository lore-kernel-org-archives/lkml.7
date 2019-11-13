Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF29C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26207222C5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573607928;
	bh=cWFUgc9/WbM1JBUyl6nC5epn+Sxpk+I2iHNF3JCvRzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QoK5KazvGIQRXS9Fk4vyJKwLnOPyZzCmZiTOhsER9udDBoooWZhRhEH2Rljk21XR3
	 pbiMxJvUGSutxz24I/XAAm+S+Nrkyq2RaLi24WXrTTc1w6fCtE9NHDgllwIOgbYf1w
	 KWN+CIFv6j5bOZBfuBPVxP0TmJEzqm1LH9ZtlCAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbfKMBSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:18:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:48488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfKMBSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:18:47 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4299E20818;
        Wed, 13 Nov 2019 01:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573607926;
        bh=cWFUgc9/WbM1JBUyl6nC5epn+Sxpk+I2iHNF3JCvRzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uFZqyCsQdXa09TJBj5G4d6yualQoRZfRb2KX0ZqsUQKbI+pL/864h+GADHn9e1yQx
         e0EQ6xcJ0J5vs4NIT2zrzuEmIvChyROaobMKvp8mA0efOggwatJMx0SSSXfpesaYlT
         WFw1Q7MKQXPv20Mb17pN3PvbHZREfKnIAyJyzqzM=
Date:   Tue, 12 Nov 2019 20:18:45 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.4 STABLE] kvm: mmu: Don't read PDPTEs when paging is
 not enabled
Message-ID: <20191113011845.GM8496@sasha-vm>
References: <20191112001705.5885-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191112001705.5885-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:17:05PM -0800, Sean Christopherson wrote:
>From: Junaid Shahid <junaids@google.com>
>
>Upstream commit d35b34a9a70edae7ef923f100e51b8b5ae9fe899.
>
>kvm should not attempt to read guest PDPTEs when CR0.PG = 0 and
>CR4.PAE = 1.
>
>Signed-off-by: Junaid Shahid <junaids@google.com>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Queued up for 4.4, thank you.

-- 
Thanks,
Sasha
