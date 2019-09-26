Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2976C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDBF222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfIZMzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:55:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfIZMzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:55:11 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74CBE796E0;
        Thu, 26 Sep 2019 12:55:11 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A837460A97;
        Thu, 26 Sep 2019 12:55:09 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 0/7] intel-speed-select: Add CascadeLake-N support
Date:   Thu, 26 Sep 2019 08:54:54 -0400
Message-Id: <20190926125501.1616-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 26 Sep 2019 12:55:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for SST-BF on CascadeLake-N support.  The CascadeLake-N
processor only support SST-BF and not other SST functionality.

Prarit Bhargava (7):
  intel-speed-select: Add int argument to command functions
  intel-speed-select: Make process_command generic
  intel-speed-select: Add check for CascadeLake-N models
  intel-speed-select: Add configuration for CascadeLake-N
  intel-speed-select: Implement CascadeLake-N help and command functions
    structures
  intel-speed-select: Implement 'perf-profile info' on CascadeLake-N
  intel-speed-select: Implement base-freq commands on CascadeLake-N

 .../x86/intel-speed-select/isst-config.c      | 443 ++++++++++++------
 .../x86/intel-speed-select/isst-display.c     |  28 +-
 tools/power/x86/intel-speed-select/isst.h     |   8 +-
 3 files changed, 319 insertions(+), 160 deletions(-)

-- 
2.21.0

