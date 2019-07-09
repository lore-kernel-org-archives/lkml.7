Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82DAC004EF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8618B2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 11:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfGILQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 07:16:46 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:29726 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfGILQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 07:16:45 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 58C4C37B3ABEEA91A434
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2019 19:16:43 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x69BEa6o016939
        for <linux-kernel@vger.kernel.org>; Tue, 9 Jul 2019 19:14:36 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070919144690-2212250 ;
          Tue, 9 Jul 2019 19:14:46 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/2] fix use-after-free in mpc831x_usb_cfg() and do some cleanups
Date:   Tue, 9 Jul 2019 19:12:46 +0800
Message-Id: <1562670768-23178-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-09 19:14:47,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-09 19:14:39,
        Serialize complete at 2019-07-09 19:14:39
X-MAIL: mse-fl1.zte.com.cn x69BEa6o016939
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix use-after-free in mpc831x_usb_cfg() and do some cleanups.
According to Markus's suggestion, split it into two small patches:
https://lkml.org/lkml/2019/7/8/520

Wen Yang (2):
  powerpc/83xx: fix use-after-free in mpc831x_usb_cfg()
  powerpc/83xx: cleanup error paths in mpc831x_usb_cfg()

 arch/powerpc/platforms/83xx/usb.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
2.9.5

