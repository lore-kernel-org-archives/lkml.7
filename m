Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEC4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F43020830
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfCZJCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:02:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60856 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfCZJCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:02:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B99EB31688F6;
        Tue, 26 Mar 2019 09:02:34 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-21.pek2.redhat.com [10.72.12.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85EE780A3F;
        Tue, 26 Mar 2019 09:02:30 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@suse.com,
        rppt@linux.ibm.com, osalvador@suse.de, willy@infradead.org,
        william.kucharski@oracle.com, Baoquan He <bhe@redhat.com>
Subject: [PATCH v2 0/4] Clean up comments and codes in sparse_add_one_section()
Date:   Tue, 26 Mar 2019 17:02:23 +0800
Message-Id: <20190326090227.3059-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 26 Mar 2019 09:02:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is v2 post. V1 is here:
http://lkml.kernel.org/r/20190320073540.12866-1-bhe@redhat.com

This patchset includes 4 patches. The first three patches are around
sparse_add_one_section(). The last one is a simple clean up patch when
review codes in hotplug path, carry it in this patchset.

Baoquan He (4):
  mm/sparse: Clean up the obsolete code comment
  mm/sparse: Optimize sparse_add_one_section()
  mm/sparse: Rename function related to section memmap allocation/free
  drivers/base/memory.c: Rename the misleading parameter

 drivers/base/memory.c |  6 ++---
 mm/sparse.c           | 58 ++++++++++++++++++++++---------------------
 2 files changed, 33 insertions(+), 31 deletions(-)

-- 
2.17.2

