Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F73FC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5999720656
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfEAUhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:37:51 -0400
Received: from inva021.nxp.com ([92.121.34.21]:56214 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfEAUhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:37:50 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31E52200068;
        Wed,  1 May 2019 22:37:49 +0200 (CEST)
Received: from smtp.na-rdc02.nxp.com (inv1260.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EDEE420002A;
        Wed,  1 May 2019 22:37:48 +0200 (CEST)
Received: from someleo.am.freescale.net (someleo.am.freescale.net [10.81.32.93])
        by inv1260.us-phx01.nxp.com (Postfix) with ESMTP id 376E640A63;
        Wed,  1 May 2019 13:37:48 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] fixes to soc/fsl drivers for v5.1
Date:   Wed,  1 May 2019 15:37:48 -0500
Message-Id: <20190501203748.5393-1-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please help to merge the following fix for soc/fsl drivers.

Thanks,
Leo

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-fix-v5.1

for you to fetch changes up to 5674a92ca4b7e5a6a19231edd10298d30324cd27:

  soc/fsl/qe: Fix an error code in qe_pin_request() (2019-04-02 18:02:48 -0500)

----------------------------------------------------------------
NXP/FSL soc driver fixes for v5.1

QE drivers
- Fix an error path in qe_pin_request()

----------------------------------------------------------------
Dan Carpenter (1):
      soc/fsl/qe: Fix an error code in qe_pin_request()

 drivers/soc/fsl/qe/gpio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
