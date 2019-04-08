Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBFCC10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7990520883
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 10:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDHKn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 06:43:59 -0400
Received: from 176.12.98.74.MAXnet.ru ([176.12.98.74]:40100 "EHLO
        shell.ipa.basealt.ru" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfDHKn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 06:43:58 -0400
Received: by shell.ipa.basealt.ru (Postfix, from userid 709000081)
        id AA5A827C6A; Mon,  8 Apr 2019 13:37:57 +0300 (MSK)
From:   Nikolai Kostrigin <nickel@altlinux.org>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jroedel@suse.de, Nikolai Kostrigin <nickel@altlinux.org>
Subject: [PATCH RESEND 0/1] PCI: Add ATS-disable quirk for AMD Radeon R7 GPUs
Date:   Mon,  8 Apr 2019 13:37:24 +0300
Message-Id: <20190408103725.30426-1-nickel@altlinux.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This solves system hang and file system corruption for Stoney Ridge systems (with built-in Radeon R4/R5 + discreet AMD Radeon R7 GPU)
Such system example: HP laptop 17-ak041ur (more HW info at https://bugzilla.kernel.org/show_bug.cgi?id=194521)

Nikolai Kostrigin (1):
  PCI: Add ATS-disable quirk for AMD Radeon R7 GPUs

 drivers/pci/quirks.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.21.0

