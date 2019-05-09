Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEA3C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DE3A217F5
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 18:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557427754;
	bh=OP280kuGSMjRSEKfqeYczZixuEf3EDUGnZF1DlEt8Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0q2zgYhBhUkSDX2+ilNjAJSdrm9FCIcCHk+HEy+a6RfIVLEB6I9V8QafLZy2+1A6f
	 j32ODYcl+1wZNUGvkV0gppfHygAwrNksl19ls4rvWdgGYFHmX3BifsaqtcsPn0o462
	 JRw/8pfkD5knFSrbG/gJ8EFPyE+WftXtWElLARZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfEIStN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 14:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfEIStF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:49:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA9E9217D7;
        Thu,  9 May 2019 18:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427745;
        bh=OP280kuGSMjRSEKfqeYczZixuEf3EDUGnZF1DlEt8Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BvQOF6ZE/xZh5D3Sdtig1+piVmydW+rhXECHwwqTSCFz3cu9beI+Gqp4024e60T0A
         MQLnZaX5M2V7j2b+XfrE881lhfQgoi951G64YsICCovNjpdfGAJhhNy2oDg1va83bz
         TzZYJWEabjIgH8qDaQjP2IGxUGzxN7k4G0VWUJ4A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.19 55/66] intel_th: pci: Add Comet Lake support
Date:   Thu,  9 May 2019 20:42:30 +0200
Message-Id: <20190509181307.330586608@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181301.719249738@linuxfoundation.org>
References: <20190509181301.719249738@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit e60e9a4b231a20a199d7a61caadc48693c30d695 upstream.

This adds support for Intel TH on Comet Lake.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/pci.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/hwtracing/intel_th/pci.c
+++ b/drivers/hwtracing/intel_th/pci.c
@@ -165,6 +165,11 @@ static const struct pci_device_id intel_
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x34a6),
 		.driver_data = (kernel_ulong_t)&intel_th_2x,
 	},
+	{
+		/* Comet Lake */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x02a6),
+		.driver_data = (kernel_ulong_t)&intel_th_2x,
+	},
 	{ 0 },
 };
 


