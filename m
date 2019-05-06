Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B64C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F422053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 19:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557169655;
	bh=td4OvxrBcPmkDdFNMhTd5GOSULW88Fh9zmY67lJjBaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G+eq/C9VW2RANmnrPhuEpvflWFt9iN26fTBiHJ2t7isc1bqD0/LFbYy4SgQHKgRlW
	 Ki02K0ITWmSeJMmpfQCpN65vZsUQVxjCvP0wVSPuVK4/+ic/UNFa4wDgmvCw97DbYP
	 cNuCXs7FR+JA5p7miiCvpOGU4t8q7lNDN0gqMH+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfEFTHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 15:07:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36904 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbfEFTHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 15:07:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F2707AD3A;
        Mon,  6 May 2019 19:07:32 +0000 (UTC)
Date:   Mon, 6 May 2019 21:07:31 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     mike.kravetz@oracle.com, shenkai8@huawei.com,
        linfeilong@huawei.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, wangwang2@huawei.com,
        "Zhoukang (A)" <zhoukang7@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>, agl@us.ibm.com,
        nacc@us.ibm.com, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/hugetlb: Don't put_page in lock of hugetlb_lock
Message-ID: <20190506190731.GE31017@dhcp22.suse.cz>
References: <12a693da-19c8-dd2c-ea6a-0a5dc9d2db27@huawei.com>
 <b8ade452-2d6b-0372-32c2-703644032b47@huawei.com>
 <20190506142001.GC31017@dhcp22.suse.cz>
 <d11fa51f-e976-ec33-4f5b-3b26ada64306@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d11fa51f-e976-ec33-4f5b-3b26ada64306@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 06-05-19 23:22:08, Zhiqiang Liu wrote:
[...]
> Does adding Cc: stable mean adding Cc: <stable@vger.kernel.org>
> tag in the patch or Ccing stable@vger.kernel.org when sending the new mail?

The former. See Documentation/process/stable-kernel-rules.rst for more.

Thanks!
-- 
Michal Hocko
SUSE Labs
