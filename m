Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE841C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD252054F
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 13:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfE1Nhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 09:37:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:52868 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfE1Nhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 09:37:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 285ADACD4;
        Tue, 28 May 2019 13:37:44 +0000 (UTC)
Date:   Tue, 28 May 2019 15:37:42 +0200
From:   "jroedel@suse.de" <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Gary R Hook <ghook@amd.com>, "Hook, Gary" <Gary.Hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/amd: print out "tag" in INVALID_PPR_REQUEST
Message-ID: <20190528133742.GA8151@suse.de>
References: <20190506041106.29167-1-cai@lca.pw>
 <ea379dc8-dd6b-f204-0abc-7b6fe87a851b@amd.com>
 <1557845746.6132.27.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557845746.6132.27.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 10:55:46AM -0400, Qian Cai wrote:
> Jroedel, I am wondering what the plan for 41e59a41fc5d1 (iommu tree) or this
> patch to be pushed to the linux-next or mainline...

Looks like I applied that patch directly to the master branch, which is
not what goes upstream. I cherry-picked it to x86/amd, so it will go
upstream for v5.3.


Regards,

	Joerg
