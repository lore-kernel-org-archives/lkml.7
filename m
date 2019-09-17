Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2832AC49ED7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0425F20665
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 02:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391950AbfIQCBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Sep 2019 22:01:08 -0400
Received: from mga11.intel.com ([192.55.52.93]:43627 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbfIQCBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 22:01:07 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Sep 2019 19:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,515,1559545200"; 
   d="scan'208";a="186014744"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga008.fm.intel.com with ESMTP; 16 Sep 2019 19:01:06 -0700
Date:   Tue, 17 Sep 2019 10:00:46 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Will Deacon <will@kernel.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, peterz@infradead.org
Subject: Re: [PATCH] mm: remove redundant assignment of entry
Message-ID: <20190917020046.GA8609@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190708082740.21111-1-richardw.yang@linux.intel.com>
 <20190914000326.h4ruqmyvo3yisf52@master>
 <20190916211516.znruqltoqdeq7pml@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190916211516.znruqltoqdeq7pml@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 16, 2019 at 10:15:16PM +0100, Will Deacon wrote:
>On Sat, Sep 14, 2019 at 12:03:26AM +0000, Wei Yang wrote:
>> On Mon, Jul 08, 2019 at 04:27:40PM +0800, Wei Yang wrote:
>> >Since ptent will not be changed after previous assignment of entry, it
>> >is not necessary to do the assignment again.
>> >
>> 
>> Sounds this one is lost in the time line :-)
>
>Don't think so -- looks like it's in linux-next [1] via akpm to me.
>

Ah, thanks. I may miss some message.

>Will
>
>[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b47011719e5c05aa9dc78fe76a7e46075f422a45

-- 
Wei Yang
Help you, Help me
