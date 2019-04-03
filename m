Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB6EC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D292147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbfDCN0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:26:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:53997 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726625AbfDCN0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:26:06 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x33DLSS6019129;
        Wed, 3 Apr 2019 15:23:42 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2rmgev46jf-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 03 Apr 2019 15:23:42 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 70DC031;
        Wed,  3 Apr 2019 13:23:41 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2E08E29C0;
        Wed,  3 Apr 2019 13:23:41 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 3 Apr 2019
 15:23:41 +0200
Received: from localhost (10.201.23.16) by webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.435.0; Wed, 3 Apr 2019 15:23:40
 +0200
From:   Olivier Moysan <olivier.moysan@st.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>,
        <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>,
        <apatard@mandriva.com>
Subject: [PATCH 0/7] ASoC: cs42l51: add some features
Date:   Wed, 3 Apr 2019 15:23:30 +0200
Message-ID: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-03_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add support of following features to Cirrus CS42L51 audio codec driver:
- reset
- regulators
- master mode
- power management
- adc volume control

Olivier Moysan (7):
  ASoC: dt-bindings: update cs42l51 bindings
  ASoC: cs42l51: add regulator management
  ASoC: cs42l51: add reset management
  ASoC: cs42l51: add support of master mode
  ASoC: cs42l51: change mic bias DAPM
  ASoC: cs42l51: add power management
  ASoC: cs42l51: add adc volume control

 .../devicetree/bindings/sound/cs42l51.txt          |  16 ++
 sound/soc/codecs/cs42l51-i2c.c                     |  13 +-
 sound/soc/codecs/cs42l51.c                         | 217 ++++++++++++++++++++-
 sound/soc/codecs/cs42l51.h                         |   3 +
 4 files changed, 242 insertions(+), 7 deletions(-)

-- 
2.7.4

