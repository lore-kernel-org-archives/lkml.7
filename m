Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA185C3A5A9
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76FFE23404
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620810;
	bh=3srGCbj7ekQs7/Q2VMppiRyfVO4nSNJpbhCJvTAUeOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Amv8f613en/m3FG6x32cgM3FEksIvRzVkYOOWbLfcq50Ptr7W7o/AG3HQ6EyCs0Cb
	 5LgPgKpDBzA7rVHr9fKwjDHgJ3mZXFFnLJazEkSHpuqSR4IWaQXioa61LdwV/SrlIn
	 dzpVEXBtojezhVYCM1UWzTpmF5Zgb31II0POIivg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390693AbfIDSN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:13:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390684AbfIDSN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:13:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3866208E4;
        Wed,  4 Sep 2019 18:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620806;
        bh=3srGCbj7ekQs7/Q2VMppiRyfVO4nSNJpbhCJvTAUeOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQ6jIuHHkjof0UuCuGhFbbLEdw6i7CcxMligFjFLwZieznYsa54iezwC/QKoDBEJj
         ZuNpmX2VSOmdE4wOqgS7eX3KpJ9FX0Cc7hxQEd0LC5P91cJYLYVlguZS7iOZyDwNQU
         Qf+F8BNMg30BcmNoFhdeLsaZWEsg272DiUcO0+LU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Rekowski?= <p.rekowski@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.2 061/143] ALSA: hda/ca0132 - Add new SBZ quirk
Date:   Wed,  4 Sep 2019 19:53:24 +0200
Message-Id: <20190904175316.460609767@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175314.206239922@linuxfoundation.org>
References: <20190904175314.206239922@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paweł Rekowski <p.rekowski@gmail.com>

commit 2ca371d847511f97ef991ef612a2ce805489840e upstream.

This patch adds a new PCI subsys ID for the SBZ, as found and tested by
me and some reddit users.

Link: https://lore.kernel.org/lkml/20190819204008.14426-1-p.rekowski@gmail.com
Signed-off-by: Paweł Rekowski <p.rekowski@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_ca0132.c |    1 +
 1 file changed, 1 insertion(+)

--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1175,6 +1175,7 @@ static const struct snd_pci_quirk ca0132
 	SND_PCI_QUIRK(0x1028, 0x0708, "Alienware 15 R2 2016", QUIRK_ALIENWARE),
 	SND_PCI_QUIRK(0x1102, 0x0010, "Sound Blaster Z", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1102, 0x0023, "Sound Blaster Z", QUIRK_SBZ),
+	SND_PCI_QUIRK(0x1102, 0x0027, "Sound Blaster Z", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1102, 0x0033, "Sound Blaster ZxR", QUIRK_SBZ),
 	SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
 	SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),


