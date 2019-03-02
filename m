Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E443C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 129012075B
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 01:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbfCBBRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 20:17:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:47488 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726007AbfCBBRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 20:17:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0B67AD3E;
        Sat,  2 Mar 2019 01:17:46 +0000 (UTC)
From:   Tony Jones <tonyj@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        Tony Jones <tonyj@suse.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Feng Tang <feng.tang@intel.com>,
        Tom Zanussi <tzanussi@gmail.com>,
        Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
Subject: [PATCH v2 0/7] perf script python: add Python3 support
Date:   Fri,  1 Mar 2019 17:18:56 -0800
Message-Id: <20190302011903.2416-1-tonyj@suse.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 of my version of the patchset.  Incorporating the 
previous feedback.  Some changes from v1 were already merged.

Patch 1/7 deals with the existing inconsistent indentation.
Indentation is now consistent per file but varying styles (tabs,
4 spaces and 8 spaces).   
I will followup at a later date with changes to checkpatch to ensure
that the syntax per file is maintained.

Patches 2/7 through 5/7 were sent in v1,  they have been changed 
to remove the previous indentation changes

Patch 6/7 was sent in v1.  I had previously *not* been able to test 
export-to-postgresql.py.  I was able to do so this time and found
that more changes were needed.    The author of the original code
seems concerned about code-style so I would suggest you only merge 
with his explicit ACK.

Patch 7/7 was not in v1, it cleans up some repeated use of date
functions in the SQL exporters.  It is not mandatory for Python3
support.  It is dependent on Patch#6.

I hope I've got everything correct, I've retested until I feel I 
can't look at Python code anymore for a while :-). Hopefully I've 
not made any more mistakes.  If I have, please LMK and I'll do v3.

Thanks

Tony
