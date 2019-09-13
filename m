Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB24C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0099F206BB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380892;
	bh=gjzFRXAqiMorqpExW6XZ3MrQJzRAdD16aRLBvFb9r/o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rk2bMqYlOw27t7rUStQ0LbsjIY/PetSOWuCZyP865l+gt0DC2kgEpBhEeOsRZR/24
	 5bqivW8nauR8nxInperWVuyu14L4FipREhiCfVztkdZHXwlM46s75KtIaWJNEHpELV
	 zpDUV1NcuEqQAkqJA9Ha8p5lvaLEaFfzPLv258Ew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390841AbfIMNVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:21:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390827AbfIMNV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:21:28 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F5A120717;
        Fri, 13 Sep 2019 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380888;
        bh=gjzFRXAqiMorqpExW6XZ3MrQJzRAdD16aRLBvFb9r/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jy/2h6KBvG9zwp8d9I1I2RuvNGv3ujfxYf+6luA2yeUscdZvOFPyYjJtZ7wFPTXMJ
         fgx+TM2XdM6A2V6rXbDjSHIQ2tZ9sAMZAjHo6SYadxCG8wQlw72lVp4/P1x3mk8MVH
         DsSzVyVY2Vxqx7dr3FWB8MAyvOXgQ6GrfbG+G/fQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>
Subject: [PATCH 5.2 10/37] drm/nouveau/sec2/gp102: add missing MODULE_FIRMWAREs
Date:   Fri, 13 Sep 2019 14:07:15 +0100
Message-Id: <20190913130513.757861608@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130510.727515099@linuxfoundation.org>
References: <20190913130510.727515099@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

commit 55f7e5c364dce20e691fda329fb2a6cc3cbb63b6 upstream.

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Cc: stable@vger.kernel.org [v5.2+]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp102.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp102.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/secboot/gp102.c
@@ -190,6 +190,9 @@ MODULE_FIRMWARE("nvidia/gp102/nvdec/scru
 MODULE_FIRMWARE("nvidia/gp102/sec2/desc.bin");
 MODULE_FIRMWARE("nvidia/gp102/sec2/image.bin");
 MODULE_FIRMWARE("nvidia/gp102/sec2/sig.bin");
+MODULE_FIRMWARE("nvidia/gp102/sec2/desc-1.bin");
+MODULE_FIRMWARE("nvidia/gp102/sec2/image-1.bin");
+MODULE_FIRMWARE("nvidia/gp102/sec2/sig-1.bin");
 MODULE_FIRMWARE("nvidia/gp104/acr/bl.bin");
 MODULE_FIRMWARE("nvidia/gp104/acr/unload_bl.bin");
 MODULE_FIRMWARE("nvidia/gp104/acr/ucode_load.bin");
@@ -210,6 +213,9 @@ MODULE_FIRMWARE("nvidia/gp104/nvdec/scru
 MODULE_FIRMWARE("nvidia/gp104/sec2/desc.bin");
 MODULE_FIRMWARE("nvidia/gp104/sec2/image.bin");
 MODULE_FIRMWARE("nvidia/gp104/sec2/sig.bin");
+MODULE_FIRMWARE("nvidia/gp104/sec2/desc-1.bin");
+MODULE_FIRMWARE("nvidia/gp104/sec2/image-1.bin");
+MODULE_FIRMWARE("nvidia/gp104/sec2/sig-1.bin");
 MODULE_FIRMWARE("nvidia/gp106/acr/bl.bin");
 MODULE_FIRMWARE("nvidia/gp106/acr/unload_bl.bin");
 MODULE_FIRMWARE("nvidia/gp106/acr/ucode_load.bin");
@@ -230,6 +236,9 @@ MODULE_FIRMWARE("nvidia/gp106/nvdec/scru
 MODULE_FIRMWARE("nvidia/gp106/sec2/desc.bin");
 MODULE_FIRMWARE("nvidia/gp106/sec2/image.bin");
 MODULE_FIRMWARE("nvidia/gp106/sec2/sig.bin");
+MODULE_FIRMWARE("nvidia/gp106/sec2/desc-1.bin");
+MODULE_FIRMWARE("nvidia/gp106/sec2/image-1.bin");
+MODULE_FIRMWARE("nvidia/gp106/sec2/sig-1.bin");
 MODULE_FIRMWARE("nvidia/gp107/acr/bl.bin");
 MODULE_FIRMWARE("nvidia/gp107/acr/unload_bl.bin");
 MODULE_FIRMWARE("nvidia/gp107/acr/ucode_load.bin");
@@ -250,3 +259,6 @@ MODULE_FIRMWARE("nvidia/gp107/nvdec/scru
 MODULE_FIRMWARE("nvidia/gp107/sec2/desc.bin");
 MODULE_FIRMWARE("nvidia/gp107/sec2/image.bin");
 MODULE_FIRMWARE("nvidia/gp107/sec2/sig.bin");
+MODULE_FIRMWARE("nvidia/gp107/sec2/desc-1.bin");
+MODULE_FIRMWARE("nvidia/gp107/sec2/image-1.bin");
+MODULE_FIRMWARE("nvidia/gp107/sec2/sig-1.bin");


