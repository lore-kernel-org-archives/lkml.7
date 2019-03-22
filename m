Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9D7C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347C9213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="QhKSBw49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfCVDAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:00:06 -0400
Received: from csm1.csm-office.com.au ([165.228.118.109]:60196 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVDAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:00:06 -0400
X-Greylist: delayed 978 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Mar 2019 23:00:05 EDT
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id x2M2hAKV008721
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 22 Mar 2019 13:43:24 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1553222605; bh=5bOVsKzc9EBlIeMx7bopb2RPt3r5sODTQnzC9CP3eus=;
        h=From:To:Cc:Subject:Date;
        b=QhKSBw494vL2Na4/ERX2r+RL1Nfz00NSCOZb1iBVk9ZNYxVUWCn8xCKqsRJJwXFm+
         tQZIhee0GjQWPJaOUwF+oooVwsFVDjQvSvrpHP89tu0GmWVRo8kjVYAlmFFjeJSg8j
         +4cSdWde5FF57rIjqHYKhKZv6OWnx+FgUf/6Xz2mm2Jb42zpJ2JXlhB+09Wa8V8C6I
         DX0oBOF1Gv8tNPUwvejK7OIvM/ZBjMH55NL8twDg9j9rdLCRzYsVayNqBPuTIYFafi
         ozQN9QP4dNbIwPk+8VDzIzgtZVZPD9VitSBOydsve2ouHDgGmdrZDGjPcM14nwbzuB
         7+jkQ4c8/HFwg==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tom Burkart <tom@aussec.com>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH v17 0/3] PPS: pps-gpio PPS ECHO implementation
Date:   Fri, 22 Mar 2019 13:42:30 +1100
Message-Id: <20190322024233.17568-1-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
would you please add this patch set to the kernel tree at the next opportunity?
It has been Acked by Rodolfo Giometti, the PPS maintainer.
Hopefully I have addressed all the changes you have requested.

Tom Burkart


Tom Burkart (3):
  pps: descriptor-based gpio
  dt-bindings: pps: pps-gpio PPS ECHO implementation
  pps: pps-gpio pps-echo implementation

 Documentation/devicetree/bindings/pps/pps-gpio.txt |   7 +
 drivers/pps/clients/pps-gpio.c                     | 153 ++++++++++++++++-----
 include/linux/pps-gpio.h                           |   5 +-
 3 files changed, 125 insertions(+), 40 deletions(-)

-- 
2.12.3

