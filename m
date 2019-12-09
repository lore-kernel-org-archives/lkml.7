Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F348CC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D495C206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 05:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfLIFKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 00:10:45 -0500
Received: from out28-74.mail.aliyun.com ([115.124.28.74]:55156 "EHLO
        out28-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfLIFKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 00:10:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2758775|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.216612-0.00519232-0.778196;DS=CONTINUE|ham_system_inform|0.0495488-0.000247355-0.950204;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03279;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.GDNCC0Y_1575868229;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GDNCC0Y_1575868229)
          by smtp.aliyun-inc.com(10.147.40.200);
          Mon, 09 Dec 2019 13:10:36 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, yamada.masahiro@socionext.com,
        tglx@linutronix.de, chenhc@lemote.com, tbogendoerfer@suse.de,
        paul.burton@mips.com, paulburton@kernel.org, paul@crapouillou.net,
        jhogan@kernel.org, fancer.lancer@gmail.com, ralf@linux-mips.org,
        jiaxun.yang@flygoat.com
Subject: MIPS: X1830: Add X1830 system type. 
Date:   Mon,  9 Dec 2019 13:10:24 +0800
Message-Id: <1575868225-57755-1-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1->v2:
1.Add more detailed commit message.
2.Add a /* fall-through */ comment to prevent GCC from issuing a
  warning when -Wimplicit-fallthrough is used.
3.Change my Signed-off-by from "Zhou Yanjie <zhouyanjie@zoho.com>"
  to "周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>" because
  the old mailbox is in an unstable state.

