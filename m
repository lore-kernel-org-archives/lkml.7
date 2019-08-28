Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD2BC3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C0A22CF8
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566991424;
	bh=ynjmbm9JoAmTlyfg2zZRxbVy+h8uPz7ueGPMnfux9sE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TGxDsjzNb+RQB6fvx+R9azWcoXU+3i3Bb1He1p8CFHUUk9ciHl0fu3LZ/UaJjWmvQ
	 AGjsuuVNuqqaU+SLgWo0CjTGGvZKMEGdkd81NG+YC9LKi1x25vcZa+w1QauHLfJVWK
	 Jh0i7qVFdbkLX6SkMPUsYFnhoJC+HGDqUrWfMKk8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfH1LXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 07:23:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:53112 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726253AbfH1LXn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 07:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 895E0AEE1;
        Wed, 28 Aug 2019 11:23:41 +0000 (UTC)
Date:   Wed, 28 Aug 2019 13:23:40 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Mina Almasry <almasrymina@google.com>
Cc:     mike.kravetz@oracle.com, shuah@kernel.org, rientjes@google.com,
        shakeelb@google.com, gthelen@google.com, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org, aneesh.kumar@linux.vnet.ibm.com,
        mkoutny@suse.com
Subject: Re: [PATCH v3 0/6] hugetlb_cgroup: Add hugetlb_cgroup reservation
 limits
Message-ID: <20190828112340.GB7466@dhcp22.suse.cz>
References: <20190826233240.11524-1-almasrymina@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826233240.11524-1-almasrymina@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-08-19 16:32:34, Mina Almasry wrote:
>  mm/hugetlb.c                                  | 493 ++++++++++++------
>  mm/hugetlb_cgroup.c                           | 187 +++++--

This is a lot of changes to an already subtle code which hugetlb
reservations undoubly are. Moreover cgroupv1 is feature frozen and I am
not aware of any plans to port the controller to v2. That all doesn't
sound in favor of this change. Mike is the maintainer of the hugetlb
code so I will defer to him to make a decision but I wouldn't recommend
that.
-- 
Michal Hocko
SUSE Labs
