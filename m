Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51BC4C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BCC620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfCDIwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:52:12 -0500
Received: from smtp.nue.novell.com ([195.135.221.5]:38795 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbfCDIwL (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Mon, 4 Mar 2019 03:52:11 -0500
Received: from emea4-mta.ukb.novell.com ([10.120.13.87])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 04 Mar 2019 09:52:10 +0100
Received: from d104.suse.de (nwb-a10-snat.microfocus.com [10.120.13.201])
        by emea4-mta.ukb.novell.com with ESMTP (NOT encrypted); Mon, 04 Mar 2019 08:51:54 +0000
From:   Oscar Salvador <osalvador@suse.de>
To:     akpm@linux-foundation.org
Cc:     mhocko@suse.com, david@redhat.com, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH 0/2] Unlock 1GB-hugetlb on x86_64
Date:   Mon,  4 Mar 2019 09:51:45 +0100
Message-Id: <20190304085147.556-1-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC -> V1:
	- Split up the patch
	- Added Michal's Acked-by

The RFC version of this patch was discussed here [1], and it did not find any
objection.
I decided to split up the former patch because one of the changes enables
offlining operation for 1GB-hugetlb pages, while the other change is a mere
cleanup.

Patch1 contains all the information regarding 1GB-hugetlb pages change.

[1] https://lore.kernel.org/linux-mm/20190221094212.16906-1-osalvador@suse.de/

Oscar Salvador (2):
  mm,memory_hotplug: Unlock 1GB-hugetlb on x86_64
  mm,memory_hotplug: Drop redundant hugepage_migration_supported check

 mm/memory_hotplug.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

-- 
2.13.7

