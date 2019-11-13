Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4504C17440
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E597222C5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 01:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573607911;
	bh=eJBav0KzdzrZFNz6y/0Ugy9SqzAGRpQbeGlzfx5qrnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lrYSZ5zNbYJEz9aZeBAn1TXfp6Xd7TrTIUk7ZOFlW5uSQYGUxc4mO9YLIe4YOuofu
	 uhaIA1E4lvamAqWSpLT09G2VjmtuLZV3mEAaG4jUgUbcUxQraujHD/NgZncYcRhlUl
	 W0jGkqmt0orNBuk2ORjD869u7NdKPDnSspC8aHYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfKMBSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 20:18:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:48278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbfKMBSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:18:30 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0F1A20818;
        Wed, 13 Nov 2019 01:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573607910;
        bh=eJBav0KzdzrZFNz6y/0Ugy9SqzAGRpQbeGlzfx5qrnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R/jJg3L7R7Xan8O39Tuqd972s6Fb6lL5Mt4OEvIkSm7e+NhnWoiP374Yd6zVy+3a2
         tiDkBW2zq2vUiMPIZPUeW43V0Sln6MYEhnhq9LigmHtyxZIsHEoIJTfOUp7Xg86+YZ
         jUAPFeqznhWO95qpVJDlctK2gcBprx7VZwliXRWg=
Date:   Tue, 12 Nov 2019 20:18:28 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.9 STABLE] kvm: mmu: Don't read PDPTEs when paging is
 not enabled
Message-ID: <20191113011828.GL8496@sasha-vm>
References: <20191111235019.31416-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191111235019.31416-1-sean.j.christopherson@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 03:50:19PM -0800, Sean Christopherson wrote:
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

Queued up for 4.9, thank you.

-- 
Thanks,
Sasha
