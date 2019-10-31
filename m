Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD1BCA9EC7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC20D2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 02:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfJaCA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 22:00:26 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5232 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfJaCA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 22:00:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5BEF151A0CF6DAD5A48B;
        Thu, 31 Oct 2019 10:00:23 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 10:00:13 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <akinobu.mita@gmail.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <zhongjiang@huawei.com>
Subject: [PATCH v3 0/2] fault-inject: Simplify and clean up 
Date:   Thu, 31 Oct 2019 09:56:15 +0800
Message-ID: <1572486977-14195-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> v2:
    Add another patch to use DEFINE_DEBUGFS_ATTRIBUTE and replace
    debugfs_create_file with debugfs_create_file_unsafe.

v1 -> v2:
    According to Akinobu's suggestion, Use debugfs_create_ulong to
    simplify the code.

zhong jiang (2):
  fault-inject: Use debugfs_create_ulong() instead of
    debugfs_create_ul()
  fault-inject: use DEFINE_DEBUGFS_ATTRIBUTE to define debugfs fops

 lib/fault-inject.c | 45 +++++++++++++++------------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

-- 
1.7.12.4

