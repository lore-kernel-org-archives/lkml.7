Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9137C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92CFE214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbfLLPvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:51:05 -0500
Received: from out28-3.mail.aliyun.com ([115.124.28.3]:43199 "EHLO
        out28-3.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729340AbfLLPvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:51:04 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3353695|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.017967-0.000539308-0.981494;DS=CONTINUE|ham_system_inform|0.0147424-0.00377881-0.981479;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03296;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.GFo2FEj_1576165852;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.GFo2FEj_1576165852)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 12 Dec 2019 23:50:58 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, paul@crapouillou.net, paul.burton@mips.com,
        paulburton@kernel.org, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
Subject: [PATCH 0/2] Add I2C support for the Ingenic X1000 SoC.
Date:   Thu, 12 Dec 2019 23:50:48 +0800
Message-Id: <1576165850-20727-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576165850-20727-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1576165850-20727-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*** BLURB HERE ***

周琰杰 (Zhou Yanjie) (2):
  dt-bindings: I2C: Add X1000 bindings.
  I2C: JZ4780: Add support for the X1000.

 .../devicetree/bindings/i2c/i2c-jz4780.txt         |   4 +-
 drivers/i2c/busses/i2c-jz4780.c                    | 159 +++++++++++++++------
 2 files changed, 120 insertions(+), 43 deletions(-)

-- 
2.7.4

