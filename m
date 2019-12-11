Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6DC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90C524658
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576078234;
	bh=JQzQ2DYa8/YLrp70/Glnv+01jA+qGk/ngB4y2h3S+Bs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lxC1pnddwLAplxC00WI5DbPj2ErtTJUJMr7uwDwbfiwdSOVzJBfjlDgGVQgosIetp
	 fgeym7aW6++qYTqoBifPUE044TbF9O27Ghgb6RBOFwlum4n3B/yED4/F6pWO41BeeO
	 RbndFgwP5BE/kcjDKvqVhlWMtsJfffV0RHeNQJZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387983AbfLKPad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:30:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387897AbfLKP3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:29:30 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 599392467D;
        Wed, 11 Dec 2019 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576078169;
        bh=JQzQ2DYa8/YLrp70/Glnv+01jA+qGk/ngB4y2h3S+Bs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+gYQkobpL7os+SgSCqmpEWqtfCMfCJ9wBP1pT99pKIzxQtmH6dNq0Tx3wyZ/uMT3
         uQZa5gYoJHdjEFpJTyulPvavb8l2b9vIFzr0xlvSaUIW4Sb8b0iEHVUBN8K2aLxLjp
         XvIqhPLYEwyoOUzcarXg0FrykrX/ciFxG5mcCE5k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Chiou, Cooper" <cooper.chiou@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.3 024/105] ALSA: hda: Add Cometlake-S PCI ID
Date:   Wed, 11 Dec 2019 16:05:13 +0100
Message-Id: <20191211150228.207802839@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chiou, Cooper <cooper.chiou@intel.com>

[ Upstream commit b73a58549ea37a44434c7afab3c7ad9af210cfd9 ]

Add HD Audio Device PCI ID for the Intel Cometlake-S platform

Signed-off-by: Chiou, Cooper <cooper.chiou@intel.com>
Link: https://lore.kernel.org/r/20191108071349.12840-1-cooper.chiou@intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index e1791d01ccc01..46c2b1022495f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2428,6 +2428,9 @@ static const struct pci_device_id azx_ids[] = {
 	/* CometLake-H */
 	{ PCI_DEVICE(0x8086, 0x06C8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
+	/* CometLake-S */
+	{ PCI_DEVICE(0x8086, 0xa3f0),
+	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
 	/* Icelake */
 	{ PCI_DEVICE(0x8086, 0x34c8),
 	  .driver_data = AZX_DRIVER_SKL | AZX_DCAPS_INTEL_SKYLAKE},
-- 
2.20.1



