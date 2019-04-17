Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A295DC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7DB20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 15:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555515568;
	bh=ElNj0GCipg4WCffjx+s827R/cfpVp1Lu7OYJ2Zcc+Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vgkSbi62RqWbc7l9PIP0hnNYP8xLSegDOwsUhMy/FZ6wg6q0K0sOil6AcyfG03DTG
	 AgoU27w263++Z/HBOiPrX5uK+70ZqIiULULoDVgtHtMwF6VLelc9V6fcKX0J1xIq2M
	 0ehtmHsAVqViS9Zs7TDNBPv2KGOx67gc3QRsC120=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbfDQPj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 11:39:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:38064 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732659AbfDQPj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 11:39:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6ABD6ADAA;
        Wed, 17 Apr 2019 15:39:25 +0000 (UTC)
Date:   Wed, 17 Apr 2019 17:39:23 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Keith Busch <keith.busch@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        mgorman@techsingularity.net, riel@surriel.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190417153923.GO5878@dhcp22.suse.cz>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <876768ad-a63a-99c3-59de-458403f008c4@linux.alibaba.com>
 <a0bf6b61-1ec2-6209-5760-80c5f205d52e@intel.com>
 <20190417092318.GG655@dhcp22.suse.cz>
 <20190417152345.GB4786@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417152345.GB4786@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 17-04-19 09:23:46, Keith Busch wrote:
> On Wed, Apr 17, 2019 at 11:23:18AM +0200, Michal Hocko wrote:
> > On Tue 16-04-19 14:22:33, Dave Hansen wrote:
> > > Keith Busch had a set of patches to let you specify the demotion order
> > > via sysfs for fun.  The rules we came up with were:
> > 
> > I am not a fan of any sysfs "fun"
> 
> I'm hung up on the user facing interface, but there should be some way a
> user decides if a memory node is or is not a migrate target, right?

Why? Or to put it differently, why do we have to start with a user
interface at this stage when we actually barely have any real usecases
out there?

-- 
Michal Hocko
SUSE Labs
