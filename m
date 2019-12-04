Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143C8C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3F320674
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575482858;
	bh=TJx8KbA4ZSUM9FPpwLULBs4doPP4axQ+NI5GD8/63TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gqTdwjJv+giGPycaf7XdkRyD3z1ftK8R6tk+fsPtqa0QCp8SkZ7uj/HhQ/BZ8Xibm
	 lrPn3IFJGaazqZ2mdz2f3WbxRuESyC2mXvpijAWlb3Bnzvb5MRC0Ovq0iwT7EirOZw
	 jb/wLV5TMXaJel5duw8Ao2pI7MGo0hzoXqhjpJGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfLDSHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:57650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbfLDSHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:07:32 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97C4A20675;
        Wed,  4 Dec 2019 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482852;
        bh=TJx8KbA4ZSUM9FPpwLULBs4doPP4axQ+NI5GD8/63TE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MckX4L2gZNTaC/m+s9hWljfioAtqbPKeTy7w3xFnezWUsoFWo1ThO5deb+skuehCP
         dmYPPotG3+yrSD9pjWncG6PgvSBLrIyyGmp+lC0BS1F/wqZtyPcpLVEKIZpUijIlwn
         bViRhbCUlgT+aBxBeKFLBFnevnDCTmvwx46IFA1M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        youling257 <youling257@gmail.com>
Subject: [PATCH 4.14 160/209] staging: rtl8723bs: Add 024c:0525 to the list of SDIO device-ids
Date:   Wed,  4 Dec 2019 18:56:12 +0100
Message-Id: <20191204175334.496878404@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 3d5f1eedbfd22ceea94b39989d6021b1958181f4 upstream.

Add 024c:0525 to the list of SDIO device-ids, based on a patch found
in the Android X86 kernels. According to that patch this device id is
used on the Alcatel Plus 10 device.

Reported-and-tested-by: youling257 <youling257@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20191111113846.24940-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -25,6 +25,7 @@
 static const struct sdio_device_id sdio_ids[] =
 {
 	{ SDIO_DEVICE(0x024c, 0x0523), },
+	{ SDIO_DEVICE(0x024c, 0x0525), },
 	{ SDIO_DEVICE(0x024c, 0x0623), },
 	{ SDIO_DEVICE(0x024c, 0x0626), },
 	{ SDIO_DEVICE(0x024c, 0xb723), },


