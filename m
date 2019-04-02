Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0C9C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A7892148E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 23:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfDBXKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:10:10 -0400
Received: from smtp-out-no.shaw.ca ([64.59.134.9]:35922 "EHLO
        smtp-out-no.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBXKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 19:10:10 -0400
Received: from tethys.mmayer.net ([70.68.144.247])
        by shaw.ca with ESMTP
        id BSPohVn12ldkPBSPphKtbF; Tue, 02 Apr 2019 17:02:02 -0600
X-Authority-Analysis: v=2.3 cv=Ko4zJleN c=1 sm=1 tr=0
 a=5Vvn7CJLxh9yo+qVPaC6cg==:117 a=5Vvn7CJLxh9yo+qVPaC6cg==:17
 a=oexKYjalfGEA:10 a=Q-fNiiVtAAAA:8 a=ME_z1uwoAAAA:20 a=Jxw1BS9pz4YfrDcTxLYA:9
 a=Fp8MccfUoT0GBdDC_Lng:22
Received: by tethys.mmayer.net (Postfix, from userid 501)
        id B48193010142EB; Tue,  2 Apr 2019 16:01:59 -0700 (PDT)
From:   Markus Mayer <code@mmayer.net>
To:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/6] memory: brcmstb: dpfe: introduce DPFE API v3
Date:   Tue,  2 Apr 2019 16:00:57 -0700
Message-Id: <20190402230103.25491-1-code@mmayer.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAmdF70CmoH7seUX1UA3vPiq8/kbdcuv2vbsBbXzgvMQgsQpzP6GZJ4kRu+QQCmkoD4DOJbWP2nhGiZNTgnQh7iL7H9xC1Vr9O0U6UMV3s2v67iCLzTd
 N+Z/69WFnxny/eSF1+MO0slgXFnDlR0WE3uwOmaZv6Np6pZ/aJY7rBJ77hQ7+1rB0BMKPdu7m12M/PAJbIhYOf8XEIZQTF9OdqF/KQus0jw9JYlkQGkGcmCA
 kmTSOodopBxGLpFYK/iQ6QlRGc3Z7ARVX8ORPQui/ToYzUiFdESx7osZ/t6KP3VC8I0NP+DEemjKeQkqUrGyWZgs65NNXy3iwmiErgrPE4XjaZDf+mKOOM3D
 uaP4QhFM1XmUO7zlUuPlgWdQRWg3THiOoMD9B0pGf48AeRqc6sZViqmtt90H9N7hWjkwCvqZzDBirHNzqgZtV9NNXcQDPQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Mayer <mmayer@broadcom.com>

This series introduces a new API for communicating with the DCPU. 
It will be used as the default going forward.

Before adding the new API, there is also some code cleanup and
hardening.

This series is based on drivers/next of
https://github.com/Broadcom/stblinux.git, since it builds on top of
recently upstreamed changes that are present in this branch.

Markus Mayer (6):
  memory: brcmstb: dpfe: remove unused code and fix formatting
  memory: brcmstb: dpfe: report firmware loading error
  memory: brcmstb: dpfe: wait for DCPU to be ready
  memory: brcmstb: dpfe: prepare support for multiple API versions
  memory: brcmstb: dpfe: prepare for API-dependent sysfs attributes
  memory: brcmstb: dpfe: introduce DPFE API v3

 drivers/memory/brcmstb_dpfe.c | 273 ++++++++++++++++++++++++++--------
 1 file changed, 213 insertions(+), 60 deletions(-)

-- 
2.17.1

