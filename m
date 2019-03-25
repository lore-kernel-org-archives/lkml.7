Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DAEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3B82075D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553538863;
	bh=8sZEPWEf7FmoOkB2a4Nco1mbgq4m5ufYRz+NRxTLZZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWCCkLdhbMNrNnhsMjMG/0MhbwLPRvPzm/d0rmTOQDHfqK+HHjUsio1kqz3sWgN7k
	 ryuFrC2Ctip/+CJi/VmEPUWPzM0vYj91VOzIq8u3d13qNyCPlPLzthUmTo77t+ccrL
	 CpDmkbHwGO4dXIqvOtq703YgZZ8eGhI8U1vsvxJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbfCYSeW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:34:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:38522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730023AbfCYSeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:34:18 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42EE208E4;
        Mon, 25 Mar 2019 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553538856;
        bh=8sZEPWEf7FmoOkB2a4Nco1mbgq4m5ufYRz+NRxTLZZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pN1DIF3MaQXXgSASt75hfMywCmYhb85Pg7C00sYects+ptvuHpeZlRcdQSekFa/ew
         aP8w8Ha1hzHSrWp3r+Y+PNHff4hFyNCJ4A9eaOAIHpnA5ZLOX/mQp+AIAahMr+MrRS
         I3fL77/p5kCXlyAjgu2j5HEBM7BMtfBkc7W76V1Y=
From:   helgaas@kernel.org
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/4] ACPI / tables: Cleanup whitespace
Date:   Mon, 25 Mar 2019 13:34:01 -0500
Message-Id: <20190325183403.251473-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
In-Reply-To: <20190325183403.251473-1-helgaas@kernel.org>
References: <20190325183403.251473-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Cleanup some whitespace to match the rest of the file.  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/tables.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index 8fccbe49612a..4672f9ef183a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -240,8 +240,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
  * On success returns sum of all matching entries for all proc handlers.
  * Otherwise, -ENODEV or -EINVAL is returned.
  */
-static int __init
-acpi_parse_entries_array(char *id, unsigned long table_size,
+static int __init acpi_parse_entries_array(char *id, unsigned long table_size,
 		struct acpi_table_header *table_header,
 		struct acpi_subtable_proc *proc, int proc_num,
 		unsigned int max_entries)
@@ -314,8 +313,7 @@ acpi_parse_entries_array(char *id, unsigned long table_size,
 	return errs ? -EINVAL : count;
 }
 
-int __init
-acpi_table_parse_entries_array(char *id,
+int __init acpi_table_parse_entries_array(char *id,
 			 unsigned long table_size,
 			 struct acpi_subtable_proc *proc, int proc_num,
 			 unsigned int max_entries)
@@ -346,8 +344,7 @@ acpi_table_parse_entries_array(char *id,
 	return count;
 }
 
-int __init
-acpi_table_parse_entries(char *id,
+int __init acpi_table_parse_entries(char *id,
 			unsigned long table_size,
 			int entry_id,
 			acpi_tbl_entry_handler handler,
@@ -362,8 +359,7 @@ acpi_table_parse_entries(char *id,
 						max_entries);
 }
 
-int __init
-acpi_table_parse_madt(enum acpi_madt_type id,
+int __init acpi_table_parse_madt(enum acpi_madt_type id,
 		      acpi_tbl_entry_handler handler, unsigned int max_entries)
 {
 	return acpi_table_parse_entries(ACPI_SIG_MADT,
@@ -725,8 +721,7 @@ static void *amlcode __attribute__ ((weakref("AmlCode")));
 static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
 #endif
 
-acpi_status
-acpi_os_table_override(struct acpi_table_header *existing_table,
+acpi_status acpi_os_table_override(struct acpi_table_header *existing_table,
 		       struct acpi_table_header **new_table)
 {
 	if (!existing_table || !new_table)
@@ -788,7 +783,6 @@ static int __init acpi_parse_apic_instance(char *str)
 
 	return 0;
 }
-
 early_param("acpi_apic_instance", acpi_parse_apic_instance);
 
 static int __init acpi_force_table_verification_setup(char *s)
@@ -797,7 +791,6 @@ static int __init acpi_force_table_verification_setup(char *s)
 
 	return 0;
 }
-
 early_param("acpi_force_table_verification", acpi_force_table_verification_setup);
 
 static int __init acpi_force_32bit_fadt_addr(char *s)
@@ -807,5 +800,4 @@ static int __init acpi_force_32bit_fadt_addr(char *s)
 
 	return 0;
 }
-
 early_param("acpi_force_32bit_fadt_addr", acpi_force_32bit_fadt_addr);
-- 
2.21.0.392.gf8f6787159e-goog

