Return-Path: <SRS0=SILN=ZX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11484C43215
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC36B20867
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Dec 2019 16:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575219313;
	bh=r3b+bnDqexbrCOViiqxKfOKwp1GKepGzbJ9KHNlPw4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=obD/IwWL54SwezX2h4oF8JykME/qr7iI4wNC0kawdpqZES42QU+tErSsMz0rPzEKi
	 lmvkYhkjE3XlTzPYZDZV7rLDG6rkg2ZUriRD2FwjD/HwZ4NmCOvrcRyy8yaQf5Qqd+
	 R0FV+lzHdDDBtSu+ARaPZnlwg4Tphp60CLi3BQ84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfLAQzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Dec 2019 11:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbfLAQzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 11:55:12 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDBC2073C;
        Sun,  1 Dec 2019 16:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575219312;
        bh=r3b+bnDqexbrCOViiqxKfOKwp1GKepGzbJ9KHNlPw4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOSNefNJesjN26J3buOjenJJjVEqFqwfrrYXt8ah4cxgf9azFX8tS9M+Y0zPpw5kw
         8FahXDfVwMSexMpucFrVvrrIWkS/fw+S7ej4pl7YUwD4boqmcEN3p2vAj5Z1D4c8pD
         /w4cpbO653OwTigF8fNhuDjUL9QNvEiSBgkEX8UE=
Date:   Sun, 1 Dec 2019 11:55:10 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Ajay Kaher <akaher@vmware.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH STABLE ONLY] add missing page refcount overflow checks
Message-ID: <20191201165510.GT5861@sasha-vm>
References: <20191129090351.3507-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191129090351.3507-1-vbabka@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 10:03:48AM +0100, Vlastimil Babka wrote:
>This collection of patches add the missing overflow checks in arch-specific
>gup.c variants for x86 and s390. Those were missed in backport of 8fde12ca79af
>("mm: prevent get_user_pages() from overflowing page refcount") as mainline
>had a single gup.c implementation at that point. See individual patches for
>details.

Queued up, thanks!

-- 
Thanks,
Sasha
