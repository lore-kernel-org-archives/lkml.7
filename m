Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE4C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7E020656
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 19:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557428788;
	bh=U2ddoaxNddJnFuld8DffmPpRIoM8TBSm6suNkKdVHy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AKYzIeVSB7fCWkdw3/Nkvyocgvx7kkjkBhMc/4eDJC7Ewvl9Wr2d5q12tJmbwtbyf
	 8c/4Ft1gmh46A6113Baw+7ghzigMvV2C06Z0FaV2AajlyoewAJiHfQRbaZNSWwFt4Z
	 IyioXKjnWK3rqfN2Ga82tH2DqTPk1J2+vr150Mbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfEITG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 15:06:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfEISqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 14:46:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2401C2182B;
        Thu,  9 May 2019 18:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557427610;
        bh=U2ddoaxNddJnFuld8DffmPpRIoM8TBSm6suNkKdVHy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i7yB6EDIUSQ348LDI67bCLnu46RX+lGHqajvgFSUIc4w5UrglTe7/XNb2E54zozhJ
         OJzagiUpkPljHB6k9rGwWe8aHPENlJnYBCVeZdUnRbgxv7h7mXhsx8QbVGa2SWf/4y
         WmWZ3uFv+ayb4aSZ4tQAojEn6vzWCqpBrecyeoq0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH 4.14 35/42] intel_th: pci: Add Comet Lake support
Date:   Thu,  9 May 2019 20:42:24 +0200
Message-Id: <20190509181259.622269659@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509181252.616018683@linuxfoundation.org>
References: <20190509181252.616018683@linuxfoundation.org>
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
@@ -173,6 +173,11 @@ static const struct pci_device_id intel_
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
 


