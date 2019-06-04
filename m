Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FB0C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D05223BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 12:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559651755;
	bh=eNxVSFwc3/pnhAYGQZ8U500Dhw3eSvn9d45Ab4766Bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=onPd9PUhaIrZbDoc84yVofZ9ZOFleaVlvF4sUneXLENNldJ9t0hda/NrJ91XOR8/+
	 +bcJGouRcs5gOCZ0QjZULAlEXKJjcokkNVbtRnDZ9uWY4IFhVElJX86iUzsHSuVAAg
	 VVQNGg/T8CfsK8UteBPD2aZK7FmDPW5ZH0tuNSsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfFDMfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 08:35:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40284 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727398AbfFDMfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 08:35:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07CE9AFD1;
        Tue,  4 Jun 2019 12:35:53 +0000 (UTC)
Date:   Tue, 4 Jun 2019 14:35:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] mm/swap: Fix release_pages() when releasing devmap
 pages
Message-ID: <20190604123551.GI4669@dhcp22.suse.cz>
References: <20190524173656.8339-1-ira.weiny@intel.com>
 <20190527150107.GG1658@dhcp22.suse.cz>
 <20190529035618.GA21745@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529035618.GA21745@iweiny-DESK2.sc.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-05-19 20:56:19, Ira Weiny wrote:
> Would you like to roll a V3 with some of this in the commit
> message?

Yes please. I will re-read the whole changelog and let's see whether I
can make more sense of it.

Thanks!
-- 
Michal Hocko
SUSE Labs
