Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E3CECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22D62168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 22:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571263704;
	bh=hwfzlsBcG2FeLV5V6cTxwfSC9qezqB7LbBwB6xzmIXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GoIKeWm6i1mh5gwbTcyWF2l9Y5b8++FTLZiSUFdi88IpkwAQzzGwXfdyVOdeAs7Rn
	 l88LpNVopa7Lu9Gen8guYxPDyvSBX1PiegNvgq6Jts9XpNf0ifUjRAahEQbWXzlF72
	 t5ZskzFKCPiqFHRfgKH7xGiafHExBtAlfIA2WrvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439082AbfJPWIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 18:08:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:50738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438052AbfJPV5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 17:57:49 -0400
Received: from localhost (unknown [192.55.54.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4CD7921D7A;
        Wed, 16 Oct 2019 21:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571263068;
        bh=hwfzlsBcG2FeLV5V6cTxwfSC9qezqB7LbBwB6xzmIXA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nk56zj3XDQQxLRCXoKQupancoFZUeJbXLfleU5tloqBUhQ47OT5+XlktMWao7TXKU
         PbQrpyyOtGYnwbHOB01gmaUmFRS6DN856h3oCPaKXwEQRHYlNFXFhRYd94W3tpIAuF
         ndxxnKtt1nzeME/QsOHekA2OkdbKd8eOoC3pFDpk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Erik Schmauss <erik.schmauss@intel.com>,
        Bob Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        John Garry <john.garry@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 68/81] ACPICA: ACPI 6.3: PPTT add additional fields in Processor Structure Flags
Date:   Wed, 16 Oct 2019 14:51:19 -0700
Message-Id: <20191016214846.058277835@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016214805.727399379@linuxfoundation.org>
References: <20191016214805.727399379@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Erik Schmauss <erik.schmauss@intel.com>

Commit b5eab512e7cffb2bb37c4b342b5594e9e75fd486 upstream.

ACPICA commit c736ea34add19a3a07e0e398711847cd6b95affd

Link: https://github.com/acpica/acpica/commit/c736ea34
Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: John Garry <john.garry@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/acpi/actbl2.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index c50ef7e6b9425..1d4ef0621174d 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -1472,8 +1472,11 @@ struct acpi_pptt_processor {
 
 /* Flags */
 
-#define ACPI_PPTT_PHYSICAL_PACKAGE          (1)	/* Physical package */
-#define ACPI_PPTT_ACPI_PROCESSOR_ID_VALID   (2)	/* ACPI Processor ID valid */
+#define ACPI_PPTT_PHYSICAL_PACKAGE          (1)
+#define ACPI_PPTT_ACPI_PROCESSOR_ID_VALID   (1<<1)
+#define ACPI_PPTT_ACPI_PROCESSOR_IS_THREAD  (1<<2)	/* ACPI 6.3 */
+#define ACPI_PPTT_ACPI_LEAF_NODE            (1<<3)	/* ACPI 6.3 */
+#define ACPI_PPTT_ACPI_IDENTICAL            (1<<4)	/* ACPI 6.3 */
 
 /* 1: Cache Type Structure */
 
-- 
2.20.1



