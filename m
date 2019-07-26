Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC27DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1FBB22CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbfGZNqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:46:12 -0400
Received: from foss.arm.com ([217.140.110.172]:44000 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388212AbfGZNqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:46:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26A3B152D;
        Fri, 26 Jul 2019 06:46:04 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D81D73F694;
        Fri, 26 Jul 2019 06:46:02 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>,
        Gaku Inami <gaku.inami.xh@renesas.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH v2 0/6] firmware: arm_scmi: miscellaneous fixes/updates
Date:   Fri, 26 Jul 2019 14:45:25 +0100
Message-Id: <20190726134531.8928-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are few miscellaneous fixes and updates to SCMI. Fixes are mostly
for the reported issues and updates are based on code inspection during
development of new features(delayed response and notifications). The
new features will follow this.

--
Regards,
Sudeep

v1->v2:
	- Fixed spurious ] in doxygen comment
	- Dropped the first patch as it's already merged
	- Added a new patch to use correct style for SPDX License in .h

Sudeep Holla (6):
  firmware: arm_scmi: Use the correct style for SPDX License Identifier
  firmware: arm_scmi: Align few names in sensors protocol with SCMI
    specification
  firmware: arm_scmi: Remove extra check for invalid length message
    responses
  firmware: arm_scmi: Fix few trivial typos in comments
  firmware: arm_scmi: Use the term 'message' instead of 'command'
  firmware: arm_scmi: Check if platform has released shmem before using

 drivers/firmware/arm_scmi/common.h  | 10 +++++-----
 drivers/firmware/arm_scmi/driver.c  | 24 +++++++++++++-----------
 drivers/firmware/arm_scmi/sensors.c | 28 +++++++++++++++-------------
 include/linux/scmi_protocol.h       | 14 +++++++-------
 4 files changed, 40 insertions(+), 36 deletions(-)

-- 
2.17.1

