Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BA6C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC39920833
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 17:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfDIRgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 13:36:53 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:42140 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbfDIRgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 13:36:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C379715BE;
        Tue,  9 Apr 2019 10:36:52 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 62E193F59C;
        Tue,  9 Apr 2019 10:36:51 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, Dietmar.Eggemann@arm.com,
        morten.rasmussen@arm.com, qais.yousef@arm.com
Subject: [PATCH 0/2] sched/topology: Small fixes
Date:   Tue,  9 Apr 2019 18:35:44 +0100
Message-Id: <20190409173546.4747-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing too fancy here, just some fixlets resulting from staring at topology.c

Patch 1 skips writes to sched_group's when they are already initialized
Patch 2 fixes a derelict comment (spotted by Dietmar)

Valentin Schneider (2):
  sched/topology: build_sched_groups: Skip duplicate group rewrites
  sched/topology: Fix build_sched_groups() comment

 kernel/sched/topology.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--
2.20.1

