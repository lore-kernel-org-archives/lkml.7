Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53250C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 299E1205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 13:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407223AbfIWNQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 09:16:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39648 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405137AbfIWNQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 09:16:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BBF0AC0546D5;
        Mon, 23 Sep 2019 13:16:44 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 355DA60BFB;
        Mon, 23 Sep 2019 13:16:44 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 0/2] intel-speed-select: Convert output to tables
Date:   Mon, 23 Sep 2019 09:16:36 -0400
Message-Id: <20190923131638.6668-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 23 Sep 2019 13:16:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The turbo ratio limits and turbo frequencies add a large amount of
lines to the output.  The output can be truncated into human and
machine readable tables to reduce the number of lines of output.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Prarit Bhargava (2):
  intel-speed-select: Display turbo-ratio-limits as a table
  intel-speed-select: Display turbo frequencies in a table

 .../x86/intel-speed-select/isst-display.c     | 196 +++++++++---------
 1 file changed, 94 insertions(+), 102 deletions(-)

-- 
2.21.0

