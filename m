Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D64BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80A0520879
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=aussec.com header.i=@aussec.com header.b="uTOXuegN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfCXEeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:34:10 -0400
Received: from csm1.csm-office.com.au ([165.228.118.109]:38330 "EHLO
        sleepy.aussec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbfCXEeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:34:10 -0400
X-Virus-Scanned: amavisd-new at aussec.com
Received: from hpdv6.aussec.com.com (c110-21-61-29.farfl4.nsw.optusnet.com.au [110.21.61.29])
        (authenticated bits=0)
        by sleepy.aussec.com (8.15.2/8.15.2) with ESMTPSA id x2O4XY4j008019
        (version=TLSv1.2 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Sun, 24 Mar 2019 15:33:48 +1100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aussec.com; s=2016;
        t=1553402029; bh=xwcmTcG8nmtJYgew+CA5nCSF4wgpIHmbOtoC5DNcAZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=uTOXuegNxHV+n/bRgY/HlrXiOZwG6jo01f1LfwdBmxF3Wwi1VBDC8ZpUH/ARvuTv8
         +87VTAVSVToGAOD1NYmTD04QpNg48x6S2Qf1AIjkzKlk+1cUD544NblpCZ+y6XHDll
         OkyeFN9i6gvYTNxixswvAf3vAUTlJx1/DftPGFrB11r0PFWsCKAzxT/E+oMF7X3B0H
         EdZURVvs/sJVcCMOR3I9F8NoMu8MUzSWncP5kAWZK/B4Xcw001ly7SFJKxwXyVGuNh
         w043iavctdWv6tsDucO+9cKJKrKARsW04I8OL5skZeCVCQr6QcXcBxALdY1zb22zLQ
         bynwjCKcAPXHQ==
From:   Tom Burkart <tom@aussec.com>
To:     Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tom Burkart <tom@aussec.com>,
        Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH v18 0/3] PPS: pps-gpio PPS ECHO implementation
Date:   Sun, 24 Mar 2019 15:33:02 +1100
Message-Id: <20190324043305.6627-1-tom@aussec.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20190321154633.b9d1a356a100a4a14fa219f7@linux-foundation.org>
References: <20190321154633.b9d1a356a100a4a14fa219f7@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
would you please add this patch set to the kernel tree at the next opportunity?
Hopefully I have addressed all the changes you have requested and the linkages
are correct.

Tom


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

